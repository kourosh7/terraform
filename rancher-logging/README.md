# Terraform rancher-logging script

## Summary

This Terraform script will install the rancher-logging helm chart into Rancher.

Values that need to be set:

## provider.tf
- api_url: url to your Rancher setup
- token_key: api bearer token that you set in Rancher for installing this

## rancher-logging.tf
- chart_version: the version of the rancher-logging helm chart you wish to be installed
