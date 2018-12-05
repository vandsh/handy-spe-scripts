Param(
  [Parameter(Mandatory=$True,Position=1)]
  [string]$variablesFilePath
)
	$azureVariables = Get-Content -Raw -Path $variablesFilePath | ConvertFrom-Json
	
	Import-AzureRmContext -Path $azureVariables.profilePath
	$nic = Get-AzureRmNetworkInterface -name $azureVariables.nicName -resourcegroupname $azureVariables.resourceGroupName
	$nic.IpConfigurations[0].LoadBalancerBackendAddressPools=$null
	Set-AzureRmNetworkInterface -NetworkInterface $nic