This sample consists on using the built-in Azure Web App Backup and Restore feature with the high level steps:
  - Get the associated Powershell script;
  - Do a Backup of the Azure Web App;
  - Restore this Backup to one other slot.

# Prerequisities

- Configure your Azure Web App (main Slot) with Backups setup to a Blob Storage - manual (not automatic) is ok for the purpose of this demo.
- Read general document about [Backup your Web App](https://docs.microsoft.com/en-us/azure/app-service/web-sites-backup)

# Script

```
$ResourceGroupName = "TODO";
$WebAppName = "TODO";
$SlotName = "TODO";
$StorageAccountName = "TODO";
$ContainerName = "TODO";
$BlobFileName = "TODO";

#Login-AzureRmAccount;
$storageAccountKey = Get-AzureRmStorageAccountKey -ResourceGroupName $ResourceGroupName -Name $StorageAccountName;
$context = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $storageAccountKey[0].Value;
$sasUrl = New-AzureStorageContainerSASToken -Name $ContainerName -Permission rwdl -Context $context -ExpiryTime (Get-Date).AddDays(1) -FullUri;
Restore-AzureRmWebAppBackup -ResourceGroupName $ResourceGroupName -Name $WebAppName -Slot $SlotName -StorageAccountUrl $sasUrl -BlobName $BlobFileName -Overwrite;
```

Note: Like explained [here](https://azure.microsoft.com/en-us/documentation/articles/app-service-powershell-backup/) you could improve that by including database backup, setup Schedule automatic backup, etc. 