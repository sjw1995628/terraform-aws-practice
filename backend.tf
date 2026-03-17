 terraform { 
  cloud { 
    
    organization = "mtc-tf-jwson" 

    workspaces { 
      name = "ecs" 
    } 
  } 
}