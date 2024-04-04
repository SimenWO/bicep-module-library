metadata name = 'Network Security Group'
metadata description = 'This module deploys a Network Security Group.'

@description('Required. Name of the Network Security Group.')
param name string

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('Optional. Array of Security Rules to deploy to the Network Security Group. When not provided, an NSG including only the built-in roles will be deployed.')
param securityRules array = []

@description('Optional. When enabled, flows created from Network Security Group connections will be re-evaluated when rules are updates. Initial enablement will trigger re-evaluation. Network Security Group connection flushing is not available in all regions.')
param flushConnection bool = false

@description('Optional. Resource ID of the diagnostic storage account.')
param diagnosticStorageAccountId string = ''

// @description('Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely.')
// @minValue(0)
// @maxValue(365)
// param diagnosticLogsRetentionInDays int = 365

@description('Optional. Resource ID of the diagnostic log analytics workspace.')
param diagnosticWorkspaceId string = ''

@description('Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.')
param diagnosticEventHubAuthorizationRuleId string = ''

@description('Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.')
param diagnosticEventHubName string = ''

@allowed([
  ''
  'CanNotDelete'
  'ReadOnly'
])
@description('Optional. Specify the type of lock.')
param lock string = ''

@description('Optional. Array of role assignment objects that contain the \'roleDefinitionIdOrName\' and \'principalId\' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: \'/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11\'.')
param roleAssignments array = []

@description('Optional. Tags of the NSG resource.')
param tags object = {}

@description('Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource.')
@allowed([
  'allLogs'
  'NetworkSecurityGroupEvent'
  'NetworkSecurityGroupRuleCounter'
])
param diagnosticLogCategoriesToEnable array = [
  'allLogs'
]

@description('Optional. The name of the diagnostic setting, if deployed. If left empty, it defaults to "<resourceName>-diagnosticSettings".')
param diagnosticSettingsName string = ''

var builtInRoleNames = {
  'Avere Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4f8fab4f-1852-4a58-a46a-8eaf358af14a')
  'Avere Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'c025889f-8102-4ebf-b32c-fc0c6f0c6bd9')
  'Azure Center for SAP solutions administrator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7b0c7e81-271f-4c71-90bf-e30bdfdbc2f7')
  'Azure Center for SAP solutions reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '05352d14-a920-4328-a0de-4cbe7430e26b')
  'Azure Center for SAP solutions service role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'aabbc5dd-1af0-458b-a942-81af88f9c138')
  'Azure Kubernetes Service Policy Add-on Deployment': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '18ed5180-3e48-46fd-8541-4ea054d57064')
  'Backup Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '5e467623-bb1f-42f4-a55d-6e525e11384b')
  'Backup Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '00c29273-979b-4161-815c-10b084fb9324')
  Contributor: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
  'Cosmos DB Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '230815da-be43-4aae-9cb4-875f7bd000aa')
  'Desktop Virtualization Virtual Machine Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'a959dbd1-f747-45e3-8ba6-dd80f235f97c')
  'DevTest Labs User': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '76283e04-6283-4c54-8f91-bcf1374a3c64')
  'DNS Resolver Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '0f2ebee7-ffd4-4fc0-b3b7-664099fdad5d')
  'DNS Zone Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'befefa01-2a29-4197-83a8-272ff33ce314')
  'DocumentDB Account Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '5bd9cd88-fe45-4216-938b-f97437e15450')
  'Domain Services Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'eeaeda52-9324-47f6-8069-5d5bade478b2')
  'Domain Services Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '361898ef-9ed1-48c2-849c-a832951106bb')
  'LocalNGFirewallAdministrator role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'a8835c7d-b5cb-47fa-b6f0-65ea10ce07a2')
  'Log Analytics Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '92aaf0da-9dab-42b6-94a3-d43ce8d16293')
  'Log Analytics Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '73c42c96-874c-492b-b04d-ab87d138a893')
  'Managed Application Contributor Role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '641177b8-a67a-45b9-a033-47bc880bb21e')
  'Managed Application Operator Role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'c7393b34-138c-406f-901b-d8cf2b17e6ae')
  'Managed Applications Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b9331d33-8a36-4f8c-b097-4f54124fdb44')
  'Monitoring Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '749f88d5-cbae-40b8-bcfc-e573ddc772fa')
  'Monitoring Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '43d0d8ad-25c7-4714-9337-8ba259a9fe05')
  'Network Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4d97b98b-1d4f-4787-a291-c67834d212e7')
  Owner: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8e3af657-a8ff-443c-a75c-2fe8c4bcb635')
  'Private DNS Zone Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b12aa53e-6015-4669-85d0-8515ebb3ae7f')
  Reader: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'acdd72a7-3385-48ef-bd42-f606fba81ae7')
  'Resource Policy Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '36243c78-bf99-498c-9df9-86d9f8d28608')
  'Role Based Access Control Administrator (Preview)': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'f58310d9-a9f6-439a-9e8d-f62e7b41a168')
  'Site Recovery Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '6670b86e-a3f7-4917-ac9b-5d6ab1be4567')
  'Site Recovery Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '494ae006-db33-4328-bf46-533a6560a3ca')
  'SQL Managed Instance Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4939a1f6-9ae0-4e48-a1e0-f2cbe897382d')
  'SQL Security Manager': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '056cd41c-7e88-42e1-933e-88ba6a50c9c3')
  'Storage Account Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '17d1049b-9a84-46fb-8f53-869881c3d3ab')
  'Traffic Manager Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'a4b10055-b0c7-44c2-b00f-c7b5b3550cf7')
  'User Access Administrator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '18d7d88d-d35e-4fb5-a5c3-7773c20a72d9')
  'Virtual Machine Administrator Login': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '1c0163c0-47e6-4577-8991-ea5c82e286e4')
  'Virtual Machine Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '9980e02c-c2be-4d73-94e8-173b1dc7cf3c')
  'Virtual Machine User Login': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'fb879df8-f326-4884-b1cf-06f3ad86be52')
  'Windows Admin Center Administrator Login': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'a6333a3e-0164-44c3-b281-7a577aff287f')
}

var diagnosticsLogsSpecified = [for category in filter(diagnosticLogCategoriesToEnable, item => item != 'allLogs'): {
  category: category
  enabled: true
  /*retentionPolicy: {
      enabled: true
      days: diagnosticLogsRetentionInDays
  }*/
}]

var diagnosticsLogs = contains(diagnosticLogCategoriesToEnable, 'allLogs') ? [
  {
    categoryGroup: 'allLogs'
    enabled: true
    /*retentionPolicy: {
      enabled: true
      days: diagnosticLogsRetentionInDays
  }*/
  }
] : diagnosticsLogsSpecified

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2022-07-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    flushConnection: flushConnection
    securityRules: [for securityRule in securityRules: {
      name: securityRule.name
      properties: {
        protocol: securityRule.properties.protocol
        access: securityRule.properties.access
        priority: securityRule.properties.priority
        direction: securityRule.properties.direction
        description: contains(securityRule.properties, 'description') ? securityRule.properties.description : ''
        sourcePortRange: contains(securityRule.properties, 'sourcePortRange') ? securityRule.properties.sourcePortRange : ''
        sourcePortRanges: contains(securityRule.properties, 'sourcePortRanges') ? securityRule.properties.sourcePortRanges : []
        destinationPortRange: contains(securityRule.properties, 'destinationPortRange') ? securityRule.properties.destinationPortRange : ''
        destinationPortRanges: contains(securityRule.properties, 'destinationPortRanges') ? securityRule.properties.destinationPortRanges : []
        sourceAddressPrefix: contains(securityRule.properties, 'sourceAddressPrefix') ? securityRule.properties.sourceAddressPrefix : ''
        destinationAddressPrefix: contains(securityRule.properties, 'destinationAddressPrefix') ? securityRule.properties.destinationAddressPrefix : ''
        sourceAddressPrefixes: contains(securityRule.properties, 'sourceAddressPrefixes') ? securityRule.properties.sourceAddressPrefixes : []
        destinationAddressPrefixes: contains(securityRule.properties, 'destinationAddressPrefixes') ? securityRule.properties.destinationAddressPrefixes : []
        sourceApplicationSecurityGroups: contains(securityRule.properties, 'sourceApplicationSecurityGroups') ? securityRule.properties.sourceApplicationSecurityGroups : []
        destinationApplicationSecurityGroups: contains(securityRule.properties, 'destinationApplicationSecurityGroups') ? securityRule.properties.destinationApplicationSecurityGroups : []
      }
    }]
  }
}

module networkSecurityGroup_securityRules 'securityRules/deploy.bicep' = [for (securityRule, index) in securityRules: {
  name: '${uniqueString(deployment().name, location)}-securityRule-${index}'
  params: {
    name: securityRule.name
    networkSecurityGroupName: networkSecurityGroup.name
    protocol: securityRule.properties.protocol
    access: securityRule.properties.access
    priority: securityRule.properties.priority
    direction: securityRule.properties.direction
    description: contains(securityRule.properties, 'description') ? securityRule.properties.description : ''
    sourcePortRange: contains(securityRule.properties, 'sourcePortRange') ? securityRule.properties.sourcePortRange : ''
    sourcePortRanges: contains(securityRule.properties, 'sourcePortRanges') ? securityRule.properties.sourcePortRanges : []
    destinationPortRange: contains(securityRule.properties, 'destinationPortRange') ? securityRule.properties.destinationPortRange : ''
    destinationPortRanges: contains(securityRule.properties, 'destinationPortRanges') ? securityRule.properties.destinationPortRanges : []
    sourceAddressPrefix: contains(securityRule.properties, 'sourceAddressPrefix') ? securityRule.properties.sourceAddressPrefix : ''
    destinationAddressPrefix: contains(securityRule.properties, 'destinationAddressPrefix') ? securityRule.properties.destinationAddressPrefix : ''
    sourceAddressPrefixes: contains(securityRule.properties, 'sourceAddressPrefixes') ? securityRule.properties.sourceAddressPrefixes : []
    destinationAddressPrefixes: contains(securityRule.properties, 'destinationAddressPrefixes') ? securityRule.properties.destinationAddressPrefixes : []
    sourceApplicationSecurityGroups: contains(securityRule.properties, 'sourceApplicationSecurityGroups') ? securityRule.properties.sourceApplicationSecurityGroups : []
    destinationApplicationSecurityGroups: contains(securityRule.properties, 'destinationApplicationSecurityGroups') ? securityRule.properties.destinationApplicationSecurityGroups : []
  }
}]

resource networkSecurityGroup_lock 'Microsoft.Authorization/locks@2020-05-01' = if (!empty(lock)) {
  name: '${networkSecurityGroup.name}-${lock}-lock'
  properties: {
    level: any(lock)
    notes: lock == 'CanNotDelete' ? 'Cannot delete resource or child resources.' : 'Cannot modify the resource or child resources.'
  }
  scope: networkSecurityGroup
}

resource networkSecurityGroup_diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if (!empty(diagnosticStorageAccountId) || !empty(diagnosticWorkspaceId) || !empty(diagnosticEventHubAuthorizationRuleId) || !empty(diagnosticEventHubName)) {
  name: !empty(diagnosticSettingsName) ? diagnosticSettingsName : '${name}-diagnosticSettings'
  properties: {
    storageAccountId: !empty(diagnosticStorageAccountId) ? diagnosticStorageAccountId : null
    workspaceId: !empty(diagnosticWorkspaceId) ? diagnosticWorkspaceId : null
    eventHubAuthorizationRuleId: !empty(diagnosticEventHubAuthorizationRuleId) ? diagnosticEventHubAuthorizationRuleId : null
    eventHubName: !empty(diagnosticEventHubName) ? diagnosticEventHubName : null
    logs: diagnosticsLogs
  }
  scope: networkSecurityGroup
}

resource networkSecurityGroup_roleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for (roleAssignment, index) in (roleAssignments ?? []): {
  name: guid(networkSecurityGroup.id, roleAssignment.principalId, roleAssignment.roleDefinitionIdOrName)
  properties: {
    roleDefinitionId: contains(builtInRoleNames, roleAssignment.roleDefinitionIdOrName) ? builtInRoleNames[roleAssignment.roleDefinitionIdOrName] : contains(roleAssignment.roleDefinitionIdOrName, '/providers/Microsoft.Authorization/roleDefinitions/') ? roleAssignment.roleDefinitionIdOrName : subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleAssignment.roleDefinitionIdOrName)
    principalId: roleAssignment.principalId
    description: roleAssignment.?description
    principalType: roleAssignment.?principalType
    condition: roleAssignment.?condition
    conditionVersion: !empty(roleAssignment.?condition) ? (roleAssignment.?conditionVersion ?? '2.0') : null // Must only be set if condtion is set
    delegatedManagedIdentityResourceId: roleAssignment.?delegatedManagedIdentityResourceId
  }
  scope: networkSecurityGroup
}]

@description('The resource group the network security group was deployed into.')
output resourceGroupName string = resourceGroup().name

@description('The resource ID of the network security group.')
output resourceId string = networkSecurityGroup.id

@description('The name of the network security group.')
output name string = networkSecurityGroup.name

@description('The location the resource was deployed into.')
output location string = networkSecurityGroup.location
