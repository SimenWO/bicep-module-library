using './main.bicep'

param acrName = 'acrbicepmodulelibrary' //Choose your own name
param bicepRegistryRGName = 'acrservice-dev-rg' //Choose your own name for your Resource Group
param swaName = 'bicepmodulelibrary'
param repositoryUrl = 'https://github.com/SimenWO/bicep-module-library'
