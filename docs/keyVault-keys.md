# Key Vault Keys

This module deploys a Key Vault Key.

!!! info "Module reference (latest tag)"
    ```
    br:acromethszrrtlas.azurecr.io/modules/res/keyvault/keys:0.1.0
    ```

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
keyVaultName   | Yes      | Conditional. The name of the parent key vault. Required if the template is used in a standalone deployment.
name           | Yes      | Required. The name of the key.
tags           | No       | Optional. Resource tags.
attributesEnabled | No       | Optional. Determines whether the object is enabled.
attributesExp  | No       | Optional. Expiry date in seconds since 1970-01-01T00:00:00Z. For security reasons, it is recommended to set an expiration date whenever possible.
attributesNbf  | No       | Optional. Not before date in seconds since 1970-01-01T00:00:00Z.
curveName      | No       | Optional. The elliptic curve name.
keyOps         | No       | Optional. Array of JsonWebKeyOperation.
keySize        | No       | Optional. The key size in bits. For example: 2048, 3072, or 4096 for RSA.
kty            | No       | Optional. The type of the key.
roleAssignments | No       | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.
rotationPolicy | No       | Optional. Key rotation policy properties object.

### keyVaultName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Conditional. The name of the parent key vault. Required if the template is used in a standalone deployment.

### name

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. The name of the key.

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

### curveName

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The elliptic curve name.

- Default value: `P-256`

- Allowed values: `P-256`, `P-256K`, `P-384`, `P-521`

### keyOps

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Array of JsonWebKeyOperation.

- Allowed values: `decrypt`, `encrypt`, `import`, `sign`, `unwrapKey`, `verify`, `wrapKey`

### keySize

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The key size in bits. For example: 2048, 3072, or 4096 for RSA.

- Default value: `-1`

### kty

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The type of the key.

- Default value: `EC`

- Allowed values: `EC`, `EC-HSM`, `RSA`, `RSA-HSM`

### roleAssignments

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.

### rotationPolicy

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Key rotation policy properties object.

## Outputs

Name | Type | Description
---- | ---- | -----------
name | string | The name of the key.
resourceId | string | The resource ID of the key.
resourceGroupName | string | The name of the resource group the key was created in.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "modules/res/keyVault/keys/deploy.json"
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
        "curveName": {
            "value": "P-256"
        },
        "keyOps": {
            "value": []
        },
        "keySize": {
            "value": -1
        },
        "kty": {
            "value": "EC"
        },
        "roleAssignments": {
            "value": []
        },
        "rotationPolicy": {
            "value": {}
        }
    }
}
```


