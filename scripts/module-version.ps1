param (
    [Parameter(Mandatory = $true)]
    [string]$registryName,
    [Parameter(Mandatory = $true)]
    [string]$repositoryName,
    [Parameter(Mandatory = $true)]
    [string]$versionPath
)

# Fetch the latest tag from Azure Container Registry
$latestTag = az acr repository show-tags --name $registryName --repository $repositoryName --orderby time_desc --output tsv | Select-Object -First 1
$latestPatchNumber = 0

if ($latestTag -match '(\d+)\.(\d+)\.(\d+)') {
    $latestMajor = $matches[1]
    $latestMinor = $matches[2]
    $latestPatchNumber = [int]$matches[3]
}
else {
    $latestMajor = 0
    $latestMinor = 0
}

# Read the current major and minor versions from version.json
$version = Get-Content -Path $versionPath | ConvertFrom-Json
$currentMajor = $version.version.major
$currentMinor = $version.version.minor

# Determine the next version
if ($latestMajor -lt $currentMajor -or ($latestMajor -eq $currentMajor -and $latestMinor -lt $currentMinor)) {
    # If the current major or minor version in version.json is greater than the latest in ACR, start patch at 0
    $newVersion = "$currentMajor.$currentMinor.0"
}
elseif ($latestMajor -eq $currentMajor -and $latestMinor -eq $currentMinor) {
    # If the current major and minor match the latest in ACR, increment the patch number
    $newVersion = "$currentMajor.$currentMinor." + ($latestPatchNumber + 1)
}
else {
    # If no tags found or the version.json specifies a version rollback, default to 0.1.0
    # This case might occur if there's a need to start over or correct versioning mistakes
    $newVersion = "0.1.0"
}

Write-Host "New version to publish: $newVersion"

# Output the new version for use in Azure DevOps pipeline variables
Write-Host "##vso[task.setvariable variable=newVersion]$newVersion"
