# AVD - Storage Azure Files

This module deploys storage (Azure Files) for FSLogix or MSIX.

!!! info "Module reference (latest tag)"
    ```
    br:acromethszrrtlas.azurecr.io/modules/ptn/storageazurefiles:0.1.0
    ```

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
workloadSubsId | Yes      | AVD workload subscription ID, multiple subscriptions scenario.
storageObjectsRgName | Yes      | Resource Group Name for Azure Files.
identityServiceProvider | Yes      | Required, The service providing domain services for Azure Virtual Desktop.
serviceObjectsRgName | Yes      | Resource Group Name for management VM.
storageAccountName | Yes      | Storage account name.
fileShareName  | Yes      | Storage account file share name.
privateEndpointSubnetId | Yes      | Private endpoint subnet ID.
sessionHostLocation | Yes      | Location where to deploy compute services.
fileShareMultichannel | Yes      | File share SMB multichannel.
identityDomainName | Yes      | Identity domain name.
identityDomainGuid | Yes      | AD domain GUID.
wrklKvName     | Yes      | Keyvault name to get credentials from.
domainJoinUserName | Yes      | AVD session host domain join credentials.
vmLocalUserName | Yes      | AVD session host local admin credentials.
storageSku     | Yes      | Azure Files storage account SKU.
fileShareQuotaSize | Yes      | *Azure File share quota
vnetPrivateDnsZoneFilesId | Yes      | Use Azure private DNS zones for private endpoints.
storageToDomainScript | Yes      | Script name for adding storage account to Active Directory.
storageToDomainScriptUri | Yes      | URI for the script for adding the storage account to Active Directory.
tags           | Yes      | Tags to be applied to resources
managementVmName | Yes      | Name for management virtual machine. for tools and to join Azure Files to domain.
deployPrivateEndpoint | Yes      | Optional. AVD Accelerator will deploy with private endpoints by default.
alaWorkspaceResourceId | Yes      | Log analytics workspace for diagnostic logs.
time           | No       | Do not modify, used to set unique value for resource deployment.
storagePurpose | Yes      | Sets purpose of the storage account.
dscAgentPackageLocation | Yes      | Sets location of DSC Agent.
storageCustomOuPath | Yes      | Custom OU path for storage.
ouStgPath      | Yes      | OU Storage Path
managedIdentityClientId | Yes      | Managed Identity Client ID
securityPrincipalName | Yes      | Identity name array to grant RBAC role to access AVD application group and NTFS permissions.
storageAccountFqdn | Yes      | storage account FDQN.

### workloadSubsId

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

AVD workload subscription ID, multiple subscriptions scenario.

### storageObjectsRgName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Resource Group Name for Azure Files.

### identityServiceProvider

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required, The service providing domain services for Azure Virtual Desktop.

### serviceObjectsRgName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Resource Group Name for management VM.

### storageAccountName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Storage account name.

### fileShareName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Storage account file share name.

### privateEndpointSubnetId

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Private endpoint subnet ID.

### sessionHostLocation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Location where to deploy compute services.

### fileShareMultichannel

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

File share SMB multichannel.

### identityDomainName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Identity domain name.

### identityDomainGuid

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

AD domain GUID.

### wrklKvName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Keyvault name to get credentials from.

### domainJoinUserName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

AVD session host domain join credentials.

### vmLocalUserName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

AVD session host local admin credentials.

### storageSku

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Azure Files storage account SKU.

### fileShareQuotaSize

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

*Azure File share quota

### vnetPrivateDnsZoneFilesId

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Use Azure private DNS zones for private endpoints.

### storageToDomainScript

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Script name for adding storage account to Active Directory.

### storageToDomainScriptUri

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

URI for the script for adding the storage account to Active Directory.

### tags

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Tags to be applied to resources

### managementVmName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Name for management virtual machine. for tools and to join Azure Files to domain.

### deployPrivateEndpoint

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. AVD Accelerator will deploy with private endpoints by default.

### alaWorkspaceResourceId

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Log analytics workspace for diagnostic logs.

### time

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Do not modify, used to set unique value for resource deployment.

- Default value: `[utcNow()]`

### storagePurpose

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Sets purpose of the storage account.

### dscAgentPackageLocation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Sets location of DSC Agent.

### storageCustomOuPath

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Custom OU path for storage.

### ouStgPath

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

OU Storage Path

### managedIdentityClientId

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Managed Identity Client ID

### securityPrincipalName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Identity name array to grant RBAC role to access AVD application group and NTFS permissions.

### storageAccountFqdn

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

storage account FDQN.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "modules/ptn/storageAzureFiles/deploy.json"
    },
    "parameters": {
        "workloadSubsId": {
            "value": ""
        },
        "storageObjectsRgName": {
            "value": ""
        },
        "identityServiceProvider": {
            "value": ""
        },
        "serviceObjectsRgName": {
            "value": ""
        },
        "storageAccountName": {
            "value": ""
        },
        "fileShareName": {
            "value": ""
        },
        "privateEndpointSubnetId": {
            "value": ""
        },
        "sessionHostLocation": {
            "value": ""
        },
        "fileShareMultichannel": {
            "value": null
        },
        "identityDomainName": {
            "value": ""
        },
        "identityDomainGuid": {
            "value": ""
        },
        "wrklKvName": {
            "value": ""
        },
        "domainJoinUserName": {
            "value": ""
        },
        "vmLocalUserName": {
            "value": ""
        },
        "storageSku": {
            "value": ""
        },
        "fileShareQuotaSize": {
            "value": 0
        },
        "vnetPrivateDnsZoneFilesId": {
            "value": ""
        },
        "storageToDomainScript": {
            "value": ""
        },
        "storageToDomainScriptUri": {
            "value": ""
        },
        "tags": {
            "value": {}
        },
        "managementVmName": {
            "value": ""
        },
        "deployPrivateEndpoint": {
            "value": null
        },
        "alaWorkspaceResourceId": {
            "value": ""
        },
        "time": {
            "value": "[utcNow()]"
        },
        "storagePurpose": {
            "value": ""
        },
        "dscAgentPackageLocation": {
            "value": ""
        },
        "storageCustomOuPath": {
            "value": ""
        },
        "ouStgPath": {
            "value": ""
        },
        "managedIdentityClientId": {
            "value": ""
        },
        "securityPrincipalName": {
            "value": ""
        },
        "storageAccountFqdn": {
            "value": ""
        }
    }
}
```


