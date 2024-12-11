using GarminSync.API.Settings;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace GarminSync.API;

public class DownloadStepsData(
    ILogger<DownloadStepsData> logger,
    IOptions<AzureSettings> azureSettings,
    IOptions<GarminConnectSettings> garminConnectSettings)
{
    [Function("DownloadStepsData")]
    public void Run([TimerTrigger("0 0 */1 * * *", RunOnStartup = true)] TimerInfo myTimer)
    {
        logger.LogInformation($"Using Garmin.Connect user: {garminConnectSettings.Value.Username}");
        logger.LogInformation($"C# Timer trigger function executed at: {DateTime.Now}");

        if (myTimer.ScheduleStatus is not null)
        {
            logger.LogInformation($"Next timer schedule at: {myTimer.ScheduleStatus.Next}");
            
        }
    }
}