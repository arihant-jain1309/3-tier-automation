# **3-Tier Automation Framework**

This project provisions and configures a reusable 3-tier application stack on AWS using:

* Terraform (Infrastructure as Code)

* Ansible (Configuration Management)

* GitHub Actions (CI/CD)

The setup is parameterized to support multiple clients using the variable `client_name`.

---

## **Architecture**

The infrastructure includes:

* VPC

* Public Subnet (Web Tier)

* Private Subnet (App Tier)

* Private Subnet (DB Tier)

* Security Groups

* EC2 Instances

### **Web Tier**

* Runs Nginx

* Configured as reverse proxy

* Accessible over HTTP (Port 80\)

### **App Tier**

* Docker installed

* Application runs inside Docker container (Port 5000\)

* Accessible only from Web Tier

### **Database Tier**

* MySQL installed

* Basic hardening applied:

  * Anonymous users removed

  * Remote root login disabled

  * Test database removed

* Accessible only from App Tier

---

## **Terraform Structure**

Terraform code is modular:

* modules/network

* modules/security

* modules/compute

To deploy manually:

`cd terraform`  
`terraform init`  
`terraform apply -var="client_name=clientA"`

To deploy another client:

`terraform apply -var="client_name=clientB"`

No code changes required.

---

## **Ansible Structure**

Ansible is organized using roles:

* roles/web

* roles/app

* roles/db

To run manually:

`cd ansible`  
`ansible-playbook -i inventory.ini site.yml`

---

## **CI/CD Pipeline**

Pipeline file:  
 .github/workflows/deploy.yml

Trigger: Manual (workflow\_dispatch)

Required Input:

* client\_name

Pipeline Flow:

1. Checkout repository

2. Configure AWS credentials from GitHub Secrets

3. Terraform init

4. Terraform apply

5. Run Ansible playbooks

---

## **Required GitHub Secrets**

Add the following in repository settings:

* AWS\_ACCESS\_KEY

* AWS\_SECRET\_KEY

---

## **Assumptions**

* AWS Region: ap-south-1

* Ubuntu AMI used

* SSH access restricted to admin IP

* Application runs on port 5000

