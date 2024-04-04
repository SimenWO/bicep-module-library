# Private DNS Zone Groups

This module deploys a Private Endpoint - Private DNS Zone Groups.

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
privateEndpointName | Yes      | Conditional. The name of the parent private endpoint. Required if the template is used in a standalone deployment.
privateDNSResourceIds | Yes      | Required. Array of private DNS zone resource IDs. A DNS zone group can support up to 5 DNS zones.
name           | No       | Optional. The name of the private DNS zone group.

### privateEndpointName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Conditional. The name of the parent private endpoint. Required if the template is used in a standalone deployment.

### privateDNSResourceIds

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. Array of private DNS zone resource IDs. A DNS zone group can support up to 5 DNS zones.

### name

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The name of the private DNS zone group.

- Default value: `default`

## Outputs

Name | Type | Description
---- | ---- | -----------
name | string | The name of the private endpoint DNS zone group.
resourceId | string | The resource ID of the private endpoint DNS zone group.
resourceGroupName | string | The resource group the private endpoint DNS zone group was deployed into.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "modules/res/network/privateEndpoints/privateDnsZoneGroups/deploy.json"
    },
    "parameters": {
        "privateEndpointName": {
            "value": ""
        },
        "privateDNSResourceIds": {
            "value": []
        },
        "name": {
            "value": "default"
        }
    }
}
```


