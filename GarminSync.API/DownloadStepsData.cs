using Azure;
using Azure.Data.Tables;
using Garmin.Connect;
using Garmin.Connect.Auth;
using GarminSync.API.Models;
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
    public async Task Run([TimerTrigger("0 0 */1 * * *", RunOnStartup = true)] TimerInfo myTimer)
    {
        var userSettings = garminConnectSettings.Value;
        var tableSettings = azureSettings.Value;
        
        logger.LogInformation($"Using Garmin.Connect user: {userSettings.Username}");
        
        var authParameters = new BasicAuthParameters(userSettings.Username, userSettings.Password);
        var client = new GarminConnectClient(new GarminConnectContext(new HttpClient(), authParameters));
        var stepsData = await client.GetWellnessStepsData(DateTime.Today);
        
        logger.LogInformation($"Downloaded {stepsData.Length} wellness data chunks");
        
        var tableClient = new TableClient(
            new Uri(tableSettings.TablesUrl),
            tableSettings.TableName,
            new TableSharedKeyCredential(tableSettings.StorageAccountName, tableSettings.StorageAccountSharedKey));

        foreach (var stepsDataChunk in stepsData.Where(sd => sd.Steps > 0))
        {
            var startUtc = stepsDataChunk.StartGmt.ToUniversalTime();
            await tableClient.UpsertEntityAsync(new StepsInfoEntity
            {
                PartitionKey = startUtc.ToString("yyyy-MM-dd"),
                RowKey = startUtc.ToString("yyyy-MM-dd HH:mm:ss"),
                Timestamp = DateTimeOffset.Now,
                ETag = new ETag(Guid.CreateVersion7().ToString()),
                Steps = stepsDataChunk.Steps,
            });
        }
    }
}