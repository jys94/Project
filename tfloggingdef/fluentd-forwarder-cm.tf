resource "kubectl_manifest" "fluentd_forwarder_configmap" {
    yaml_body = <<YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: fluentd-forwarder-cm
data:
  fluentd-inputs.conf: |
    # HTTP input for the liveness and readiness probes
    <source>
      @type http
      port 9880
    </source>
    # Get the logs from the containers running in the node
    <source>
      @type tail
      path /var/log/containers/*.log
      # exclude Fluentd logs
      exclude_path /var/log/containers/*fluentd*.log
      pos_file /opt/bitnami/fluentd/logs/buffers/fluentd-docker.pos
      tag kubernetes.*
      read_from_head true
      format json
    </source>    
    # enrich with kubernetes metadata
    <filter kubernetes.**>
      @type kubernetes_metadata
    </filter>
  fluentd-output.conf: |
    # Throw the healthcheck to the standard output instead of forwarding it
    <match fluentd.healthcheck>
      @type null
    </match>
    # Forward all logs to the Elasticsearch
    <match kubernetes.var.log.containers.**_kube-system_**>
      @type elasticsearch
      host "elastic.lishprj.link"
      port "443"
      scheme https
      user elastic
      password elastic
      index_name "controlplane-logs"
      include_tag_key true
      <buffer>
        @type file
        path /opt/bitnami/fluentd/logs/buffers/controlplane-logs.buffer
        flush_thread_count 2
        flush_interval 5s
      </buffer>
    </match>
    <match kubernetes.var.log.containers.**_default_**>
      @type elasticsearch
      host "elastic.lishprj.link"
      port "443"
      scheme https
      user elastic
      password elastic
      index_name "app-logs"
      include_tag_key true
      <buffer>
        @type file
        path /opt/bitnami/fluentd/logs/buffers/app-logs.buffer
        flush_thread_count 2
        flush_interval 5s
      </buffer>
    </match>
  fluentd.conf: |
    # Ignore fluentd own events
    <match fluent.**>
      @type null
    </match>
    @include fluentd-inputs.conf
    @include fluentd-output.conf
YAML
}