# Prerequisities
- Azure Web App with Backups setup to a Blob Storage

# ![VSTS Build Definition](/vsts/Build Definition.PNG)

TODO image

- Download Azure Blob Storage Backup file (Azure Powershell)
  - Script Path = scripts/DownloadAzureBlobStorageFile.ps1
  - Script Arguments = $(StorageAccountName) $(StorageAccountKey) $(ContainerName) $(BlobFileName) $(Agent.WorkFolder)
- Extract files (Extract files)
  - Archive file patterns = $(Agent.WorkFolder)/*.zip
  - Destination folder = $(Agent.WorkFolder)/unzipfiles
- Copy Publish Artifact: drop-unzip-files (Copy and Publish Build Artifact)
  - Copy Root = $(Agent.WorkFolder)/unzipfiles/fs/site/wwwroot
