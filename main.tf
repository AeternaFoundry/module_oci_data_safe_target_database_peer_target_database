resource "oci_data_safe_target_database_peer_target_database" "data_safe_target_database_peer_target_databases" {
  for_each = var.data_safe_target_database_peer_target_databases

  target_database_id       = each.value.target_database_id
  dataguard_association_id = each.value.dataguard_association_id
  description              = each.value.description
  display_name             = each.value.display_name

  database_details {
    autonomous_database_id = each.value.database_details.autonomous_database_id
    database_type          = each.value.database_details.database_type
    db_system_id           = each.value.database_details.db_system_id
    infrastructure_type    = each.value.database_details.infrastructure_type
    instance_id            = each.value.database_details.instance_id
    ip_addresses           = each.value.database_details.ip_addresses
    listener_port          = each.value.database_details.listener_port
    pluggable_database_id  = each.value.database_details.pluggable_database_id
    service_name           = each.value.database_details.service_name
    vm_cluster_id          = each.value.database_details.vm_cluster_id
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }

  dynamic "tls_config" {
    for_each = each.value.tls_config != null ? [each.value.tls_config] : []
    content {
      certificate_store_type = tls_config.value.certificate_store_type
      key_store_content      = tls_config.value.key_store_content
      status                 = tls_config.value.status
      store_password         = tls_config.value.store_password
      trust_store_content    = tls_config.value.trust_store_content
    }
  }
}

