<#
.SYNOPSIS
    Automates the deployment and replacement of session hosts in an Azure Virtual Desktop (AVD) environment.
.DESCRIPTION
    This script deploys new session hosts using Bicep templates and replaces the old session hosts with the newly deployed ones. 
    It sends drain notifications to users, sets session hosts to drain mode, and removes them after the grace period.
.PARAMETER IdentityDomainName
    The domain name for the identity provider.
.PARAMETER AmdVmSize
    The size of the Azure VM to be deployed.
.PARAMETER IdentityServiceProvider
    The identity service provider used for authentication.
.PARAMETER Fslogix
    Indicates whether FSLogix should be used.
.PARAMETER FslogixFileShare
    The file share used for FSLogix profiles.
.NOTES
    This script is designed to run in a pipeline for managing AVD session hosts.
.LINK
    https://aka.ms/installazurecliwindowsx64
.EXAMPLE
    .\Set-SessionHostConfiguration.ps1 -IdentityDomainName 'example.com' -AmdVmSize 'Standard_D4s_v3' -IdentityServiceProvider 'AzureAD' -Fslogix 'Enabled' -Verbose
#>


Param(
[parameter(Mandatory=$false)]
[string]
$IdentityDomainName, 

[parameter(Mandatory)]
[string]
$AmdVmSize, 

[parameter(Mandatory)]
[string]
$IdentityServiceProvider,

[parameter(Mandatory)]
[string]
$Fslogix,

[parameter(Mandatory=$false)]
[string]
$FslogixFileShare,

[parameter(Mandatory=$false)]
[string]
$fslogixStorageFqdn,

[parameter(Mandatory)]
[string]
$HostPoolRegistrationToken,    

[parameter(Mandatory)]
[string]
$NvidiaVmSize,

[Parameter(Mandatory=$false)]
[string]
$GroupToAdd

# [parameter(Mandatory)]
# [string]
# $ScreenCaptureProtection
)

##############################################################
#  Functions
##############################################################
function Write-Log {
param(
        [parameter(Mandatory)]
        [string]$Message,

        [parameter(Mandatory)]
        [string]$Type
)
$Path = 'C:\Windows\Temp\AVDSessionHostConfig.log'
if (!(Test-Path -Path $Path)) {
        New-Item -Path 'C:\' -Name 'AVDSessionHostConfig.log' | Out-Null
}
$Timestamp = Get-Date -Format 'MM/dd/yyyy HH:mm:ss.ff'
$Entry = '[' + $Timestamp + '] [' + $Type + '] ' + $Message
$Entry | Out-File -FilePath $Path -Append
}

function Get-WebFile {
param(
        [parameter(Mandatory)]
        [string]$FileName,

        [parameter(Mandatory)]
        [string]$URL
)
$Counter = 0
do {
        Invoke-WebRequest -Uri $URL -OutFile $FileName -ErrorAction 'SilentlyContinue'
        if ($Counter -gt 0) {
                Start-Sleep -Seconds 30
        }
        $Counter++
}
until((Test-Path $FileName) -or $Counter -eq 9)
}

$ErrorActionPreference = 'Stop'

try {

        ##############################################################
        #  Run the Virtual Desktop Optimization Tool (VDOT)
        ##############################################################
        # https://github.com/The-Virtual-Desktop-Team/Virtual-Desktop-Optimization-Tool
        {
                # Download VDOT
                $URL = 'https://github.com/The-Virtual-Desktop-Team/Virtual-Desktop-Optimization-Tool/archive/refs/heads/main.zip'
                $ZIP = 'VDOT.zip'
                Invoke-WebRequest -Uri $URL -OutFile $ZIP

                # Extract VDOT from ZIP archive
                Expand-Archive -LiteralPath $ZIP -Force

                # Fix to disable AppX Packages
                # As of 2/8/22, all AppX Packages are enabled by default
                $Files = (Get-ChildItem -Path .\VDOT\Virtual-Desktop-Optimization-Tool-main -File -Recurse -Filter "AppxPackages.json").FullName
                foreach ($File in $Files) {
                        $Content = Get-Content -Path $File
                        $Settings = $Content | ConvertFrom-Json
                        $NewSettings = @()
                        foreach ($Setting in $Settings) {
                                $NewSettings += [pscustomobject][ordered]@{
                                        AppxPackage = $Setting.AppxPackage
                                        VDIState    = 'Disabled'
                                        URL         = $Setting.URL
                                        Description = $Setting.Description
                                }
                        }

                        $JSON = $NewSettings | ConvertTo-Json
                        $JSON | Out-File -FilePath $File -Force
                }

                # Run VDOT
                & .\VDOT\Virtual-Desktop-Optimization-Tool-main\Windows_VDOT.ps1 -Optimizations 'All' -AdvancedOptimizations 'Edge', 'RemoveLegacyIE' -AcceptEULA

                Write-Log -Message 'Optimized the operating system using VDOT' -Type 'INFO'
        }    

        ##############################################################
        #  Add Recommended AVD Settings
        ##############################################################
        $Settings = @(

                # Disable Automatic Updates: https://docs.microsoft.com/en-us/azure/virtual-desktop/set-up-customize-master-image#disable-automatic-updates
                [PSCustomObject]@{
                        Name         = 'NoAutoUpdate'
                        Path         = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
                        PropertyType = 'DWord'
                        Value        = 1
                },

                # Enable Time Zone Redirection: https://docs.microsoft.com/en-us/azure/virtual-desktop/set-up-customize-master-image#set-up-time-zone-redirection
                [PSCustomObject]@{
                        Name         = 'fEnableTimeZoneRedirection'
                        Path         = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                        PropertyType = 'DWord'
                        Value        = 1
                }
        )

        ##############################################################
        #  Add GPU Settings
        ##############################################################
        # This setting applies to the VM Size's recommended for AVD with a GPU
        if ($AmdVmSize -eq 'true' -or $NvidiaVmSize -eq 'true') {
                $Settings += @(

                        # Configure GPU-accelerated app rendering: https://docs.microsoft.com/en-us/azure/virtual-desktop/configure-vm-gpu#configure-gpu-accelerated-app-rendering
                        [PSCustomObject]@{
                                Name         = 'bEnumerateHWBeforeSW'
                                Path         = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                                PropertyType = 'DWord'
                                Value        = 1
                        },

                        # Configure fullscreen video encoding: https://docs.microsoft.com/en-us/azure/virtual-desktop/configure-vm-gpu#configure-fullscreen-video-encoding
                        [PSCustomObject]@{
                                Name         = 'AVC444ModePreferred'
                                Path         = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                                PropertyType = 'DWord'
                                Value        = 1
                        }
                )
        }
        # This setting applies only to VM Size's recommended for AVD with a Nvidia GPU
        if ($NvidiaVmSize -eq 'true') {
                $Settings += @(

                        # Configure GPU-accelerated frame encoding: https://docs.microsoft.com/en-us/azure/virtual-desktop/configure-vm-gpu#configure-gpu-accelerated-frame-encoding
                        [PSCustomObject]@{
                                Name         = 'AVChardwareEncodePreferred'
                                Path         = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                                PropertyType = 'DWord'
                                Value        = 1
                        }
                )
        }

        # ##############################################################
        # #  Add Screen Capture Protection Setting
        # ##############################################################
        # if ($ScreenCaptureProtection -eq 'true') {
        #         $Settings += @(

        #                 # Enable Screen Capture Protection: https://docs.microsoft.com/en-us/azure/virtual-desktop/screen-capture-protection
        #                 [PSCustomObject]@{
        #                         Name         = 'fEnableScreenCaptureProtect'
        #                         Path         = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
        #                         PropertyType = 'DWord'
        #                         Value        = 1
        #                 }
        #         )
        # }

        ##############################################################
        #  Add Fslogix Settings
        ##############################################################
        if ($Fslogix -eq 'true') {
                $Settings += @(
                        # Enables Fslogix profile containers: https://docs.microsoft.com/en-us/fslogix/profile-container-configuration-reference#enabled
                        [PSCustomObject]@{
                                Name         = 'Enabled'
                                Path         = 'HKLM:\SOFTWARE\Fslogix\Profiles'
                                PropertyType = 'DWord'
                                Value        = 1
                        },
                        # Deletes a local profile if it exists and matches the profile being loaded from VHD: https://docs.microsoft.com/en-us/fslogix/profile-container-configuration-reference#deletelocalprofilewhenvhdshouldapply
                        [PSCustomObject]@{
                                Name         = 'DeleteLocalProfileWhenVHDShouldApply'
                                Path         = 'HKLM:\SOFTWARE\FSLogix\Profiles'
                                PropertyType = 'DWord'
                                Value        = 1
                        },
                        # The folder created in the Fslogix fileshare will begin with the username instead of the SID: https://docs.microsoft.com/en-us/fslogix/profile-container-configuration-reference#flipflopprofiledirectoryname
                        [PSCustomObject]@{
                                Name         = 'FlipFlopProfileDirectoryName'
                                Path         = 'HKLM:\SOFTWARE\FSLogix\Profiles'
                                PropertyType = 'DWord'
                                Value        = 1
                        },
                        # # Loads FRXShell if there's a failure attaching to, or using an existing profile VHD(X): https://docs.microsoft.com/en-us/fslogix/profile-container-configuration-reference#preventloginwithfailure
                        # [PSCustomObject]@{
                        #         Name         = 'PreventLoginWithFailure'
                        #         Path         = 'HKLM:\SOFTWARE\FSLogix\Profiles'
                        #         PropertyType = 'DWord'
                        #         Value        = 1
                        # },
                        # # Loads FRXShell if it's determined a temp profile has been created: https://docs.microsoft.com/en-us/fslogix/profile-container-configuration-reference#preventloginwithtempprofile
                        # [PSCustomObject]@{
                        #         Name         = 'PreventLoginWithTempProfile'
                        #         Path         = 'HKLM:\SOFTWARE\FSLogix\Profiles'
                        #         PropertyType = 'DWord'
                        #         Value        = 1
                        # },
                        # List of file system locations to search for the user's profile VHD(X) file: https://docs.microsoft.com/en-us/fslogix/profile-container-configuration-reference#vhdlocations
                        [PSCustomObject]@{
                                Name         = 'VHDLocations'
                                Path         = 'HKLM:\SOFTWARE\FSLogix\Profiles'
                                PropertyType = 'MultiString'
                                Value        = $FslogixFileShare
                        },
                        [PSCustomObject]@{
                                Name         = 'VolumeType'
                                Path         = 'HKLM:\SOFTWARE\FSLogix\Profiles'
                                PropertyType = 'MultiString'
                                Value        = 'vhdx'
                        }
                )
        }
        if ($IdentityServiceProvider -eq "EntraID" -and $Fslogix -eq 'true') {
                $Settings += @(
                        [PSCustomObject]@{
                                Name         = 'CloudKerberosTicketRetrievalEnabled'
                                Path         = 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters'
                                PropertyType = 'DWord'
                                Value        = 1
                        },
                        [PSCustomObject]@{
                                Name         = 'LoadCredKeyFromProfile'
                                Path         = 'HKLM:\Software\Policies\Microsoft\AzureADAccount'
                                PropertyType = 'DWord'
                                Value        = 1
                        },
                        [PSCustomObject]@{
                                Name         = $IdentityDomainName
                                Path         = 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\domain_realm'
                                PropertyType = 'String'
                                Value        = $fslogixStorageFqdn
                        }

                )
        }

        ##############################################################
        #  Add Microsoft Entra ID Join Setting
        ##############################################################
        if ($IdentityServiceProvider -eq "EntraID") {
                $Settings += @(

                        # Enable PKU2U: https://docs.microsoft.com/en-us/azure/virtual-desktop/troubleshoot-azure-ad-connections#windows-desktop-client
                        [PSCustomObject]@{
                                Name         = 'AllowOnlineID'
                                Path         = 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\pku2u'
                                PropertyType = 'DWord'
                                Value        = 1
                        }
                )
        }


        ##############################################################
        #  Set session timeouts
        ##############################################################

        $Settings += @(
                [PSCustomObject]@{
                        Name         = 'RemoteAppLogoffTimeLimit' # Remote App Logoff time limit - how long after a RmoteApp is closed is the session closed - 15 minutes
                        Path         = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                        PropertyType = 'DWord'
                        Value        = 10800000 # = 10800000 milliseconds = a4cb80 = 3 hours
                },
                [PSCustomObject]@{
                        Name         = 'MaxDisconnectionTime' # Max disconnection time - how long after a session is disconnected is the session ended - 3 hours
                        Path         = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                        PropertyType = 'DWord'
                        Value        = 10800000 # = 10800000 milliseconds = a4cb80 = 3 hours
                },
                [PSCustomObject]@{
                        Name         = 'MaxConnectionTime' # Max connection time - maximum time a session can run for - 1 day
                        Path         = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                        PropertyType = 'DWord'
                        Value        = 86400000 # = 86400000 milliseconds = 5265c00 = 1 day
                },
                [PSCustomObject]@{
                        Name         = 'MaxIdleTime' # Max idle time - how long can an active session be idle for before it is disconnected - 4 hours
                        Path         = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
                        PropertyType = 'DWord'
                        Value        = 10800000 # = 10800000 milliseconds = a4cb80 = 3 hours
                }
        )



        # Set registry settings
        foreach ($Setting in $Settings) {
                # Create registry key(s) if necessary
                if (!(Test-Path -Path $Setting.Path)) {
                        New-Item -Path $Setting.Path -Force
                }

                # Checks for existing registry setting
                $Value = Get-ItemProperty -Path $Setting.Path -Name $Setting.Name -ErrorAction 'SilentlyContinue'
                $LogOutputValue = 'Path: ' + $Setting.Path + ', Name: ' + $Setting.Name + ', PropertyType: ' + $Setting.PropertyType + ', Value: ' + $Setting.Value

                # Creates the registry setting when it does not exist
                if (!$Value) {
                        New-ItemProperty -Path $Setting.Path -Name $Setting.Name -PropertyType $Setting.PropertyType -Value $Setting.Value -Force
                        Write-Log -Message "Added registry setting: $LogOutputValue" -Type 'INFO'
                }
                # Updates the registry setting when it already exists
                elseif ($Value.$($Setting.Name) -ne $Setting.Value) {
                        Set-ItemProperty -Path $Setting.Path -Name $Setting.Name -Value $Setting.Value -Force
                        Write-Log -Message "Updated registry setting: $LogOutputValue" -Type 'INFO'
                }
                # Writes log output when registry setting has the correct value
                else {
                        Write-Log -Message "Registry setting exists with correct value: $LogOutputValue" -Type 'INFO'    
                }
                Start-Sleep -Seconds 1
        }


        ##############################################################
        # Add Defender Exclusions for FSLogix 
        ##############################################################
        # https://docs.microsoft.com/en-us/azure/architecture/example-scenario/wvd/windows-virtual-desktop-fslogix#antivirus-exclusions
        if ($Fslogix -eq 'true') {

                $Files = @(
                        "%ProgramFiles%\FSLogix\Apps\frxdrv.sys",
                        "%ProgramFiles%\FSLogix\Apps\frxdrvvt.sys",
                        "%ProgramFiles%\FSLogix\Apps\frxccd.sys",
                        "%TEMP%\*.VHD",
                        "%TEMP%\*.VHDX",
                        "%Windir%\TEMP\*.VHD",
                        "%Windir%\TEMP\*.VHDX"
                        "$FslogixFileShareName\*.VHD"
                        "$FslogixFileShareName\*.VHDX"
                )

                foreach ($File in $Files) {
                        Add-MpPreference -ExclusionPath $File
                }
                Write-Log -Message 'Enabled Defender exlusions for FSLogix paths' -Type 'INFO'

                $Processes = @(
                        "%ProgramFiles%\FSLogix\Apps\frxccd.exe",
                        "%ProgramFiles%\FSLogix\Apps\frxccds.exe",
                        "%ProgramFiles%\FSLogix\Apps\frxsvc.exe"
                )

                foreach ($Process in $Processes) {
                        Add-MpPreference -ExclusionProcess $Process
                }
                Write-Log -Message 'Enabled Defender exlusions for FSLogix processes' -Type 'INFO'
        }


        ##############################################################
        #  Install the AVD Agent
        ##############################################################
        # Disabling this method for installing the AVD agent until EntraID Join can completed successfully
        $BootInstaller = 'AVD-Bootloader.msi'
        Get-WebFile -FileName $BootInstaller -URL 'https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrxrH'
        Start-Process -FilePath 'msiexec.exe' -ArgumentList "/i $BootInstaller /quiet /qn /norestart /passive" -Wait -Passthru
        Write-Log -Message 'Installed AVD Bootloader' -Type 'INFO'
        Start-Sleep -Seconds 5

        $AgentInstaller = 'AVD-Agent.msi'
        Get-WebFile -FileName $AgentInstaller -URL 'https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrmXv'
        Start-Process -FilePath 'msiexec.exe' -ArgumentList "/i $AgentInstaller /quiet /qn /norestart /passive REGISTRATIONTOKEN=$HostPoolRegistrationToken" -Wait -PassThru
        Write-Log -Message 'Installed AVD Agent' -Type 'INFO'
        Start-Sleep -Seconds 5


        ##############################################################
        #  CUSTOM: Adding local admin to session host
        ##############################################################

        Write-Log -Message "Adding group/member to Administrators: $GroupToAdd" -Type 'INFO'
        if ($IdentityServiceProvider -ne 'EntraID') {
            if (![string]::IsNullOrEmpty($GroupToAdd)) {
                $culture = Get-Culture
                $adminGroup = if ($culture.Name -eq 'nb-NO') { "Administratorer" } else { "Administrators" }
                
                # Check if the user is already a member of the group
                $group = Get-LocalGroup -Name $adminGroup
                $isMember = Get-LocalGroupMember -Group $group | Where-Object { $_.Name -eq $GroupToAdd }
        
                if ($null -eq $isMember) {
                    Add-LocalGroupMember -Group $adminGroup -Member $GroupToAdd
                    Write-Host "Domain join account added to local administrators group"
                } else {
                    Write-Host "Group/member is already a member of the local administrators group"
                }
            }
            else {
                Write-Host "No group to add to local administrators group"
            }
        }
        else {
            Write-Host "Using EntraID, no domain join account to add to local administrators group"
        }

        ##############################################################
        #  Restart VM
        ##############################################################
        if ($IdentityServiceProvider -eq "EntraID" -and $AmdVmSize -eq 'false' -and $NvidiaVmSize -eq 'false') {
                Start-Process -FilePath 'shutdown' -ArgumentList '/r /t 30'
        }
        }
        catch {
        Write-Log -Message $_ -Type 'ERROR'
        throw
        }