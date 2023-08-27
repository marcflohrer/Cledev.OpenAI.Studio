using Serilog;
using Serilog.Sinks.MSSqlServer;

namespace Cledev.OpenAI.Studio.Extensions;

public static class LoggerExtensions
{
    public static void AddLogger(this IServiceCollection services, string connectionString)
    {
        var logger = new LoggerConfiguration().WriteTo.MSSqlServer(
                connectionString: connectionString,
                sinkOptions: new MSSqlServerSinkOptions()
                {
                    TableName = "Logs",
                    SchemaName = "EventLogging",
                    AutoCreateSqlTable = true,
                    BatchPostingLimit = 1000,
                    BatchPeriod = TimeSpan.FromMinutes(1)
                }, restrictedToMinimumLevel: Serilog.Events.LogEventLevel.Error
                ).CreateLogger();
        services.AddSingleton<Serilog.ILogger>(logger);
    }
}
