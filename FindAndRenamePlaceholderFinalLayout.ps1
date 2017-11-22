$startPath = "/sitecore/content/Site/Folder"
$oldPlaceholder = "Interior Hero"
$newPlaceholder = "Interior-Hero"
$count = 0;
Get-ChildItem -Path $startPath -Recurse | ForEach-Object { 
   $item = $_;
 
   Get-Rendering -Item $item -PlaceHolder $oldPlaceholder -FinalLayout | Foreach-Object { 
   $count = $count + 1
   Write-Host $item.Paths.FullPath
   $_.Placeholder = $newPlaceholder; 
   Set-Rendering -Item $item -Instance $_  -FinalLayout
   }
}

Write-Host "Count: " $count