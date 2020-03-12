using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Security.Claims;
using System.Text;
using Newtonsoft.Json;
using NLog;
using NLog.Layouts;
using WorkManager.Data.Models;

namespace WorkManager.Data
{
    public class JWT
    {
        public const string ISSUER = "workmanager";
        public const string AUDIENCE = "workmanager";
        public const string SECRET_KEY = "workmanager123456789@987654321";

        public const string REFRESH_ISSUER = "refresh_workmanager";
        public const string REFRESH_AUDIENCE = "refresh_workmanager";
        public const string REFRESH_SECRET_KEY = "refresh_workmanager123456789@987654321";
    }

    public static class AppClaimTypes
    {
        public const string Username = "username";
    }

    public class App
    {

        public string Name { get; set; }
        public string ApiUrl { get; set; }
        public string SecretsFileName { get; set; }
        public float TokenValidHours { get; set; }
        public float CookiePersistentHours { get; set; }
        public NLogAppConfig NLog { get; set; }

        private static App _instance;
        public static App Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new App();
                return _instance;
            }
        }
    }

    public class NLogAppConfig
    {
        public string Name { get; set; }
        public string DBProvider { get; set; }
        public string ConnectionString { get; set; }
        public CommandType CommandType { get; set; }
        public string CommandText { get; set; }
        public IEnumerable<NLogParameter> Parameters { get; set; }
    }

    public class NLogParameter
    {
        public string Name { get; set; }
        public string Layout { get; set; }
    }

    public static class LoggingExtensions
    {
        public static Logger CustomProperties(this Logger logger,
            object data)
        {
            return logger.WithProperty("Data", data != null ? JsonConvert.SerializeObject(data) : null);
        }

        public static Logger CustomProperties(this Logger logger,
            AppUsers user, object data = null)
        {
            return logger.WithProperty("Data", data != null ? JsonConvert.SerializeObject(data) : null)
                .WithProperty("UserId", user?.Id)
                .WithProperty("UserName", user?.UserName);
        }

        public static Logger CustomProperties(this Logger logger,
            ClaimsPrincipal user, object data = null)
        {
            return logger.WithProperty("Data", data != null ? JsonConvert.SerializeObject(data) : null)
                .WithProperty("UserId", user?.Identity.Name);
        }
    }

    public static partial class EnumExtensions
    {
        public static IEnumerable<Type> GetValues<Type>()
        {
            var type = typeof(Type);
            var enumType = typeof(Enum);
            var enums = type.GetFields().Where(f => f.FieldType.IsSubclassOf(enumType));
            return enums.Select(f => (Type)f.GetValue(null));
        }

        private static readonly IDictionary<Type, IDictionary<int, string>>
            enumCaches = new Dictionary<Type, IDictionary<int, string>>();

        public static IDictionary<int, string> Get<Type>()
        {
            var type = typeof(Type);
            if (enumCaches.ContainsKey(type))
                return enumCaches[type];
            var enumType = typeof(Enum);
            var enums = type.GetFields().Where(f => f.FieldType.IsSubclassOf(enumType));
            var dict = new Dictionary<int, string>();
            foreach (var e in enums)
            {
                dict[(int)e.GetRawConstantValue()] = e.FieldType.DisplayName(e.Name);
            }
            enumCaches[type] = dict;
            return dict;
        }

        public static string DisplayName(this Enum enumVal)
        {
            var enumType = enumVal.GetType();
            var name = Enum.GetName(enumType, enumVal);
            var displayNameAttr = enumType.GetField(name).GetCustomAttributes(false)
                .OfType<DisplayAttribute>().SingleOrDefault();
            if (displayNameAttr != null)
                return displayNameAttr.Name;
            return null;
        }

        public static String DisplayName(this Type enumType, string enumName)
        {
            var displayNameAttr = enumType.GetField(enumName).GetCustomAttributes(false)
                .OfType<DisplayAttribute>().SingleOrDefault();
            if (displayNameAttr != null)
                return displayNameAttr.Name;
            return null;
        }
    }

    public static class DateTimeExtensions
    {

        public static DateTime ToStartOfDay(this DateTime dt)
        {
            return new DateTime(dt.Year, dt.Month, dt.Day, 0, 0, 0);
        }

        public static DateTime ToEndOfDay(this DateTime dt)
        {
            return new DateTime(dt.Year, dt.Month, dt.Day, 23, 59, 59);
        }

    }
}