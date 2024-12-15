using Azure;
using Azure.Data.Tables;

namespace GarminSync.API.Models;

public record StepsInfoEntity : ITableEntity
{
    public required string PartitionKey { get; set; }
    public required string RowKey { get; set; }
    public DateTimeOffset? Timestamp { get; set; }
    public ETag ETag { get; set; }
    public long Steps { get; set; }
}