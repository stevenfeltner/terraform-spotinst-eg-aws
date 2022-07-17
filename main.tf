#create an Elastigroup
resource "spotinst_elastigroup_aws" "elastigroup" {

  name                          = var.name
  description                   = var.description
  product                       = var.product
  subnet_ids                    = var.subnet_ids
  region                        = var.region
  preferred_availability_zones  = var.preferred_availability_zones
  max_size                      = var.max_size
  min_size                      = var.min_size
  desired_capacity              = var.desired_capacity
  capacity_unit                 = var.capacity_unit
  security_groups               = var.security_groups
  image_id                      = var.image_id
  iam_instance_profile          = var.iam_instance_profile
  key_name                      = var.key_name
  enable_monitoring             = var.enable_monitoring
  user_data                     = var.user_data
  shutdown_script               = var.shutdown_script
  ebs_optimized                 = var.ebs_optimized
  placement_tenancy             = var.placement_tenancy

  dynamic "metadata_options" {
    for_each = (var.http_tokens != null && var.http_put_response_hop_limit != null) ? [1] : []
    content {
      http_tokens                 = var.http_tokens
      http_put_response_hop_limit = var.http_put_response_hop_limit
    }
  }

  dynamic "cpu_options" {
    for_each = var.threads_per_core != null ? [1] : []
    content {
      threads_per_core            = var.threads_per_core
    }
  }

  instance_types_ondemand       = var.instance_types_ondemand
  instance_types_spot           = var.instance_types_spot
  instance_types_preferred_spot = var.instance_types_preferred_spot

  dynamic "instance_types_weights" {
    for_each = var.instance_types_weights != null ? [var.instance_types_weights] : []
    content {
      weight                    = instance_types_weights.value.weight
      instance_type             = instance_types_weights.value.instance_type
    }
  }
  cpu_credits                   = var.cpu_credits
  fallback_to_ondemand          = var.fallback_to_ondemand
  wait_for_capacity             = var.wait_for_capacity
  wait_for_capacity_timeout     = var.wait_for_capacity_timeout
  orientation                   = var.orientation
  spot_percentage               = var.spot_percentage
  draining_timeout              = var.draining_timeout
  utilize_reserved_instances    = var.utilize_reserved_instances
  minimum_instance_lifetime     = var.minimum_instance_lifetime

  dynamic "scaling_strategy" {
    for_each = (var.terminate_at_end_of_billing_hour != null || var.termination_policy != null) ? [1] :[]
    content {
      terminate_at_end_of_billing_hour = var.terminate_at_end_of_billing_hour
      termination_policy               = var.termination_policy
    }
  }

  health_check_type             = var.health_check_type
  health_check_grace_period     = var.health_check_grace_period
  health_check_unhealthy_duration_before_replacement = var.health_check_unhealthy_duration_before_replacement

  dynamic tags {
    for_each = var.tags == null ? {} : var.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  elastic_ips = var.elastic_ips

  dynamic "revert_to_spot" {
    for_each = var.revert_to_spot != null ? [var.revert_to_spot] : []
    content {
      perform_at    = revert_to_spot.value.perform_at
      time_windows  = revert_to_spot.value.time_windows
    }
  }

  dynamic "resource_tag_specification" {
    for_each = (var.should_tag_enis != null || var.should_tag_volumes != null || var.should_tag_snapshots != null || var.should_tag_amis != null) ? [1] : []
    content {
      should_tag_enis       = var.should_tag_enis
      should_tag_volumes    = var.should_tag_volumes
      should_tag_snapshots  = var.should_tag_snapshots
      should_tag_amis       = var.should_tag_amis
    }
  }

  elastic_load_balancers  = var.elastic_load_balancers
  target_group_arns       = var.target_group_arns

  dynamic "multai_target_sets" {
    for_each = var.multai_target_sets != null ? [var.multai_target_sets] : []
    content {
      balancer_id   = multai_target_sets.value.balancer_id
      target_set_id = multai_target_sets.value.target_set_id
    }
  }

  dynamic "signal" {
    for_each = var.signal != null ? [var.signal] : []
    content {
      name    = signal.value.name
      timeout = signal.value.timeout
    }
  }

  dynamic "scheduled_task" {
    for_each = var.scheduled_task != null ? [var.scheduled_task] : []
    content {
      task_type               = scheduled_task.value.task_type
      cron_expression         = scheduled_task.value.cron_expression
      start_time              = scheduled_task.value.start_time
      frequency               = scheduled_task.value.frequency
      scale_target_capacity   = scheduled_task.value.scale_target_capacity
      scale_min_capacity      = scheduled_task.value.scale_min_capacity
      scale_max_capacity      = scheduled_task.value.scale_max_capacity
      is_enabled              = scheduled_task.value.is_enabled
      target_capacity         = scheduled_task.value.target_capacity
      min_capacity            = scheduled_task.value.min_capacity
      max_capacity            = scheduled_task.value.max_capacity
      batch_size_percentage   = scheduled_task.value.batch_size_percentage
      grace_period            = scheduled_task.value.grace_period
      adjustment              = scheduled_task.value.adjustment
      adjustment_percentage   = scheduled_task.value.adjustment_percentage
    }
  }

  dynamic "scaling_up_policy" {
    for_each = var.scaling_up_policy != null ? [var.scaling_up_policy] : []
    content {
      policy_name         = scaling_up_policy.value.policy_name
      metric_name         = scaling_up_policy.value.metric_name
      statistic           = scaling_up_policy.value.statistic
      unit                = scaling_up_policy.value.unit
      operator            = scaling_up_policy.value.operator
      source              = scaling_up_policy.value.source
      threshold           = scaling_up_policy.value.threshold
      action_type         = scaling_up_policy.value.action_type
      namespace           = scaling_up_policy.value.namespace
      is_enabled          = scaling_up_policy.value.is_enabled
      period              = scaling_up_policy.value.period
      evaluation_periods  = scaling_up_policy.value.evaluation_periods
      cooldown            = scaling_up_policy.value.cooldown
      dynamic "dimensions" {
        for_each          = var.scaling_up_dimensions != null ? [var.scaling_up_dimensions] : []
        content {
          name            = dimensions.value.name
          value           = dimensions.value.value
        }
      }
#      dynamic "step_adjustment" {
#        for_each          = ( var.scaling_up_step_adjustment != null &&
#                              scaling_up_policy.value.threshold == null &&
#                              scaling_up_policy.value.action_type == null) ? [var.scaling_up_step_adjustment] : []
#        content {
#          threshold             = step_adjustment.value.threshold
#          action {
#            type                = step_adjustment.value.type
#            adjustment          = step_adjustment.value.adjustment
#            maximim             = step_adjustment.value.maximim
#            minimum             = step_adjustment.value.minimum
#            min_target_capacity = step_adjustment.value.min_target_capacity
#            target              = step_adjustment.value.target
#          }
#        }
#      }
      adjustment                = scaling_up_policy.value.adjustment
      min_target_capacity       = scaling_up_policy.value.min_target_capacity
      max_target_capacity       = scaling_up_policy.value.max_target_capacity
      minimum                   = scaling_up_policy.value.minimum
      maximum                   = scaling_up_policy.value.maxium
      target                    = scaling_up_policy.value.target
    }
  }


  dynamic "scaling_down_policy" {
    for_each = var.scaling_down_policy != null ? [var.scaling_down_policy] : []
    content {
      policy_name         = scaling_down_policy.value.policy_name
      metric_name         = scaling_down_policy.value.metric_name
      statistic           = scaling_down_policy.value.statistic
      unit                = scaling_down_policy.value.unit
      operator            = scaling_down_policy.value.operator
      source              = scaling_down_policy.value.source
      threshold           = scaling_down_policy.value.threshold
      action_type         = scaling_down_policy.value.action_type
      namespace           = scaling_down_policy.value.namespace
      is_enabled          = scaling_down_policy.value.is_enabled
      period              = scaling_down_policy.value.period
      evaluation_periods  = scaling_down_policy.value.evaluation_periods
      cooldown            = scaling_down_policy.value.cooldown
      dynamic "dimensions" {
        for_each          = var.scaling_down_dimensions != null ? [var.scaling_down_dimensions] : []
        content {
          name            = dimensions.value.name
          value           = dimensions.value.value
        }
      }
#      dynamic "step_adjustment" {
#        for_each          = ( var.scaling_down_step_adjustment != null &&
#                              scaling_down_policy.value.threshold == null &&
#                              scaling_down_policy.value.action_type == null) ? [var.scaling_down_step_adjustment] : []
#        content {
#          threshold             = scaling_down_policy.value.threshold
#          action {
#            adjustment          = scaling_down_policy.value.adjustment
#            maximim             = scaling_down_policy.value.maximim
#            minimum             = scaling_down_policy.value.minimum
#            min_target_capacity = scaling_down_policy.value.min_target_capacity
#            target              = scaling_down_policy.value.target
#          }
#        }
#      }
      adjustment                = scaling_down_policy.value.adjustment
      min_target_capacity       = scaling_down_policy.value.min_target_capacity
      max_target_capacity       = scaling_down_policy.value.max_target_capacity
      minimum                   = scaling_down_policy.value.minimum
      maximum                   = scaling_down_policy.value.maxium
      target                    = scaling_down_policy.value.target
    }
  }

  lifecycle {
    ignore_changes = [
      desired_capacity
    ]
  }
}