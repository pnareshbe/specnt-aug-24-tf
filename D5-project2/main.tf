
provider "aws" {
  region     = "us-east-1"
  #profile = "aws-b1-d1"
  profile = "specnet-tf-aug-vms"
}

/*terraform {
 backend "s3" {
   bucket = "vishwa23082024"
   #bucket = "vishwa2108202401"
   region = "us-east-1"
   key = "terraform-mod1.tfstate"
 }
}*/


module "mynet" {
    #source = "../modules/vpc-subnet"
    #source = "https://github.com/vishwacloudlab-tf/specnt-aug-24-tf/modules/vpc-subnet"
    source = "git::https://github.com/vishwacloudlab-tf/specnt-aug-24-tf.git//modules/vpc-subnet?ref=main"

    enable_ig = true # Enabling this, will create IGW, New route table, associate the subnet to RT
    vpc_cidr = "10.10.0.0/16"
    vpc_name = "vpc1" 
    tag_env = "dev" 
    tag_dep = "finance"
    public_subnets = {
    sub1 = {
        cidr_block        = "10.10.1.0/24"
        availability_zone = "us-east-1a"
        name              = "sub1"
      },
        sub2 = {
        cidr_block        = "10.10.2.0/24"
        availability_zone = "us-east-1b"
        name              = "sub2"
      }
        sub3 = {
        cidr_block        = "10.10.3.0/24"
        availability_zone = "us-east-1c"
        name              = "sub3"
      }
    }
}

module "new-key-pair" {
  source = "../modules/key-pair"
  key_name1 = "key1-aug-24"
  path = "D:\\repo\\TF-acc-19-aug-24\\D5-project2"
}

module "sgs" {
  source = "../modules/security-group"
  vpc-id = module.mynet.vpc-id
  security_groups = {
    web_sg_1 = {
      name    = "web-sg-1"
      ingress = [
        [80, 80, "tcp", ["0.0.0.0/0"]],
        [22, 22, "tcp", ["0.0.0.0/0"]]
      ]
      egress = [
        [0, 0, "-1", ["0.0.0.0/0"]]
      ]
    }
  }
}

# EC2 Instance
module "vm01" {
  source = "../modules/ec2-volume"

  #Create EC2
  subnet_id     = module.mynet.subnet-ids[0].id
  key_name      = module.new-key-pair.key-name
  enable_pub_ip = true
  sg_ids = [module.sgs.sg_ids["web_sg_1"] ]
  ami_id = "ami-066784287e358dad1"
  instance_type = "t2.micro"
  tag_env = "dev"
  filepath = "D:\\repo\\TF-acc-19-aug-24\\D4-project1-optimized\\user_data.sh"

  # Volume details
  new_volume = true
  device_name = "/dev/sdf"
  volume_size = "1"
  volume_name = "vol1-vm01"
}

resource "null_resource" "mount_volume" {
    triggers = {
      always_run = "${timestamp()}"
    } 
 provisioner "remote-exec" {
   
    connection {
      type        = "ssh"
      user        = "ec2-user"  # Default for Amazon Linux
      #private_key = file("key1-aug-24.pem")  # Path to your private key
      private_key = file(module.new-key-pair.key_path)
      host        = module.vm01.web_server_public_ip
    }

    inline = [
      # Partition the volume using fdisk
      "echo -e 'n\np\n1\n\n\nw' | sudo fdisk /dev/xvdf",

      # Format the volume (only if it hasn't been formatted already)
      "sudo mkfs -t xfs /dev/xvdf1",

      # Create a directory for mounting
      "sudo mkdir -p /mnt/data",

      # Mount the volume to the directory
      "sudo mount /dev/xvdf1 /mnt/data",

      # Ensure the volume is mounted at boot
      "echo '/dev/xvdf1 /mnt/data xfs defaults,nofail 0 2' | sudo tee -a /etc/fstab",
      "sudo chmod 777 /mnt/data",
      #create new file in the new mount
      "sudo echo 'test file' > /mnt/data/file1.txt",
      "cat /mnt/data/file1.txt"

    ]
  }
  #depends_on = [ module.new-key-pair.aws_key_pair.generated_key, module.vm01.aws_volume_attachment.example  ]
}


output "ec2_pub_ip" {
  value = module.vm01.web_server_public_ip
  
}

