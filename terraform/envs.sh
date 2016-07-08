#!/bin/bash
set -x

export AWS_ACCESS_KEY="insertawskeyhere"
export AWS_SECRET_KEY="insertsecrethere"
export TF_VAR_aws_account_number="insertacctnohere"

export TF_VAR_aws_account=wicksy
export TF_VAR_stack=WicksyCV

mkdir -p ./${TF_VAR_aws_account}/${TF_VAR_stack} 2>/dev/null
set +x
