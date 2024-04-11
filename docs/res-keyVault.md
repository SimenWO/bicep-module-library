# Key Vaults

This module deploys a Key Vault.

!!! info "Module reference (latest tag)"
    ```
    br:acromethszrrtlas.azurecr.io/modules/res/keyvault:0.1.7
    ```

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
name           | Yes      | Required. Name of the Key Vault. Must be globally unique.
location       | No       | Optional. Location for all resources.
accessPolicies | No       | Optional. Array of access policies object.
secrets        | No       | Optional. All secrets to create.
keys           | No       | Optional. All keys to create.
enableVaultForDeployment | No       | Optional. Specifies if the vault is enabled for deployment by script or compute.
enableVaultForTemplateDeployment | No       | Optional. Specifies if the vault is enabled for a template deployment.
enableVaultForDiskEncryption | No       | Optional. Specifies if the azure platform has access to the vault for enabling disk encryption scenarios.
enableSoftDelete | No       | Optional. Switch to enable/disable Key Vault's soft delete feature.
softDeleteRetentionInDays | No       | Optional. softDelete data retention days. It accepts >=7 and <=90.
enableRbacAuthorization | No       | Optional. Property that controls how data actions are authorized. When true, the key vault will use Role Based Access Control (RBAC) for authorization of data actions, and the access policies specified in vault properties will be ignored (warning: this is a preview feature). When false, the key vault will use the access policies specified in vault properties, and any policy stored on Azure Resource Manager will be ignored. If null or not specified, the vault is created with the default value of false. Note that management actions are always authorized with RBAC.
createMode     | No       | Optional. The vault's create mode to indicate whether the vault need to be recovered or not. - recover or default.
enablePurgeProtection | No       | Optional. Provide 'true' to enable Key Vault's purge protection feature.
vaultSku       | No       | Optional. Specifies the SKU for the vault.
networkAcls    | No       | Optional. Service endpoint object information. For security reasons, it is recommended to set the DefaultAction Deny.
publicNetworkAccess | No       | Optional. Whether or not public network access is allowed for this resource. For security reasons it should be disabled. If not specified, it will be disabled by default if private endpoints are set and networkAcls are not set.
diagnosticStorageAccountId | No       | Optional. Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.
diagnosticWorkspaceId | No       | Optional. Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.
diagnosticEventHubAuthorizationRuleId | No       | Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.
diagnosticEventHubName | No       | Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.
lock           | No       | Optional. Specify the type of lock.
roleAssignments | No       | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.
privateEndpoints | No       | Optional. Configuration details for private endpoints. For security reasons, it is recommended to use private endpoints whenever possible.
tags           | No       | Optional. Resource tags.
diagnosticLogCategoriesToEnable | No       | Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource.
diagnosticMetricsToEnable | No       | Optional. The name of metrics that will be streamed.
diagnosticSettingsName | No       | Optional. The name of the diagnostic setting, if deployed. If left empty, it defaults to "<resourceName>-diagnosticSettings".

### name

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. Name of the Key Vault. Must be globally unique.

### location

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Location for all resources.

- Default value: `[resourceGroup().location]`

### accessPolicies

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Array of access policies object.

### secrets

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. All secrets to create.

### keys

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. All keys to create.

### enableVaultForDeployment

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Specifies if the vault is enabled for deployment by script or compute.

- Default value: `True`

### enableVaultForTemplateDeployment

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Specifies if the vault is enabled for a template deployment.

- Default value: `True`

### enableVaultForDiskEncryption

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Specifies if the azure platform has access to the vault for enabling disk encryption scenarios.

- Default value: `True`

### enableSoftDelete

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Switch to enable/disable Key Vault's soft delete feature.

- Default value: `True`

### softDeleteRetentionInDays

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. softDelete data retention days. It accepts >=7 and <=90.

- Default value: `90`

### enableRbacAuthorization

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Property that controls how data actions are authorized. When true, the key vault will use Role Based Access Control (RBAC) for authorization of data actions, and the access policies specified in vault properties will be ignored (warning: this is a preview feature). When false, the key vault will use the access policies specified in vault properties, and any policy stored on Azure Resource Manager will be ignored. If null or not specified, the vault is created with the default value of false. Note that management actions are always authorized with RBAC.

- Default value: `False`

### createMode

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The vault's create mode to indicate whether the vault need to be recovered or not. - recover or default.

- Default value: `default`

### enablePurgeProtection

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Provide 'true' to enable Key Vault's purge protection feature.

- Default value: `True`

### vaultSku

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Specifies the SKU for the vault.

- Default value: `premium`

- Allowed values: `premium`, `standard`

### networkAcls

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Service endpoint object information. For security reasons, it is recommended to set the DefaultAction Deny.

### publicNetworkAccess

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Whether or not public network access is allowed for this resource. For security reasons it should be disabled. If not specified, it will be disabled by default if private endpoints are set and networkAcls are not set.

- Allowed values: ``, `Enabled`, `Disabled`

### diagnosticStorageAccountId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.

### diagnosticWorkspaceId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.

### diagnosticEventHubAuthorizationRuleId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.

### diagnosticEventHubName

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.

### lock

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Specify the type of lock.

- Allowed values: ``, `CanNotDelete`, `ReadOnly`

### roleAssignments

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.

### privateEndpoints

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Configuration details for private endpoints. For security reasons, it is recommended to use private endpoints whenever possible.

### tags

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Resource tags.

### diagnosticLogCategoriesToEnable

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource.

- Default value: `allLogs`

- Allowed values: `allLogs`, `AuditEvent`, `AzurePolicyEvaluationDetails`

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
resourceId | string | The resource ID of the key vault.
resourceGroupName | string | The name of the resource group the key vault was created in.
name | string | The name of the key vault.
uri  | string | The URI of the key vault.
location | string | The location the resource was deployed into.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "modules/res/keyVault/deploy.json"
    },
    "parameters": {
        "name": {
            "value": ""
        },
        "location": {
            "value": "[resourceGroup().location]"
        },
        "accessPolicies": {
            "value": []
        },
        "secrets": {
            "value": {}
        },
        "keys": {
            "value": []
        },
        "enableVaultForDeployment": {
            "value": true
        },
        "enableVaultForTemplateDeployment": {
            "value": true
        },
        "enableVaultForDiskEncryption": {
            "value": true
        },
        "enableSoftDelete": {
            "value": true
        },
        "softDeleteRetentionInDays": {
            "value": 90
        },
        "enableRbacAuthorization": {
            "value": false
        },
        "createMode": {
            "value": "default"
        },
        "enablePurgeProtection": {
            "value": true
        },
        "vaultSku": {
            "value": "premium"
        },
        "networkAcls": {
            "value": {}
        },
        "publicNetworkAccess": {
            "value": ""
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
        "privateEndpoints": {
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


