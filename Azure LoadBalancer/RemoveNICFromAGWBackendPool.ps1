
Param(
  [Parameter(Mandatory=$True,Position=1)]
  [string]$variablesFilePath
)
	$azureVariables = Get-Content -Raw -Path $variablesFilePath | ConvertFrom-Json
	
	Import-AzureRmContext -Path $azureVariables.profilePath
	$appGateway = Get-AzureRmApplicationGateway -name $azureVariables.appGatewayName -resourcegroupname $azureVariables.resourceGroupName
	$backendPool = Get-AzureRmApplicationGatewayBackendAddressPool -name $azureVariables.appGatewayPoolName -ApplicationGateway $appGateway
	$nic = Get-AzureRmNetworkInterface -name $azureVariables.nicName -resourcegroupname $azureVariables.resourceGroupName
	$nicIpAddress = $nic.IpConfigurations[0].PrivateIpAddress
	$backendPoolAddresses = $backendPool.BackendAddresses | Where-Object { $_.IpAddress -ne $nicIpAddress } | ForEach {$_.IpAddress}
	$appGateway = Set-AzureRmApplicationGatewayBackendAddressPool -ApplicationGateway $appGateway -Name $azureVariables.appGatewayPoolName -BackendIPAddresses $backendPoolAddresses