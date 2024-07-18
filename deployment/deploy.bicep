@description('The name of the Web App')
param webAppName string

@description('The region where the resources will be deployed')
param location string

@description('The SKU of the App Service Plan')
param sku string = 'F1'

var appServicePlanName = '${webAppName}-asp'

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
    tier: 'Free'
  }
  properties: {
    reserved: false
  }
}

resource webApp 'Microsoft.Web/sites@2020-12-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

output webAppName string = webApp.name
output appServicePlanName string = appServicePlan.name
