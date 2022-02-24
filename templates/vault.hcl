storage "raft" {
    path = "/opt/vault"
    node_id = "{{ inventory_hostname }}"

    retry_join {
        leader_api_addr = "https://vault-1.linkmobility.com"
    }

    retry_join {
        leader_api_addr = "https://vault-2.linkmobility.com"
    }

    retry_join {
        leader_api_addr = "https://vault-3.linkmobility.com"
    }
}

listener "tcp" {
    address = "[::]:443"
    cluster_address = "[::]:8201"
    tls_cert_file = "/etc/vault.d/server.crt"
    tls_key_file = "/etc/vault.d/server.key"
}

telemetry {
  prometheus_retention_time = "30s"
  disable_hostname = true
}

disable_mlock = true
cluster_name = "gostudent-vault"
api_addr = "https://{{ inventory_hostname }}.linkmobility.com"
cluster_addr = "https://{{ inventory_hostname }}.linkmobility.com:8201"
ui = true
