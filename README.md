# Terraform - AWS AppStream 2.0 Environment
- Terraform script to create AWS AppStream 2.0 with all basic infrastructure necessary to work (VPCs, subnets, route tables and so on).  
- The main file you should pay attention to is the **variables.tf**. This file contains the principal components to create names, CIDR, main options and so on. If you need customize some options, you will need to modify this file, and maybe, the other files too.
- **This Terraform script is intended to create a fast and simple environment to do tests with AWS AppStream 2.0.**  
- **I recommended you use this Terraform in an AWS sandbox account. So once you are sure that the script will not affect your production environment, you can change it and use it as per your need.**
- **If you intended to use this Terraform in a production environment, you need to review all Terraform script, and I recommended you to limit the AWS IAM user permissions.**
- **And the more important thing: Although I have used this script several times, use it at your own risk.**  

# What this script will set by default  

1. VPC:
   - Region: us-east-1
   - VPC Name: vpc_terraform
   - VPC CIDR: 10.10.0.0/16
   - Private Subnet A: 10.10.1.0/24
   - Private Subnet B: 10.10.2.0/24
   - Public Subnet A: 10.10.11.0/24
   - Public Subnet B: 10.10.12.0/24
   - Private Route Table: vpc_terraform_priv_rt
   - Public Route Table: vpc_terraform_pub_rt
   - Internet Gateway: vpc_terraform_igw
   - NAT Gateway: vpc_terraform_nat_gw
   - Elastic IP Name: vpc_terraform_eip_nat_gw
   - Elastic IP: IP provided by AWS after creation
   - DHCP Option Name: vpc_terraform_dhcp_opt
   - Domain Name: appstream.lab
   - DNS: 10.10.10.10, 10.10.10.20
     
2. AppStream: 
   - Fleet Name: appstream_lab
   - Stack Name: stack_lab
   - Instance Type: stream.standard.medium
   - Image: Amazon-AppStream2-Sample-Image-06-17-2024 (this image is provided by AWS and have some apps installed, perfect to take a look on AWS AppStream service)
  
# Requirements
   - A operating system Linux, macOS or Windows (Linux is preferable). You can use a docker image too.
   - Terraform 1.9 or higher installed. (I will not show how install Terraform. However you can take a look on https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-cli).
   - An AWS account.
   - A user created on AWS IAM with the follow permissions attached: AmazonAppStreamFullAccess, AmazonEC2FullAccess and AmazonVPCFullAccess.
   - An Access Key and Secret Access Key for the user created.

# Step by step
   - Create a folder to download the Terraform files.
   - Download the Terraform files inside the previously created folder. ```git clone https://github.com/andersonvilanova/appstream-terraform.git```.
   - In your shell, inside the project folder, you need to initialize the Terraform dependency (this command is executed in the first time, or you can to need it, if you to change the AWS provider version).  
     - ```$ terraform init```  
        ![image](https://github.com/user-attachments/assets/711f699a-1d36-4097-8bec-91df3d81ebc0)  
  
   - The next command will validate the configuration files in this directory. Always that you to change your Terraform files, you can to execute this command to check if there are no errors. 
     - ```$ terraform validate```  
        ![image](https://github.com/user-attachments/assets/3e606a6e-fb9e-4796-afee-c9598407aabf)  

   - Before continuing, we need to pass the credentials. Enter the credentials according to the system you are using. See the examples below (you will need to follow this step whenever you close and open another shell) .  
      - **Linux**  
        ```export AWS_ACCESS_KEY_ID="AKIXXXXXXXXXXXXXXFWE"```  
        ```export AWS_SECRET_ACCESS_KEY="O7JzXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXlPJ5"```  
        ![image](https://github.com/user-attachments/assets/efb1d7cb-816f-4904-9567-eedf21a6eedb)  
 
     - **CMD**  
        ```SET AWS_ACCESS_KEY_ID="AKIXXXXXXXXXXXXXXFWE"```  
        ```SET AWS_SECRET_ACCESS_KEY="O7JzXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXlPJ5"```  
        ![image](https://github.com/user-attachments/assets/28945691-c6e6-4df7-a2d6-c73dc09e1c86)  
  
      - **Powershell**  
        ```$env:AWS_ACCESS_KEY_ID="AKIXXXXXXXXXXXXXXFWE"```  
        ```$env:AWS_SECRET_ACCESS_KEY="O7JzXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXlPJ5"```  
        ![image](https://github.com/user-attachments/assets/fc2ed850-7fb9-4e30-84fa-1278b78de06b)  
  
  - Now, we need to create a file plan, with all changes that will be carried out on aws.  
     - ```$ terraform plan -out plan.out```  
       ![image](https://github.com/user-attachments/assets/1a3b67e6-90ed-47a5-8bb1-2646fb98233c)  
       ![image](https://github.com/user-attachments/assets/cac9545d-f25b-4890-81f6-4642a2c8db9e)  

  - If you need to check the contents of the plan.out file, because you have entered a new session, or changed the file, you can run the command below.  
     - ```$ terraform show plan.out```
       ![image](https://github.com/user-attachments/assets/6478eb13-f419-4a3d-b709-0b96cff6a0d2)  

  - Once everything is correct, you can proceed with the creation. To do this, type the command below, and wait to the end of process.  
     - ```$ terraform apply plan.out```
       ![image](https://github.com/user-attachments/assets/15682a67-4ec4-4f13-bdc1-7299534ee89a)  
       ![image](https://github.com/user-attachments/assets/3935c5f6-90fb-4735-b979-3788fde2efa5)  

  - With the environment created, the last step is to go to the **AWS console**, in the AppStream service. In the menu on the left, select the **User Pool** option. Create the test users. To do this, simply enter the user's email, first name and last name.
     - Steps to create a user and associate the stack  
       ![image](https://github.com/user-attachments/assets/614c0f7e-39a2-4dac-ba50-4fa4d4bcdf62)  
       ![image](https://github.com/user-attachments/assets/84d840d7-60e8-40c1-afa6-43d8f6026c71)  
       ![image](https://github.com/user-attachments/assets/f881ad1d-b6fe-4007-b71d-d7fb1eae75c9)  
       ![image](https://github.com/user-attachments/assets/f2738bf9-d069-4331-ad06-94049ff87f44)  

    - When you create a new user, they will receive an email to activate their user by creating a password. They will also receive a link to access AppStream services.  
    - Once the user clicks on the AppStream link they received via email, they will be directed to the portal. They will need to enter their username and password, and will have access to the available applications.  
      ![image](https://github.com/user-attachments/assets/f410da3d-fc8f-4d12-b61c-c3b58f78fda2)  
      ![image](https://github.com/user-attachments/assets/9a793e3a-a2f1-4659-a93b-d80fc9667d2d)  
      ![image](https://github.com/user-attachments/assets/de62dc24-27de-4ed0-b175-e32305e467a5)  

   - When you finish testing, you can destroy the entire environment by typing the command below.
      - ```$ terraform destroy```  
      - Type **Yes**, and **Enter**.  
      - Wait a few minutes. When you receive confirmation, the entire environment will have been destroyed, and you won't have to worry about any costs for resources you forgot to delete.  
      ![image](https://github.com/user-attachments/assets/6a7df877-c72d-47ca-a4d7-6d2cfdbc4626)  
      ![image](https://github.com/user-attachments/assets/82f07693-f090-4f02-b4e0-3c1308c2d373)  
      ![image](https://github.com/user-attachments/assets/b95f12b4-a0df-4073-a0d8-c131651804e0)
