FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env

WORKDIR /app

# Copy csproj and restore as distinct layers
COPY ["./Cledev.OpenAI.Studio/Cledev.OpenAI.Studio.csproj", "Cledev.OpenAI.Studio/"]

RUN dotnet restore -s https://api.nuget.org/v3/index.json Cledev.OpenAI.Studio/Cledev.OpenAI.Studio.csproj

# Copy everything else and build
COPY . ./

RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime

WORKDIR /app

COPY --from=build-env /app/out .

ENTRYPOINT ["dotnet", "CleDev.OpenAI.Studio.dll"]
