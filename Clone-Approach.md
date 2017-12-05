This sample consists on using the built-in Azure Web App Clone feature with the high level steps:
  - Get the source web app;
  - Create a new Slot based on this source web app.

# Prerequisities

- Read general documentation about [Clone a Web App](https://docs.microsoft.com/azure/app-service/app-service-web-app-cloning)
  - Be aware about [some requirements and restrictions](https://docs.microsoft.com/azure/app-service/app-service-web-app-cloning#current-restrictions).
  - *For example: you source Azure Web App should be at least in Premium SKU.*

# Script

```
$ResourceGroupName = "TODO";
$WebAppName = "TODO";
$SlotName = "TODO";
$AppServicePlanName = "TODO";

#Login-AzureRmAccount;
$srcapp = Get-AzureRmWebApp -ResourceGroupName $ResourceGroupName -Name $WebAppName;
New-AzureRmWebAppSlot -ResourceGroupName $ResourceGroupName -Name $WebAppName -Slot $SlotName -AppServicePlan $AppServicePlanName -SourceWebApp $srcapp;
```