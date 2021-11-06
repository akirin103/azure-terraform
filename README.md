## azure-terraform

<br />

This project is for the practice of azure cloud construction using terraform.  
Authentication information is assumed to use "az login" of "azure cli"  

<br />

## terraform commands

```bash
# format
$ terraform fmt

# construct azure environment
$ terraform apply --auto-approve

# check plan
$ terraform plan

# destruct azure environment
$ terraform destroy --auto-approve
```

<br />

## links

[Terraform registry Microsoft Azure](https://registry.terraform.io/namespaces/Azure)  
[Create two web apps connected securely with Private Endpoint and VNet integration](https://docs.microsoft.com/ja-jp/azure/app-service/scripts/terraform-secure-backend-frontend)

<br />

## about modules

- network
[Terraform registry Microsoft Azure Network](https://registry.terraform.io/modules/Azure/network/azurerm/latest)

    added only subnet's delegation settings to use appservice vnet integration feature.
