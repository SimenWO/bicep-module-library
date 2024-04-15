# Private Endpoints

This module deploys a Private Endpoint.

!!! info "Module reference (latest tag)"
    ```
    br:acromethszrrtlas.azurecr.io/modules/res/network/privateendpoints:0.1.0
    ```

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
name           | Yes      | Required. Name of the private endpoint resource to create.
subnetResourceId | Yes      | Required. Resource ID of the subnet where the endpoint needs to be created.
serviceResourceId | Yes      | Required. Resource ID of the resource that needs to be connected to the network.
applicationSecurityGroups | No       | Optional. Application security groups in which the private endpoint IP configuration is included.
customNetworkInterfaceName | No       | Optional. The custom name of the network interface attached to the private endpoint.
ipConfigurations | No       | Optional. A list of IP configurations of the private endpoint. This will be used to map to the First Party Service endpoints.
groupIds       | Yes      | Required. Subtype(s) of the connection to be created. The allowed values depend on the type serviceResourceId refers to.
privateDnsZoneGroup | No       | Optional. The private DNS zone group configuration used to associate the private endpoint with one or multiple private DNS zones. A DNS zone group can support up to 5 DNS zones.
location       | No       | Optional. Location for all Resources.
lock           | No       | Optional. Specify the type of lock.
roleAssignments | No       | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.
tags           | No       | Optional. Tags to be applied on all resources/resource groups in this deployment.
customDnsConfigs | No       | Optional. Custom DNS configurations.
manualPrivateLinkServiceConnections | No       | Optional. Manual PrivateLink Service Connections.

### name

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. Name of the private endpoint resource to create.

### subnetResourceId

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. Resource ID of the subnet where the endpoint needs to be created.

### serviceResourceId

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. Resource ID of the resource that needs to be connected to the network.

### applicationSecurityGroups

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Application security groups in which the private endpoint IP configuration is included.

### customNetworkInterfaceName

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The custom name of the network interface attached to the private endpoint.

### ipConfigurations

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. A list of IP configurations of the private endpoint. This will be used to map to the First Party Service endpoints.

### groupIds

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. Subtype(s) of the connection to be created. The allowed values depend on the type serviceResourceId refers to.

### privateDnsZoneGroup

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The private DNS zone group configuration used to associate the private endpoint with one or multiple private DNS zones. A DNS zone group can support up to 5 DNS zones.

### location

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Location for all Resources.

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

Optional. Tags to be applied on all resources/resource groups in this deployment.

### customDnsConfigs

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Custom DNS configurations.

### manualPrivateLinkServiceConnections

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Manual PrivateLink Service Connections.

## Outputs

Name | Type | Description
---- | ---- | -----------
resourceGroupName | string | The resource group the private endpoint was deployed into.
resourceId | string | The resource ID of the private endpoint.
name | string | The name of the private endpoint.
location | string | The location the resource was deployed into.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "modules/res/network/privateEndpoints/deploy.json"
    },
    "parameters": {
        "name": {
            "value": ""
        },
        "subnetResourceId": {
            "value": ""
        },
        "serviceResourceId": {
            "value": ""
        },
        "applicationSecurityGroups": {
            "value": []
        },
        "customNetworkInterfaceName": {
            "value": ""
        },
        "ipConfigurations": {
            "value": []
        },
        "groupIds": {
            "value": []
        },
        "privateDnsZoneGroup": {
            "value": {}
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
        },
        "customDnsConfigs": {
            "value": []
        },
        "manualPrivateLinkServiceConnections": {
            "value": []
        }
    }
}
```


