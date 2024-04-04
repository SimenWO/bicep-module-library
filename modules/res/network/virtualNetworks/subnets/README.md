# Subnets

This module deploys a Subnet.

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
name           | Yes      | Optional. The Name of the subnet resource.
virtualNetworkName | Yes      | Conditional. The name of the parent virtual network. Required if the template is used in a standalone deployment.
addressPrefix  | Yes      | Required. The address prefix for the subnet.
networkSecurityGroupId | No       | Optional. The resource ID of the network security group to assign to the subnet.
routeTableId   | No       | Optional. The resource ID of the route table to assign to the subnet.
serviceEndpoints | No       | Optional. The service endpoints to enable on the subnet.
delegations    | No       | Optional. The delegations to enable on the subnet.
natGatewayId   | No       | Optional. The resource ID of the NAT Gateway to use for the subnet.
privateEndpointNetworkPolicies | No       | Optional. enable or disable apply network policies on private endpoint in the subnet.
privateLinkServiceNetworkPolicies | No       | Optional. enable or disable apply network policies on private link service in the subnet.
addressPrefixes | No       | Optional. List of address prefixes for the subnet.
applicationGatewayIpConfigurations | No       | Optional. Application gateway IP configurations of virtual network resource.
ipAllocations  | No       | Optional. Array of IpAllocation which reference this subnet.
serviceEndpointPolicies | No       | Optional. An array of service endpoint policies.
roleAssignments | No       | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.

### name

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. The Name of the subnet resource.

### virtualNetworkName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Conditional. The name of the parent virtual network. Required if the template is used in a standalone deployment.

### addressPrefix

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. The address prefix for the subnet.

### networkSecurityGroupId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The resource ID of the network security group to assign to the subnet.

### routeTableId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The resource ID of the route table to assign to the subnet.

### serviceEndpoints

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The service endpoints to enable on the subnet.

### delegations

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The delegations to enable on the subnet.

### natGatewayId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The resource ID of the NAT Gateway to use for the subnet.

### privateEndpointNetworkPolicies

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. enable or disable apply network policies on private endpoint in the subnet.

- Allowed values: `Disabled`, `Enabled`, ``

### privateLinkServiceNetworkPolicies

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. enable or disable apply network policies on private link service in the subnet.

- Allowed values: `Disabled`, `Enabled`, ``

### addressPrefixes

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. List of address prefixes for the subnet.

### applicationGatewayIpConfigurations

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Application gateway IP configurations of virtual network resource.

### ipAllocations

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Array of IpAllocation which reference this subnet.

### serviceEndpointPolicies

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. An array of service endpoint policies.

### roleAssignments

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.

## Outputs

Name | Type | Description
---- | ---- | -----------
resourceGroupName | string | The resource group the virtual network peering was deployed into.
name | string | The name of the virtual network peering.
resourceId | string | The resource ID of the virtual network peering.
subnetAddressPrefix | string | The address prefix for the subnet.
subnetAddressPrefixes | array | List of address prefixes for the subnet.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "modules/res/network/virtualNetworks/subnets/deploy.json"
    },
    "parameters": {
        "name": {
            "value": ""
        },
        "virtualNetworkName": {
            "value": ""
        },
        "addressPrefix": {
            "value": ""
        },
        "networkSecurityGroupId": {
            "value": ""
        },
        "routeTableId": {
            "value": ""
        },
        "serviceEndpoints": {
            "value": []
        },
        "delegations": {
            "value": []
        },
        "natGatewayId": {
            "value": ""
        },
        "privateEndpointNetworkPolicies": {
            "value": ""
        },
        "privateLinkServiceNetworkPolicies": {
            "value": ""
        },
        "addressPrefixes": {
            "value": []
        },
        "applicationGatewayIpConfigurations": {
            "value": []
        },
        "ipAllocations": {
            "value": []
        },
        "serviceEndpointPolicies": {
            "value": []
        },
        "roleAssignments": {
            "value": []
        }
    }
}
```


