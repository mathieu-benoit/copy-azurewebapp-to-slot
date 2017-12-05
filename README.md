This sample consists on documenting how you could copy one Azure Web App to one slot by using PowerShell.

3 approaches are taken here, it's the opportunity to play with Powershell:
- [First approach](Backup-Restore-Approach.md) - Use the built-in Azure Web App Backup and Restore feature with the high level steps:
  - Get the associated Powershell script;
  - Restore one Backup to one other slot.
  - Important note: maybe easier to set up but be careful here because all the settings are copied/restored.
- [Second approach (more complicated, but why not)](Blob-Start-Stop-Approach.md) - Use the Azure Web App Backup feature but restoring part of it, in our case, just the wwwroot:
  - Get the associated Powershell scripts;
  - Get the associated Azure Blob file of one backup;
  - Unzip this file;
  - Stop the Slot;
  - Upload by FTP the wwwroot folder to the associated slot folder;
  - Start the Slot.

This is 3 different approaches to play with different Powershell scripts.

Hope that helps and let's adapt by yourself these 2 approaches for your own context, needs and setups!