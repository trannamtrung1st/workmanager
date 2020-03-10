﻿using Microsoft.AspNetCore.Authentication;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Security.Claims;
using System.Text;

namespace WorkManager.Data.ViewModels
{
    public class TokenInfo
    {
        public string UserId { get; set; }
        public IDictionary<string, IEnumerable<string>> Claims { get; }

        public TokenInfo(string id, IEnumerable<Claim> claims)
        {
            UserId = id;

            Claims = new Dictionary<string, IEnumerable<string>>(claims.GroupBy(c => c.Type)
                .Select(group => new KeyValuePair<string, IEnumerable<string>>(
                    group.Key, group.Select(c => c.Value).ToList())));
        }
    }

    public class AuthorizationGrantViewModel //Resource Owner Password Credentials Grant
    {
        [JsonProperty("username")]
        public string username { get; set; }
        //REQUIRED.  The resource owner username.

        [JsonProperty("password")]
        [DataType(DataType.Password)]
        public string password { get; set; }
        //REQUIRED.  The resource owner password.

        [JsonProperty("grant_type")]
        public string grant_type { get; set; }
        //REQUIRED. 
        //- password: grant username and password
        //- refresh_token: grant refresh_token

        [JsonProperty("refresh_token")]
        public string refresh_token { get; set; }
        //OPTIONAL.  The refresh_token

        [JsonProperty("scope")]
        public string scope { get; set; }
        //OPTIONAL.  The scope of the access request as described by
    }

    public class AddRolesToUserViewModel
    {
        public string username { get; set; }
        public List<string> roles { get; set; }
    }

    public class RemoveRolesFromUserViewModel
    {
        public string username { get; set; }
        public List<string> roles { get; set; }
    }

    public class LoginViewModel
    {
        public string username { get; set; }
        public string password { get; set; }
        public bool remember_me { get; set; }
    }

    public class RegisterViewModel
    {
        [JsonProperty("username")]
        [Required]
        [StringLength(100, MinimumLength = 5)]
        [Display(Name = "Username")]
        public string username { get; set; }

        //[JsonProperty("email")]
        //[Required]
        //[EmailAddress]
        //[Display(Name = "Email")]
        //public string Email { get; set; }

        [JsonProperty("password")]
        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} and at max {1} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string password { get; set; }

        [JsonProperty("confirm_password")]
        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("password", ErrorMessage = "The password and confirmation password do not match.")]
        public string confirm_password { get; set; }
    }

    public class TokenResponseViewModel
    {
        public string access_token { get; set; }
        public string token_type { get; set; }
        public string expires_utc { get; set; }
        public string issued_utc { get; set; }
        public string refresh_token { get; set; }
    }

}