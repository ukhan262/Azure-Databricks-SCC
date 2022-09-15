locals {
  name = "${var.prefix}-pe"
  default_tags = {
    env         = var.environment
    tier        = var.tier
    infra       = var.infra
    cost_center = var.cost_center
    data        = var.data
    regulatory  = var.regulatory
    owner       = var.owner
  }
  tags = merge(local.default_tags, var.additional_tags)
}
