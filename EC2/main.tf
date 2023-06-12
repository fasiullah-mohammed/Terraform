# Configure the AWS provider
provider "aws" {
  region = "us-west-2"  # Specify your desired AWS region
}

# Create an EC2 instance
resource "aws_instance" "First" {
  ami           = "ami-0ab193018f3e9351b"  # Specify the AMI ID for your desired instance type
  instance_type = "t2.micro"  # Use the t2.micro instance type, which is eligible for the free tier

  # Specify other optional configuration options
  
  tags = {
    Name = "coffee"
  }
}
