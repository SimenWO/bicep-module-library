# Public IP Addresses

This module deploys a Public IP Address.

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
name           | No       | Required. The name of the Public IP Address.
publicIPPrefixResourceId | No       | Optional. Resource ID of the Public IP Prefix object. This is only needed if you want your Public IPs created in a PIP Prefix.
publicIPAllocationMethod | No       | Optional. The public IP address allocation method.
skuName        | No       | Optional. Name of a public IP address SKU.
skuTier        | No       | Optional. Tier of a public IP address SKU.
zones          | No       | Optional. A list of availability zones denoting the IP allocated for the resource needs to come from.
publicIPAddressVersion | No       | Optional. IP address version.
diagnosticStorageAccountId | No       | Optional. Resource ID of the diagnostic storage account.
diagnosticWorkspaceId | No       | Optional. Resource ID of the diagnostic log analytics workspace.
diagnosticEventHubAuthorizationRuleId | No       | Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.
diagnosticEventHubName | No       | Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.
domainNameLabel | No       | Optional. The domain name label. The concatenation of the domain name label and the regionalized DNS zone make up the fully qualified domain name associated with the public IP address. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system.
fqdn           | No       | Optional. The Fully Qualified Domain Name of the A DNS record associated with the public IP. This is the concatenation of the domainNameLabel and the regionalized DNS zone.
reverseFqdn    | No       | Optional. The reverse FQDN. A user-visible, fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN.
lock           | No       | Optional. Specify the type of lock.
location       | No       | Optional. Location for all resources.
roleAssignments | No       | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.
tags           | No       | Optional. Tags of the resource.
diagnosticLogCategoriesToEnable | No       | Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource.
diagnosticMetricsToEnable | No       | Optional. The name of metrics that will be streamed.
diagnosticSettingsName | No       | Optional. The name of the diagnostic setting, if deployed. If left empty, it defaults to "<resourceName>-diagnosticSettings".

### name

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Required. The name of the Public IP Address.

- Default value: `test-ip`

### publicIPPrefixResourceId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Resource ID of the Public IP Prefix object. This is only needed if you want your Public IPs created in a PIP Prefix.

### publicIPAllocationMethod

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The public IP address allocation method.

- Default value: `Dynamic`

- Allowed values: `Dynamic`, `Static`

### skuName

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Name of a public IP address SKU.

- Default value: `Basic`

- Allowed values: `Basic`, `Standard`

### skuTier

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Tier of a public IP address SKU.

- Default value: `Regional`

- Allowed values: `Global`, `Regional`

### zones

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. A list of availability zones denoting the IP allocated for the resource needs to come from.

### publicIPAddressVersion

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. IP address version.

- Default value: `IPv4`

- Allowed values: `IPv4`, `IPv6`

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

### domainNameLabel

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The domain name label. The concatenation of the domain name label and the regionalized DNS zone make up the fully qualified domain name associated with the public IP address. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system.

### fqdn

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The Fully Qualified Domain Name of the A DNS record associated with the public IP. This is the concatenation of the domainNameLabel and the regionalized DNS zone.

### reverseFqdn

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The reverse FQDN. A user-visible, fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN.

### lock

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Specify the type of lock.

- Allowed values: ``, `CanNotDelete`, `ReadOnly`

### location

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Location for all resources.

- Default value: `[resourceGroup().location]`

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

- Allowed values: `allLogs`, `DDoSProtectionNotifications`, `DDoSMitigationFlowLogs`, `DDoSMitigationReports`

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
resourceGroupName | string | The resource group the public IP address was deployed into.
name | string | The name of the public IP address.
resourceId | string | The resource ID of the public IP address.
ipAddress | string | The public IP address of the public IP address resource.
location | string | The location the resource was deployed into.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "modules/res/network/publicIPAddresses/deploy.json"
    },
    "parameters": {
        "name": {
            "value": "test-ip"
        },
        "publicIPPrefixResourceId": {
            "value": ""
        },
        "publicIPAllocationMethod": {
            "value": "Dynamic"
        },
        "skuName": {
            "value": "Basic"
        },
        "skuTier": {
            "value": "Regional"
        },
        "zones": {
            "value": []
        },
        "publicIPAddressVersion": {
            "value": "IPv4"
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
        "domainNameLabel": {
            "value": ""
        },
        "fqdn": {
            "value": ""
        },
        "reverseFqdn": {
            "value": ""
        },
        "lock": {
            "value": ""
        },
        "location": {
            "value": "[resourceGroup().location]"
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


