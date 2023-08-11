variable "resource_group_name"{
    type = string  
}
variable "location"{
  type = string
}
variable "virtual_network_name"{
  type = string
}
variable "appgw_subnet_name"{
  type =  string
  
}
variable "appgw_subnet_name1" {
  type= string
}
variable "appgw_subnet_name2" {
  type= string
}
variable "appgw-pip" {
  type = string
}
variable "appgw-pip1" {
  type = string
}
variable "app_gateway_name1" {
    type = string  
}
variable "appgw-pip2" {
  type = string
  
}
variable "allocation_method"{
  type = string
}

variable "app_gateway_name"{
    type = string  
}
variable "aks_name1" {
  type = string
  
}
variable "aks_name2" {
  type = string
  
}
variable "dns_prefix1" {
  type = string
}
variable "dns_prefix2" {
  type = string
}

variable "app_gateway_tier"{
  type = string
}

variable "gateway_ip_configuration"{
  type = string
}

variable "app_gateway_name2" {
    type = string  
}
variable "sku" {
  type = string
}

variable "aks_name" {
  type = string
}

variable "azurerm_subnet" {
  type = string
}
variable "azurerm_subnet1" {
  type = string
}
variable "azurerm_subnet2" {
  type = string
}
variable "dns_prefix" {
  type = string
}
variable "private_dns_zone_id" {
  type = string
}
variable "kubernetes_version" {
  type = string
}
variable "azure_policy_enabled" {
  type = bool
  default     = true
}
variable "dns_prefix_private_cluster" {
  type = string
    default = null
}
variable "automatic_channel_upgrade" {
  type        = string
  default     = "stable"
}

variable "node_resource_group1"{
  type = string
}
variable "node_resource_group2"{
  type = string
}
variable "disk_encryption_set_id" {
  type = string

  description = <<-EOT
       (Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes.
      
      More information can be found in the documentation [here](https://docs.microsoft.com/en-us/azure/aks/azure-disk-customer-managed-keys).
      EOT

  default = null
}

variable "node_resource_group" {
  type = string

  description = <<-EOT
      (Optional) The name of the Resource Group where the Kubernetes Nodes should exist.
      
      Changing this forces a new resource to be created.

      **NOTE**: Azure requires that a new, non-existent Resource Group is used, as otherwise the provisioning of the Kubernetes Service will fail.
      EOT

  default = null
}

variable "private_cluster_public_fqdn_enabled" {
  type = string

  description = <<-EOT
      (Optional)   Specifies whether a Public FQDN for this Private Cluster should be added.
      
      **NOTE1**: This requires that the Preview Feature `Microsoft.ContainerService/EnablePrivateClusterPublicFQDN` is enabled and the Resource Provider is re-registered, see the documentation [here](https://docs.microsoft.com/en-us/azure/aks/private-clusters#create-a-private-aks-cluster-with-a-public-dns-address) for more information.

      **NOTE2**: If you use BYO DNS Zone, AKS cluster should either use a User Assigned Identity or a service principal (which is deprecated) with the Private DNS Zone Contributor role and access to this Private DNS Zone. If UserAssigned identity is used - to prevent improper resource order destruction - cluster should depend on the role assignment. 
      EOT

  default = false
}

variable "sku_tier" {
  type        = string
  description = "(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are `Free` and `Paid` (which includes the Uptime SLA)."
  default     = "Standard"
}


variable "default_node_pool_name" {
  type        = string
  description = "(Optional) The name which should be used for the default Kubernetes Node Pool. Changing this forces a new resource to be created."
  default     = "default"
}

variable "default_node_pool_vm_size" {
  type        = string
  description = "(Optional) The size of the Virtual Machine, such as Standard_DS2_v2."
  default     = "Standard_B2s"
}

variable "default_node_pool_capacity_reservation_group_id" {
  type        = string
  description = "(Optional) Specifies the ID of the Capacity Reservation Group within which this AKS Cluster should be created. Changing this forces a new resource to be created."
  default     = null
}

variable "default_node_pool_custom_ca_trust_enabled" {
  type        = bool
  description = "(Optional) Specifies whether to trust a Custom CA."
  default     = false
}

variable "default_node_pool_enable_auto_scaling" {
  type = bool

  description = <<-EOT
    (Optional)   Should the Kubernetes Auto Scaler be enabled for this Node Pool?

    **NOTE**: This requires that the `type` is set to `VirtualMachineScaleSets`. Also, If you're using AutoScaling, you may wish to use Terraform's `ignore_changes` functionality to ignore changes to the `node_count` field.
  EOT

  default = false
}

variable "default_node_pool_enable_host_encryption" {
  type        = bool
  description = "(Optional) Should the nodes in the Default Node Pool have host encryption enabled?"
  default     = false
}

variable "default_node_pool_enable_node_public_ip" {
  type        = bool
  description = "(Optional) Should nodes in this Node Pool have a Public IP Address? Changing this forces a new resource to be created."
  default     = false
}

variable "default_node_pool_host_group_id" {
  type        = string
  description = "(Optional) Specifies the ID of the Host Group within which this AKS Cluster should be created."
  default     = null
}

variable "default_node_pool_fips_enabled" {
  type = bool

  description = <<-EOT
    (Optional)   Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created.

    **NOTE**: FIPS support is in Public Preview - more information and details on how to opt into the Preview can be found in [this article](https://docs.microsoft.com/en-us/azure/aks/use-multiple-node-pools#add-a-fips-enabled-node-pool-preview).
    EOT

  default = null
}

variable "default_node_pool_kubelet_disk_type" {
  type        = string
  description = "(Optional) The type of disk used by kubelet. At this time the only possible value is OS."
  default     = "OS"
}

variable "default_node_pool_max_pods" {
  type        = number
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  default     = 250
}

variable "default_node_pool_message_of_the_day" {
  type        = string
  description = "(Optional) A base64-encoded string which will be written to /etc/motd after decoding. This allows customization of the message of the day for Linux nodes. It cannot be specified for Windows nodes and must be a static string (i.e. will be printed raw and not executed as a script). Changing this forces a new resource to be created."
  default     = 250
}

variable "default_node_pool_node_public_ip_prefix_id" {
  type        = string
  description = "(Optional) Resource ID for the Public IP Addresses Prefix for the nodes in this Node Pool. enable_node_public_ip should be true. Changing this forces a new resource to be created."
  default     = null
}

variable "default_node_pool_node_labels" {
  type        = map(string)
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created."
  default     = null
}

variable "default_node_pool_only_critical_addons_enabled" {
  type        = bool
  description = "(Optional) Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint. Changing this forces a new resource to be created."
  default     = null
}

variable "default_node_pool_orchestrator_version" {
  type = string

  description = <<-EOT
    (Optional)   Version of Kubernetes used for the Agents. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)
    
    **NOTE**: This version must be supported by the Kubernetes Cluster - as such the version of Kubernetes used on the Cluster/Control Plane may need to be upgraded first.
  EOT

  default = null
}

variable "default_node_pool_os_disk_size_gb" {
  type        = string
  description = "(Optional) The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created."
  default     = null
}

variable "default_node_pool_os_disk_type" {
  type        = string
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are `Ephemeral` and `Managed`. Changing this forces a new resource to be created."
  default     = "Managed"
}

variable "default_node_pool_os_sku" {
  type        = string
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are `Ephemeral` and `Managed`. Changing this forces a new resource to be created."
  default     = "Ubuntu"
}

# variable "default_node_pool_pod_subnet_id" {
#   type        = string
#   description = "(Optional) The ID of the Subnet where the pods in the default Node Pool should exist."
#   default     = null
# }

variable "default_node_pool_proximity_placement_group_id" {
  type        = string
  description = "(Optional) The ID of the Proximity Placement Group."
  default     = null
}

variable "default_node_pool_scale_down_mode" {
  type        = string
  description = "(Optional) Specifies the autoscaling behaviour of the Kubernetes Cluster. Allowed values are Delete and Deallocate"
  default     = "Delete"
}

variable "default_node_pool_type" {
  type        = string
  description = "(Optional) The type of Node Pool which should be created. Possible values are `AvailabilitySet` and `VirtualMachineScaleSets`."
  default     = "VirtualMachineScaleSets"
}

variable "default_node_pool_tags" {
  type = map(string)

  description = <<-EOT
    (Optional)   A mapping of tags to assign to the Node Pool.

    **NOTE**: At this time there's a bug in the AKS API where Tags for a Node Pool are not stored in the correct case - you may wish to use Terraform's `ignore_changes` functionality to ignore changes to the casing until this is fixed in the AKS API.
  EOT

  default = null
}

variable "default_node_pool_ultra_ssd_enabled" {
  type        = bool
  description = "(Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. See the [documentation](https://docs.microsoft.com/en-us/azure/aks/use-ultra-disks) for more information."
  default     = false
}

# variable "default_node_pool_vnet_subnet_id" {

#   description = "(Optional) The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."

# }

variable "default_node_pool_max_count" {
  type        = number
  description = <<EOT
    (Optional) The maximum number of nodes which should exist in this Node Pool. If specified this must be between `1` and `1000`.

    **NOTE**: This is mandatory if `enable_auto_scaling` is set to `true`.
  EOT

  default = null
}

variable "default_node_pool_min_count" {
  type        = number
  description = <<EOT
    (Optional) The minimum number of nodes which should exist in this Node Pool. If specified this must be between `1` and `1000`.

    **NOTE**: This is mandatory if `enable_auto_scaling` is set to `true`.
  EOT

  default = null
}

variable "default_node_pool_node_count" {
  type = number

  description = <<EOT
    (Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count
    **NOTE**: When `enable_auto_scaling` is set to `true` this is optional. However, when `enable_auto_scaling` is set to `false` this is required
  EOT

  default = null
}

variable "default_node_pool_workload_runtime" {
  type        = string
  description = <<EOT
   (Optional) Specifies the workload runtime used by the node pool. 
    **NOTE**: This is mandatory if `enable_auto_scaling` is set to `true`.
  EOT

  default = "OCIContainer"
}

variable "default_node_pool_zones" {
  type        = list(string)
  description = "(Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster should be located. "
  default     = null
}

variable "http_application_routing_enabled" {
    type = string
    default     = false
}
variable "oidc_issuer_enabled" {
  type = string
    default     = false
}
variable "workload_identity_enabled" {
  type = string
  default     = false
}
variable "public_network_access_enabled" {
  type = string
  default = false
}
variable "run_command_enabled" {
  type = string
  default     = false
  
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

  default = {
    network_plugin     = "azure"
    load_balancer_sku  = "standard"
    outbound_type      = "userDefinedRouting"
    dns_service_ip     = "10.255.255.10"
    docker_bridge_cidr = "172.29.0.0/16"
    service_cidr       = "10.255.255.0/28"
    network_policy     = "azure"
  }

}
variable "default_node_pool_kubelet_config" {
  type = object({
    allowed_unsafe_sysctls    = list(string)
    container_log_max_line    = number
    container_log_max_size_mb = string
    cpu_cfs_quota_enabled     = bool
    cpu_cfs_quota_period      = string
    cpu_manager_policy        = string
    image_gc_high_threshold   = number
    image_gc_low_threshold    = number
    pod_max_pid               = number
    topology_manager_policy   = string
  })

  description = <<-EOT
   (Optional)   A default_node_pool_kubelet_config block supports the following:

    ```
    {
      allowed_unsafe_sysctls    = list(string) - (Optional) Specifies the allow list of unsafe sysctls command or patterns (ending in `*`). Changing this forces a new resource to be created.
      container_log_max_line    = number - (Optional) Specifies the maximum number of container log files that can be present for a container. must be at least 2. Changing this forces a new resource to be created.
      container_log_max_size_mb = string - (Optional) Specifies the maximum size (e.g. 10MB) of container log file before it is rotated. Changing this forces a new resource to be created.
      cpu_cfs_quota_enabled     = bool - (Optional) Is CPU CFS quota enforcement for containers enabled? Changing this forces a new resource to be created.
      cpu_cfs_quota_period      = string - (Optional) Specifies the CPU CFS quota period value. Changing this forces a new resource to be created.
      cpu_manager_policy        = string - (Optional) Specifies the CPU Manager policy to use. Possible values are `none` and `static`, Changing this forces a new resource to be created.
      image_gc_high_threshold   = number - (Optional) Specifies the percent of disk usage above which image garbage collection is always run. Must be between `0` and `100`. Changing this forces a new resource to be created.
      image_gc_low_threshold    = number - (Optional) Specifies the percent of disk usage lower than which image garbage collection is never run. Must be between `0` and `100`. Changing this forces a new resource to be created.
      pod_max_pid               = number - (Optional) Specifies the maximum number of processes per pod. Changing this forces a new resource to be created.
      topology_manager_policy   = string - (Optional) Specifies the Topology Manager policy to use. Possible values are `none`, `best-effort`, `restricted` or `single-numa-node`. Changing this forces a new resource to be created.
    }
    ```

    **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
  EOT

  default = null
}

variable "default_node_pool_linux_os_config" {
  type = object({
    swap_file_size_mb             = string
    transparent_huge_page_defrag  = string
    transparent_huge_page_enabled = string

    sysctl_config = object({
      fs_aio_max_nr                      = number
      fs_file_max                        = number
      fs_inotify_max_user_watches        = number
      fs_nr_open                         = number
      kernel_threads_max                 = number
      net_core_netdev_max_backlog        = number
      net_core_optmem_max                = number
      net_core_rmem_default              = number
      net_core_rmem_max                  = number
      net_core_somaxconn                 = number
      net_core_wmem_default              = number
      net_core_wmem_max                  = number
      net_ipv4_ip_local_port_range_max   = number
      net_ipv4_ip_local_port_range_min   = number
      net_ipv4_neigh_default_gc_thresh1  = number
      net_ipv4_neigh_default_gc_thresh2  = number
      net_ipv4_neigh_default_gc_thresh3  = number
      net_ipv4_tcp_fin_timeout           = number
      net_ipv4_tcp_keepalive_intvl       = number
      net_ipv4_tcp_keepalive_probes      = number
      net_ipv4_tcp_keepalive_time        = number
      net_ipv4_tcp_max_syn_backlog       = number
      net_ipv4_tcp_max_tw_buckets        = number
      net_ipv4_tcp_tw_reuse              = number
      net_netfilter_nf_conntrack_buckets = number
      net_netfilter_nf_conntrack_max     = number
      vm_max_map_count                   = number
      vm_swappiness                      = number
      vm_vfs_cache_pressure              = number
    })
  })

  description = <<-EOT

    ``` (Optional)
    {
      swap_file_size_mb             = string - (Optional) Specifies the size of swap file on each node in MB. Changing this forces a new resource to be created.
      transparent_huge_page_defrag  = string - (Optional) specifies the defrag configuration for Transparent Huge Page. Possible values are `always`, `defer`, `defer+madvise`, `madvise` and `never`. Changing this forces a new resource to be created.
      transparent_huge_page_enabled = string - (Optional) Specifies the Transparent Huge Page enabled configuration. Possible values are `always`, `madvise` and `never`. Changing this forces a new resource to be created.
      
      sysctl_config = { // (Optional) A `sysctl_config` block as defined below. Changing this forces a new resource to be created.
        fs_aio_max_nr                      = number - (Optional) The sysctl setting fs.aio-max-nr. Must be between `65536` and `6553500`. Changing this forces a new resource to be created.
        fs_file_max                        = number - (Optional) The sysctl setting fs.file-max. Must be between `8192` and `12000500`. Changing this forces a new resource to be created.
        fs_inotify_max_user_watches        = number - (Optional) The sysctl setting fs.inotify.max_user_watches. Must be between `781250` and `2097152`. Changing this forces a new resource to be created.
        fs_nr_open                         = number - (Optional) The sysctl setting fs.nr_open. Must be between `8192` and `20000500`. Changing this forces a new resource to be created.
        kernel_threads_max                 = number - (Optional) The sysctl setting kernel.threads-max. Must be between `20` and `513785`. Changing this forces a new resource to be created.
        net_core_netdev_max_backlog        = number - (Optional) The sysctl setting net.core.netdev_max_backlog. Must be between `1000` and `3240000`. Changing this forces a new resource to be created.
        net_core_optmem_max                = number - (Optional) The sysctl setting net.core.optmem_max. Must be between `20480` and `4194304`. Changing this forces a new resource to be created.
        net_core_rmem_default              = number - (Optional) The sysctl setting net.core.rmem_default. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
        net_core_rmem_max                  = number - (Optional) The sysctl setting net.core.rmem_max. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
        net_core_somaxconn                 = number - (Optional) The sysctl setting net.core.somaxconn. Must be between `4096` and `3240000`. Changing this forces a new resource to be created.
        net_core_wmem_default              = number - (Optional) The sysctl setting net.core.wmem_default. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
        net_core_wmem_max                  = number - (Optional) The sysctl setting net.core.wmem_max. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
        net_ipv4_ip_local_port_range_max   = number - (Optional) The sysctl setting net.ipv4.ip_local_port_range max value. Must be between `1024` and `60999`. Changing this forces a new resource to be created.
        net_ipv4_ip_local_port_range_min   = number - (Optional) The sysctl setting net.ipv4.ip_local_port_range min value. Must be between `1024` and `60999`. Changing this forces a new resource to be created.
        net_ipv4_neigh_default_gc_thresh1  = number - (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh1. Must be between `128` and `80000`. Changing this forces a new resource to be created.
        net_ipv4_neigh_default_gc_thresh2  = number - (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh2. Must be between `512` and `90000`. Changing this forces a new resource to be created.
        net_ipv4_neigh_default_gc_thresh3  = number - (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh3. Must be between `1024` and `100000`. Changing this forces a new resource to be created.
        net_ipv4_tcp_fin_timeout           = number - (Optional) The sysctl setting net.ipv4.tcp_fin_timeout. Must be between `5` and `120`. Changing this forces a new resource to be created.
        net_ipv4_tcp_keepalive_intvl       = number - (Optional) The sysctl setting net.ipv4.tcp_keepalive_intvl. Must be between `10` and `75`. Changing this forces a new resource to be created.
        net_ipv4_tcp_keepalive_probes      = number - (Optional) The sysctl setting net.ipv4.tcp_keepalive_probes. Must be between `1` and `15`. Changing this forces a new resource to be created.
        net_ipv4_tcp_keepalive_time        = number - (Optional) The sysctl setting net.ipv4.tcp_keepalive_time. Must be between `30` and `432000`. Changing this forces a new resource to be created.
        net_ipv4_tcp_max_syn_backlog       = number - (Optional) The sysctl setting net.ipv4.tcp_max_syn_backlog. Must be between `128` and `3240000`. Changing this forces a new resource to be created.
        net_ipv4_tcp_max_tw_buckets        = number - (Optional) The sysctl setting net.ipv4.tcp_max_tw_buckets. Must be between `8000` and `1440000`. Changing this forces a new resource to be created.
        net_ipv4_tcp_tw_reuse              = number - (Optional) The sysctl setting net.ipv4.tcp_tw_reuse. Changing this forces a new resource to be created.
        net_netfilter_nf_conntrack_buckets = number - (Optional) The sysctl setting net.netfilter.nf_conntrack_buckets. Must be between `65536` and `147456`. Changing this forces a new resource to be created.
        net_netfilter_nf_conntrack_max     = number - (Optional) The sysctl setting net.netfilter.nf_conntrack_max. Must be between `131072` and `589824`. Changing this forces a new resource to be created.
        vm_max_map_count                   = number - (Optional) The sysctl setting vm.max_map_count. Must be between `65530` and `262144`. Changing this forces a new resource to be created.
        vm_swappiness                      = number - (Optional) The sysctl setting vm.swappiness. Must be between `0` and `100`. Changing this forces a new resource to be created.
        vm_vfs_cache_pressure              = number - (Optional) The sysctl setting vm.vfs_cache_pressure. Must be between `0` and `100`. Changing this forces a new resource to be created.
      }
    }
    ```

    **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
  EOT

  default = null
}
variable "default_node_pool_upgrade_settings" {
  type = object({
    max_surge = string
  })

  description = <<-EOT
    (Optional) A default_node_pool_upgrade_settings block supports the following:

    ```
    {
      max_surge = string - (Required) The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade.
    }
    ```
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

    ```
    {
      log_analytics_workspace_id = string -  (Required) The ID of the Log Analytics Workspace which the OMS Agent should send data to.
    }
    ```
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


# variable "service_principal" {
#   type = object({
#     client_id     = string
#     client_secret = string
#   })

#   description = <<-EOT
#     (Optional) A service_principal block as documented below. One of either identity or service_principal must be specified.
#     A service_principal block as documented below. One of either `identity` or `service_principal` must be specified.

#     A migration scenario from service_principal to identity is supported. When upgrading service_principal to identity, your cluster's control plane and addon pods will switch to use managed identity, but the kubelets will keep using your configured service_principal until you upgrade your Node Pool.

#     ```
#     {
#       client_id     = string - (Required) The Client ID for the Service Principal.
#       client_secret = string - (Required) The Client Secret for the Service Principal.
#     }
#     ```
#   EOT

#   default = null
# }

# variable "windows_profile" {
#   type = object({
#     admin_username = string
#     admin_password = string
#     license        = string
#     gmsa = object({
#       dns_server  = string
#       root_domain = string
#     })
#   })

#   description = <<-EOT
#    (Optional) A windows_profile block as defined below.

#     ```
#     {
#       admin_username = string - (Required) The Admin Username for Windows VMs.
#       admin_password = string - (Required) The Admin Password for Windows VMs. Length must be between 14 and 123 characters.
#       license        = string - (Optional) Specifies the type of on-premise license which should be used for Node Pool Windows Virtual Machine. At this time the only possible value is `Windows_Server`.
#       gmsa      = {
#         dns_server = string -  (Required) Specifies the DNS server for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
#         root_domain = string - (Required) Specifies the root domain name for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
#       }
#     }
#     ```

#     **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
#   EOT

#   default = null
#
variable "edge_zone" {
  type        = string
  description = <<-EOT
    (Optional) Specifies the Edge Zone within the Azure Region where this Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.
    **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
  EOT
  default     = null
}

# variable "http_proxy_config" {
#   type = object({
#     http_proxy  = string
#     https_proxy = string
#     no_proxy    = list(string)
#     trusted_ca  = any
#   })

#   description = <<-EOT
#      (Optional) A http_proxy_config block as defined below.
#     This requires that the Preview Feature Microsoft.ContainerService/HTTPProxyConfigPreview is enabled and the Resource Provider is re-registered
#     ```
#     {
#       http_proxy     = string - (Optional) The proxy address to be used when communicating over HTTP. Changing this forces a new resource to be created.
#       https_proxy    = string - (Optional) The proxy address to be used when communicating over HTTPS. 
#       no_proxy       = list(string) - (Optional) The list of domains that will not use the proxy for communication. If you specify the default_node_pool.0.vnet_subnet_id, be sure to include the Subnet CIDR in the no_proxy list.
#       trusted_ca     = any -  (Optional) The base64 encoded alternative CA certificate content in PEM format.
#     }
#     ```
#   EOT

#   default = null
# }

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

# variable "key_management_service" {
#   type = object({
#     key_vault_key_id         = string
#     key_vault_network_access = optional(string)
#   })

#   description = <<-EOT
#      (Optional) A key_management_service block supports the following:
#     ```
#     {
#       key_vault_key_id            = string -  (Required) Identifier of Azure Key Vault key. See key identifier format for more details. When Azure Key Vault key management service is enabled, this field is required and must be a valid key identifier. When enabled is false, leave the field empty.
#       key_vault_network_access    = string - (Optional) Network access of the key vault Network access of key vault. The possible values are Public and Private. Public means the key vault allows public access from all networks. Private means the key vault disables public access and enables private link. The default value is Public
#     }
#     ```
#   EOT

#   default = null
# }

# variable "key_vault_secrets_provider" {
#   type = object({
#     secret_rotation_enabled  = bool
#     secret_rotation_interval = string
#   })

#   description = <<-EOT
#      (Optional) A key_vault_secrets_provider block supports the following:
#       To enablekey_vault_secrets_provider either secret_rotation_enabled or secret_rotation_interval must be specified.
#     ```
#     {
#       secret_rotation_enabled            = bool -   (Optional) Is secret rotation enabled?
#       secret_rotation_interval           = string -  (Optional) The interval to poll for secret rotation. This attribute is only set when secret_rotation is true and defaults to 2m.
#     }
#     ```
#   EOT

#   default = null
# }
# variable "microsoft_defender" {
#   type = object({
#     log_analytics_workspace_id = string
#   })
#   description = <<-EOT
#     (Required) - A microsoft_defender block supports the following:
#     ```
#     {
#       log_analytics_workspace_id            = string -   (Required) Specifies the ID of the Log Analytics Workspace where the audit logs collected by Microsoft Defender should be sent to.
#     }
#     ```
#   EOT
#   default     = null
# }
# variable "monitor_metrics" {
#   type = object({
#     annotations_allowed = list(string)
#     labels_allowed      = list(string)
#   })
#   description = <<-EOT
#     (Optional) Monitor metrics block supports the following:
#     {
#       annotations_allowed            = list(string) - (Optional) Specifies a comma-separated list of Kubernetes annotation keys that will be used in the resource's labels metric.
#       labels_allowed                 = list(string) - (Optional) Specifies a Comma-separated list of additional Kubernetes label keys that will be used in the resource's labels metric.
#     }
#   EOT
#   default     = null
# }
# variable "workload_autoscaler_profile" {
#   type = object({
#     keda_enabled = bool
#   })
#   description = <<-EOT
#     (Optional) A workload_autoscaler_profile block defined below.    ```
#     {
#       keda_enabled            = bool -  (Optional) Specifies whether KEDA Autoscaler can be used for workloads. 
#     }
#     ```
#   EOT
#   default     = null
# }
# variable "storage_profile" {
#   type = object({
#     blob_driver_enabled             = bool
#     disk_driver_enabled             = bool
#     disk_driver_version             = string
#     file_driver_enabled             = bool
#     snapsnapshot_controller_enabled = bool
#   })
#   description = <<-EOT
#     (Optional) A storage_profile block as defined below:
#     ```
#     {
#       blob_driver_enabled             = bool - (Optional) Is the Blob CSI driver enabled? Defaults to false.
#       disk_driver_enabled             = bool - (Optional) Is the Disk CSI driver enabled? Defaults to true.
#       disk_driver_version             = string - (Optional) Disk CSI Driver version to be used. Possible values are v1 and v2. Defaults to v1.
#       file_driver_enabled             = bool - (Optional) Is the File CSI driver enabled? Defaults to true.
#       snapsnapshot_controller_enabled = bool - (Optional) Is the Snapshot Controller enabled? Defaults to true.
#     }
#     ```
#   EOT
#   default     = null
# }
# variable "web_app_routing" {
#   type = object({
#     dns_zone_id = string
#   })
#   description = <<-EOT
#     (Optional) A workload_autoscaler_profile block defined below.    ```
#     {
#       dns_zone_id = string -   (Required) Specifies the ID of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled. For Bring-Your-Own DNS zones this property should be set to an empty string "".
#     }
#     ```
#   EOT
#   default     = null
# }
# variable "api_server_access_profile" {
#   type = object({
#     authorized_ip_ranges     = list(string)
#     subnet_id                = string
#     vnet_integration_enabled = bool
#   })

#   description = <<-EOT
#     (Optional) An api_server_access_profile block supports the following:
#     ```
#     {
#       authorized_ip_ranges      = list(string) - (Optional) Set of authorized IP ranges to allow access to API server, e.g. ["198.51.100.0/24"].
#       subnet_id                 = string - (Optional) The ID of the Subnet where the API server endpoint is delegated to.
#       vnet_integration_enabled  = bool - (Optional) (Optional) Should API Server VNet Integration be enabled?      cpu_cfs_quota_enabled     = bool - (Optional) Is CPU CFS quota enforcement for containers enabled? Changing this forces a new resource to be created.
#     }
#     ```

#     **NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`.
#   EOT

#   default = null
# }



