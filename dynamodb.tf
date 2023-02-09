resource "aws_dynamodb_table" "dev-ekscluster" {
  for_each       = toset([for name in local.backends: "dev-${name}"])
  name           = each.value
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"     # Partition Key (Primary Key)
  attribute {
    name = "LockID"
    type = "S"    # String Type
  }
}

resource "aws_appautoscaling_target" "dynamodb_table_read_write_target" {
  for_each           = local.tables
  min_capacity       = 1
  max_capacity       = 10
  resource_id        = "table/${keys(each.value)[0]}"
  scalable_dimension = "dynamodb:table:${values(each.value)[0]}CapacityUnits"
  service_namespace  = "dynamodb"
  depends_on         = [ aws_dynamodb_table.dev-ekscluster ]
}

resource "aws_appautoscaling_policy" "dynamodb_table_read_write_policy" {
  for_each           = tomap(aws_appautoscaling_target.dynamodb_table_read_write_target)
  name               = "DynamoDB${values(local.tables[each.key])[0]}CapacityUtilization:${each.value.resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = each.value.resource_id
  scalable_dimension = each.value.scalable_dimension
  service_namespace  = each.value.service_namespace
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDB${values(local.tables[each.key])[0]}CapacityUtilization"
    }
    target_value = 70
  }
}