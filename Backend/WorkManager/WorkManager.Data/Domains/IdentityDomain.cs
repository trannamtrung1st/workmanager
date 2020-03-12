using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using WorkManager.Data.Models;
using WorkManager.Data.ViewModels;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using TNT.Core.Helpers.DI;

namespace WorkManager.Data.Domains
{
    public class IdentityDomain : BaseDomain
    {
        [Inject]
        private readonly UserManager<AppUsers> _userManager;
        [Inject]
        private readonly RoleManager<AppRoles> _roleManager;
        [Inject]
        private readonly SignInManager<AppUsers> _signInManager;
        [Inject]
        private readonly IdentityContext _identityContext;

        public IdentityDomain(ServiceInjection inj) : base(inj)
        {
        }

        #region Role
        public IQueryable<AppRoles> GetRoles()
        {
            return _roleManager.Roles;
        }

        public AppRoles GetRoleByName(string name)
        {
            return GetRoles().FirstOrDefault(r => r.Name == name);
        }

        public async Task<IdentityResult> RemoveRoleAsync(AppRoles role)
        {
            return await _roleManager.DeleteAsync(role);
        }

        public async Task<IdentityResult> CreateRoleAsync(AppRoles role)
        {
            var result = await _roleManager.CreateAsync(role);
            return result;
        }

        public async Task<IdentityResult> EditRoleAsync(AppRoles role,
            EditRoleViewModel model)
        {
            role.Name = model.Name;
            var result = await _roleManager.UpdateAsync(role);
            return result;
        }
        #endregion

        #region User
        public IQueryable<AppUsers> Users
        {
            get
            {
                return _userManager.Users;
            }
        }

        public async Task<AppUsers> GetUserByUserName(string username)
        {
            return await _userManager.FindByNameAsync(username);
        }

        public async Task<AppUsers> GetUserById(string id)
        {
            return await _userManager.FindByIdAsync(id);
        }

        public object GetUserProfile(AppUsers user)
        {
            return new
            {
                fullname = user.FullName,
                email = user.Email,
                id = user.Id,
                phone = user.PhoneNumber
            };
        }

        public async Task<IdentityResult> UpdateUser(AppUsers user)
        {
            return await _userManager.UpdateAsync(user);
        }

        public async Task<IdentityResult> AddUserToRoles(AppUsers user, IEnumerable<string> roles)
        {
            return await _userManager.AddToRolesAsync(user, roles);
        }

        public async Task<IdentityResult> RemoveUserFromRoles(AppUsers user, IEnumerable<string> roles)
        {
            return await _userManager.RemoveFromRolesAsync(user, roles);
        }

        public AppUsers ToUser(RegisterViewModel model)
        {
            return new AppUsers
            {
                UserName = model.username,
                EmployeeCode = model.employee_code,
                FullName = model.full_name,
                PhoneNumber = model.phone,
                Email = model.email
            };
        }

        public async Task<IdentityResult> CreateUserAsync(AppUsers user, string password)
        {
            var result = await _userManager.CreateAsync(user, password);
            return result;
        }

        public async Task<IdentityResult> CreateUserWithRolesAsync(AppUsers user, string password, IEnumerable<string> roles = null)
        {
            using (var trans = _identityContext.Database.BeginTransaction())
            {
                var result = await _userManager.CreateAsync(user, password);
                if (!result.Succeeded)
                    return result;
                if (roles != null)
                    result = await _userManager.AddToRolesAsync(user, roles);
                if (result.Succeeded)
                    trans.Commit();
                return result;
            }
        }
        #endregion

        #region OAUTH
        public TokenResponseViewModel GenerateTokenResponse(AuthenticationTicket ticket)
        {
            #region Generate JWT Token
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.Default.GetBytes(JWT.SECRET_KEY);
            var issuer = JWT.ISSUER;
            var audience = JWT.AUDIENCE;
            var identity = ticket.Principal.Identity as ClaimsIdentity;
            identity.AddClaim(new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()));
            identity.AddClaim(new Claim(JwtRegisteredClaimNames.Sub, ticket.Principal.Identity.Name));

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Issuer = issuer,
                Audience = audience,
                Subject = identity,
                IssuedAt = ticket.Properties.IssuedUtc?.UtcDateTime,
                Expires = ticket.Properties.ExpiresUtc?.UtcDateTime,
                SigningCredentials = new SigningCredentials(
                    new SymmetricSecurityKey(key),
                    SecurityAlgorithms.HmacSha256Signature),
                NotBefore = ticket.Properties.IssuedUtc?.UtcDateTime
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            var tokenString = tokenHandler.WriteToken(token);
            #endregion

            var resp = new TokenResponseViewModel();
            resp.access_token = tokenString;
            resp.token_type = "bearer";
            if (ticket.Properties.ExpiresUtc != null)
                resp.expires_utc = ticket.Properties.ExpiresUtc?.ToString("yyyy-MM-ddTHH:mm:ssZ");
            if (ticket.Properties.IssuedUtc != null)
                resp.issued_utc = ticket.Properties.IssuedUtc?.ToString("yyyy-MM-ddTHH:mm:ssZ");

            #region Refresh Token
            key = Encoding.Default.GetBytes(JWT.REFRESH_SECRET_KEY);
            issuer = JWT.REFRESH_ISSUER;
            audience = JWT.REFRESH_AUDIENCE;
            var id = identity.Name;
            var refreshIdentity = new ClaimsIdentity(
                identity.Claims.Where(c => c.Type == identity.NameClaimType),
                identity.AuthenticationType);

            var refresh_expires = ticket.Properties.IssuedUtc?.UtcDateTime
                .AddDays(App.Instance.TokenValidHours * 2);
            tokenDescriptor = new SecurityTokenDescriptor
            {
                Issuer = issuer,
                Audience = audience,
                Subject = refreshIdentity,
                IssuedAt = ticket.Properties.IssuedUtc?.UtcDateTime,
                Expires = refresh_expires,
                SigningCredentials = new SigningCredentials(
                    new SymmetricSecurityKey(key),
                    SecurityAlgorithms.HmacSha256Signature),
                NotBefore = ticket.Properties.IssuedUtc?.UtcDateTime
            };

            token = tokenHandler.CreateToken(tokenDescriptor);
            tokenString = tokenHandler.WriteToken(token);
            resp.refresh_token = tokenString;
            #endregion

            resp.employee_code = identity.FindFirst(AppClaimTypes.EmployeeCode).Value;
            resp.username = identity.FindFirst(AppClaimTypes.Username).Value;
            resp.role = identity.FindFirst(AppClaimTypes.Role).Value;
            resp.user_id = identity.Name;

            return resp;
        }

        public ClaimsPrincipal ValidateRefreshToken(string tokenStr)
        {
            var tokenHandler = new JwtSecurityTokenHandler();

            try
            {
                SecurityToken secToken;
                var param = new TokenValidationParameters()
                {
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true,
                    ValidIssuer = JWT.REFRESH_ISSUER,
                    ValidAudience = JWT.REFRESH_AUDIENCE,
                    IssuerSigningKey = new SymmetricSecurityKey(
                            Encoding.Default.GetBytes(JWT.REFRESH_SECRET_KEY)),
                    ClockSkew = TimeSpan.Zero
                };
                return tokenHandler.ValidateToken(tokenStr, param, out secToken);
            }
            catch (Exception) { }
            return null;
        }

        public async Task<AppUsers> AuthenticateAsync(string username, string password)
        {
            var user = await _userManager.FindByNameAsync(username);
            if (user == null || !(await _userManager.CheckPasswordAsync(user, password)))
                return null;
            return user;
        }

        public async Task<ClaimsIdentity> GetIdentityAsync(AppUsers user, string scheme)
        {
            var identity = new ClaimsIdentity(scheme);
            identity.AddClaim(new Claim(ClaimTypes.Name, user.Id));
            var claims = await _userManager.GetClaimsAsync(user);
            var roles = await _userManager.GetRolesAsync(user);
            foreach (var r in roles)
                claims.Add(new Claim(ClaimTypes.Role, r));
            identity.AddClaims(claims);
            identity.AddClaim(new Claim(AppClaimTypes.Username, user.UserName));
            identity.AddClaim(new Claim(AppClaimTypes.Role, roles.FirstOrDefault()));
            identity.AddClaim(new Claim(AppClaimTypes.EmployeeCode, user.EmployeeCode));
            return identity;
        }

        //for IdentityCookie
        public async Task<ClaimsPrincipal> GetApplicationPrincipalAsync(AppUsers user)
        {
            var principal = await _signInManager.CreateUserPrincipalAsync(user);
            var identity = principal.Identity as ClaimsIdentity;
            identity.AddClaim(new Claim(ClaimTypes.Name, user.Id));
            var claims = new List<Claim>();
            var roles = await _userManager.GetRolesAsync(user);
            foreach (var r in roles)
                claims.Add(new Claim(ClaimTypes.Role, r));
            identity.AddClaims(claims);
            return principal;
        }

        #endregion

        #region External Login
        public AuthenticationProperties ConfigureExternalAuthenticationProperties(string provider, string redirectUrl, string userId = null)
        {
            return _signInManager.ConfigureExternalAuthenticationProperties(provider, redirectUrl, userId);
        }

        public async Task<ExternalLoginInfo> GetExternalLoginInfoAsync(string expectedXsrf = null)
        {
            return await _signInManager.GetExternalLoginInfoAsync(expectedXsrf);
        }

        public Task<SignInResult> ExternalLoginSignInAsync(string loginProvider, string providerKey, bool isPersistent, bool bypassTwoFactor)
        {
            return _signInManager.ExternalLoginSignInAsync(loginProvider, providerKey, isPersistent, bypassTwoFactor);
        }

        public async Task<AppUsers> AuthenticateExternalAsync(string provider, string providerKey)
        {
            var user = await _userManager.FindByLoginAsync(provider, providerKey);
            return user;
        }

        public async Task<IdentityResult> AddLoginToUserAsync(AppUsers user, ExternalLoginInfo info)
        {
            var result = await _userManager.AddLoginAsync(user, info);
            if (!result.Succeeded)
                throw new InvalidOperationException($"Unexpected error occurred adding external login for user with ID '{user.Id}'.");
            return result;
        }

        #endregion

    }
}