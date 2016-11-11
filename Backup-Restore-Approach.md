This sample consists on using the built-in Azure Web App Backup and Restore feature with the high level steps:
  - Get the associated Powershell script;
  - Do a Backup of the Azure Web App;
  - Restore this Backup to one other slot.

# Overview

![Workflow Overview](/images/Backup-Restore-Approach - Workflow Overview.PNG)

# Prerequisities
- Have a VSTS project
- Configure your Azure Web App (main Slot) with Backups setup to a Blob Storage - manual (not automatic) is ok for the purpose of this demo.
- Optional - Have a GitHub account, I put the scripts on GitHub to share them as open-source but you could use other kind of repository with VSTS.

# VSTS Build Definition

![VSTS Build Definition](/images/Backup-Restore-Approach - Build Definition.PNG)

## Build variables:
- N/A

## Build steps/tasks:
- Copy Publish Artifact: drop-ps1 (Copy and Publish Build Artifact)
  - Copy Root = scripts
  - Content = *.ps1
  - Artifact Name = drop-ps1
  - Artifact Type = Server

# VSTS Release Definition

![VSTS Release Definition](/images/Backup-Restore-Approach - Release Definition.PNG)

## Release variables:
- ResourceGroupName
- WebAppName
- Slot
- StorageAccountName
- ContainerName
- BlobFileName

## Release steps/tasks:
- Restore backup to Slot (Azure Powershell)
  - Script Path = $(System.DefaultWorkingDirectory)/{build-name}/drop-ps1/[RestoreAzureWebAppBackup.ps1](/scripts/RestoreAzureWebAppBackup.ps1)
  - Script Arguments = $(ResourceGroupName) $(WebAppName) $(SlotName) $(StorageAccountName) $(ContainerName) $(BlobFileName)

Note: Like explained [here](https://azure.microsoft.com/en-us/documentation/articles/app-service-powershell-backup/) you could improve that by including database backup, setup Schedule automatic backup, etc. 