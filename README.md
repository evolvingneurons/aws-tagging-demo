# AWS Resource Tagging Demo
Example Terraform execution plan that demonstrates the use of AWS tags to label AWS resources.

## Details

This execution plan will deploy the following AWS resources:
- (1) VPC
- (2) Private subnets
- (2) Public subnets
- (2) security groups
- (1) EC2 t2.micro instance
- (1) 20GB EBS volume attached to the EC2 instance
- (1) Two node Aurora MySQL database cluster

 ##  High Level Instructions for Lab Use
 
 These instructions assume basic knowledge of AWS, systems administration, and Terraform. To run this Terraform plan on your local machine, perform the following:
 
 1. In the AWS account, create a new user and attach only the minimum number of policies to create the resources above.
 2. Configure Terraform so that it can use the API keys generated for the new user.
 3. On the local machine that will apply the Terraform plan, generate a key pair in the working directory that contains all of the \*.tf files that describe the Terraform plan. On Linux/Mac `ssh-keygen -b 2048 -f my-key-pair` will generate a key pair that can be used by this example code. For Windows users, `puttygen` is a popular ssh key generation tool.
 4. To review what the Terraform plan will apply, run `terraform plan` from the working directory in the command window. This is also an easy way to confirm AWS API credentials are configured correctly and that the ssh key pair files can be found.
 5. If everything appears to be correct and there are no conflicts with existing applications running in your AWS accounts, run `terraform apply` to create all resources and apply the Terraform plan.
 
