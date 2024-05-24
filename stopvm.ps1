#Parametry na wejściu
param (
    [Parameter(Mandatory=$true)]
    [String] $VMname,

    [Parameter(Mandatory=$true)] 
    [String] $RG
)

# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process

# Connect to Azure with system-assigned managed identity
$AzureContext = (Connect-AzAccount -Identity).context

# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext
Write-Output "Succesfully connected to Azure using MI"

#Stop Azure VM
Stop-AzVM -Name $VMName -ResourceGroupName $RG -Force

# if ($RG) 
# { 
# 	$VMs = Get-AzVM -ResourceGroupName $RG
# }
# else 
# { 
# 	$VMs = Get-AzVM
# }

# # Start each of the VMs
# foreach ($VM in $VMs)
# {
# 	$VMStatus = $VM | Stop-AzVM - Force -ErrorAction Continue

# 	if ($VMStatus.Status -ne 'Succeeded')
# 	{
# 		# The VM failed to start, so send notice
#         Write-Output ($VM.Name + " failed to stop")
#         Write-Error ($VM.Name + " failed to stop. Error was:") -ErrorAction Continue
# 		Write-Error (ConvertTo-Json $VMStatus.Error) -ErrorAction Continue
# 	}
# 	else
# 	{
# 		# The VM stopped, so send notice
# 		Write-Output ($VM.Name + " has been stopped")
# 	}
# }