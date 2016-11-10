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

TODO

# VSTS Release Definition

TODO

Note: Like explained [here](https://azure.microsoft.com/en-us/documentation/articles/app-service-powershell-backup/) you could improve that by including database backup, setup Schedule automatic backup, etc. 