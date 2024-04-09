# Module catalog

## Introduction

To share Bicep modules within our organization, we have established a private module registry, hosted on Azure Container Registry. This ensures that our cloud resources are deployed consistently and reliably across multiple projects. Our private registry enables the secure sharing of internally developed modules, enhancing collaboration while maintaining strict security standards.

Importantly, each module within our registry undergoes rigorous testing with PS-Rule. Leveraging the principles of the Azure Well-Architected Framework (WAF), PS-Rule for Azure plays a critical role in our development process by:

- **Suggesting Changes**: Offering actionable recommendations to enhance the quality of our solutions.
- **Linking to Documentation**: Providing direct connections to relevant documentation, enabling our team to understand and apply best practices within our specific environment.
- **Demonstrating Implementation**: Showcasing examples in both Azure Bicep and ARM templates syntax, these demonstrations guide our developers in adopting the changes effectively.

!!! note

    The modules currently published to our private container registry have been selectively curated for Azure Virtual Desktop deployments. However, the individual resource modules they are suitable for any other azure deployment.

## Getting Started

The module catalog is divided into two main categories: Pattern modules (also known as composite modules) and Resource modules. Resource modules are standalone entities designed to manage specific Azure resources. In contrast, Pattern modules are constructed from multiple Resource modules, combined with custom modules to perform specific tasks.

To consume a module your user needs to have acr-pull permission on the Azure container registry. This permission allows you to pull (download) container images and Bicep modules stored in the registry.

### Use a Bicep Module

When you have found a module you want to use, you create a module definition in your Bicep template. Here's an example:

```Bicep
module myModule 'br:<ACRNAME>.azurecr.io/modulepath/modulename:moduleversion' = {
    name: 'my-module'
    params: {
        moduleParameter1: 'value'
    }
}

```

The module path for a virtual machine would for example be "modules/res/compute/virtualmachines".

### Alias

You can use a registry alias to simplify your module definition. Instead of specifying the registry name every time you define a module, you instead use its alias. This keeps the Bicep file tidier and it's also easier to switch registry for different situations, because then the changes will apply to all Bicep files in your repository.

To define an alias, you need to create a **bicepconfig.json** file in the same folder as your Bicep files. Within the bicepconfig.json file, you define aliases as in this example:

```JSON
{
    "moduleAliases": {
    "ts": {},
    "br": {
      "res-modules": {
        "registry": "<ACRNAME>.azurecr.io",
        "modulePath": "modules/res"
      },
      "ptn-modules": {
        "registry": "<ACRNAME>.azurecr.io",
        "modulePath": "modules/ptn"
      }
    }
  },
}
```

When you define a module in a Bicep file, you use a slightly different type of module path, which includes the alias:

```Bicep
module myModule 'br/res-modules:modulepath/modulename:moduleversion' = {
    //...
}

```

The "modulepath/modulename" for the virtual machine would for example be "compute/virtualmachines".

### Versioning

A tag in the ACR represents the version of a module. A single module in a registry can have multiple versions. All of the versions share a module identifier, but they have different tags. When you use a module, you need to use a tag to specify the version that you want to use, so that Bicep knows which module file to retrieve. The latest version should be represented in each module folder.

## Additional Resources

Resource section linking to:

- [Bicep documentation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
- [Azure Container Registry / Bicep Private Registry](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-get-started-bicep?tabs=CLI)

- [PSRule](https://azure.github.io/PSRule.Rules.Azure/about/)
