FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 85

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-dotnet-configure-containers


FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src


COPY . .

RUN dotnet restore "./myFirstWebApplication.csproj" && dotnet build "./myFirstWebApplication.csproj" -c Release -o /app/build && dotnet publish "./myFirstWebApplication.csproj" -c Release -o /app/publish



FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "myFirstWebApplication.dll"]
