FROM mcr.microsoft.com/dotnet/sdk:3.1 AS base
WORKDIR /app
EXPOSE 11130

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["DevOpsChallenge.csproj", "./"]
RUN dotnet restore "./DevOpsChallenge.csproj"
COPY . .
RUN dotnet build "DevOpsChallenge.csproj" -c Release -o /app

FROM build as publish
RUN dotnet publish "DevOpsChallenge.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "DevOpsChallenge.dll"]