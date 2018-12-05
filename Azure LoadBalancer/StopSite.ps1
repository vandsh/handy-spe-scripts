Param(
  [Parameter(Mandatory=$True,Position=1)]
  [string]$variablesFilePath
)
	$azureVariables = Get-Content -Raw -Path $variablesFilePath | ConvertFrom-Json
	$siteName = $azureVariables.iisSiteName
	Stop-WebSite -Name "$siteName"