using Azure;
using Azure.Data.Tables;

namespace GarminSync.API.Models;

public record struct StepsInfoEntity : ITableEntity
{
    public string PartitionKey { get; set; }
    public string RowKey { get; set; }
    public DateTimeOffset? Timestamp { get; set; }
    public ETag ETag { get; set; }
    public long Steps { get; set; }
}