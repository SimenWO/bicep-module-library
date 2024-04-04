param (
    [Parameter(Mandatory = $true)]
    [string]$bicepFilePath,
    [Parameter(Mandatory = $true)]
    [string]$registryName,
    [Parameter(Mandatory = $true)]
    [string]$repositoryName
)

$docsFolderPath = 'docs'

# Assuming necessary modules are already installed and available
Install-Module -Name 'PSDocs.Azure' -Repository PSGallery -force;
Import-Module -Name 'PSDocs.Azure' -force;

# Ensure the docs folder exists at the root level
$rootDocsPath = Join-Path -Path (Get-Location) -ChildPath $docsFolderPath
if (-not (Test-Path $rootDocsPath)) {
    New-Item -ItemType Directory -Path $rootDocsPath -Force
    Write-Host "Created docs folder at root level."
}

function GenerateReadme {
    param (
        [string]$templateFilePath,
        [string]$readmePath
    )
    $output = Invoke-PSDocument -Module PSDocs.Azure -InputObject $templateFilePath -InstanceName 'README' -Culture 'en-US'
    $output | Out-File -FilePath $readmePath -Encoding utf8 -Force
    Write-Host "Markdown file generated at $readmePath."
}

function FetchLatestTag {
    param (
        [string]$registryName,
        [string]$repositoryName
    )
    $latestTag = az acr repository show-tags --name $registryName --repository $repositoryName --orderby time_desc --output tsv | Select-Object -First 1
    return $latestTag
}

function Update-ReadmeWithLatestTag {
    param (
        [string]$readmePath,
        [string]$tag
    )
    $infoBlock = @"
!!! info "Module reference (latest tag)"
    ``````
    br:${registryName}.azurecr.io/${repositoryName}:$tag
    ``````
"@
    $content = Get-Content $readmePath -Raw
    $updatedContent = $content.Replace("## Parameters", "$infoBlock`n`n## Parameters")
    $updatedContent | Set-Content $readmePath
    Write-Host "Updated $readmePath with latest tag $tag."
}


# Check if the Bicep file exists
if (-not (Test-Path $bicepFilePath)) {
    Write-Error "Bicep file ($bicepFilePath) not found."
    exit
}

# Convert Bicep file to ARM template
$armTemplateFilePath = [System.IO.Path]::ChangeExtension($bicepFilePath, 'json')
try {
    bicep build $bicepFilePath --outfile $armTemplateFilePath
    Write-Host "Bicep file ($bicepFilePath) successfully converted to ARM template ($armTemplateFilePath)."
}
catch {
    Write-Error "An error occurred while converting the Bicep file to ARM template: $_"
    exit
}

# Generate README for the ARM template in the same directory as the Bicep file
$templateDir = Split-Path $armTemplateFilePath
$readmePathOriginal = Join-Path -Path $templateDir -ChildPath "README.md"
GenerateReadme -templateFilePath $armTemplateFilePath -readmePath $readmePathOriginal

# Generate another README under the docs folder with a specific naming convention
$templateDirPath = Split-Path $bicepFilePath -Parent
$parentFolderName = Split-Path $templateDirPath -Leaf
$grandParentFolderName = Split-Path (Split-Path $templateDirPath -Parent) -Leaf
$uniqueDocName = "$grandParentFolderName-$parentFolderName.md"
$readmePathDocs = Join-Path -Path $rootDocsPath -ChildPath $uniqueDocName
GenerateReadme -templateFilePath $armTemplateFilePath -readmePath $readmePathDocs

# Fetching latest tag
$latestTag = FetchLatestTag -registryName $registryName -repositoryName $repositoryName


# After generating each README, update it with the latest tag
Update-ReadmeWithLatestTag -readmePath $readmePathOriginal -tag $latestTag
Update-ReadmeWithLatestTag -readmePath $readmePathDocs -tag $latestTag

# Optionally, remove the ARM template (json) file if no longer needed
Remove-Item -Path $armTemplateFilePath -Force
Write-Host "ARM template ($armTemplateFilePath) removed successfully."
