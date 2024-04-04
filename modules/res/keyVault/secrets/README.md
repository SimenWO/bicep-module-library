# Key Vault Secrets

This module deploys a Key Vault Secret.

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
keyVaultName   | Yes      | Conditional. The name of the parent key vault. Required if the template is used in a standalone deployment.
name           | Yes      | Required. The name of the secret.
tags           | No       | Optional. Resource tags.
attributesEnabled | No       | Optional. Determines whether the object is enabled.
attributesExp  | No       | Optional. Expiry date in seconds since 1970-01-01T00:00:00Z. For security reasons, it is recommended to set an expiration date whenever possible.
attributesNbf  | No       | Optional. Not before date in seconds since 1970-01-01T00:00:00Z.
contentType    | No       | Optional. The content type of the secret.
value          | Yes      | Required. The value of the secret. NOTE: "value" will never be returned from the service, as APIs using this model are is intended for internal use in ARM deployments. Users should use the data-plane REST service for interaction with vault secrets.
roleAssignments | No       | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.

### keyVaultName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Conditional. The name of the parent key vault. Required if the template is used in a standalone deployment.

### name

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. The name of the secret.

### tags

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Resource tags.

### attributesEnabled

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Determines whether the object is enabled.

- Default value: `True`

### attributesExp

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Expiry date in seconds since 1970-01-01T00:00:00Z. For security reasons, it is recommended to set an expiration date whenever possible.

- Default value: `-1`

### attributesNbf

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Not before date in seconds since 1970-01-01T00:00:00Z.

- Default value: `-1`

### contentType

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The content type of the secret.

### value

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. The value of the secret. NOTE: "value" will never be returned from the service, as APIs using this model are is intended for internal use in ARM deployments. Users should use the data-plane REST service for interaction with vault secrets.

### roleAssignments

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.

## Outputs

Name | Type | Description
---- | ---- | -----------
name | string | The name of the secret.
resourceId | string | The resource ID of the secret.
resourceGroupName | string | The name of the resource group the secret was created in.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "modules/res/keyVault/secrets/deploy.json"
    },
    "parameters": {
        "keyVaultName": {
            "value": ""
        },
        "name": {
            "value": ""
        },
        "tags": {
            "value": {}
        },
        "attributesEnabled": {
            "value": true
        },
        "attributesExp": {
            "value": -1
        },
        "attributesNbf": {
            "value": -1
        },
        "contentType": {
            "reference": {
                "keyVault": {
                    "id": ""
                },
                "secretName": ""
            }
        },
        "value": {
            "reference": {
                "keyVault": {
                    "id": ""
                },
                "secretName": ""
            }
        },
        "roleAssignments": {
            "value": []
        }
    }
}
```


