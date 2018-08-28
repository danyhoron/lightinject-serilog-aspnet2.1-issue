FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src

# copy csproj and restore as distinct layers
COPY *.csproj .

RUN dotnet restore 

# copy everything else and build app
COPY . .

RUN dotnet publish -c Release -o /app

FROM microsoft/dotnet:2.1-aspnetcore-runtime AS runtime
WORKDIR /app

COPY --from=build /app .
ENTRYPOINT ["dotnet", "LightInject_Serilog_aspnetcore_2.1.dll"]
