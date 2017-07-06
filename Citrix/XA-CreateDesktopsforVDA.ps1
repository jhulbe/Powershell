<#
.synopsis 

Script for tagging each machine inside a delivery group and then creating a desktop named SERVERNAME_DT for each individual server

.notes
EastCoast-Desktop delivery group using SERVER1,SERVER2,SERVER3 as a pool of servers would create the following desktops inside of eastcoast_desktop
SERVER1_DT - limited to SERVER1
SERVER2_DT - limited to SERVER2
SERVER3_DT - limited to SERVER3

This is to add administrative connections for the HELPDESK to remote directly to a machine, or test the delivery of a specific machine
grabbed script from : https://www.citrix.com/blogs/2017/04/17/how-to-assign-desktops-to-specific-servers-in-xenapp-7/

update your DDC in line 25
Update you delivery group in line 26

#>






$DDC = "ddcserver"
$DeliveryGroup = "EastCoast-Desktop"
Param (
	[String]$DesktopGroupName = "$DeliveryGroup", 
	[Parameter(Mandatory=$True)][Array]$UserGroups
)

# Error handling
$ErrorActionPreference = "Stop"

#Add-PSSnapin Citrix*

# This is the prefix that will be used before each tag used for machine assignments. 
[String]$TagSuffix = "_DT"

# First, let make sure that that every single machine have a single tag assigned to it. 
Write-Host "Processing all RDS hosts" 
ForEach ($m_VDA in $(Get-BrokerMachine -adminaddress $DDC -SessionSupport MultiSession -DesktopGroupName "$DeliveryGroup")) {
	[String]$m_SimpleMachineName = "$($m_VDA.MachineName.Split('\')[1])$($TagSuffix)"
	[String]$m_TagName = "$($m_SimpleMachineName)"
	Write-Host "	$($m_SimpleMachineName): " -NoNewline
	If ($m_VDA.Tags -notcontains $m_TagName) {
		Write-Host -ForegroundColor Yellow "Desktop not found, creating"
		# Create new tag first and assign it to VDA
		New-BrokerTag -adminaddress $DDC -Name $m_TagName -Description "Unique to $($m_VDA.MachineName)" | Add-BrokerTag -Machine $m_VDA | Out-Null
		
		# Create new entitlement policy rule
		New-BrokerEntitlementPolicyRule -adminaddress $DDC $m_SimpleMachineName -DesktopGroupUid $m_VDA.DesktopGroupUid -IncludedUsers $UserGroups -PublishedName $m_SimpleMachineName -RestrictToTag $m_TagName | Out-Null
	} Else {
		Write-Host -ForegroundColor Green "Desktop already exists"
	}
}

