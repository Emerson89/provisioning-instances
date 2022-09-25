resource "aws_security_group" "main" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}

resource "aws_security_group_rule" "ingress_rule" {
  type              = "ingress"
  for_each          = var.ingress
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = aws_security_group.main.id
}

resource "aws_security_group_rule" "egress_rule" {
  type              = "egress"
  for_each          = var.egress
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = aws_security_group.main.id
}