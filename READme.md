## Terraform installation
* Download terraform zip file from : https://www.terraform.io/downloads.html
* unzip the dir, you will get terraform binary file
* give executable permissions to terraform binary: `chmod +x terraform`
* move terraform to path `/usr/local/bin/` where able to access as command: `mv terrafom /usr/local/bin/`
* execute command `terraform version`


## aws credentials
* if you have awscli you can configure using `aws configure command`
* or just add credential keys in `terraform.tfvars file`


## create ssh login keys
Execute below script to create ssh-keys. this is onetime job. no need to execute everytime.
```
./generate_keys.sh
```
^ This file will create `login_key` and `login_key.pub` ssh keys used to login the vm created.  
^ Incase if you create keys with different name you need to modify two files `terraform.tfvars` and line number 12 in `main.tf`     

## Inside terraform
#### files
install_script.sh <<  write your script to install and configure the vm.  
terraform.tfvars << To change any specifications of vm.  


## Commands
```
terraform plan
terraform apply
terraform destroy
```

* `terraform plan`: will show what is going to be created
* `terraform apply`: will create resources(ec2 instance)
* `terraform destroy`: will delete resources(ec2 instance)


## how to login vm
```
ssh -i login_key ubuntu@<ip>
```


## usage
1. create keys `generate_keys.sh`
2. create vm `terraform apply --auto-approve`
3. destroy vm `terraform destroy`


## Notes:
* By default instance will be created in `us-east-1 ` region and `ubuntu 20` os. you can change this in `terraform.tfvars`
* Instance will be created in default vpc and default subnet, you can change this behaviour in `terraform.tfvars`
* so make sure you have right ports opened on `default` security group in `us-east-1` region. you can add security group in `terraform.tfvars`