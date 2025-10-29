using System.Globalization;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.DependencyInjection;

namespace CodeAlongNtt;

/// <summary>
/// Sample .NET 9 application demonstrating UK English locale formatting
/// </summary>
public class Program
{
    public static async Task Main(string[] args)
    {
        // Set up the host with dependency injection and logging
        var host = Host.CreateDefaultBuilder(args)
            .ConfigureServices(services =>
            {
                services.AddSingleton<UKGreetingService>();
            })
            .Build();

        var logger = host.Services.GetRequiredService<ILogger<Program>>();
        var greetingService = host.Services.GetRequiredService<UKGreetingService>();

        logger.LogInformation("Starting .NET 9 application with UK English locale support");

        // Demonstrate UK locale formatting
        var greeting = greetingService.Greet("Developer");
        Console.WriteLine(greeting);

        logger.LogInformation("Environment setup complete for Ubuntu with UK English locale");
        logger.LogInformation("Supported technologies: Node.js, TypeScript, Python, .NET 9");

        await host.StopAsync();
    }
}

/// <summary>
/// Service that provides UK-style greetings and date formatting
/// </summary>
public class UKGreetingService
{
    private readonly CultureInfo _ukCulture;

    public UKGreetingService()
    {
        // Set up UK English culture
        _ukCulture = new CultureInfo("en-GB");
    }

    public string Greet(string name)
    {
        var now = DateTime.Now;

        // Format date in UK style (DD/MM/YYYY)
        var ukDate = now.ToString("dd/MM/yyyy", _ukCulture);

        // Format time in 24-hour format (common in UK)
        var ukTime = now.ToString("HH:mm", _ukCulture);

        return $"Good day, {name}! Today is {ukDate} at {ukTime}.";
    }
}