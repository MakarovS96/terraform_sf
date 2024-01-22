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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ya_inst_1"></a> [ya\_inst\_1](#module\_ya\_inst\_1) | ./modules/compute_instance | n/a |
| <a name="module_ya_inst_2"></a> [ya\_inst\_2](#module\_ya\_inst\_2) | ./modules/compute_instance | n/a |

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.testnet](https://registry.terraform.io/providers/yandex-cloud/yandex/0.105.0/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.testsubnet1](https://registry.terraform.io/providers/yandex-cloud/yandex/0.105.0/docs/resources/vpc_subnet) | resource |
| [yandex_vpc_subnet.testsubnet2](https://registry.terraform.io/providers/yandex-cloud/yandex/0.105.0/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud"></a> [cloud](#input\_cloud) | Id of cloud | `string` | `"b1g4bbs8vqoial0me098"` | no |
| <a name="input_folder"></a> [folder](#input\_folder) | Id of buckets folder | `string` | `"b1grknfubsv8vul1i8j4"` | no |
| <a name="input_zonea"></a> [zonea](#input\_zonea) | Use specific availability zone | `string` | `"ru-central1-a"` | no |
| <a name="input_zoneb"></a> [zoneb](#input\_zoneb) | Use specific availability zone | `string` | `"ru-central1-b"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_ip_address_vm1"></a> [external\_ip\_address\_vm1](#output\_external\_ip\_address\_vm1) | n/a |
| <a name="output_external_ip_address_vm2"></a> [external\_ip\_address\_vm2](#output\_external\_ip\_address\_vm2) | n/a |
| <a name="output_internal_ip_address_vm1"></a> [internal\_ip\_address\_vm1](#output\_internal\_ip\_address\_vm1) | n/a |
| <a name="output_internal_ip_address_vm2"></a> [internal\_ip\_address\_vm2](#output\_internal\_ip\_address\_vm2) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->