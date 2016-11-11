Param(
    [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] [Parameter(Mandatory=$true)] $WebAppName,
    [string] [Parameter(Mandatory=$true)] $SlotName,
    [string] [Parameter(Mandatory=$true)] $StorageAccountName,
    [string] [Parameter(Mandatory=$true)] $ContainerName,
    [string] [Parameter(Mandatory=$true)] $BlobFileName
)

#Login-AzureRmAccount

$storageAccountKey = Get-AzureRmStorageAccountKey -ResourceGroupName $ResourceGroupName -Name $StorageAccountName
$context = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $storageAccountKey[0].Value
$sasUrl = New-AzureStorageContainerSASToken -Name $ContainerName -Permission rwdl -Context $context -ExpiryTime (Get-Date).AddDays(1) -FullUri

Restore-AzureRmWebAppBackup -ResourceGroupName $ResourceGroupName -Name $WebAppName -Slot $SlotName -StorageAccountUrl $sasUrl -BlobName $BlobFileName -Overwrite