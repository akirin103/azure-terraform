## azure-terraform

<br />

This project is for the practice of azure cloud construction using terraform.  
Authentication information is assumed to use "az login" of "azure cli"  

<br />

### terraform commands

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

### test
```bash
# Get vm's public ip
# Please change resource group(test-rg)　and vm name(test-vm) as appropriate
$ az vm list-ip-addresses -g test-rg -n test-vm \
| jq '.[0] | .virtualMachine | .network | .publicIpAddresses | .[0] | .ipAddress'

# Please change <IP Address> To the public ip before you get
$ ssh adminuser@<IP Address>
```
