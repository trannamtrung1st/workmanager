using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using WorkManager.Data;
using WorkManager.Data.Global;
using WorkManager.Data.Models;
using Swashbuckle.AspNetCore.Swagger;
using TNT.Core.Helpers.DI;

namespace WorkManager.WebApi
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
            configuration.Bind("App", App.Instance);
            G.ConfigureLogging();
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            ServiceInjection.Register(new List<Type>() { typeof(Startup) });
            services.AddServiceInjection();

            services.AddDbContext<WorkContext>(options =>
            {
                options.UseSqlServer(
                    Configuration.GetConnectionString("WorkContext"));
                options.UseLazyLoadingProxies();
            });

            services.Configure<ApiBehaviorOptions>(options =>
            {
                options.SuppressModelStateInvalidFilter = true;
            });

            G.Configure(services);

            #region OAuth
            services.AddDbContext<IdentityContext>(options =>
            {
                options.UseSqlServer(
                    Configuration.GetConnectionString("WorkContext"));
                options.UseLazyLoadingProxies();
            });

            services.AddDefaultIdentity<AppUsers>(config =>
            {
                config.SignIn.RequireConfirmedEmail = false;
            })
            .AddRoles<AppRoles>()
            .AddEntityFrameworkStores<IdentityContext>();

            services.Configure<IdentityOptions>(options =>
            {
                options.Password.RequireDigit = false;
                options.Password.RequireLowercase = false;
                options.Password.RequireNonAlphanumeric = false;
                options.Password.RequireUppercase = false;
                options.Password.RequiredLength = 6;
                options.Password.RequiredUniqueChars = 0;

                options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(5);
                options.Lockout.MaxFailedAccessAttempts = 5;
                options.Lockout.AllowedForNewUsers = true;

                options.User.AllowedUserNameCharacters =
                "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._@+";
                options.User.RequireUniqueEmail = false;
            });

            services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
                .AddJwtBearer(jwtBearerOptions =>
                {
                    jwtBearerOptions.TokenValidationParameters = new TokenValidationParameters()
                    {
                        ValidateAudience = true,
                        ValidateLifetime = true,
                        ValidateIssuerSigningKey = true,
                        ValidIssuer = JWT.ISSUER,
                        ValidAudience = JWT.AUDIENCE,
                        IssuerSigningKey = new SymmetricSecurityKey(
                            Encoding.Default.GetBytes(JWT.SECRET_KEY)),
                        ClockSkew = TimeSpan.Zero
                    };
                    //jwtBearerOptions.Events = new JwtBearerEvents
                    //{
                    //    OnMessageReceived = (context) =>
                    //    {
                    //        StringValues values;
                    //        if (!context.Request.Query.TryGetValue("access_token", out values))
                    //            return Task.CompletedTask;
                    //        var token = values.FirstOrDefault();
                    //        context.Token = token;
                    //        return Task.CompletedTask;
                    //    }
                    //};

                });
            //.AddGoogle(o =>
            //{
            //    o.ClientId = "";
            //    o.ClientSecret = "";

            //    //Google+ shut down
            //    o.UserInformationEndpoint = "https://www.googleapis.com/oauth2/v2/userinfo";
            //    o.ClaimActions.Clear();
            //    o.ClaimActions.MapJsonKey(ClaimTypes.NameIdentifier, "id");
            //    o.ClaimActions.MapJsonKey(ClaimTypes.Name, "name");
            //    o.ClaimActions.MapJsonKey(ClaimTypes.GivenName, "given_name");
            //    o.ClaimActions.MapJsonKey(ClaimTypes.Surname, "family_name");
            //    o.ClaimActions.MapJsonKey("urn:google:profile", "link");
            //    o.ClaimActions.MapJsonKey(ClaimTypes.Email, "email");
            //    o.ClaimActions.MapJsonKey(ClaimTypes.Surname, "family_name");
            //})
            //.AddFacebook(o =>
            //{
            //    o.ClientId = "";
            //    o.ClientSecret = "";
            //});
            #endregion

            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2);

            // Register the Swagger generator, defining 1 or more Swagger documents
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new Info
                {
                    Version = "v1",
                    Title = "API",
                    Description = "API",
                    TermsOfService = "None",
                });

                c.AddSecurityDefinition("Bearer",
                    new ApiKeyScheme
                    {
                        In = "header",
                        Description = "Please enter into field the word 'Bearer' following by space and JWT",
                        Name = "Authorization",
                        Type = "apiKey"
                    });
                c.AddSecurityRequirement(new Dictionary<string, IEnumerable<string>> {
                    { "Bearer", Enumerable.Empty<string>() },
                });

            });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            App.Instance.AppWebRoot = env.WebRootPath;

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            // Enable middleware to serve generated Swagger as a JSON endpoint.
            app.UseSwagger();

            // Enable middleware to serve swagger-ui (HTML, JS, CSS, etc.), 
            // specifying the Swagger JSON endpoint.
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "My API V1");
                c.RoutePrefix = string.Empty;
            });

            app.UseCors(builder =>
            {
                builder.AllowAnyHeader();
                builder.AllowAnyMethod();
                builder.AllowAnyOrigin();
            });
            app.UseAuthentication();

            app.UseMvc();
        }
    }
}