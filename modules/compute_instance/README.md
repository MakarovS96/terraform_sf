# compute_instance

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) |  >= 1.5 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | 0.105.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.105.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_compute_instance.vm](https://registry.terraform.io/providers/yandex-cloud/yandex/0.105.0/docs/resources/compute_instance) | resource |
| [yandex_compute_image.my_image](https://registry.terraform.io/providers/yandex-cloud/yandex/0.105.0/docs/data-sources/compute_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_family_image"></a> [instance\_family\_image](#input\_instance\_family\_image) | instance family name | `string` | `"lamp"` | no |
| <a name="input_vpc_subnet_id"></a> [vpc\_subnet\_id](#input\_vpc\_subnet\_id) | id of subnet | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone of availability | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_ip_address"></a> [external\_ip\_address](#output\_external\_ip\_address) | n/a |
| <a name="output_internal_ip_address"></a> [internal\_ip\_address](#output\_internal\_ip\_address) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
