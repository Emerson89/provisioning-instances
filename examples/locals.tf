locals {
   ingress_ec2 = {
    "ingress_rule_1" = {
      "from_port"   = "0"
      "to_port"     = "65535" ##all internal traffic 
      "protocol"    = "-1"
      "cidr_blocks" = ["10.10.0.0/16"]
    },
  }
  
}
