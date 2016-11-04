This sample consists on documenting how you could copy the wwwroot folder content from one Azure Web App to one Slot by using Visual Studio Team Services (VSTS).
There is no built-in feature for doing that currently, so with this sample it's the opportunity to play with VSTS ;)

![Workflow Overview](/vsts/Workflow Overview.PNG)

# Prerequisities
- Have a VSTS project
- Configure your Azure Web App (main Slot) with Backups setup to a Blob Storage
- Optional - Have a GitHub account, I put the scripts on GitHub to share them as open-source but you could use any kind of repository with VSTS.

# VSTS Build Definition

![VSTS Build Definition](/vsts/Build Definition.PNG)

## Here are the variables of the VSTS Build Definition:
- StorageAccountName
- StorageAccountKey
- ContainerName
- BlobFileName

## Here are the steps/tasks of the VSTS Build Definition:

- Download Azure Blob Storage Backup file (Azure Powershell)
  - Script Path = scripts/DownloadAzureBlobStorageFile.ps1
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

![VSTS Release Definition](/vsts/Release Definition.PNG)

## Here are the variables of the VSTS Release Definition:
- ResourceGroupName
- WebAppName
- Slot

## Here are the steps/tasks of the VSTS Release Definition:

- Stop Slot (Azure Powershell)
  - Script Path = $(System.DefaultWorkingDirectory)/Prepare Copy Azure Web App backup to a Slot/drop-ps1/StopAzureWebAppSlot.ps1
  - Script Arguments = $(ResourceGroupName) $(WebAppName) $(Slot)
- FTP Upload (FTP Upload)
  - Source folder = $(System.DefaultWorkingDirectory)/Prepare Copy Azure Web App backup to a Slot/drop-unzip-files
  - File pattern = \**\**
  - Remote directory = /site/wwwroot
  - Clean remote directory = checked, if you want
  - Overwrite = checked
  - Preserve file paths = checked
- Start Slot (Azure Powershell)
  - Script Path = $(System.DefaultWorkingDirectory)/Prepare Copy Azure Web App backup to a Slot/drop-ps1/StartAzureWebAppSlot.ps1
  - Script Arguments = $(ResourceGroupName) $(WebAppName) $(Slot)

Hope that helps and let's adapt by yourself this approach for your own needs and setups! ;)
  
