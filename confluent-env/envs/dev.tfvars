
service_accounts = [
  {
    name  = "env-automation"
    roles = ["EnvironmentAdmin", "AccountAdmin", "MetricsViewer", "DataSteward", "Operator"]
  },
  {
    name  = "metrics-reader"
    roles = ["MetricsViewer", "DataSteward", "Operator"]
  }
]
