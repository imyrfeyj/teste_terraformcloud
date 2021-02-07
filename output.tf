output "ip_address" {
value = aws_instance.web[*].public_ip
/* usando loop no output
  Value = {
    for instance in aws_instance.web:
    instance.id => instance.private_ip
    
  }
*/
}