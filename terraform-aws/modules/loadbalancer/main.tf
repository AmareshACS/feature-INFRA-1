resource "aws_alb" "alb" {

    internal = false
    load_balancer_type = "application"
    ip_address_type  = "ipv4"

    subnets = var.subnet_ids
    security_groups = var.sg_id
    tags = {
      "Name" = "${var.env_name}-alb"
    }
}
