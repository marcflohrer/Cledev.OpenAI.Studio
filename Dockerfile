FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env

WORKDIR /app

# Copy csproj and restore as distinct layers
COPY ["./Cledev.OpenAI.Studio/Cledev.OpenAI.Studio.csproj", "Cledev.OpenAI.Studio/"]

RUN dotnet restore -s https://api.nuget.org/v3/index.json Cledev.OpenAI.Studio/Cledev.OpenAI.Studio.csproj

RUN dotnet dev-certs https

# Copy everything else and build
COPY . ./

RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime

WORKDIR /app

COPY --from=build-env /app/Cledev.OpenAI.Studio/index.md .
COPY --from=build-env /app/out .
COPY --from=build-env /root/.dotnet/corefx/cryptography/x509stores/my/* /root/.dotnet/corefx/cryptography/x509stores/my/

ENTRYPOINT ["dotnet", "Cledev.OpenAI.Studio.dll"]
