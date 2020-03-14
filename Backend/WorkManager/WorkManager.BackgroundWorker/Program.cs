using FirebaseAdmin;
using FirebaseAdmin.Messaging;
using Google.Apis.Auth.OAuth2;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using TNT.Core.Helpers.DI;
using WorkManager.Data.Domains;
using WorkManager.Data.Global;
using WorkManager.Data.Models;
using WorkManager.Data.Models.Extensions;
using WorkManager.Data.Models.Repositories;

namespace WorkManager.BackgroundWorker
{
    class Program
    {
        static void Main(string[] args)
        {
            var services = new ServiceCollection();
            services.AddDbContext<WorkContext>(builder =>
            {
                builder.UseSqlServer(
                    "Server=localhost; Database=WorkManager; Trusted_Connection = False;User Id=sa;Password=123456;");
                builder.UseLazyLoadingProxies();
            });
            services.AddServiceInjection();
            G.Configure(services);
            var provider = services.BuildServiceProvider();

            FirebaseApp.Create(new AppOptions
            {
                Credential = GoogleCredential.FromFile("./Secrets/firebase.json")
            });

            while (true)
            {
                Console.Clear();
                using (var scope = provider.CreateScope())
                {
                    var uow = scope.ServiceProvider.GetService<IUnitOfWork>();
                    var domain = scope.ServiceProvider.GetService<TaskDomain>();
                    var eDomain = scope.ServiceProvider.GetService<EventDomain>();
                    var notFinishedTask = domain.Tasks
                        .NotInStatus("CANCEL").NotInStatus("DONE")
                        .NotInStatus("FINISH CONFIRMED");
                    var lateTasks = notFinishedTask.Late().NotInStatus("LATE").ToList();
                    Console.WriteLine($"Late tasks: {lateTasks.Count}");
                    var now = DateTime.UtcNow;

                    foreach (var t in lateTasks)
                    {
                        var currentStatus = JsonConvert.DeserializeObject<List<string>>(t.Status);
                        currentStatus.Remove("DUE SOON");
                        currentStatus.Add("LATE");
                        t.Status = JsonConvert.SerializeObject(currentStatus);
                        uow.SaveChanges();
                        var data = new Dictionary<string, string>();
                        data["title"] = "You missed a taskk";
                        data["message"] = $"Task \"{t.Name}\" is expired at {t.Deadline}";
                        eDomain.Notify(new Message
                        {
                            Topic = t.OfUser,
                            Data = data
                        });
                        Console.WriteLine($"Notify: {t.OfUser}");
                    }
                    Console.WriteLine("----------------");

                    var dueSoonTasks = notFinishedTask.DueSoon().NotInStatus("LATE")
                        .NotInStatus("DUE SOON").ToList();
                    Console.WriteLine($"Due soon tasks: {dueSoonTasks.Count}");

                    foreach (var t in dueSoonTasks)
                    {
                        var currentStatus = JsonConvert.DeserializeObject<List<string>>(t.Status);
                        currentStatus.Add("DUE SOON");
                        t.Status = JsonConvert.SerializeObject(currentStatus);
                        uow.SaveChanges();
                        var data = new Dictionary<string, string>();
                        data["title"] = "Your task due soon";
                        data["message"] = $"Task \"{t.Name}\" only has {(int)(t.Deadline - now)?.TotalHours} hours left";
                        eDomain.Notify(new Message
                        {
                            Topic = t.OfUser,
                            Data = data
                        });
                        Console.WriteLine($"Notify: {t.OfUser}");
                    }
                    Console.WriteLine("----------------");
                }

                Thread.Sleep(30000);
            }

        }
    }
}
