targetScope = 'subscription'

@minLength(5)
@maxLength(50)
@description('Provide a globally unique name of your Azure Container Registry')
param acrName string

@minLength(1)
@maxLength(40)
@description('Required. The name of the static site.')
param swaName string 

param repositoryUrl string

@description('Location og the deployment')
param location string = deployment().location

@description('Bicep registry resource group name')
param bicepRegistryRGName string

@description('Tags represents a list of key vaule pairs that describe the resoruce ')
param tags object = {}

// ---------
// VARIABLES
// ---------

// ---------
// RESOURCES
// ---------

resource bicepRegistryRG 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: bicepRegistryRGName
  location: location
  tags: tags
}

module acr 'br/public:avm/res/container-registry/registry:0.1.0' = {
  name: '${deployment().name}-acrDeploy'
  scope: bicepRegistryRG
  params: {
    name: acrName
    acrSku: 'Basic'
    tags: tags
  }
}

// Placeholder for Static Web App

module swa 'br/public:avm/res/web/static-site:0.3.0' = {
  name: '${deployment().name}-swaDeploy'
  scope: bicepRegistryRG
  params: {
    name: swaName
    sku: 'Free'
    location: location
    repositoryUrl: repositoryUrl
    allowConfigFileUpdates: true
    branch: 'main'
    provider: 'Github'
  }
}
