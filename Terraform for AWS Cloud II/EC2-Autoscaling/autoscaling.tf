# Auto-Scaling Launch_configuration

resource "aws_launch_configuration" "terra-launchconfig" {
  name          = "terra-launchconfig"
  image_id      = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.terra_key1.key_name
}


#AutoScaling Group

resource "aws_autoscaling_group" "terra-autoscaling" {
  name                      = "terra-autoscaling"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 200
  health_check_type         = "EC2"
  force_delete              = true
  launch_configuration      = aws_launch_configuration.terra-launchconfig.name
  vpc_zone_identifier       = ["eu-west-2"]

   tag {
    key                 = "Name"
    value               = "terra custom EC2"
    propagate_at_launch = false
   }
  }

  #AutoScaling Policy

  resource "aws_autoscaling_policy" "terra-autoscaling-policy" {
  name                   = "terra-autoscaling-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 200
  autoscaling_group_name = aws_autoscaling_group.terra-autoscaling.name
  policy_type            = "SimpleScaling"
}

# CloudWatch Monitoring

resource "aws_cloudwatch_metric_alarm" "terra-alarm" {
  alarm_name          = "terra-alarm"
  alarm_description   = "Alarm once CPU usage Increase"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 30

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.terra-autoscaling.name
  }

  alarm_actions     = [aws_autoscaling_policy.terra-autoscaling-policy.arn]
}

# Auto Descaling Policy

 resource "aws_autoscaling_policy" "terra-autoscaling-policy-scaledown" {
  name                   = "terra-autoscaling-policy-scaledown"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 200
  autoscaling_group_name = aws_autoscaling_group.terra-autoscaling.name
  policy_type            = "SimpleScaling"
}

# Auto Descaling CloudWatch

resource "aws_cloudwatch_metric_alarm" "terra-alarm-scaledown" {
  alarm_name          = "terra-alarm-scaledown"
  alarm_description   = "Alarm once CPU usage Decrease"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 10

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.terra-autoscaling.name
  }

  alarm_actions     = [aws_autoscaling_policy.terra-autoscaling-policy-scaledown.arn]
}
