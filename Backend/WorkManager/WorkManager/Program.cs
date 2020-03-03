using System;
using TNT.Core.Template.DataService;

namespace WorkManager
{
    class Program
    {
        static void Main(string[] args)
        {
            var gen = new SimpleGenerator(
                "WorkManager.Data",
                "localhost",
                "WorkManager", "sa", "123456",
                "Models", "WorkContext",
                "../../../../WorkManager.Data");
            gen.Regen(args);
        }
    }
}
