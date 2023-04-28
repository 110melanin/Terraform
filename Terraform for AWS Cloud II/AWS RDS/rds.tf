# RDS Resources

resource "aws_db_subnet_group" "mariadb-subnets" {
  name       = "mariadb-subnet"
  subnet_ids = [aws_subnet.terra-subnet-private-1.id, aws_subnet.terra-subnet-private-2.id]

  tags = {
    Name = "My terra DB subnet group"
  }
}

# RDS Parameter Group

resource "aws_db_parameter_group" "terra-mariadb-parameters" {
  name   = "terra-mariadb-parameters"
  family = "mariadb10.4"
  description = "Mariadb parameter group"

  parameter {
    name  = "max_allowed_packet"
    value = "167"
  }
}

# RDS instance

resource "aws_db_instance" "terra-mariadb" {
  allocated_storage    = 10
  engine               = "mariadb"
  engine_version       = "10.4.8"
  instance_class       = "db.t2.micro"
  username             = "root"        #username
  password             = "mariadb141"  #password
  parameter_group_name = aws_db_parameter_group.terra-mariadb-parameters.name
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.allow-mariadb.id]
  multi_az             = "false"
  storage_type         = "gp2"
  backup_retention_period = 30
  availability_zone    = aws_subnet.terra-subnet-private-1.availability_zone
  
  tags = {
    Name = "terra-mariadb"
  }
}

output "rds" {
    value = aws_db_instance.terra-mariadb.endpoint
}

