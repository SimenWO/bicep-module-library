# Network Interfaces

This module deploys a Network Interface.

!!! info "Module reference (latest tag)"
    ```
    br:acromethszrrtlas.azurecr.io/modules/res/network/networkinterfaces:0.1.0
    ```

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
name           | Yes      | Required. The name of the network interface.
location       | No       | Optional. Location for all resources.
tags           | No       | Optional. Tags of the resource.
enableIPForwarding | No       | Optional. Indicates whether IP forwarding is enabled on this network interface.
enableAcceleratedNetworking | No       | Optional. If the network interface is accelerated networking enabled.
dnsServers     | No       | Optional. List of DNS servers IP addresses. Use 'AzureProvidedDNS' to switch to azure provided DNS resolution. 'AzureProvidedDNS' value cannot be combined with other IPs, it must be the only value in dnsServers collection.
networkSecurityGroupResourceId | No       | Optional. The network security group (NSG) to attach to the network interface.
auxiliaryMode  | No       | Optional. Auxiliary mode of Network Interface resource. Not all regions are enabled for Auxiliary Mode Nic.
disableTcpStateTracking | No       | Optional. Indicates whether to disable tcp state tracking. Subscription must be registered for the Microsoft.Network/AllowDisableTcpStateTracking feature before this property can be set to true.
ipConfigurations | Yes      | Required. A list of IPConfigurations of the network interface.
lock           | No       | Optional. Specify the type of lock.
roleAssignments | No       | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.
diagnosticStorageAccountId | No       | Optional. Resource ID of the diagnostic storage account.
diagnosticWorkspaceId | No       | Optional. Resource identifier of log analytics.
diagnosticEventHubAuthorizationRuleId | No       | Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.
diagnosticEventHubName | No       | Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.
diagnosticMetricsToEnable | No       | Optional. The name of metrics that will be streamed.
diagnosticSettingsName | No       | Optional. The name of the diagnostic setting, if deployed. If left empty, it defaults to "<resourceName>-diagnosticSettings".

### name

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. The name of the network interface.

### location

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Location for all resources.

- Default value: `[resourceGroup().location]`

### tags

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Tags of the resource.

### enableIPForwarding

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Indicates whether IP forwarding is enabled on this network interface.

- Default value: `False`

### enableAcceleratedNetworking

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. If the network interface is accelerated networking enabled.

- Default value: `False`

### dnsServers

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. List of DNS servers IP addresses. Use 'AzureProvidedDNS' to switch to azure provided DNS resolution. 'AzureProvidedDNS' value cannot be combined with other IPs, it must be the only value in dnsServers collection.

### networkSecurityGroupResourceId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The network security group (NSG) to attach to the network interface.

### auxiliaryMode

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Auxiliary mode of Network Interface resource. Not all regions are enabled for Auxiliary Mode Nic.

- Default value: `None`

- Allowed values: `Floating`, `MaxConnections`, `None`

### disableTcpStateTracking

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Indicates whether to disable tcp state tracking. Subscription must be registered for the Microsoft.Network/AllowDisableTcpStateTracking feature before this property can be set to true.

- Default value: `False`

### ipConfigurations

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. A list of IPConfigurations of the network interface.

### lock

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Specify the type of lock.

- Allowed values: ``, `CanNotDelete`, `ReadOnly`

### roleAssignments

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.

### diagnosticStorageAccountId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Resource ID of the diagnostic storage account.

### diagnosticWorkspaceId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Resource identifier of log analytics.

### diagnosticEventHubAuthorizationRuleId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.

### diagnosticEventHubName

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.

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
name | string | The name of the deployed resource.
resourceId | string | The resource ID of the deployed resource.
resourceGroupName | string | The resource group of the deployed resource.
location | string | The location the resource was deployed into.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "modules/res/network/networkInterfaces/deploy.json"
    },
    "parameters": {
        "name": {
            "value": ""
        },
        "location": {
            "value": "[resourceGroup().location]"
        },
        "tags": {
            "value": {}
        },
        "enableIPForwarding": {
            "value": false
        },
        "enableAcceleratedNetworking": {
            "value": false
        },
        "dnsServers": {
            "value": []
        },
        "networkSecurityGroupResourceId": {
            "value": ""
        },
        "auxiliaryMode": {
            "value": "None"
        },
        "disableTcpStateTracking": {
            "value": false
        },
        "ipConfigurations": {
            "value": []
        },
        "lock": {
            "value": ""
        },
        "roleAssignments": {
            "value": []
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


