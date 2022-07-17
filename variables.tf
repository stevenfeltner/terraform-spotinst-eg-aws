variable "name" {
  type        = string
  description = "The group name."
}
variable "description" {
  type        = string
  default     = null
  description = "The group description."
}
variable "product" {
  type        = string
  default     = null
  description = "Operation system type. Valid values: \"Linux/UNIX\", \"SUSE Linux\", \"Windows\". For EC2 Classic instances: \"Linux/UNIX (Amazon VPC)\", \"SUSE Linux (Amazon VPC)\", \"Windows (Amazon VPC)\"."
}
variable "availability_zones" {
  type        = string
  default     = null
  description = "List of Strings of availability zones. When this parameter is set, subnet_ids should be left unused. Note: availability_zones naming syntax follows the convention availability-zone:subnet:placement-group-name. For example, to set an AZ in us-east-1 with subnet subnet-123456 and placement group ClusterI03, you would set: availability_zones = [\"us-east-1a:subnet-123456:ClusterI03\"]"
}
variable "subnet_ids" {
  type        = string
  default     = null
  description = " List of Strings of subnet identifiers. Note: When this parameter is set, availability_zones should be left unused."
}
variable "region" {
  type        = string
  default     = null
  description = "The AWS region your group will be created in. Note: This parameter is required if you specify subnets (through subnet_ids). This parameter is optional if you specify Availability Zones (through availability_zones)."
}
variable "preferred_availability_zones" {
  type        = string
  default     = null
  description = "The AZs to prioritize when launching Spot instances. If no markets are available in the Preferred AZs, Spot instances are launched in the non-preferred AZs. Note: Must be a sublist of availability_zones and orientation value must not be \"equalAzDistribution\"."
}
variable "max_size" {
  type = string
  default = null
  description = "The maximum number of instances the group should have at any time."
}
variable "min_size" {
  type        = string
  default     = null
  description = "The minimum number of instances the group should have at any time."
}
variable "desired_capacity" {
  type        = string
  default     = null
  description = "The desired number of instances the group should have at any time."
}
variable "capacity_unit" {
  type        = string
  default     = null
  description = "Default: instance) The capacity unit to launch instances by. If not specified, when choosing the weight unit, each instance will weight as the number of its vCPUs. Valid values: instance, weight."
}
variable "security_groups" {
  type        = string
  default     = null
  description = "A list of associated security group IDS."
}
variable "image_id" {
  type        = string
  default     = null
  description = "The ID of the AMI used to launch the instance."
}
variable "iam_instance_profile" {
  type        = string
  default     = null
  description = "The ARN or name of an IAM instance profile to associate with launched instances."
}
variable "key_name" {
  type        = string
  default     = null
  description = "The key name that should be used for the instance."
}
variable "enable_monitoring" {
  type        = string
  default     = null
  description = "Indicates whether monitoring is enabled for the instance."
}
variable "user_data" {
  type        = string
  default     = null
  description = "The user data to provide when launching the instance."
}
variable "shutdown_script" {
  type        = string
  default     = null
  description = "The Base64-encoded shutdown script that executes prior to instance termination, for more information please see: Shutdown Script"
}
variable "ebs_optimized" {
  type        = string
  default     = null
  description = "Enable high bandwidth connectivity between instances and AWS’s Elastic Block Store (EBS). For instance types that are EBS-optimized by default this parameter will be ignored."
}
variable "placement_tenancy" {
  type        = string
  default     = null
  description = "Default: \"default\") Enable dedicated tenancy. Note: There is a flat hourly fee for each region in which dedicated tenancy is used. Valid values: \"default\", \"dedicated\" ."
}
## metadata_options ##
variable "http_token" {
  type        = string
  default     = null
  description = "The state of token usage for your instance metadata requests. Valid values: optional or required."
}
variable "http_put_response_hop_limit" {
  type        = string
  default     = null
  description = "Default: 1. The desired HTTP PUT response hop limit for instance metadata requests. The larger the number, the further instance metadata requests can travel. Valid values: Integers from 1 to 64."
}

## cpu_options ##
variable "threads_per_core" {
  type        = string
  default     = null
  description = "The ability to define the number of threads per core in instances that allow this."
}
####

variable "instance_types_ondemand" {
  type        = string
  default     = null
  description = "The type of instance determines your instance's CPU capacity, memory and storage (e.g., m1.small, c1.xlarge)."
}
variable "instance_types_spot" {
  type        = string
  default     = null
  description = "One or more instance types."
}
variable "instance_types_preferred_spot" {
  type        = string
  default     = null
  description = "Prioritize a subset of spot instance types. Must be a subset of the selected spot instance types."
}


variable "instance_types_weights" {
  type            = list(object({
    weight        = number
    instance_type = string
  }))
  default         = null
  description     = "List of weights per instance type for weighted groups. "
}

variable "cpu_credits" {
  type        = string
  default     = null
  description = "Controls how T3 instances are launched. Valid values: standard, unlimited."
}
variable "fallback_to_ondemand" {
  type        = bool
  default     = null
  description = "In a case of no Spot instances available, Elastigroup will launch on-demand instances instead."
}
variable "wait_for_capacity" {
  type        = number
  default     = null
  description = "Minimum number of instances in a 'HEALTHY' status that is required before continuing. This is ignored when updating with blue/green deployment. Cannot exceed desired_capacity."
}
variable "wait_for_capacity_timeout" {
  type        = number
  default     = null
  description = "Time (seconds) to wait for instances to report a 'HEALTHY' status. Useful for plans with multiple dependencies that take some time to initialize. Leave undefined or set to 0 to indicate no wait. This is ignored when updating with blue/green deployment."
}
variable "orientation" {
  type        = string
  default     = null
  description = " Default: balanced) Select a prediction strategy. Valid values: balanced, costOriented, equalAzDistribution, availabilityOriented. You can read more in our documentation."
}
variable "spot_percentage" {
  type        = string
  default     = null
  description = "The percentage of Spot instances that would spin up from the desired_capacity number."
}
variable "ondemand_count" {
  type        = string
  default     = null
  description = "Number of on demand instances to launch in the group. All other instances will be spot instances. When this parameter is set the spot_percentage parameter is being ignored."
}
variable "draining_timeout" {
  type        = string
  default     = null
  description = " The time in seconds, the instance is allowed to run while detached from the ELB. This is to allow the instance time to be drained from incoming TCP connections before terminating it, during a scale down operation."
}
variable "utilize_reserved_instances" {
  type        = bool
  default     = null
  description = "In a case of any available reserved instances, Elastigroup will utilize them first before purchasing Spot instances."
}
variable "minimum_instance_lifetime" {
  type        = number
  default     = null
  description = "Defines the preferred minimum instance lifetime in hours. Markets which comply with this preference will be prioritized. Optional values: 1, 3, 6, 12, 24."
}
## scaling_strategy ##
variable "terminate_at_end_of_billing_hour" {
  type        = string
  default     = null
  description = "Specify whether to terminate instances at the end of each billing hour."
}
variable "termination_policy" {
  type        = string
  default     = null
  description = "Determines whether to terminate the newest instances when performing a scaling action. Valid values: \"default\", \"newestInstance\"."
}
###

## health check ##
variable "health_check_type" {
  type        = string
  default     = null
  description = "The service that will perform health checks for the instance. Valid values: \"ELB\", \"HCS\", \"TARGET_GROUP\", \"MLB\", \"EC2\", \"MULTAI_TARGET_SET\", \"MLB_RUNTIME\", \"K8S_NODE\", \"NOMAD_NODE\", \"ECS_CLUSTER_INSTANCE\"."
}
variable "health_check_grace_period" {
  type        = number
  default     = null
  description = "The amount of time, in seconds, after the instance has launched to starts and check its health."
}
variable "health_check_unhealthy_duration_before_replacement" {
  type        = number
  default     = null
  description = "The amount of time, in seconds, that we will wait before replacing an instance that is running and became unhealthy (this is only applicable for instances that were once healthy)."
}
##########

variable "tags" {
  type            = map(string)
  default         = null
  description     = "Additional Tags to be added to resources"
}
variable "elastic_ips" {
  type            = list(string)
  default         = null
  description     = "A list of AWS Elastic IP allocation IDs to associate to the group instances."
}
variable "revert_to_spot" {
  type            = object({
    perform_at    = string
    time_windows  = list(string)
  })
  default         = null
  description     = "Hold settings for strategy correction – replacing On-Demand for Spot instances."
}

variable "should_tag_enis" {
  type        = string
  default     = null
  description = "Tag specification for ENI resources."
}
variable "should_tag_volumes" {
  type        = string
  default     = null
  description = "Tag specification for Volume resources."
}
variable "should_tag_snapshots" {
  type        = string
  default     = null
  description = "Tag specification for Snapshot resources."
}
variable "should_tag_amis" {
  type            = string
  default         = null
  description     = "Tag specification for AMI resources."
}
variable "elastic_load_balancers" {
  type            = list(string)
  default         = null
  description     = "The group name."
}
variable "target_group_arns" {
  type            = list(string)
  default         = null
  description     = "The group name."
}
variable "multai_target_sets" {
  type            = list(object({
    target_set_id = string
    balancer_id   = string
  }))
  default         = null
  description     = "Set of targets to register."
}
variable "signal" {
  type        = list(object({
    name      = string
    timeout   = number
  }))
  default     = null
  description = "Signal object."
}
# task scheduling #
variable "scheduled_task" {
  type = list(object({
    task_type               = string
    cron_expression         = string
    start_time              = string
    frequency               = string
    scale_target_capacity   = number
    scale_min_capacity      = number
    scale_max_capacity      = number
    is_enabled              = bool
    target_capacity         = number
    min_capacity            = number
    max_capacity            = number
    batch_size_percentage   = number
    grace_period            = number
    adjustment              = number
    adjustment_percentage   = number
  }))
  default                   = null
  description               = "scheduled task object"
}

variable "scaling_up_policy" {
  type = list(object({
    policy_name           = string
    metric_name           = string
    statistic             = string
    unit                  = string
    threshold             = number
    action_type           = number
    namespace             = number
    is_enabled            = bool
    period                = number
    evaluuation_periods   = number
    cooldown              = number
    dimensions            = list(object({
      name                = string
      value               = string
    }))
    operator              = number
    source                = number
    step_adjustment       = list(object({
      type                = string
      adjustment          = number
      maximim             = number
      minimum             = number
      min_target_capacity = number
      target              = number
      threshold           = number
    }))
  }))
  default                 = null
  description             = "scaling_up object"
}
variable "scaling_down_policy" {
  type = list(object({
    policy_name           = string
    metric_name           = string
    statistic             = string
    unit                  = string
    threshold             = number
    action_type           = number
    namespace             = number
    is_enabled            = bool
    period                = number
    evaluuation_periods   = number
    cooldown              = number
    dimensions            = list(object({
      name                = string
      value               = string
    }))
    operator              = number
    source                = number
    step_adjustment       = list(object({
      type                = string
      adjustment          = number
      maximim             = number
      minimum             = number
      min_target_capacity = number
      target              = number
      threshold           = number
    }))
  }))
  default                 = null
  description             = "scaling_down object"
}
variable "scaling_target_policy" {
  type                    = list(object({
    policy_name           = string
    metric_name           = string
    statistic             = string
    unit                  = string
    namespace             = number
    cooldown              = number
    source                = string
    dimensions            = list(object({
      name                = string
      value               = string
    }))
    target                = number
    max_capacity_per_scale= number
    predictive_mode       = string
  }))
  default                 = null
  description             = "scaling_target_policy object"
}

variable "scaling_multiple_metrics" {
  type                    = list(object({
    expressions           = list(object({
      name                = string
      expression          = string
    }))
    metrics = list(object({
      metric_name         = string
      name                = string
      name_space          = string
      statistic           = string
      extended_statistic  = string
      unit                = string
      dimensions          = string
    }))
  }))
  default                 = null
  description             = "scaling_multiple_metrics object"
}

variable "network_interface" {
  type = list(object({
    network_interface_id                = string
    device_index                        = string
    description                         = string
    private_ip_address                  = string
    delete_on_termination               = number
    secondary_private_ip_address_count  = number
    associate_public_ip_address         = string
    associate_ipv6_address              = number
  }))
  default = null
  description = "scaling_target_policy object"
}

variable "block_device_mappings" {
  type 								= list(object({
    device_name						= string
    snapshot_id 					= string
    volume_type 					= string
    volume_size						= number
    iops							= number
    delete_on_termination 			= bool
    encrypted 						= bool
    kms_key_id 						= string
    throughput						= number
  }))
  default 							= null
  description 						= "Block Device Mapping Object"
}

variable "ephemeral_block_device" {
  type 								= list(object({
    device_name						= string
    virtual_name					= string
  }))
  default 							= null
  description 						= "ephemeral_block_device Object"
}

variable "persist_root_device" {
  type        = string
  default     = null
  description = "The group name."
}
variable "persist_block_devices" {
  type        = string
  default     = null
  description = "The group name."
}
variable "persist_private_ip" {
  type        = string
  default     = null
  description = "The group name."
}
variable "block_devices_mode" {
  type        = string
  default     = null
  description = "The group name."
}
variable "private_ips" {
  type        = string
  default     = null
  description = "The group name."
}
##########

## stateful_deallocation ##
variable "stateful_deallocation" {
  type 								    = object({
    should_delete_images			    = bool
    should_delete_network_interfaces	= bool
    should_delete_volumes			    = bool
    should_delete_snapshots	            = bool
  })
  default 							    = null
  description 						    = "stateful_deallocation Object"
}
##########

## stateful_instance_action ##
variable "stateful_instance_action" {
  type 					    = list(object({
    stateful_instance_id    = string
    type					= string
  }))
  default 					= null
  description 				= "stateful_instance_action Object"
}
##########

## integration_rancher ##
variable "integration_rancher" {
  type 			  = object({
    master_host   = string
    access_key	  = string
    secret_key    = string
    version       = number
  })
  default 		  = null
  description     = "integration_rancher Object"
}
##########

## integration_ecs ##
variable "integration_ecs" {
  type 			                            = object({
    cluster_name                            = string
    autoscale_is_enabled                    = bool
    autoscale_cooldown                      = number
    autoscale_is_auto_config                = bool
    autoscale_scale_down_non_service_tasks  = bool
    autoscale_headroom                      = object({
      cpu_per_unit                          = number
      memory_per_unit                       = number
      num_of_units                          = number
      })
    autoscale_down                          = object({
        evaluation_periods                  = number
        max_scale_down_percentage           = number
      })
    autoscale_attributes	                = string
    batch                                   = object({
        job_queue_names                     = list(string)
      })
  })
  default 		                            = null
  description                               = "integration_ecs Object"
}
##########

## integration_codedeploy ##
variable "integration_codedeploy" {
  type 			                    = object({
    cleanup_on_failure              = string
    terminate_instance_on_failure	= string
    deployment_groups               = list(object({
      application_name              = string
      deployment_group_name         = string
    }))
  })
  default 		                    = null
  description                       = "integration_codedeploy Object"
}
##########

## integration_route53 ##
variable "integration_route53" {
  type 			                    = object({
    domains                         = list(object({
      hosted_zone_id                = string
      spotinst_acct_id              = string
      record_set_type               = string
      record_sets                   = object({
        name                        = string
        use_public_ip               = bool
        use_public_dns              = bool
      })
    }))
  })
  default 		                    = null
  description                       = "integration_route53 Object"
}
##########

## Update Policy ##
variable "should_resume_stateful" {
  type        = bool
  default     = null
  description = "The group name."
}
variable "should_roll" {
  type        = bool
  default     = null
  description = "The group name."
}
variable "auto_apply_tags" {
  type        = bool
  default     = null
  description = "The group name."
}

variable "batch_size_percentage" {
  type        = number
  default     = null
  description = "The group name."
}
variable "health_check_type" {
  type        = string
  default     = null
  description = "The group name."
}
variable "grace_period" {
  type        = number
  default     = null
  description = "The group name."
}
variable "wait_for_roll_percentage" {
  type        = number
  default     = null
  description = "The group name."
}
variable "wait_for_roll_timeout" {
  type        = number
  default     = null
  description = "The group name."
}
############

variable "update_strategy" {
  type = object({
    action                              = string
    should_drain_instances              = false
    batch_min_healthy_percentage        = number
    on_failure                          = object({
      action_type                       = string
      should_handle_all_batches         = bool
      draining_timeout                  = number
      should_decrement_target_capacity  = bool
    })
  })
  default                               = null
  description                           = "The update strategy object."
}