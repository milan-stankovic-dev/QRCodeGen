# --- Stage 1: Build ---
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy everything explicitly
COPY QRCodeGen.csproj ./QRCodeGen.csproj
RUN dotnet restore QRCodeGen.csproj

COPY . .
RUN dotnet publish -c Release -o /app/publish

# --- Stage 2: Run ---
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "QRCodeGen.dll"]
