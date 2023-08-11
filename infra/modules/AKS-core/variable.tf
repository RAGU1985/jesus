variable "subscription_id" {
  type        = string
  description = "Subscription id to echo"
}

variable "managed_identity" {
  type = map(object({
    name                          = string
    resource_group_name           = string
    location                      = string
  }))
    default     = {}
}
variable "private_dns_zone" {
  type = map(object({
    name                          = string
    resource_group_name           = string
  }))
}
variable "resource_groups" {
  type = map(object({
    location = string
    name     = string
  }))
  description = "Specifies the map of objects for a resource group"
  default     = {}
}

variable "location" {
  type = string
}
variable "virtual_networks" {
  type = map(object({
    name                = string
    resource_group_name = string
  }))
  description = "Specifies the map of objects for a virtual network"
  default     = {}
}

variable "subnets" {
  type = map(object({
    address_prefixes                          = list(string)
    name                                      = string
    private_endpoint_network_policies_enabled = bool
    resource_group_name                       = string
    virtual_network_name                      = string
    service_endpoints                         = list(string)
    delegation = list(object({
      name = string
      service_delegation = list(object({
        actions = list(string)
        name    = string
      }))
    }))
  }))
  description = "Specifies the map of objects for a subnet"
  default     = {}
}

variable "subnet_network_security_group_associations" {
  type = map(object({
    network_security_group_name = string
    resource_group_name         = string
    subnet_name                 = string
    virtual_network_name        = string
  }))
  description = "Specifies the map of objects for a subnet network security group association."
  default     = {}
}

variable "network_security_groups" {
  type = map(object({
    location            = string
    name                = string
    resource_group_name = string

    security_rules = list(object({
      name                         = string
      description                  = string
      protocol                     = string
      direction                    = string
      access                       = string
      priority                     = number
      source_address_prefix        = string
      source_address_prefixes      = list(string)
      destination_address_prefix   = string
      destination_address_prefixes = list(string)
      source_port_range            = string
      source_port_ranges           = list(string)
      destination_port_range       = string
      destination_port_ranges      = list(string)
    }))
  }))
  description = "Specifies the map of objects for a network security group"
  default     = {}
}

variable "route_tables" {
  type = map(object({
    name                          = string
    resource_group_name           = string
    location                      = string
    disable_bgp_route_propagation = bool

    routes = list(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = string
    }))
  }))
  description = "The route tables with their properties."
  default     = {}
}
variable "private_dns_zones" {
  type = map(object({
    name                = string
    resource_group_name = string
  }))
  description = "Specifies the map of objects for a private dns zone"
  default     = {}
}


variable "aks_clusters" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = string
    kubernetes_version  = string
    node_resource_group = string
    sku_tier            = string

  aks_default_pool = object({
      name                         = string
      vm_size                      = string
      availability_zones           = list(string) 
      enable_auto_scaling          = bool
      max_pods                     = number
      os_disk_size_gb              = number
      os_disk_type                 = string
      enable_host_encryption       = bool
      networking_resource_group    = string
      node_count                   = number
      max_count                    = number
      min_count                    = number
      only_critical_addons_enabled = bool

  })
}))
default = {}  
}
variable "network_profile" {
  type = object({
    network_mode        = optional(string)
    network_policy      = optional(string)
    dns_service_ip      = optional(string)
    ebpf_data_plane     = optional(string)
    network_plugin_mode = optional(string)
    pod_cidr            = optional(string)
    pod_cidrs           = optional(list(string))
    service_cidr        = optional(string)
    service_cidrs       = optional(list(string))
    load_balancer_sku   = optional(string)
    ip_versions         = optional(list(string))
    nat_gateway_profile = optional(object({
      idle_timeout_in_minutes   = number
      managed_outbound_ip_count = number
    }))

    load_balancer_profile = optional(object({
      outbound_ports_allocated    = number
      idle_timeout_in_minutes     = number
      managed_outbound_ip_count   = number
      managed_outbound_ipv6_count = number
      outbound_ip_prefix_ids      = list(string)
      outbound_ip_address_ids     = list(string)
    }))
  })

  description = <<-EOT
    (Optional) A network_profile block as defined below: (If network_profile is not defined, kubenet profile will be used by default.)
    ```
    {
      network_plugin        = string - (Required) Network plugin to use for networking. Currently supported values are azure and kubenet. Changing this forces a new resource to be created.
      network_mode          = string - (Optional) Network mode to be used with Azure CNI. Possible values are `bridge` and `transparent`. This property can only be set when network_plugin is set to azure. Changing this forces a new resource to be created.
      network_policy        = string - (Optional) Sets up network policy to be used with Azure CNI. [Network policy allows us to control the traffic flow between pods](https://docs.microsoft.com/en-us/azure/aks/use-network-policies). Currently supported values are `calico` and `azure`. Changing this forces a new resource to be created.
      dns_service_ip        = string - (Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created.
      docker_bridge_cidr    = string - (Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created.
      ebpf_data_plane       = string - (Optional) Specifies the eBPF data plane used for building the Kubernetes network. Possible value is cilium. Changing this forces a new resource to be created.
      network_plugin_mode   = string - (Optional) Specifies the network plugin mode used for building the Kubernetes network. Possible value is Overlay. 
      outbound_type         = string - (Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are `loadBalancer` and `userDefinedRouting`. Defaults to `loadBalancer`.
      pod_cidr              = string - (Optional) The CIDR to use for pod IP addresses. This field can only be set when `network_plugin` is set to `kubenet`. Changing this forces a new resource to be created.
      pod_cidrs             = string - (Optional) A list of CIDRs to use for pod IP addresses. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected.
      service_cidr          = string - (Optional) The Network Range used by the Kubernetes service. This range should not be used by any network element on or connected to this VNet. Service address CIDR must be smaller than /12. docker_bridge_cidr, dns_service_ip and service_cidr should all be empty or all should be set. Changing this forces a new resource to be created.
      service_cidrs         = string - (Optional) A list of CIDRs to use for Kubernetes services. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. 
      load_balancer_sku     = string - (Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are `Basic` and `Standard`. Defaults to `Standard`.
      ip_versions           = list(string) - (Optional) (Optional) Specifies a list of IP versions the Kubernetes Cluster will use to assign IP addresses to its nodes and pods. Possible values are IPv4 and/or IPv6. IPv4 must always be specified.
      load_balancer_profile = // (Optional) A load_balancer_profile block. This can only be specified when `load_balancer_sku` is set to `Standard`.
      { 
        outbound_ports_allocated  = number - (Optional) Number of desired SNAT port for each VM in the clusters load balancer. Must be between `0` and `64000` inclusive. Defaults to `0`.
        idle_timeout_in_minutes   = number - (Optional) Desired outbound flow idle timeout in minutes for the cluster load balancer. Must be between `4` and `120` inclusive. Defaults to `30`.
        managed_outbound_ip_count = number - (Optional) Count of desired managed outbound IPs for the cluster load balancer. Must be between `1` and `100` inclusive. User has to explicitly set managed_outbound_ip_count to empty slice (`[]`) to remove it.
        managed_outbound_ipv6_count = number - (Optional) The desired number of IPv6 outbound IPs created and managed by Azure for the cluster load balancer. Must be in the range of 1 to 100 (inclusive). The default value is 0 for single-stack and 1 for dual-stack.
        outbound_ip_prefix_ids    = list(string) - (Optional) The ID of the outbound Public IP Address Prefixes which should be used for the cluster load balancer. User has to explicitly set outbound_ip_prefix_ids to empty slice (`[]`) to remove it.
        outbound_ip_address_ids   = list(string) - (Optional) The ID of the Public IP Addresses which should be used for outbound communication for the cluster load balancer. User has to explicitly set outbound_ip_address_ids to empty slice (`[]`) to remove it.
      }
    }
    ```

    **NOTE1**: When `network_plugin` is set to azure - the `default_node_pool_vnet_subnet_id` variable must be set and `pod_cidr` (in this object) must not be set.
    
    **NOTE2**: `network_mode` can only be set to `bridge` for existing Kubernetes Clusters and cannot be used to provision new Clusters - this will be removed by Azure in the future.
    
    **NOTE3**: If a property isn't required then it must be explicitly set as an empty list or `null`.
  EOT

  default = null

}

variable "aci_connector_linux" {
  type = object({
    subnet_name = string
  })

  description = <<-EOT
     // (Optional) A aci_connector_linux block. For more details, please visit [Create and configure an AKS cluster to use virtual nodes](https://docs.microsoft.com/en-us/azure/aks/virtual-nodes-portal).
    {
      subnet_name = string - (Optional) The subnet name for the virtual nodes to run. This is required when aci_connector_linux enabled argument is set to true.
    }
  EOT

  default = null
}
variable "oms_agent" {
  type = object({
    log_analytics_workspace_id = string
  })

  description = <<-EOT
     // (Optional) A oms_agent block. For more details, please visit [Create and configure an AKS cluster to use virtual nodes](https://docs.microsoft.com/en-us/azure/aks/virtual-nodes-portal).

    ```{
      log_analytics_workspace_id = string -  (Required) The ID of the Log Analytics Workspace which the OMS Agent should send data to.
    }
    EOT
  default = null
}

variable "auto_scaler_profile" {
  type = object({
    balance_similar_node_groups      = optional(bool)
    expander                         = optional(string)
    max_graceful_termination_sec     = optional(number)
    max_node_provisioning_time       = optional(string)
    max_unready_nodes                = optional(number)
    max_unready_percentage           = optional(number)
    new_pod_scale_up_delay           = optional(string)
    scale_down_delay_after_add       = optional(string)
    scale_down_delay_after_delete    = optional(string)
    scale_down_delay_after_failure   = optional(string)
    scan_interval                    = optional(string)
    scale_down_unneeded              = optional(string)
    scale_down_unready               = optional(string)
    scale_down_utilization_threshold = optional(number)
    empty_bulk_delete_max            = optional(number)
    skip_nodes_with_local_storage    = optional(bool)
    skip_nodes_with_system_pods      = optional(bool)
  })

  description = <<-EOT
    (Optional) An auto_scaler_profile block supports the following:

    ```
    {
      balance_similar_node_groups      = bool - (Optional) Detect similar node groups and balance the number of nodes between them. Defaults to `false`.
      expander                         = string - (Optional) Expander to use. Possible values are `least-waste`, `priority`, `most-pods` and `random`. Defaults to `random`.
      max_graceful_termination_sec     = number - (Optional) Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node. Defaults to `600`.
      max_node_provisioning_time       = string - (Optional) Maximum time the autoscaler waits for a node to be provisioned. Defaults to `15m`.
      max_unready_nodes                = number - (Optional) Maximum Number of allowed unready nodes. Defaults to `3`.
      max_unready_percentage           = number - (Optional) Maximum percentage of unready nodes the cluster autoscaler will stop if the percentage is exceeded. Defaults to `45`.
      new_pod_scale_up_delay           = string - (Optional) For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. Defaults to `10s`.
      scale_down_delay_after_add       = string - (Optional) How long after the scale up of AKS nodes the scale down evaluation resumes. Defaults to `10m`.
      scale_down_delay_after_delete    = string - (Optional) How long after node deletion that scale down evaluation resumes. Defaults to the value used for `scan_interval`.
      scale_down_delay_after_failure   = string - (Optional) How long after scale down failure that scale down evaluation resumes. Defaults to `3m`.
      scan_interval                    = string - (Optional) How often the AKS Cluster should be re-evaluated for scale up/down. Defaults to `10s`.
      scale_down_unneeded              = string - (Optional) How long a node should be unneeded before it is eligible for scale down. Defaults to `10m`.
      scale_down_unready               = string - (Optional) How long an unready node should be unneeded before it is eligible for scale down. Defaults to `20m`.
      scale_down_utilization_threshold = number - (Optional) Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down. Defaults to `0.5`.
      empty_bulk_delete_max            = number - (Optional) Maximum number of empty nodes that can be deleted at the same time. Defaults to `10`.
      skip_nodes_with_local_storage    = bool - (Optional) If `true` cluster autoscaler will never delete nodes with pods with local storage, for example, EmptyDir or HostPath. Defaults to `true`.
      skip_nodes_with_system_pods      = bool - (Optional) If `true` cluster autoscaler will never delete nodes with pods from kube-system (except for DaemonSet or mirror pods). Defaults to `true`.
    }
    ```

    **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
  EOT

  default = null
}

variable "linux_profile" {
  type = object({
    admin_username = string

    ssh_key = object({
      key_data = string
    })
  })

  description = <<-EOT
    (Optional)   A linux_profile block supports the following:

    ```
    {
      admin_username = string - (Required) The Admin Username for the Cluster. Changing this forces a new resource to be created.

      ssh_key = { // (Required) An ssh_key block. Only one is currently allowed. Changing this forces a new resource to be created.
        key_data = string - (Required) The Public SSH Key used to access the cluster. Changing this forces a new resource to be created.
      }
    }
    ```
  EOT

  default = null
}
variable "maintenance_window" {
  type = object({
    allowed = object({
      day   = string
      hours = list(number)
    })

    not_allowed = object({
      end   = string
      start = string
    })
  })

  description = <<-EOT
    (Optional)   A maintenance_window block supports the following:

    ```
    {
      allowed = { // (Optional) One or more allowed block as defined below.
        day   = string - (Required) A day in a week. Possible values are `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` and `Saturday`.
        hours = list(number) - (Required) An array of hour slots in a day. Possible values are between `0` and `23`.
      }

      not_allowed = { - (Optional) One or more not_allowed block as defined below.
        end   = string - (Required) The end of a time span, formatted as an RFC3339 string.
        start = string - (Required) The start of a time span, formatted as an RFC3339 string.
      }
    }
    ```

    **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
  EOT

  default = null
}
variable "azure_active_directory_role_based_access_control" {
  type = object({
    managed                = optional(bool)
    tenant_id              = optional(string)
    admin_group_object_ids = optional(list(string))
    azure_rbac_enabled     = optional(bool)
    client_app_id          = optional(string)
    server_app_id          = optional(string)
    server_app_secret      = optional(string)
  })

  description = <<-EOT
    (Optional) A azure_active_directory_role_based_access_control block supports the following:

    ```
    {
        managed                = bool - (Required) Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration.
        tenant_id              = string - (Optional) The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used.
        admin_group_object_ids = list(string) - (Optional) Can be specified when managed is set to `true`. A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster.
        azure_rbac_enabled     = bool - (Optional) Can be specified when managed is set to `true`. Is Role Based Access Control based on Azure AD enabled?
        client_app_id          = string - (Required) Specified when managed is set to `false`. The Client ID of an Azure Active Directory Application.
        server_app_id          = string - (Required) Specified when managed is set to `false`. The Server ID of an Azure Active Directory Application.
        server_app_secret      = string - (Required) Specified when managed is set to `false`. The Server Secret of an Azure Active Directory Application.
    }
    ```

    **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
  EOT
  default = {
    managed            = true
    azure_rbac_enabled = true
    admin_group_object_ids = [

    ]
  }
}

variable "edge_zone" {
  type        = string
  description = <<-EOT
    (Optional) Specifies the Edge Zone within the Azure Region where this Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.
    **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
  EOT
  default     = null
}



variable "image_cleaner_enabled" {
  type        = bool
  description = <<-EOT
    (Optional) Specifies whether Image Cleaner is enabled. 
  EOT
  default     = false
}

variable "image_cleaner_interval_hours" {
  type        = number
  description = <<-EOT
    (Optional) Specifies the interval in hours when images should be cleaned up. Defaults to 48    **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
  EOT
  default     = 48
}




