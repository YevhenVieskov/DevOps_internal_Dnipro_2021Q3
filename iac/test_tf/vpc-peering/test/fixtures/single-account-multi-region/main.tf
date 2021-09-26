// Fixtures
// VPC
resource "aws_vpc" "this" {
  provider   = aws.this
  cidr_block = "172.20.0.0/16"

  tags = {
    Name        = "this_vpc"
    Environment = "Test"
  }
}

resource "aws_vpc" "peer" {
  provider   = aws.peer
  cidr_block = "172.21.0.0/16"

  tags = {
    Name        = "peer_vpc"
    Environment = "Test"
  }
}

// Route Tables
resource "aws_route_table" "this" {
  provider = aws.this
  count    = length(var.this_subnets)
  vpc_id   = aws_vpc.this.id

  tags = {
    Name        = "This VPC RT"
    Environment = "Test"
  }
}

resource "aws_route_table" "peer" {
  provider = aws.peer
  count    = length(var.peer_subnets)
  vpc_id   = aws_vpc.peer.id

  tags = {
    Name        = "Peer VPC RT"
    Environment = "Test"
  }
}

// Subnets
resource "aws_subnet" "this" {
  provider          = aws.this
  count             = length(var.azs_this)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.this_subnets[count.index]
  availability_zone = element(var.azs_this, count.index)

  tags = {
    Name        = "This VPC Subnet"
    Environment = "Test"
  }
}

resource "aws_subnet" "peer" {
  provider          = aws.peer
  count             = length(var.azs_peer)
  vpc_id            = aws_vpc.peer.id
  cidr_block        = var.peer_subnets[count.index]
  availability_zone = element(var.azs_peer, count.index)

  tags = {
    Name        = "Peer VPC Subnet"
    Environment = "Test"
  }
}
