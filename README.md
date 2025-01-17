# AWS AppStream 2.0 Terraform Automatic Lab
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
   - Download the Terraform files inside the previously created folder. ```git clone https://github.com/andersonvilanova/appstream_terraform.git```.
   - In your shell, inside the project folder, you need to initialize the Terraform dependency (this command is executed in the first time, or you can to need it, if you to change the AWS provider version).  
     - ```$ terraform init```  
        ![image](https://github.com/user-attachments/assets/db3eb384-6a93-47fe-b2ad-c24d03c27cc1)  

   - The next command will validate the configuration files in this directory. Always that you to change your Terraform files, you can to execute this command to check if there are no errors. 
     - ```$ terraform validate```  
        ![image](https://github.com/user-attachments/assets/0fad2aaf-36eb-43b1-95d7-24229e84b98c)  

   - Before continuing, we need to pass the credentials. Enter the credentials according to the system you are using. See the examples below (you will need to follow this step whenever you close and open another shell) .  
      - **Linux**  
        ```export AWS_ACCESS_KEY_ID="AKIXXXXXXXXXXXXXXFWE"```  
        ```export AWS_SECRET_ACCESS_KEY="O7JzXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXlPJ5"```  
        ![image](https://github.com/user-attachments/assets/63896462-ffaa-48a1-89d0-b0615b8ebe98)  

      - **CMD**  
        ```SET AWS_ACCESS_KEY_ID="AKIXXXXXXXXXXXXXXFWE"```  
        ```SET AWS_SECRET_ACCESS_KEY="O7JzXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXlPJ5"```  
        ![image](https://github.com/user-attachments/assets/db1dfa3d-1f3e-4583-a91d-ae8646755b10)  

      - **Powershell**  
        ```$env:AWS_ACCESS_KEY_ID="AKIXXXXXXXXXXXXXXFWE"```  
        ```$env:AWS_SECRET_ACCESS_KEY="O7JzXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXlPJ5"```  
        ![image](https://github.com/user-attachments/assets/a80b6307-524a-4f19-a83b-fa45d84d2a32)  

  - Now, we need to create a file plan, with all changes that will be carried out on aws.  
     - ```$ terraform plan -out plan.out```  
       ![image](https://github.com/user-attachments/assets/8e1b654b-4c70-4a38-b2b9-1aa887ed51f6)  
       ![image](https://github.com/user-attachments/assets/251d23da-89f3-4e3b-a5c9-4f15fda8bbae)

  - If you need to check the contents of the plan.out file, because you have entered a new session, or changed the file, you can run the command below.  
     - ```$ terraform show plan.out```
       ![image](https://github.com/user-attachments/assets/a17e35cb-dbbe-49f2-b6e9-355f121f8b4b)  
       ![image](https://github.com/user-attachments/assets/16b3c836-1ea8-4b21-a57a-3dd7791f3c5b)  

  - Once everything is correct, you can proceed with the creation. To do this, type the command below, and wait to the end of process.  
     - ```$ terraform apply plan.out```
       ![image](https://github.com/user-attachments/assets/2b0cfd45-dc14-4169-ad25-5b0c9c07abc2)  
       ![image](https://github.com/user-attachments/assets/fa11fdc7-fd05-4b4c-8485-68ef5bc70e6a)  

  - With the environment created, the last step is to go to the **AWS console**, in the AppStream service. In the menu on the left, select the **User Pool** option. Create the test users. To do this, simply enter the user's email, first name and last name.
     - Steps to create a user and associate the stack  
       ![image](https://github.com/user-attachments/assets/921400c6-bde4-4d62-bbf1-4c899fe92e85)  
       ![image](https://github.com/user-attachments/assets/5ced8fc7-f888-43bf-8416-a07f0c029815)  
       ![image](https://github.com/user-attachments/assets/f8f19c7d-c1fe-4c43-9252-29d6a9e2812d)  
       ![image](https://github.com/user-attachments/assets/dc98c269-32f7-4059-b65e-cc6d0c48767a)  

    - When you create a new user, they will receive an email to activate their user by creating a password. They will also receive a link to access AppStream services.  
    - Once the user clicks on the AppStream link they received via email, they will be directed to the portal. They will need to enter their username and password, and will have access to the available applications.  
      ![image](https://github.com/user-attachments/assets/ce16b82a-46d3-40b2-bb3d-4ca4197cd85b)  
      ![image](https://github.com/user-attachments/assets/740446c0-44e4-4bb7-ac70-a54ae6d5af7a)  
      ![image](https://github.com/user-attachments/assets/a0d20863-c8be-4e0a-9970-d3b9c2dd7aa5)  

   - When you finish testing, you can destroy the entire environment by typing the command below.
      - ```$ terraform destroy```  
      - Type **Yes**, and **Enter**.  
      - Wait a few minutes. When you receive confirmation, the entire environment will have been destroyed, and you won't have to worry about any costs for resources you forgot to delete.  
      ![image](https://github.com/user-attachments/assets/fa29f73f-0cc2-40b5-b46a-89a55c44eeed)
      ![image](https://github.com/user-attachments/assets/a2ab8e9f-0e44-42cd-9482-fa1b6d7d632c)  
      ![image](https://github.com/user-attachments/assets/eab190d9-1bcb-4c1f-9bca-dd30ac190e04)
