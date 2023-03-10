1) 다른 AWS Region에 인프라 프로비저닝 하려는 경우,
  모든 테라폼 프로젝트 디렉토리에 공통적으로 포함된
  versions.tf, generic-variables.tf 파일에서 리전과 관련된 변수 혹은 값을 변경해줘야 함.

2) 다른 AWS Account에 인프라 프로비저닝 하려는 경우,
  2-1)
    ./tfeksdef/ec2bastion-variables.tf 파일의 인스턴스 액세스 키 값을 해당 계정에 맞게 수정해줘야 함.
    또한, 인스턴스 액세스 키를 "~/" 경로에 위치시키고, "~/.ssh/" 경로에는 "id_rsa" 이름으로 위치시켜주면 편함.
  2-2)
    또, S3 버킷 같은 경우 다른 계정에서 삭제한 이후, 몇 시간 정도 기다려야 다른 계정에서 재생성할 수 있으니
    해당 시간을 기다렸다가 동일한 이름의 버킷을 생성하거나 아예 다른 이름으로 생성해주면 됨.
    S3 버킷은 테라폼이 원격 백엔드로 사용하게 될 필수적인 리소스이므로 신경써 줄 수 밖에 없음.
    S3 버킷은 전 세계에서 고유한 이름을 가져야 하기 때문에 좀 까다로움.
  2-3)
    Route53 호스팅 영역(Hosted Zone)의 이름을 신경써 줘야 함.
    이 경우, "./tfaddonsdef/acm-certificate.tf" 파일에서,
    "data.aws_route53_zone.selected.name" 인수의 도메인 이름 값만 적절히 변경해주기만 하면 됨.

