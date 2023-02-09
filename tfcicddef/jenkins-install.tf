locals {
  jkopt1 = "--sessionTimeout=1440"
  jkopt2 = "--sessionEviction=86400"
  jvopt1 = "-Duser.timezone=Asia/Seoul"
  jvopt2 = "-Dcasc.jenkins.config=https://raw.githubusercontent.com/jys94/tools/main/jenkins-config.yaml"
  jvopt3 = "-Dhudson.model.DownloadService.noSignatureCheck=true"
}

resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://iac-source.github.io/helm-charts"
  chart      = "jenkins"

  set {
    name = "persistence.existingClaim"
    value = "${kubernetes_persistent_volume_claim_v1.efs_pvc_jenkins.metadata[0].name}" # "jenkins-pvc"
  }
  set {
    name  = "master.adminPassword"
    value = "admin"
  }
  set {
    name  = "master.nodeSelector.eks\\.amazonaws\\.com/nodegroup"
    value = "nodegroup-cicd"
  }
  set {
    name  = "agent.nodeSelector.eks\\.amazonaws\\.com/nodegroup"
    value = "nodegroup-cicd"
  }
  set {
    name  = "master.runAsUser"
    value = "1000"
  }
  set {
    name  = "master.runAsGroup"
    value = "1000"
  }
  set {
    name  = "master.tag"
    value = "2.249.3-lts-centos7"
  }
  set {
    name  = "master.serviceType"
    value = "NodePort"
  }
  set {
    name  = "master.servicePort"
    value = "80"
  }
  set {
    name  = "master.jenkinsOpts"
    value = "${local.jkopt1} ${local.jkopt2}"
  }
  set {
    name  = "master.javaOpts"
    value = "${local.jvopt1} ${local.jvopt2} ${local.jvopt3}"
  }
  # set {
  #   name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
  #   value = "${aws_iam_role.jenkins_codepipeline_polling_iam_role.arn}"
  # }
}