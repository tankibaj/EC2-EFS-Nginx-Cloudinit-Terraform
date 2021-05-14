# Automate infrastructure provisioning using [Terraform](https://www.terraform.io/) and [Cloudinit](https://cloudinit.readthedocs.io/en/latest/).

<br/>

## Goals

- Provision an EC2 instance.
- Install Nginx package using automate configuration [user-data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html).
- Provision an EFS and mounts it to the launched EC2 instance.
- Serve nginx home page (`index.html`) from the mounted EFS.
- Write reusable terraform modules for EC2 and EFS.

<br/>

## Prerequisites

- [Git](https://git-scm.com/)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [Terraform](https://www.terraform.io/downloads.html)
- [JQ](https://stedolan.github.io/jq/) (optional)
- [Curl](https://curl.se/) (optional)


<br/>

## Quick Start

#### Clone repo

  ```bash
  git clone https://github.com/tankibaj/EC2-EFS-Nginx-Cloudinit-Terraform.git && cd EC2-EFS-Nginx-Cloudinit-Terraform
  ```

<br/>

#### Provision infrastructure

- Modify `variables.tf` for desire settings. Mainly  `variable "key_name"` (line 21) to set your ssh key for the ec2 instance.

  ```
  vim variables.tf
  ```

- Prepare your working directory for other terrafrom commands.

  ```bash
  terraform init
  ```

- Show changes required by the current configuration.

  ```bash
  terraform plan
  ```

- Create infrastructure.

  ```bash
  apply -auto-approve
  ```



> I have used AWS default VPC to make it simple. But If you would like to use this infrastructure for the production environment then my recommendation is to create a new VPC for these resources.

<br/>

#### Verify Nginx

- Obtain EC2 instance Public IP

    ```bash
    EC2_IP=$(terraform output -json ec2_public_ip | jq -r '.[0]')
    ```
    
- Curl it.

    ```bash
    ❯ curl $EC2_IP
    
    # Output sample
    Hello World!
    ```
    
    > Sometimes EC2 instance can take a bit of time to update packages and install Nginx. So if you don't see `Hello World!` then please try again after a while.

<br/>

#### Verify EFS

Check whether EFS has been successfuly mounted or not:

- Obtain EC2 instance Public IP

    ```bash
    EC2_IP=$(terraform output -json ec2_public_ip | jq -r '.[0]')
    ```
- SSH into EC2 instance

    ```bash
    ssh ubuntu@$EC2_IP
    ```
- Check EFS using `df`

    ```bash
    ❯ df -h | grep efs

    # Output sample
    fs-5d7edb06.efs.eu-central-1.amazonaws.com:/  8.0E     0  8.0E   0% /mnt/efs
    ```

- Check EFS mount

    ```bash
    ❯ mount | grep nfs
    
    # Output sample
    fs-5d7edb06.efs.eu-central-1.amazonaws.com:/ on /mnt/efs type nfs4 (rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=172.31.15.48,local_lock=none,addr=172.31.13.33)
    ```

<br/>

