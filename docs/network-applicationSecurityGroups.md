# Application Security Group

This module deploys a Application Security Group.

!!! info "Module reference (latest tag)"
    ```
    br:acromethszrrtlas.azurecr.io/modules/res/network/applicationsecuritygroups:0.1.0
    ```

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
name           | Yes      | Required. Name of the Application Security Group.
location       | No       | Optional. Location for all resources.
lock           | No       | Optional. Specify the type of lock.
roleAssignments | No       | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.
tags           | No       | Optional. Tags of the resource.

### name

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. Name of the Application Security Group.

### location

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Location for all resources.

- Default value: `[resourceGroup().location]`

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

## Outputs

Name | Type | Description
---- | ---- | -----------
resourceGroupName | string | The resource group the application security group was deployed into.
resourceId | string | The resource ID of the application security group.
name | string | The name of the application security group.
location | string | The location the resource was deployed into.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "modules/res/network/applicationSecurityGroups/deploy.json"
    },
    "parameters": {
        "name": {
            "value": ""
        },
        "location": {
            "value": "[resourceGroup().location]"
        },
        "lock": {
            "value": ""
        },
        "roleAssignments": {
            "value": []
        },
        "tags": {
            "value": {}
        }
    }
}
```


