Param(
    [string] [Parameter(Mandatory=$true)] $StorageAccountName,
    [string] [Parameter(Mandatory=$true)] $StorageAccountKey,
    [string] [Parameter(Mandatory=$true)] $ContainerName,
    [string] [Parameter(Mandatory=$true)] $BlobFileName,
    [string] [Parameter(Mandatory=$true)] $Destination
)

$context = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
Get-AzureStorageBlobContent -Context $context -Container $ContainerName -Blob $BlobFileName -Destination $Destination