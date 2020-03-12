using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace WorkManager.Data.ViewModels
{
    public class ApiResult
    {
        [JsonProperty("code")]
        public ResultCode? Code { get; set; }
        [JsonProperty("message")]
        public string Message { get; set; }
        [JsonProperty("data")]
        public object Data { get; set; }
    }

    public enum ResultCode
    {
        [Display(Name = "Not found")]
        NotFound = 1,
        [Display(Name = "Unknown error")]
        UnknownError = 2,
        [Display(Name = "Fail validation")]
        FailValidation = 3,
        [Display(Name = "Unsupported")]
        Unsupported = 4,
        [Display(Name = "Unauthorized")]
        Unauthorized = 5,
        [Display(Name = "Success")]
        Success = 6,
    }
}