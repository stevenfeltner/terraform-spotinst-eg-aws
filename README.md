# Spot Elasticgroup AWS Terraform Module

Spotinst Terraform Module to integrate elastigroup

## Usage
```hcl
provider "spotinst" {
  token   = "redacted"
  account = "redacted"
}

module "eg-aws" {
  source  = "spotinst/eg-aws/stevenfeltner"
  ...
}
```

## Providers

| Name | Version |
|------|---------|
| spotinst/spotinst | >= 1.78 |
| hashicorp/aws |  |


## Documentation

If you're new to [Spot](https://spot.io/) and want to get started, please checkout our [Getting Started](https://docs.spot.io/connect-your-cloud-provider/) guide, available on the [Spot Documentation](https://docs.spot.io/) website.

## Getting Help

We use GitHub issues for tracking bugs and feature requests. Please use these community resources for getting help:

- Ask a question on [Stack Overflow](https://stackoverflow.com/) and tag it with [terraform-spotinst](https://stackoverflow.com/questions/tagged/terraform-spotinst/).
- Join our [Spot](https://spot.io/) community on [Slack](http://slack.spot.io/).
- Open an issue.

## Community

- [Slack](http://slack.spot.io/)
- [Twitter](https://twitter.com/spot_hq/)

## Contributing

Please see the [contribution guidelines](CONTRIBUTING.md).