FROM acr5borealis.azurecr.io/aspnet AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM acr5borealis.azurecr.io/sdk AS build
WORKDIR /src
COPY ["HCLPaasCoe.csproj", ""]
RUN dotnet restore "HCLPaasCoe.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "HCLPaasCoe.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "HCLPaasCoe.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "HCLPaasCoe.dll"]
