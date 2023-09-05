$rgName = "rg-terraform-tfstate-01"
$location = "northeurope"
$storageAccount = "tfstatestorage011"
$container = "tfstatecontainer01"

# create resource group
az group create --name $rgName --location $location

# create storage account
az storage account create `
    --name $storageAccount `
    --resource-group $rgName `
    --kind StorageV2 `
    --sku Standard_LRS `
    --https-only true `
    --allow-blob-public-access false

# create storage container
az storage container create --name $container --account-name $storageAccount --public-access "off"

# get SAS token
$Date = (Get-Date).AddDays(5).ToString('yyyy-MM-dd')
$key = $( az storage account keys list --resource-group $rgName --account-name $storageAccount --query [0].value -o tsv )
$sas = $( az storage container generate-sas --name $container --expiry $Date --permissions "racwdli" --account-name $storageAccount --account-key "$key" )
Write-Host "SAS Token: $sas"
