# meta arguments in Azure Terraform 

## Introduction
- Meta arguments are used to provide additional information to the Terraform configuration.

## Meta Arguments
1. `count` : The count meta-argument is used to create multiple instances of a resource.
2. `depends_on` : The depends_on meta-argument is used to specify the order of the resources to be created. 
3. `provider` : The provider meta-argument is used to specify the provider configuration for the resource.
4. `lifecycle` : The lifecycle meta-argument is used to specify the lifecycle configuration for the resource.
5. `ignore_changes` : The ignore_changes meta-argument is used to specify the attributes that should be ignored during the update.
6. `delete_before_create` : The delete_before_create meta-argument is used to delete the resource before creating it.
7. `create_before_destroy` : The create_before_destroy meta-argument is used to create the new resource before destroying the old one.
8. `count_index` : The count_index meta-argument is used to get the index of the resource in the count.
9. `for_each` : The for_each meta-argument is used to create multiple instances of a resource with unique keys.
10. `provider_alias` : The provider_alias meta-argument is used to specify the provider alias for the resource.
11. `sensitive` : The sensitive meta-argument is used to mark the attribute as sensitive.
12. `timeouts` : The timeouts meta-argument is used to specify the timeouts for the resource.
13. `connection` : The connection meta-argument is used to specify the connection configuration for the resource.
14. `provisioner` : The provisioner meta-argument is used to specify the provisioner configuration for the resource.
15. `connection_pool` : The connection_pool meta-argument is used to specify the connection pool configuration for the resource.
16. `reconfigure` : The reconfigure meta-argument is used to reconfigure the resource.
17. `import` : The import meta-argument is used to import the existing resource into the Terraform state.
18. `schema_version` : The schema_version meta-argument is used to specify the schema version for the resource.
19. `custom_timeout` : The custom_timeout meta-argument is used to specify the custom timeout for the resource.
20. `custom_config` : The custom_config meta-argument is used to specify the custom configuration for the resource