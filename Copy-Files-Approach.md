This sample consists on using the Azure Web App Backup feature but restoring part of it, in our case, just the `wwwroot`:

- Do a Backup of the Azure Web App;
- Get the associated Azure Blob file;
- Unzip this file;
- Stop the Slot;
- Upload by FTP the `wwwroot` folder to the associated slot folder;
- Start the Slot.

# Prerequisities
- Configure your Azure Web App (main Slot) with Backups setup to a Blob Storage - manual (not automatic) is ok for the purpose of this demo.
  - *You source Azure Web App should be at least in Standard SKU.*
- Read general documentation about [Backup your Web App](https://docs.microsoft.com/azure/app-service/web-sites-backup)

# Script

```
#Download Azure Blob Storage Backup file
$StorageAccountName = "TODO";
$StorageAccountKey = "TODO";
$ContainerName = "TODO";
$BlobFileName = "TODO";
$Destination = "TODO";
$context = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
Get-AzureStorageBlobContent -Context $context -Container $ContainerName -Blob $BlobFileName -Destination $Destination

#Unzip zip files
#TODO - in unzipfiles folder

#Stop the Azure Web App (to avoid files in used error)
$ResourceGroupName = "TODO";
$WebAppName = "TODO";
$Slot = "TODO";
Stop-AzureRmWebAppSlot -ResourceGroupName $ResourceGroupName -Name $WebAppName -Slot $Slot

#FTP Upload
#TODO - from unzipfiles/fs/site/wwwroot/ to /site/wwwroot/

#Start the Azure Web App
$ResourceGroupName = "TODO";
$WebAppName = "TODO";
$Slot = "TODO";
Stop-AzureRmWebAppSlot -ResourceGroupName $ResourceGroupName -Name $WebAppName -Slot $Slot
```