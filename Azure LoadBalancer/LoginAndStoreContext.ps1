Param(
  [Parameter(Mandatory=$True,Position=1)]
  [string]$variablesFilePath
)
	$azureVariables = Get-Content -Raw -Path $variablesFilePath | ConvertFrom-Json

	Login-AzureRMAccount
	Select-AzureRmSubscription -Subscriptionid $azureVariables.subscriptionId
	New-Item -ItemType File -Force -Path $azureVariables.profilePath
	Save-AzureRmContext -Path $azureVariables.profilePath -Force