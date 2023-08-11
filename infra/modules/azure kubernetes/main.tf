data "azurerm_private_dns_zone" "dnsz" {
  for_each = var.private_dns_zone
  name     = each.value["name"]
  resource_group_name = each.value["resource_group_name"]
}
resource "azurerm_kubernetes_cluster" "this" {
  provider                            = azurerm.sub_provider
  for_each                            = var.aks_clusters
  name                                = each.value["name"]
  location                            = each.value["location"]
  resource_group_name                 = each.value["resource_group_name"]
  dns_prefix                          = each.value["dns_prefix"]
  automatic_channel_upgrade           = lookup(each.value, "automatic_channel_upgrade", null)
  disk_encryption_set_id              = lookup(each.value, "disk_encryption_set_id", null)
  kubernetes_version                  = each.value["kubernetes_version"]
  node_resource_group                 = lookup(each.value, "node_resource_group", "rg-aks-nodes-${each.value.name}")
  private_cluster_enabled             = true
  private_dns_zone_id                 = data.azurerm_private_dns_zone.dnsz["dns"].id
  sku_tier                            = lookup(each.value, "sku_tier", null)
  azure_policy_enabled                = lookup(each.value, "azure_policy_enabled", true)
  http_application_routing_enabled    = lookup(each.value, "http_application_routing_enabled", false)
  edge_zone                           = lookup(each.value, "edge_zone  ", null)
  oidc_issuer_enabled                 = true
  workload_identity_enabled           = lookup(each.value, " workload_identity_enabled", true)
  public_network_access_enabled       = lookup(each.value, "public_network_access_enabled", false)
  local_account_disabled              = lookup(each.value, "local_account_disabled ", false)

  dynamic "default_node_pool" {
    for_each = lookup(each.value, "aks_default_pool", null) != null ? [lookup(each.value, "aks_default_pool", null)] : []
    content {
      name                         = default_node_pool.value.name
      vm_size                      = default_node_pool.value.vm_size
      zones                        = lookup(default_node_pool.value, "availability_zones", null)
      enable_auto_scaling          = coalesce(default_node_pool.value.enable_auto_scaling, true)
      max_pods                     = lookup(default_node_pool.value, "max_pods", null)
      os_disk_size_gb              = lookup(default_node_pool.value, "os_disk_size_gb", null)
      os_disk_type                 = lookup(default_node_pool.value, "os_disk_type", null)
      enable_host_encryption       = default_node_pool.value.enable_host_encryption == null ? true : default_node_pool.value.enable_host_encryption
      only_critical_addons_enabled = lookup(default_node_pool.value, "only_critical_addons_enabled", false)
      type                         = "VirtualMachineScaleSets"
      node_count                   = coalesce(default_node_pool.value.enable_auto_scaling, true) == true ? lookup(default_node_pool.value, "node_count", null) : default_node_pool.value.node_count
      min_count                    = coalesce(default_node_pool.value.enable_auto_scaling, true) == true ? default_node_pool.value.min_count : null
      max_count                    = coalesce(default_node_pool.value.enable_auto_scaling, true) == true ? default_node_pool.value.max_count : null
      vnet_subnet_id               = var.aks_subnet
    }
    
  } 

     dynamic "aci_connector_linux" {
    for_each = var.aci_connector_linux != null ? [var.aci_connector_linux] : []
    content {
      subnet_name = aci_connector_linux.value.subnet_name
    }
  }
    dynamic "oms_agent" {
    for_each = var.oms_agent != null ? [var.oms_agent] : []

    content {
      log_analytics_workspace_id = oms_agent.value.log_analytics_workspace_id
    }
  }

   dynamic "auto_scaler_profile" {
    for_each = var.auto_scaler_profile != null ? [var.auto_scaler_profile] : []

    content {
      balance_similar_node_groups      = auto_scaler_profile.value.balance_similar_node_groups
      expander                         = auto_scaler_profile.value.expander
      max_graceful_termination_sec     = auto_scaler_profile.value.max_graceful_termination_sec
      max_node_provisioning_time       = auto_scaler_profile.value.max_node_provisioning_time
      max_unready_nodes                = auto_scaler_profile.value.max_unready_nodes
      max_unready_percentage           = auto_scaler_profile.value.max_unready_percentage
      new_pod_scale_up_delay           = auto_scaler_profile.value.new_pod_scale_up_delay
      scale_down_delay_after_add       = auto_scaler_profile.value.scale_down_delay_after_add
      scale_down_delay_after_delete    = auto_scaler_profile.value.scale_down_delay_after_delete
      scale_down_delay_after_failure   = auto_scaler_profile.value.scale_down_delay_after_failure
      scan_interval                    = auto_scaler_profile.value.scan_interval
      scale_down_unneeded              = auto_scaler_profile.value.scale_down_unneeded
      scale_down_unready               = auto_scaler_profile.value.scale_down_unready
      scale_down_utilization_threshold = auto_scaler_profile.value.scale_down_utilization_threshold
      empty_bulk_delete_max            = auto_scaler_profile.value.empty_bulk_delete_max
      skip_nodes_with_local_storage    = auto_scaler_profile.value.skip_nodes_with_local_storage
      skip_nodes_with_system_pods      = auto_scaler_profile.value.skip_nodes_with_system_pods
    }
  }

   dynamic "linux_profile" {
    for_each = var.linux_profile != null ? [var.linux_profile] : []

    content {
      admin_username = linux_profile.value.admin_username

      dynamic "ssh_key" {
        for_each = [linux_profile.value.ssh_key]

        content {
          key_data = ssh_key.value.key_data
        }
      }
    }
  }
  
    dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? [var.maintenance_window] : []

    content {
      dynamic "allowed" {
        for_each = maintenance_window.value.allowed

        content {
          day   = allowed.value.day
          hours = allowed.value.hours
        }
      }

      dynamic "not_allowed" {
        for_each = maintenance_window.value.not_allowed

        content {
          end   = not_allowed.value.end
          start = not_allowed.value.start
        }
      }
    }
  }

  dynamic "network_profile" {
    for_each = var.network_profile != null ? [var.network_profile] : []

    content {
      network_plugin    = "azure"
      network_mode      = network_profile.value.network_mode
      network_plugin_mode = network_profile.value.network_plugin_mode 
      network_policy    = network_profile.value.network_policy
      dns_service_ip    = network_profile.value.dns_service_ip
      ebpf_data_plane   = network_profile.value.ebpf_data_plane
      outbound_type     = "userDefinedRouting"
      pod_cidr          = network_profile.value.pod_cidr
      pod_cidrs         = network_profile.value.pod_cidrs
      service_cidr      = network_profile.value.service_cidr
      service_cidrs     = network_profile.value.service_cidrs
      load_balancer_sku = network_profile.value.load_balancer_sku
      ip_versions       = network_profile.value.ip_versions

      dynamic "load_balancer_profile" {
        for_each = network_profile.value.load_balancer_profile != null ? [network_profile.value.load_balancer_profile] : []

        content {
          outbound_ports_allocated    = load_balancer_profile.value.outbound_ports_allocated
          idle_timeout_in_minutes     = load_balancer_profile.value.idle_timeout_in_minutes
          managed_outbound_ip_count   = load_balancer_profile.value.managed_outbound_ip_count
          managed_outbound_ipv6_count = load_balancer_profile.value.managed_outbound_ipv6_count
          outbound_ip_prefix_ids      = load_balancer_profile.value.outbound_ip_prefix_ids
          outbound_ip_address_ids     = load_balancer_profile.value.outbound_ip_address_ids
        }
      }

      dynamic "nat_gateway_profile" {
        for_each = network_profile.value.load_balancer_profile != null ? [network_profile.value.load_balancer_profile] : []

        content {
          idle_timeout_in_minutes   = network_profile.value.idle_timeout_in_minutes
          managed_outbound_ip_count = network_profile.value.managed_outbound_ip_count
        }
      }
    }
  }
  identity {
    type = "UserAssigned"
    identity_ids = [var.managed_identity]
  }

   dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.azure_active_directory_role_based_access_control != null ? [var.azure_active_directory_role_based_access_control] : []

    content {
      managed                = azure_active_directory_role_based_access_control.value.managed
      tenant_id              = azure_active_directory_role_based_access_control.value.tenant_id
      admin_group_object_ids = azure_active_directory_role_based_access_control.value.admin_group_object_ids
      azure_rbac_enabled     = azure_active_directory_role_based_access_control.value.azure_rbac_enabled
      client_app_id          = azure_active_directory_role_based_access_control.value.client_app_id
      server_app_id          = azure_active_directory_role_based_access_control.value.server_app_id
      server_app_secret      = azure_active_directory_role_based_access_control.value.server_app_secret
    }
  }
  # ingress_application_gateway {
  #     gateway_id =  var.app_gateway_id
 
  # }
   lifecycle {
     ignore_changes = [
       tags
     ]
   }

}


