# Virtual Network Peerings

This module deploys a Virtual Network Peering.

!!! info "Module reference (latest tag)"
    ```
    br:acromethszrrtlas.azurecr.io/modules/res/network/virtualnetworkpeerings:0.1.0
    ```

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
name           | No       | Optional. The Name of Vnet Peering resource. If not provided, default value will be localVnetName-remoteVnetName.
localVnetName  | Yes      | Conditional. The name of the parent Virtual Network to add the peering to. Required if the template is used in a standalone deployment.
remoteVirtualNetworkId | Yes      | Required. The Resource ID of the VNet that is this Local VNet is being peered to. Should be in the format of a Resource ID.
allowForwardedTraffic | No       | Optional. Whether the forwarded traffic from the VMs in the local virtual network will be allowed/disallowed in remote virtual network. Default is true.
allowGatewayTransit | No       | Optional. If gateway links can be used in remote virtual networking to link to this virtual network. Default is false.
allowVirtualNetworkAccess | No       | Optional. Whether the VMs in the local virtual network space would be able to access the VMs in remote virtual network space. Default is true.
doNotVerifyRemoteGateways | No       | Optional. If we need to verify the provisioning state of the remote gateway. Default is true.
useRemoteGateways | No       | Optional. If remote gateways can be used on this virtual network. If the flag is set to true, and allowGatewayTransit on remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. Default is false.

### name

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The Name of Vnet Peering resource. If not provided, default value will be localVnetName-remoteVnetName.

- Default value: `[format('{0}-{1}', parameters('localVnetName'), last(split(parameters('remoteVirtualNetworkId'), '/')))]`

### localVnetName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Conditional. The name of the parent Virtual Network to add the peering to. Required if the template is used in a standalone deployment.

### remoteVirtualNetworkId

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. The Resource ID of the VNet that is this Local VNet is being peered to. Should be in the format of a Resource ID.

### allowForwardedTraffic

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Whether the forwarded traffic from the VMs in the local virtual network will be allowed/disallowed in remote virtual network. Default is true.

- Default value: `True`

### allowGatewayTransit

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. If gateway links can be used in remote virtual networking to link to this virtual network. Default is false.

- Default value: `False`

### allowVirtualNetworkAccess

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Whether the VMs in the local virtual network space would be able to access the VMs in remote virtual network space. Default is true.

- Default value: `True`

### doNotVerifyRemoteGateways

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. If we need to verify the provisioning state of the remote gateway. Default is true.

- Default value: `True`

### useRemoteGateways

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. If remote gateways can be used on this virtual network. If the flag is set to true, and allowGatewayTransit on remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. Default is false.

- Default value: `False`

## Outputs

Name | Type | Description
---- | ---- | -----------
resourceGroupName | string | The resource group the virtual network peering was deployed into.
name | string | The name of the virtual network peering.
resourceId | string | The resource ID of the virtual network peering.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "modules/res/network/virtualNetworks/virtualNetworkPeerings/deploy.json"
    },
    "parameters": {
        "name": {
            "value": "[format('{0}-{1}', parameters('localVnetName'), last(split(parameters('remoteVirtualNetworkId'), '/')))]"
        },
        "localVnetName": {
            "value": ""
        },
        "remoteVirtualNetworkId": {
            "value": ""
        },
        "allowForwardedTraffic": {
            "value": true
        },
        "allowGatewayTransit": {
            "value": false
        },
        "allowVirtualNetworkAccess": {
            "value": true
        },
        "doNotVerifyRemoteGateways": {
            "value": true
        },
        "useRemoteGateways": {
            "value": false
        }
    }
}
```


