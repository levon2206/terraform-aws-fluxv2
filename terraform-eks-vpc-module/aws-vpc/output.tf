output "vpc-id" {
  value = aws_vpc.vpc_resource.id
}

output "public-subnet-ids" {
  value = aws_subnet.public_subnet.*.id
}

output "private-subnet-ids" {
  value = aws_subnet.private_subnet.*.id
}
