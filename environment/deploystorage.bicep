targetScope = 'subscription'

@sys.description('Do not modify, used to set unique value for resource deployment.')
param time string = utcNow()

@minLength(2)
@maxLength(4)
@sys.description('The name of the resource group to deploy. (Default: AVD1)')
param deploymentPrefix string = 'AVD1'

@allowed([
  'Dev' // Development
  'Test' // Test
  'Prod' // Production
])
@sys.description('The name of the resource group to deploy. (Default: Dev)')
param deploymentEnvironment string = 'Dev'

@sys.description('The subscription ID where the resources will be deployed.')
param avdWorkloadSubsId string 

@sys.description('Location where to deploy compute services. (Default: eastus2)')
param avdSessionHostLocation string = 'westeurope'



// Parameters for Storage Account and custom scripts
@sys.description('Use custom naming for the custom scripts resource group.')
param avdUseCustomNaming bool = false

@sys.description('The name of the custom scripts resource group.')
param avdCustomScriptsRgCustomName string = ''

@sys.description('Enable custom scripts.')
param enableCustomScripts bool = false

@sys.description('Tags to apply to the resources.')
param tags object = {}


// Variables
var varDeploymentPrefixLowercase = toLower(deploymentPrefix)
var varDeploymentEnvironmentLowercase = toLower(deploymentEnvironment)
var varLocations = loadJsonContent('../modules/variables/locations.json')
var varSessionHostLocationLowercase = toLower(replace(avdSessionHostLocation, ' ', ''))
var varSessionHostLocationAcronym = varLocations[varSessionHostLocationLowercase].acronym
var varComputeStorageResourcesNamingStandard = '${varDeploymentPrefixLowercase}-${varDeploymentEnvironmentLowercase}-${varSessionHostLocationAcronym}'
var varCustomScriptsRgName = avdUseCustomNaming
  ? avdCustomScriptsRgCustomName
  : 'rg-avd-${varComputeStorageResourcesNamingStandard}-customscripts-storage'

var varCustomScriptsStorageAccountName = 'stcs${varDeploymentEnvironmentLowercase}${substring(guid(customScriptsResourceGroup.outputs.name), 0, 4)}'
var varCustomScriptsContainerName = 'customscripts'


// Resource Group for Custom Scripts Storage Account
module customScriptsResourceGroup 'br/public:avm/res/resources/resource-group:0.2.4' =
  if (enableCustomScripts) {
    scope: subscription(avdWorkloadSubsId)
    name: 'CustomScriptsStorage-RG-${time}'
    params: {
      name: varCustomScriptsRgName
      location: avdSessionHostLocation
      tags: tags
    }
  }


// Storage Account for Custom Scripts 
module customScriptsStorageAccount 'br/public:avm/res/storage/storage-account:0.9.1' =
  if (enableCustomScripts) {
    name: 'CustomScriptsStorage-${time}'
    scope: resourceGroup('${avdWorkloadSubsId}', '${varCustomScriptsRgName}')
    params: {
      name: varCustomScriptsStorageAccountName
      location: avdSessionHostLocation
      kind: 'StorageV2'
      skuName: 'Standard_LRS'
      accessTier: 'Hot'
      publicNetworkAccess: 'Enabled'
      tags: tags
      blobServices: {
        containers: [
          {
            name: varCustomScriptsContainerName
          }
        ]
      }
      networkAcls: {
        defaultAction: 'Allow'
        ipRules: []
        virtualNetworkRules: []
        bypass: 'AzureServices'
      }
    }
    dependsOn: [
      customScriptsResourceGroup
    ]
  }

output storageAccountName string = customScriptsStorageAccount.outputs.name
output containerName string = varCustomScriptsContainerName
