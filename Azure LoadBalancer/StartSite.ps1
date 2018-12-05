Param(
  [Parameter(Mandatory=$True,Position=1)]
  [string]$variablesFilePath
)
	$azureVariables = Get-Content -Raw -Path $variablesFilePath | ConvertFrom-Json
	$siteName = $azureVariables.iisSiteName
	Start-WebSite -Name "$siteName"