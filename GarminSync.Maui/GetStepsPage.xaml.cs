using System.Text.Json;
using GarminSync.Maui.Models;
using Microsoft.Extensions.Logging;

namespace GarminSync.Maui;

public partial class GetStepsPage : ContentPage
{
    private readonly ILogger<GetStepsPage> _logger;

    public GetStepsPage(ILogger<GetStepsPage> logger)
    {
        _logger = logger;
        InitializeComponent();
    }

    private async void OnDownloadStepsClicked(object? sender, EventArgs e)
    {
        try
        {
            using var httpClient = new HttpClient();
            httpClient.BaseAddress = new Uri("https://fagarminsync.azurewebsites.net");
            var request = new HttpRequestMessage(
                HttpMethod.Get, 
                "/api/GetStepsData" +
                "?code=C6u2z3EcLlb4jjYVCsTW1RFvyH3WN8IGAFrX4a7ipJhJAzFu2q-YIA%3D%3D" +
                "&dateTimeFrom=2024-12-15T12:00:00.00Z");
            var result = await httpClient.SendAsync(request);

            if (result.IsSuccessStatusCode)
            {
                var stepsStringData = await result.Content.ReadAsStringAsync();
                var stepsChunks = JsonSerializer.Deserialize<StepsDataDto[]>(stepsStringData, new JsonSerializerOptions()
                {
                    PropertyNameCaseInsensitive = true
                });
        
                ResultsStack.Children.Clear();
                foreach (var chunk in stepsChunks)
                {
                    ResultsStack.Children.Add(new Label(){Text = $"{chunk.TimeStamp} # {chunk.Steps} steps"});
                }
            }
        }
        catch (Exception exception)
        {
           _logger.LogError(exception.Message);
        }
    }
}