resource "aws_appstream_fleet" "appstream_fleet" {
  name = var.appstream_name

  compute_capacity {
    desired_instances = 1
  }

  description                        = var.appstream_name
  idle_disconnect_timeout_in_seconds = 900
  disconnect_timeout_in_seconds      = 900
  display_name                       = var.appstream_name
  enable_default_internet_access     = false
  fleet_type                         = "ON_DEMAND"
  image_name                         = var.appstream_image
  instance_type                      = var.appstream_instace_type
  max_user_duration_in_seconds       = 3600

  vpc_config {
    subnet_ids = [aws_subnet.subnet_private_a.id, aws_subnet.subnet_private_b.id]
  }

  tags = {
    Name = var.appstream_name
  }
}

resource "aws_appstream_stack" "appstream_stack" {
  name         = var.stack_name
  description  = var.stack_name
  display_name = var.stack_name

  user_settings {
    action     = "CLIPBOARD_COPY_FROM_LOCAL_DEVICE"
    permission = "ENABLED"
  }
  user_settings {
    action     = "CLIPBOARD_COPY_TO_LOCAL_DEVICE"
    permission = "ENABLED"
  }
  user_settings {
    action     = "DOMAIN_PASSWORD_SIGNIN"
    permission = "ENABLED"
  }
  user_settings {
    action     = "DOMAIN_SMART_CARD_SIGNIN"
    permission = "DISABLED"
  }
  user_settings {
    action     = "FILE_DOWNLOAD"
    permission = "ENABLED"
  }
  user_settings {
    action     = "FILE_UPLOAD"
    permission = "ENABLED"
  }
  user_settings {
    action     = "PRINTING_TO_LOCAL_DEVICE"
    permission = "ENABLED"
  }

  application_settings {
    enabled = false
  }

  tags = {
    Name = var.stack_name
  }
}

resource "aws_appstream_fleet_stack_association" "fleet_stack_association" {
  fleet_name = aws_appstream_fleet.appstream_fleet.name
  stack_name = aws_appstream_stack.appstream_stack.name
}