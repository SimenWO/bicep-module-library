# Virtual Network

This module deploys a Virtual Network.

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
name           | Yes      | Required. The Virtual Network (vNet) Name.
location       | No       | Optional. Location for all resources.
addressPrefixes | Yes      | Required. An Array of 1 or more IP Address Prefixes for the Virtual Network.
subnets        | No       | Optional. An Array of subnets to deploy to the Virtual Network.
dnsServers     | No       | Optional. DNS Servers associated to the Virtual Network.
ddosProtectionPlanId | No       | Optional. Resource ID of the DDoS protection plan to assign the VNET to. If it's left blank, DDoS protection will not be configured. If it's provided, the VNET created by this template will be attached to the referenced DDoS protection plan. The DDoS protection plan can exist in the same or in a different subscription.
peerings       | No       | Optional. Virtual Network Peerings configurations.
vnetEncryption | No       | Optional. Indicates if encryption is enabled on virtual network and if VM without encryption is allowed in encrypted VNet. Requires the EnableVNetEncryption feature to be registered for the subscription and a supported region to use this property.
vnetEncryptionEnforcement | No       | Optional. If the encrypted VNet allows VM that does not support encryption. Can only be used when vnetEncryption is enabled.
flowTimeoutInMinutes | No       | Optional. The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes. Default value 0 will set the property to null.
diagnosticStorageAccountId | No       | Optional. Resource ID of the diagnostic storage account.
diagnosticWorkspaceId | No       | Optional. Resource ID of the diagnostic log analytics workspace.
diagnosticEventHubAuthorizationRuleId | No       | Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.
diagnosticEventHubName | No       | Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.
lock           | No       | Optional. Specify the type of lock.
roleAssignments | No       | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.
tags           | No       | Optional. Tags of the resource.
diagnosticLogCategoriesToEnable | No       | Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource.
diagnosticMetricsToEnable | No       | Optional. The name of metrics that will be streamed.
diagnosticSettingsName | No       | Optional. The name of the diagnostic setting, if deployed. If left empty, it defaults to "<resourceName>-diagnosticSettings".

### name

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. The Virtual Network (vNet) Name.

### location

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Location for all resources.

- Default value: `[resourceGroup().location]`

### addressPrefixes

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. An Array of 1 or more IP Address Prefixes for the Virtual Network.

### subnets

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. An Array of subnets to deploy to the Virtual Network.

### dnsServers

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. DNS Servers associated to the Virtual Network.

### ddosProtectionPlanId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Resource ID of the DDoS protection plan to assign the VNET to. If it's left blank, DDoS protection will not be configured. If it's provided, the VNET created by this template will be attached to the referenced DDoS protection plan. The DDoS protection plan can exist in the same or in a different subscription.

### peerings

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Virtual Network Peerings configurations.

### vnetEncryption

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Indicates if encryption is enabled on virtual network and if VM without encryption is allowed in encrypted VNet. Requires the EnableVNetEncryption feature to be registered for the subscription and a supported region to use this property.

- Default value: `False`

### vnetEncryptionEnforcement

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. If the encrypted VNet allows VM that does not support encryption. Can only be used when vnetEncryption is enabled.

- Default value: `AllowUnencrypted`

- Allowed values: `AllowUnencrypted`, `DropUnencrypted`

### flowTimeoutInMinutes

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes. Default value 0 will set the property to null.

- Default value: `0`

### diagnosticStorageAccountId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Resource ID of the diagnostic storage account.

### diagnosticWorkspaceId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Resource ID of the diagnostic log analytics workspace.

### diagnosticEventHubAuthorizationRuleId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.

### diagnosticEventHubName

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.

### lock

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Specify the type of lock.

- Allowed values: ``, `CanNotDelete`, `ReadOnly`

### roleAssignments

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.

### tags

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Tags of the resource.

### diagnosticLogCategoriesToEnable

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource.

- Default value: `allLogs`

- Allowed values: ``, `allLogs`, `VMProtectionAlerts`

### diagnosticMetricsToEnable

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The name of metrics that will be streamed.

- Default value: `AllMetrics`

- Allowed values: `AllMetrics`

### diagnosticSettingsName

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The name of the diagnostic setting, if deployed. If left empty, it defaults to "<resourceName>-diagnosticSettings".

## Outputs

Name | Type | Description
---- | ---- | -----------
resourceGroupName | string | The resource group the virtual network was deployed into.
resourceId | string | The resource ID of the virtual network.
name | string | The name of the virtual network.
subnetNames | array | The names of the deployed subnets.
subnetResourceIds | array | The resource IDs of the deployed subnets.
location | string | The location the resource was deployed into.
diagnosticsLogs | array | The Diagnostic Settings of the virtual network.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "modules/res/network/virtualNetworks/deploy.json"
    },
    "parameters": {
        "name": {
            "value": ""
        },
        "location": {
            "value": "[resourceGroup().location]"
        },
        "addressPrefixes": {
            "value": []
        },
        "subnets": {
            "value": []
        },
        "dnsServers": {
            "value": []
        },
        "ddosProtectionPlanId": {
            "value": ""
        },
        "peerings": {
            "value": []
        },
        "vnetEncryption": {
            "value": false
        },
        "vnetEncryptionEnforcement": {
            "value": "AllowUnencrypted"
        },
        "flowTimeoutInMinutes": {
            "value": 0
        },
        "diagnosticStorageAccountId": {
            "value": ""
        },
        "diagnosticWorkspaceId": {
            "value": ""
        },
        "diagnosticEventHubAuthorizationRuleId": {
            "value": ""
        },
        "diagnosticEventHubName": {
            "value": ""
        },
        "lock": {
            "value": ""
        },
        "roleAssignments": {
            "value": []
        },
        "tags": {
            "value": {}
        },
        "diagnosticLogCategoriesToEnable": {
            "value": [
                "allLogs"
            ]
        },
        "diagnosticMetricsToEnable": {
            "value": [
                "AllMetrics"
            ]
        },
        "diagnosticSettingsName": {
            "value": ""
        }
    }
}
```


