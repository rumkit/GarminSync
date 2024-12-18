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
        if (!DateTime.TryParse(req.Query["dateTimeFrom"], out DateTime dateTimeFrom))
            return new BadRequestObjectResult("dateTimeFrom parameter is required");

        dateTimeFrom = dateTimeFrom.ToUniversalTime();

        var tableSettings = azureSettings.Value;
        var tableClient = new TableClient(
            new Uri(tableSettings.TablesUrl),
            tableSettings.TableName,
            new DefaultAzureCredential());

        var result = new List<StepsDataDto>();
        await foreach (var entity in tableClient.QueryAsync<StepsInfoEntity>(
                           $"PartitionKey ge '{dateTimeFrom:yyyy-MM-dd}' and RowKey gt '{dateTimeFrom:yyyy-MM-dd HH:mm:ss}'",
                           100)
                      )
        {
            result.Add(new StepsDataDto(entity.Timestamp ?? default, entity.Steps));
        }

        logger.LogInformation($"Got {result.Count} steps data records");

        return new OkObjectResult(result);
    }
}