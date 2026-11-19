#Prompt utilizado 
"You're a DevOps engineer and you get the following task assigned                                                        
  Create an IaC file to create an EC2 instance in AWS                                                                     
  Let me know if you need any other details or if you have any questions" 

#1a Pregunta de seguimiento 
A few questions before I write anything:
  
  1. IaC tool — Terraform, CloudFormation, CDK, Pulumi, or a preference?
  2. Instance details:
    - Instance type (e.g. t3.micro)?
    - Region?
    - AMI — specific ID, or should I use a recent Amazon Linux 2023 / Ubuntu LTS?
  
  3. Networking — existing VPC/subnet, or create new ones? Public or private subnet?
  4. Access — SSH key pair needed? Should I attach a security group that allows SSH (port 22)?
  5. Storage — default 8 GB gp3 root volume, or different size/type?
  6. IAM — does the instance need an instance profile/role?
  7. Tags — any required tags (e.g. Name, Environment, cost-allocation tags)?
  
  The answers to 1 and 2 (tool + region) are the minimum I need to produce something usable. The rest I can default
  sensibly if you don't have strong preferences.

#1a respuesta
Let's use terraform, cheaper instance, closest region to Mexico use the most recent and secure version of ubuntu  

#2a pregunta de seguimiento 
1. Networking — should I create a new VPC/subnet, or do you have an existing one to use?
  2. SSH access — do you want a key pair attached and port 22 open, or no remote access for now?
  3. Any required tags — e.g. Name, Environment?
  
  Defaults I'll apply unless you say otherwise:
  - Region: us-east-1 (N. Virginia — closest AWS region to Mexico with the broadest service availability; us-west-2 Oregon
  is the alternative)
  - Instance type: t3.micro (cheapest general-purpose, ~$0.0104/hr)
  - AMI: latest Ubuntu 24.04 LTS (Noble) via SSM parameter, so it stays current
  - Root volume: 8 GB gp3
  - Storage encrypted: yes

  #2a respuesta 
  Create a new VPC, key pair attached, use the name kiro_instance the default looks good to me


  ##TOTAL DE CREDITOS USADOS : 0.12
