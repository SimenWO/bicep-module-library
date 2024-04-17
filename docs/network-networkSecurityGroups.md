# Network Security Group

This module deploys a Network Security Group.

!!! info "Module reference (latest tag)"
    ```
    br:acromethszrrtlas.azurecr.io/modules/res/network/networksecuritygroups:0.1.0
    ```

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
name           | Yes      | Required. Name of the Network Security Group.
location       | No       | Optional. Location for all resources.
securityRules  | No       | Optional. Array of Security Rules to deploy to the Network Security Group. When not provided, an NSG including only the built-in roles will be deployed.
flushConnection | No       | Optional. When enabled, flows created from Network Security Group connections will be re-evaluated when rules are updates. Initial enablement will trigger re-evaluation. Network Security Group connection flushing is not available in all regions.
diagnosticStorageAccountId | No       | Optional. Resource ID of the diagnostic storage account.
diagnosticWorkspaceId | No       | Optional. Resource ID of the diagnostic log analytics workspace.
diagnosticEventHubAuthorizationRuleId | No       | Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.
diagnosticEventHubName | No       | Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.
lock           | No       | Optional. Specify the type of lock.
roleAssignments | No       | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.
tags           | No       | Optional. Tags of the NSG resource.
diagnosticLogCategoriesToEnable | No       | Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource.
diagnosticSettingsName | No       | Optional. The name of the diagnostic setting, if deployed. If left empty, it defaults to "<resourceName>-diagnosticSettings".

### name

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. Name of the Network Security Group.

### location

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Location for all resources.

- Default value: `[resourceGroup().location]`

### securityRules

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Array of Security Rules to deploy to the Network Security Group. When not provided, an NSG including only the built-in roles will be deployed.

### flushConnection

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. When enabled, flows created from Network Security Group connections will be re-evaluated when rules are updates. Initial enablement will trigger re-evaluation. Network Security Group connection flushing is not available in all regions.

- Default value: `False`

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

Optional. Tags of the NSG resource.

### diagnosticLogCategoriesToEnable

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource.

- Default value: `allLogs`

- Allowed values: `allLogs`, `NetworkSecurityGroupEvent`, `NetworkSecurityGroupRuleCounter`

### diagnosticSettingsName

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The name of the diagnostic setting, if deployed. If left empty, it defaults to "<resourceName>-diagnosticSettings".

## Outputs

Name | Type | Description
---- | ---- | -----------
resourceGroupName | string | The resource group the network security group was deployed into.
resourceId | string | The resource ID of the network security group.
name | string | The name of the network security group.
location | string | The location the resource was deployed into.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "modules/res/network/networkSecurityGroups/deploy.json"
    },
    "parameters": {
        "name": {
            "value": ""
        },
        "location": {
            "value": "[resourceGroup().location]"
        },
        "securityRules": {
            "value": []
        },
        "flushConnection": {
            "value": false
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
        "diagnosticSettingsName": {
            "value": ""
        }
    }
}
```


