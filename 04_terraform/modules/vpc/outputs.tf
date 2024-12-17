
output "vpc_id" {
  value = aws_vpc.ds_vpc.id
}
output "subnet_id" {
  value = aws_subnet.ds_subnet.id
}