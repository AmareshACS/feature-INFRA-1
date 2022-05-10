resource "aws_network_interface" "nic" {
  subnet_id   = var.subnet_id
}

resource "aws_instance" "myec2" {
  ami           = var.ami
  instance_type = var.instance_type

  network_interface {
   network_interface_id = aws_network_interface.nic.id
   device_index         = 0
 }

 tags = {
   Name = "${var.env_name}-instance"
 }
}
