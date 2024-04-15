# Security Rules

This module deploys a Network Security Group - Security Rule.

!!! info "Module reference (latest tag)"
    ```
    br:acromethszrrtlas.azurecr.io/modules/res/network/networksecuritygroups/securityrules:0.1.0
    ```

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
name           | Yes      | Required. The name of the security rule.
networkSecurityGroupName | Yes      | Conditional. The name of the parent network security group to deploy the security rule into. Required if the template is used in a standalone deployment.
access         | No       | Optional. Whether network traffic is allowed or denied.
description    | No       | Optional. A description for this rule.
destinationAddressPrefix | No       | Optional. The destination address prefix. CIDR or destination IP range. Asterisk "*" can also be used to match all source IPs. Default tags such as "VirtualNetwork", "AzureLoadBalancer" and "Internet" can also be used.
destinationAddressPrefixes | No       | Optional. The destination address prefixes. CIDR or destination IP ranges.
destinationApplicationSecurityGroups | No       | Optional. The application security group specified as destination.
destinationPortRange | No       | Optional. The destination port or range. Integer or range between 0 and 65535. Asterisk "*" can also be used to match all ports.
destinationPortRanges | No       | Optional. The destination port ranges.
direction      | Yes      | Required. The direction of the rule. The direction specifies if rule will be evaluated on incoming or outgoing traffic.
priority       | Yes      | Required. The priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
protocol       | Yes      | Required. Network protocol this rule applies to.
sourceAddressPrefix | No       | Optional. The CIDR or source IP range. Asterisk "*" can also be used to match all source IPs. Default tags such as "VirtualNetwork", "AzureLoadBalancer" and "Internet" can also be used. If this is an ingress rule, specifies where network traffic originates from.
sourceAddressPrefixes | No       | Optional. The CIDR or source IP ranges.
sourceApplicationSecurityGroups | No       | Optional. The application security group specified as source.
sourcePortRange | No       | Optional. The source port or range. Integer or range between 0 and 65535. Asterisk "*" can also be used to match all ports.
sourcePortRanges | No       | Optional. The source port ranges.

### name

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. The name of the security rule.

### networkSecurityGroupName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Conditional. The name of the parent network security group to deploy the security rule into. Required if the template is used in a standalone deployment.

### access

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Whether network traffic is allowed or denied.

- Default value: `Deny`

- Allowed values: `Allow`, `Deny`

### description

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. A description for this rule.

### destinationAddressPrefix

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The destination address prefix. CIDR or destination IP range. Asterisk "*" can also be used to match all source IPs. Default tags such as "VirtualNetwork", "AzureLoadBalancer" and "Internet" can also be used.

### destinationAddressPrefixes

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The destination address prefixes. CIDR or destination IP ranges.

### destinationApplicationSecurityGroups

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The application security group specified as destination.

### destinationPortRange

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The destination port or range. Integer or range between 0 and 65535. Asterisk "*" can also be used to match all ports.

### destinationPortRanges

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The destination port ranges.

### direction

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. The direction of the rule. The direction specifies if rule will be evaluated on incoming or outgoing traffic.

- Allowed values: `Inbound`, `Outbound`

### priority

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. The priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.

### protocol

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. Network protocol this rule applies to.

- Allowed values: `*`, `Ah`, `Esp`, `Icmp`, `Tcp`, `Udp`

### sourceAddressPrefix

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The CIDR or source IP range. Asterisk "*" can also be used to match all source IPs. Default tags such as "VirtualNetwork", "AzureLoadBalancer" and "Internet" can also be used. If this is an ingress rule, specifies where network traffic originates from.

### sourceAddressPrefixes

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The CIDR or source IP ranges.

### sourceApplicationSecurityGroups

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The application security group specified as source.

### sourcePortRange

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The source port or range. Integer or range between 0 and 65535. Asterisk "*" can also be used to match all ports.

### sourcePortRanges

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The source port ranges.

## Outputs

Name | Type | Description
---- | ---- | -----------
resourceGroupName | string | The resource group the security rule was deployed into.
resourceId | string | The resource ID of the security rule.
name | string | The name of the security rule.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "modules/res/network/networkSecurityGroups/securityRules/deploy.json"
    },
    "parameters": {
        "name": {
            "value": ""
        },
        "networkSecurityGroupName": {
            "value": ""
        },
        "access": {
            "value": "Deny"
        },
        "description": {
            "value": ""
        },
        "destinationAddressPrefix": {
            "value": ""
        },
        "destinationAddressPrefixes": {
            "value": []
        },
        "destinationApplicationSecurityGroups": {
            "value": []
        },
        "destinationPortRange": {
            "value": ""
        },
        "destinationPortRanges": {
            "value": []
        },
        "direction": {
            "value": ""
        },
        "priority": {
            "value": 0
        },
        "protocol": {
            "value": ""
        },
        "sourceAddressPrefix": {
            "value": ""
        },
        "sourceAddressPrefixes": {
            "value": []
        },
        "sourceApplicationSecurityGroups": {
            "value": []
        },
        "sourcePortRange": {
            "value": ""
        },
        "sourcePortRanges": {
            "value": []
        }
    }
}
```


