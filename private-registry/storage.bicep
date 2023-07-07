@description('The prefix that will appear infront of storage account name.')
@allowed([
  'dev'
  'test'
  'prod'
])
param namePrefix string = 'dev'

@description('The storage account name.')
@minLength(3)
@maxLength(24)
param paramStorageName string = '${namePrefix}${uniqueString(resourceGroup().id)}'

@description('Transformed storage name')
var stgName = toLower(paramStorageName)

@description('The flag that set the geo-redundant storage.')
param geoRedundancy bool = false

param azureRegion string = resourceGroup().location

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: stgName
  location: azureRegion
  kind: 'StorageV2' 
  sku: {
    name: geoRedundancy ? 'Standard_GRS' : 'Standard_LRS'
  }
}

resource lockResourceGroup 'Microsoft.Authorization/locks@2016-09-01' = {
  name: 'DontDelete'
  scope: storageAccount
  properties: {
    level: 'CanNotDelete'
  }
}
