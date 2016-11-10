This sample consists on using the Azure Web App Backup feature but restoring part of it, in our case, just the wwwroot:
  - Get the associated Powershell scripts;
  - Do a Backup of the Azure Web App;
  - Get the associated Azure Blob file;
  - Unzip this file;
  - Stop the Slot;
  - Upload by FTP the wwwroot folder to the associated slot folder;
  - Start the Slot.

# Overview

![Workflow Overview](/images/Blob-Start-Stop-Approach - Workflow Overview.PNG)

# Prerequisities
- Have a VSTS project
- Configure your Azure Web App (main Slot) with Backups setup to a Blob Storage - manual (not automatic) is ok for the purpose of this demo.
- Optional - Have a GitHub account, I put the scripts on GitHub to share them as open-source but you could use other kind of repository with VSTS.

# VSTS Build Definition

![VSTS Build Definition](/images/Blob-Start-Stop-Approach - Build Definition.PNG)

## Build variables:
- StorageAccountName
- StorageAccountKey
- ContainerName
- BlobFileName

## Build steps/tasks:

- Download Azure Blob Storage Backup file (Azure Powershell)
  - Script Path = scripts/[DownloadAzureBlobStorageFile.ps1](/scripts/DownloadAzureBlobStorageFile.ps1)
  - Script Arguments = $(StorageAccountName) $(StorageAccountKey) $(ContainerName) $(BlobFileName) $(Agent.WorkFolder)
- Extract files (Extract files)
  - Archive file patterns = $(Agent.WorkFolder)/*.zip
  - Destination folder = $(Agent.WorkFolder)/unzipfiles
- Copy Publish Artifact: drop-unzip-files (Copy and Publish Build Artifact)
  - Copy Root = $(Agent.WorkFolder)/unzipfiles/fs/site/wwwroot
  - Content = \**\**
  - Artifact Name = drop-unzip-files
  - Artifact Type = Server
- Copy Publish Artifact: drop-ps1 (Copy and Publish Build Artifact)
  - Copy Root = scripts
  - Content = *.ps1
  - Artifact Name = drop-ps1
  - Artifact Type = Server
  
# VSTS Release Definition

![VSTS Release Definition](/images/Blob-Start-Stop-Approach - Release Definition.PNG)

## Release variables:
- ResourceGroupName
- WebAppName
- Slot

## Release steps/tasks:

- Stop Slot (Azure Powershell)
  - Script Path = $(System.DefaultWorkingDirectory)/Prepare Copy Azure Web App backup to a Slot/drop-ps1/[StopAzureWebAppSlot.ps1](/scripts/StopAzureWebAppSlot.ps1)
  - Script Arguments = $(ResourceGroupName) $(WebAppName) $(Slot)
- FTP Upload (FTP Upload)
  - Source folder = $(System.DefaultWorkingDirectory)/Prepare Copy Azure Web App backup to a Slot/drop-unzip-files
  - File pattern = \**\**
  - Remote directory = /site/wwwroot
  - Clean remote directory = checked, if you want
  - Overwrite = checked
  - Preserve file paths = checked
- Start Slot (Azure Powershell)
  - Script Path = $(System.DefaultWorkingDirectory)/Prepare Copy Azure Web App backup to a Slot/drop-ps1/[StartAzureWebAppSlot.ps1](/scripts/StartAzureWebAppSlot.ps1)
  - Script Arguments = $(ResourceGroupName) $(WebAppName) $(Slot)
  
