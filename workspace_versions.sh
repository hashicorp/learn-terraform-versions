#!/bin/bash
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0


# Example Terraform Cloud workspace versions script.
#
# Print out a report of Terraform Cloud workspaces, and their versions using the
# Terraform Cloud API.
#
# TFC_ORG: Name of your Terraform Cloud organization
# TFC_TOKEN: Terraform Cloud Team token, for a team with permission to read workspace details

if [  $# -le 1 ]
    then 
        echo "Usage: $0 [TFC_ORG] [TFC_TOKEN]"
    	exit 1
fi 

TFC_ORG=$1
TFC_TOKEN=$2

for ((i=1; ; i++)); do
    response=$(curl --silent --get --header "Authorization: Bearer $TFC_TOKEN" --header "Content-Type: application/vnd.api+json" "https://app.terraform.io/api/v2/organizations/$TFC_ORG/workspaces" --data-urlencode "page[number]=$i")

    jq '.data[] | {"workspace": .attributes["name"], "terraform-version": .attributes["terraform-version"] }' <<< "$response"

    if jq --exit-status '.meta.pagination["next-page"] == null' > /dev/null <<< "$response"; then
        break
    fi
done
