################################################################
# SCRIPT: Create-ADDomain
# AUTHOR: Josh Ellis - Josh@JoshEllis.NZ
# Website: JoshEllis.NZ
# VERSION: 1.0
# DATE: 12/03/2016
# DESCRIPTION: Installs Active Directory and creates a new Domain on a Server. Used for quickly deploying lab environments.
################################################################

[CmdletBinding()]
Param(
[Parameter(Mandatory=$True,Position=1)]
[string]$DomainName,
[Parameter(Mandatory=$True,Position=2)]
[string]$ADRestorePassword
     )

# Variables
$NetBIOSName = $DomainName.Split(".") | Select -First 1
$ForestMode = "Win2012R2"
$DomainMode = "Win2012R2"
$DatabasePath = "C:\ADDS\NTDS"
$SYSVOLPath = "C:\ADDS\SYSVOL"
$LogPath = "C:\ADDS\Logs"
$RestorePassword = ConvertTo-SecureString -String $ADRestorePassword -AsPlainText -Force


# Install Required Windows Features
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

# Create AD Domain
Install-ADDSForest -DomainName $DomainName `
                   -DomainNetbiosName $NetBIOSName `
                   -ForestMode $ForestMode `
                   -DomainMode $DomainMode `
                   -DatabasePath $DatabasePath `
                   -SYSVOLPath $SYSVOLPath `
                   -LogPath $LogPath `
                   -SafeModeAdministratorPassword $RestorePassword `
                   -NoRebootonCompletion:$false `
                   -Force