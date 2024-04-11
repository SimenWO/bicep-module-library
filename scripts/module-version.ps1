param (
    [Parameter(Mandatory = $true)]
    [string]$registryName,
    [Parameter(Mandatory = $true)]
    [string]$repositoryName,
    [Parameter(Mandatory = $true)]
    [string]$versionPath
)

# Initialize default version components
$latestMajor = 0
$latestMinor = 0
$latestPatchNumber = 0

try {
    # Attempt to fetch the latest tag from Azure Container Registry
    $latestTag = az acr repository show-tags --name $registryName --repository $repositoryName --orderby time_desc --output tsv | Select-Object -First 1
    
    if ($latestTag -match '(\d+)\.(\d+)\.(\d+)') {
        $latestMajor = $matches[1]
        $latestMinor = $matches[2]
        $latestPatchNumber = [int]$matches[3]
    }
} catch {
    Write-Host "Repository $repositoryName does not exist in $registryName. Assuming new repository."
}

# Read the current major and minor versions from version.json
$version = Get-Content -Path $versionPath | ConvertFrom-Json
$currentMajor = $version.version.major
$currentMinor = $version.version.minor

# Determine the next version
if ($latestMajor -lt $currentMajor -or ($latestMajor -eq $currentMajor -and $latestMinor -lt $currentMinor)) {
    $newVersion = "$currentMajor.$currentMinor.0"
}
elseif ($latestMajor -eq $currentMajor -and $latestMinor -eq $currentMinor) {
    $newVersion = "$currentMajor.$currentMinor." + ($latestPatchNumber + 1)
}
else {
    $newVersion = "0.1.0"
}

Write-Host "New version to publish: $newVersion"
Write-Output "newVersion=$newVersion"

#"newVersion=$newVersion" | Out-File -Append -Encoding utf8 -FilePath $env:GITHUB_ENV