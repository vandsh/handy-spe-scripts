Param(
  [Parameter(Mandatory=$True,Position=1)]
  [string]$variablesFilePath
)
	$azureVariables = Get-Content -Raw -Path $variablesFilePath | ConvertFrom-Json
	
	Import-AzureRmContext -Path $azureVariables.profilePath
	$lb = Get-AzureRmLoadBalancer -name $azureVariables.lbName -resourcegroupname $azureVariables.resourceGroupName
	$backend = Get-AzureRmLoadBalancerBackendAddressPoolConfig -name $azureVariables.poolName -LoadBalancer $lb
	$nic = Get-AzureRmNetworkInterface -name $azureVariables.nicName -resourcegroupname $azureVariables.resourceGroupName
	$nic.IpConfigurations[0].LoadBalancerBackendAddressPools=$backend
	Set-AzureRmNetworkInterface -NetworkInterface $nic