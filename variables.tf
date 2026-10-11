variable "data_safe_target_database_peer_target_databases" {
  description = <<EOT
Map of data_safe_target_database_peer_target_databases, attributes below
Required:
    - target_database_id
    - database_details (block):
        - autonomous_database_id (optional)
        - database_type (required)
        - db_system_id (optional)
        - infrastructure_type (required)
        - instance_id (optional)
        - ip_addresses (optional)
        - listener_port (optional)
        - pluggable_database_id (optional)
        - service_name (optional)
        - vm_cluster_id (optional)
Optional:
    - dataguard_association_id
    - description
    - display_name
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
    - tls_config (block):
        - certificate_store_type (optional)
        - key_store_content (optional)
        - status (required)
        - store_password (optional)
        - trust_store_content (optional)
EOT

  type = map(object({
    target_database_id       = string
    dataguard_association_id = optional(string)
    description              = optional(string)
    display_name             = optional(string)
    database_details = object({
      autonomous_database_id = optional(string)
      database_type          = string
      db_system_id           = optional(string)
      infrastructure_type    = string
      instance_id            = optional(string)
      ip_addresses           = optional(list(string))
      listener_port          = optional(number)
      pluggable_database_id  = optional(string)
      service_name           = optional(string)
      vm_cluster_id          = optional(string)
    })
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
    tls_config = optional(object({
      certificate_store_type = optional(string)
      key_store_content      = optional(string)
      status                 = string
      store_password         = optional(string)
      trust_store_content    = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.data_safe_target_database_peer_target_databases : (
        contains([for v in ["AUTONOMOUS_DATABASE", "DATABASE_CLOUD_SERVICE", "INSTALLED_DATABASE"] : lower(v)], lower(v.database_details.database_type))
      )
    ])
    error_message = "must be one of: \"AUTONOMOUS_DATABASE\", \"DATABASE_CLOUD_SERVICE\", \"INSTALLED_DATABASE\""
  }
}

