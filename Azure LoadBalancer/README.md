## Setup isolated node deploys:
  - Update values in  `azureVariables.json` file to that of your own subscription and resources (varying based on which server you are on
  - Copy the entire `Azure LoadBalancer` folder to the VSTS agent directory
  - Invoke the `.\LoginAndStoreContext.ps1 "./azureVariables.json"`
    - This creates an importable context that you can use going forward to update Azure resources without login
  - Set up VSTS tasks to execute the `.\RemoveNICFromBackendPool.ps1 "./azureVariables.json"` to remove the current network interface from the load balancer
  - Deploy
  - Once deployed, run a warmup script to get the site responding
  - Now `.\AddNICToBackendPool.ps1 "./azureVariables.ps1"` to add the vm back into the Load balancer
