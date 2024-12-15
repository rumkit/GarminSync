using Azure.Data.Tables;
using Azure.Identity;
using GarminSync.API.Models;
using GarminSync.API.Settings;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace GarminSync.API;

public class GetStepsData(ILogger<GetStepsData> logger, IOptions<AzureSettings> azureSettings)
{
    [Function("GetStepsData")]
    public async Task<IActionResult> Run([HttpTrigger(AuthorizationLevel.Function, "get", "post")] HttpRequest req)
    {
        var tableSettings = azureSettings.Value;
        var tableClient = new TableClient(
            new Uri(tableSettings.TablesUrl),
            tableSettings.TableName,
            new DefaultAzureCredential());
        
        var todayString = DateTime.Today.ToUniversalTime().ToString("yyyy-MM-dd");

        var result = new List<StepsInfoEntity>();
        await foreach(var entity in tableClient.QueryAsync<StepsInfoEntity>($"PartitionKey eq '{todayString}'", 100))
        {
            result.Add(entity);
        }
        
        logger.LogInformation($"Got {result.Count} steps data records");

        return new OkObjectResult(result);
    }

}