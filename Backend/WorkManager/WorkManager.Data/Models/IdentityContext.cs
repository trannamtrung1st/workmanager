using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace WorkManager.Data.Models
{
    public class IdentityContext : IdentityDbContext<AppUsers, AppRoles, string,
        IdentityUserClaim<string>,
        AppUserRole, IdentityUserLogin<string>, IdentityRoleClaim<string>,
        IdentityUserToken<string>>
    {
        public IdentityContext(DbContextOptions<IdentityContext> options)
            : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
            // Customize the ASP.NET Identity model and override the defaults if needed.
            // For example, you can rename the ASP.NET Identity table names and more.
            // Add your customizations after calling base.OnModelCreating(builder);
            builder.Entity<AppUsers>(b =>
            {
                // Each User can have many entries in the UserRole join table
                b.HasMany(e => e.UserRoles)
                    .WithOne(e => e.User)
                    .HasForeignKey(ur => ur.UserId)
                    .IsRequired();
            });

            builder.Entity<AppRoles>(b =>
            {
                // Each Role can have many entries in the UserRole join table
                b.HasMany(e => e.UserRoles)
                    .WithOne(e => e.Role)
                    .HasForeignKey(ur => ur.RoleId)
                    .IsRequired();
            });
        }

    }

    public class AppUsers : IdentityUser
    {
        [StringLength(100)]
        public override string Id { get; set; }
        [Required]
        public string FullName { get; set; }
        [Required]
        [StringLength(50)]
        public string EmployeeCode { get; set; }

        public virtual ICollection<AppUserRole> UserRoles { get; set; }
    }

    public class AppUserRole : IdentityUserRole<string>
    {
        public virtual AppUsers User { get; set; }
        public virtual AppRoles Role { get; set; }
    }

    public class AppRoles : IdentityRole<string>
    {
        [StringLength(100)]
        public override string Id { get; set; }
        public virtual ICollection<AppUserRole> UserRoles { get; set; }
    }

    public class DbContextFactory : IDesignTimeDbContextFactory<IdentityContext>
    {

        public IdentityContext CreateDbContext(string[] args)
        {
            var optionsBuilder = new DbContextOptionsBuilder<IdentityContext>();
            optionsBuilder.UseSqlServer("Server=localhost;Database=WorkManager;Trusted_Connection=False;User Id=sa;Password=123456;MultipleActiveResultSets=true");

            return new IdentityContext(optionsBuilder.Options);
        }
    }
}