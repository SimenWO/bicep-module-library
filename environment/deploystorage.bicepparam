using 'deploystorage.bicep'
@sys.description('The name of the resource group to deploy. (Default: Dev)')
param deploymentEnvironment = 'Dev'

param avdWorkloadSubsId = '9d4dc425-441e-4724-9154-6ea08c34f756'

@sys.description('Location where to deploy compute services. (Default: eastus2)')
param avdSessionHostLocation = 'westeurope'

param location = ''
