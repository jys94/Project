locals {
  tables = {
    eks_read         = { "dev-${local.backends[0]}" = "Read"  }
    eks_write        = { "dev-${local.backends[0]}" = "Write" }
    addons_read      = { "dev-${local.backends[1]}" = "Read"  }
    addons_write     = { "dev-${local.backends[1]}" = "Write" }
    cicd_read        = { "dev-${local.backends[2]}" = "Read"  }
    cicd_write       = { "dev-${local.backends[2]}" = "Write" }
    monitoring_read  = { "dev-${local.backends[3]}" = "Read"  }
    monitoring_write = { "dev-${local.backends[3]}" = "Write" }
    logging_read     = { "dev-${local.backends[4]}" = "Read"  }
    logging_write    = { "dev-${local.backends[4]}" = "Write" }
  }
  backends = [ "eks-cluster", "eks-addons", "eks-cicd", "eks-monitoring", "eks-logging" ]
}