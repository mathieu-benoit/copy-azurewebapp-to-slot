This sample consists on documenting how you could restore a backup from one Azure Web App to one of its slot by using Visual Studio Team Services (VSTS).
Two approaches are taken here, it's the opportunity to play with VSTS and Powershell:
- First approach - Use the built-in Azure Web App Backup and Restore feature with the high level steps:
  - Get the associated Powershell script;
  - Do a Backup of the Azure Web App;
  - Restore this Backup to one other slot.
- Second approach - Use the Azure Web App Backup feature but restoring part of it, in our case, just the wwwroot:
  - Get the associated Powershell scripts;
  - Do a Backup of the Azure Web App;
  - Get the associated Azure Blob file.
  - Unzip this file;
  - Stop 
  - Upload by FTP the wwwroot folder to the associated slot folder.

This is 2 different approaches to play with different Powershell scripts and VSTS tasks. Let's adapt them to your needs!

![Workflow Overview](/vsts/Blob-Start-Stop-Approach - Workflow Overview.PNG)

# Prerequisities
- Have a VSTS project
- Configure your Azure Web App (main Slot) with Backups setup to a Blob Storage - manual (not automatic) is ok for the purpose of this demo.
- Optional - Have a GitHub account, I put the scripts on GitHub to share them as open-source but you could use other kind of repository with VSTS.

#First approach - "Built-in Backup/Restore feature"

## VSTS Build Definition

TODO

## VSTS Release Definition

TODO

#Second approach - "Backup and FTP upload of its subset"

## VSTS Build Definition

![VSTS Build Definition](/vsts/Blob-Start-Stop-Approach - Build Definition.PNG)

### Here are the variables of the VSTS Build Definition:
- StorageAccountName
- StorageAccountKey
- ContainerName
- BlobFileName

### Here are the steps/tasks of the VSTS Build Definition:

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
  
## VSTS Release Definition

![VSTS Release Definition](/vsts/Blob-Start-Stop-Approach - Release Definition.PNG)

### Here are the variables of the VSTS Release Definition:
- ResourceGroupName
- WebAppName
- Slot

### Here are the steps/tasks of the VSTS Release Definition:

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

Hope that helps and let's adapt by yourself these 2 approaches for your own context, needs and setups! ;)
  
