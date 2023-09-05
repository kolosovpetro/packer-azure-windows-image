## Terraform commands

- Init examples:
    - `terraform init -backend-config="azure.sas.conf"`
    - `terraform init -backend-config="azure.sas.conf" -reconfigure`
- Plan examples
    - `terraform plan -var "prefix=${prefix}" -out "main.tfplan"`
    - `terraform plan -var "prefix=${prefix}" -var "sql_admin_password=$env:MANGO_TF_SQL_PASS" -out "main.tfplan"`
    - `terraform plan -var "prefix=${prefix}" -var "os_profile_admin_password=1wSWB2Mbl8918kFvtwac" -out "main.tfplan"`
    - `terraform plan -var-file='terraform.dev.tfvars' -var sql_admin_username='razumovsky_r' -var sql_admin_password='Zd2yqLgyV4uHVC0eTPiH' -out 'main.tfplan'`
    - `terraform plan -var-file='terraform.dev.tfvars' -out 'dev.tfplan'`
- Apply examples:
    - `terraform apply main.tfplan`
    - `terraform fmt --check`
- Import examples
    - /subscriptions/42f3171c-7f76-4241-8b33-17e610e83143/resourceGroups/rg-vm-linux-l03
    - az group show --name rg-vm-linux-l03 --query id --output tsv
    - terraform import -var "prefix=${prefix}" azurerm_resource_group.public
      /subscriptions/42f3171c-7f76-4241-8b33-17e610e83143/resourceGroups/rg-vm-linux-l03
- Destroy examples:
    - `terraform plan -var "sql_admin_password=$env:MANGO_TF_SQL_PASS" -var "prefix=${prefix}" -destroy -out "main.destroy.tfplan"`
    - `terraform plan -var "prefix=${prefix}" -destroy -out "main.destroy.tfplan"`
    - `terraform apply -destroy -auto-approve "main.destroy.tfplan"`
- Workspace examples:
    - `terraform workspace new d01`
    - `terraform workspace select d01`

## Terraform docs

- `terraform-docs markdown table ./ --output-file README.md`
