using GarminSync.API.Settings;
using Microsoft.Azure.Functions.Worker.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var builder = FunctionsApplication.CreateBuilder(args);

builder.ConfigureFunctionsWebApplication();

// Application Insights isn't enabled by default. See https://aka.ms/AAt8mw4.
// builder.Services
//     .AddApplicationInsightsTelemetryWorkerService()
//     .ConfigureFunctionsApplicationInsights();

builder.Services.AddOptions<AzureSettings>().
    Configure<IConfiguration>((settings, configuration) =>
    {
        configuration.GetSection("Azure").Bind(settings);
    });
builder.Services.AddOptions<GarminConnectSettings>().
    Configure<IConfiguration>((settings, configuration) =>
    {
        configuration.GetSection("Garmin.Connect").Bind(settings);
    });

builder.Build().Run();