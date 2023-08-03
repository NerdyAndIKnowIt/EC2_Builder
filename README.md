## EC2_Builder 

### **Warning! The private key created is unencrypted in the tfstate file, only use for temporary testing purposes!**


This creates the following resources using a terraform template:
- EC2 instance
- Installs AWS CLI using user-data
- Installs crontab using user-data
- creates a key pair for accessing the instance, stores the public key .pem file in the working directory

Sources used: 
- https://cloudkatha.com/how-to-create-ec2-instance-using-terraform-with-key-pair-on-aws/
- https://cloudkatha.com/how-to-create-key-pair-in-aws-using-terraform-in-right-way/