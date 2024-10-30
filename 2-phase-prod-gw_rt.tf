# # 퍼블릭 라우팅 테이블 생성
# resource "aws_route_table" "prod_public_rt" {
#   vpc_id = aws_vpc.prod_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.prod_igw.id
#   }

#   tags = {
#     Name = "prod-public-rt"
#   }
# }

# # 퍼블릭 서브넷과 라우팅 테이블 연결
# resource "aws_route_table_association" "public" {
#   count          = length(aws_subnet.public)
#   subnet_id      = aws_subnet.public[count.index].id
#   route_table_id = aws_route_table.prod_public_rt.id
# }

# # 프라이빗 라우팅 테이블 생성
# resource "aws_route_table" "prod_private_rt" {
#   vpc_id = aws_vpc.prod_vpc.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.prod_nat_gw.id
#   }

#   tags = {
#     Name = "prod-private-rt"
#   }
# }

# # 프라이빗 서브넷과 라우팅 테이블 연결
# resource "aws_route_table_association" "private_web" {
#   count          = length(aws_subnet.private_web)
#   subnet_id      = aws_subnet.private_web[count.index].id
#   route_table_id = aws_route_table.prod_private_rt.id
# }

# resource "aws_route_table_association" "private_was" {
#   count          = length(aws_subnet.private_was)
#   subnet_id      = aws_subnet.private_was[count.index].id
#   route_table_id = aws_route_table.prod_private_rt.id
# }

# resource "aws_route_table_association" "private_db" {
#   count          = length(aws_subnet.private_db)
#   subnet_id      = aws_subnet.private_db[count.index].id
#   route_table_id = aws_route_table.prod_private_rt.id
# }