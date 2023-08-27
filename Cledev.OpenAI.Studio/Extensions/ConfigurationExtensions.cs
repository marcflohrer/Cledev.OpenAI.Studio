namespace Cledev.OpenAI.Studio.Extensions;

public static class ConfigurationExtensions
{
    public static void AddConfiguration(this WebApplicationBuilder builder)
    {
        // Environment variables override all other configuration sources.
        builder.Configuration
        .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
        .AddJsonFile($"appsettings.{builder.Environment}.json", optional: true, reloadOnChange: true)
        .AddEnvironmentVariables();
    }
}
