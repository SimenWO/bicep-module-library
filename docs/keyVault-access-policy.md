# Key Vault Access Policies

This module deploys a Key Vault Access Policy.

!!! info "Module reference (latest tag)"
    ```
    br:acromethszrrtlas.azurecr.io/modules/res/keyvault/access-policy:0.1.0
    ```

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
keyVaultName   | Yes      | Conditional. The name of the parent key vault. Required if the template is used in a standalone deployment.
accessPolicies | No       | Optional. An array of 0 to 16 identities that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID.

### keyVaultName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Conditional. The name of the parent key vault. Required if the template is used in a standalone deployment.

### accessPolicies

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. An array of 0 to 16 identities that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID.

## Outputs

Name | Type | Description
---- | ---- | -----------
resourceGroupName | string | The name of the resource group the access policies assignment was created in.
name | string | The name of the access policies assignment.
resourceId | string | The resource ID of the access policies assignment.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "modules/res/keyVault/access-policy/deploy.json"
    },
    "parameters": {
        "keyVaultName": {
            "value": ""
        },
        "accessPolicies": {
            "value": []
        }
    }
}
```


