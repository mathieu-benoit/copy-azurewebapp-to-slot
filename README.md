This sample consists on documenting how you could restore a backup from one Azure Web App to one of its slot by using Visual Studio Team Services (VSTS).
Two approaches are taken here, it's the opportunity to play with VSTS and Powershell:
- [First approach](Backup-Restore-Approach.md) - Use the built-in Azure Web App Backup and Restore feature with the high level steps:
  - Get the associated Powershell script;
  - Do a Backup of the Azure Web App;
  - Restore this Backup to one other slot.
- [Second approach](Blob-Start-Stop-Approach.md) - Use the Azure Web App Backup feature but restoring part of it, in our case, just the wwwroot:
  - Get the associated Powershell scripts;
  - Do a Backup of the Azure Web App;
  - Get the associated Azure Blob file.
  - Unzip this file;
  - Stop 
  - Upload by FTP the wwwroot folder to the associated slot folder.

This is 2 different approaches to play with different Powershell scripts and VSTS tasks.
Hope that helps and let's adapt by yourself these 2 approaches for your own context, needs and setups! ;)