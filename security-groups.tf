resource "yandex_vpc_security_group" "sg-dataprod" {
  name        = "Dataproc cluster security group"
  description = "imporant for secure communiction"
  network_id  = module.vpc.vpc_id
  labels =  var.default_labels

  ingress {
    protocol       = "ANY"
    description    = "any ingress trafic in cluster"
    predefined_target = "self_security_group"
    from_port      = 0
    to_port        = 65535
  }

  egress {
    protocol       = "ANY"
    description    = "any egress trafic in cluster"
    predefined_target = "self_security_group"
    from_port      = 0
    to_port        = 65535
  }

  egress {
    protocol       = "TCP"
    description    = "Egress HTTPS"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port      = 443    
  }
}