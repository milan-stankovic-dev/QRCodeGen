# --- Stage 1: Build ---
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy solution and project files
COPY *.sln .
COPY QRCodeGen/*.csproj ./QRCodeGen/

# Restore dependencies
RUN dotnet restore

# Copy everything else and publish
COPY . .
WORKDIR /src/QRCodeGen
RUN dotnet publish -c Release -o /app/publish

# --- Stage 2: Run ---
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "QRCodeGen.dll"]
