#!/bin/bash
. .env
docker system prune -f
# create a variable DatabaseConnectionString for MSSQL and set password from .env file where the container name is investordb and database name is  master, user is sa and password is from .env file
DatabaseContainerName="openaidb"
ProjectName="Cledev.OpenAI.Studio"
DatabaseConnectionString="Server=${DatabaseContainerName};Database=master;User=sa;Password=${DatabasePassword};TrustServerCertificate=True;"
dotnet user-secrets init --project ./${ProjectName}/${ProjectName}.csproj
dotnet user-secrets set ConnectionStrings:DefaultConnection "${DatabaseConnectionString};" --project ./${ProjectName}/${ProjectName}.csproj
# Start the containers using docker compose
docker compose up --build -d