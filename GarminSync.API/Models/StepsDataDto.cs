namespace GarminSync.API.Models;

public record class StepsDataDto(DateTimeOffset TimeStamp, long Steps);