

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["099720109477"] # Ubuntu 
}
/*
data "aws_ami" "ubuntu_west" {
    provider = aws.west
    most_recent = true 
    filter {
        name = "name" 
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
        }
    owners = ["099720109477"] # Ubuntu 
        } 
        */
resource "aws_instance" "web" {
  #count = var.environment == "production" ? 1 + var.plus : 1
  count         = var.production ? 2 : 1
  ami           = var.image_id
/* bloco for_each loop
  for_each = toset(var.instance_type)
  instance_type = each.value
*/
  
  instance_type = count.index < 1 ? "t2.micro" : "t2.nano"
  tags = { Name = "HelloWorld"
    Env = var.environment
  }
}

/*
resource "aws_instance" "web_west" { 
    provider = aws.west
    ami = data.aws_ami.ubuntu_west.id 
    instance_type = "t2.micro" 
    tags = { Name = "HelloWorld" } 
} 

resource "aws_instance" "web2" {
  count         = var.servers
  ami           = var.image_id
  instance_type = "t2.micro"
  tags          = { Name = "HelloWorld2" }
  depends_on    = [aws_instance.web]
}
*/
resource "aws_instance" "web3" {  
  ami = 123
  instance_type = "t2.micro"

  dynamic "ebs_block_device" {
  for_each = var.blocks
  content {
    device_name = ebs_block_device.value["device_name"]
    volume_size  = ebs_block_device.value["volume_size"]
    volume_type = ebs_block_device.value["volume_type"]
    }
  }
  
}
