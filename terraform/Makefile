plan:
	terraform plan -var "aws_access_key=${AWS_ACCESS_KEY}" -var "aws_secret_key=${AWS_SECRET_KEY}" -state=./${TF_VAR_aws_account}/${TF_VAR_stack}/terraform.tfstate

apply:
	terraform apply -var "aws_access_key=${AWS_ACCESS_KEY}" -var "aws_secret_key=${AWS_SECRET_KEY}" -state=./${TF_VAR_aws_account}/${TF_VAR_stack}/terraform.tfstate

plandestroy:
	terraform plan -destroy -var "aws_access_key=${AWS_ACCESS_KEY}" -var "aws_secret_key=${AWS_SECRET_KEY}" -state=./${TF_VAR_aws_account}/${TF_VAR_stack}/terraform.tfstate

destroy:
	terraform destroy -var "aws_access_key=${AWS_ACCESS_KEY}" -var "aws_secret_key=${AWS_SECRET_KEY}" -state=./${TF_VAR_aws_account}/${TF_VAR_stack}/terraform.tfstate
