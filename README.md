### BingOps Provisioning Project Documentation: `bingops.com-provisioning`

This documentation outlines the essential components and tasks in the provisioning of the website **bingops.com** using Terraform, Proxmox, and Ansible. The project sets up a virtual machine (VM) on Proxmox, configures Cloudflare for tunneling, and deploys a React-based portfolio website with proper SSL certificates and secure SSH access.

#### Project Skeleton

```plaintext

│ # Ansible
├── roles/
│   ├── cloudflare/    # Cloudflare tunnel setup
│   ├── portfolio/     # React app deployment
│   ├── ssh/           # SSH configuration and hardening
│   ├── nginx/         # Nginx setup and reverse proxy
│   └── letsencrypt/   # SSL certificate management
├── group_vars/
│   └── all.yml        # Global variables (e.g., domain, SSH users)
├── inventories/
│   └── main/hosts     # Ansible inventory for target servers
├── playbook.yml       # Main playbook for provisioning tasks
├── bootstrap.yml      # Initial Ansible playbook
│
│ # Terraform
│
├── main.tf                 # Proxmox provider setup
├── vms.tf                  # VM provisioning on Proxmox
├── terraform.tfvars        # Terraform variables file
├── credentials.auto.tfvars # Proxmox credentials
├── variables.tf            # Terraform variables definitions
└── README.md               # Project documentation
```

### Key Steps Overview

#### 1. **Proxmox VM Creation (Terraform)**

Terraform is used to create and manage the VM for `bingops.com`. It interacts with Proxmox via the `proxmox_virtual_environment_vm` resource.

- **VM Specs:**
    - VM ID: `120`
    - Cores: `2`
    - Memory: `2GB`
    - IP: `192.168.1.120/24`
    - Network Bridge: `vmbr0`

- **Credentials Setup**:
  The Proxmox API Token and SSH key are securely stored in the `credentials.auto.tfvars` file. This file is used to provide Terraform with access to the Proxmox server.

  Here’s a sample `credentials.auto.tfvars` template you can use for your setup (make sure to replace the values with your own):

  ```plaintext
  proxmox_api_url   = "https://192.168.1.150:8006"  # Your Proxmox IP Address
  proxmox_api_token = "terraform@pve!terraform=d3adbeef-1234-5678-9101-abcdefabcdef"  # Example API Token
  
  ssh_key = "ssh-rsa AAAAB3NzaC1yc..."
  ```

    - `proxmox_api_url`: The URL for accessing your Proxmox server, including the port (e.g., `8006`).
    - `proxmox_api_token`: The API token you created in Proxmox to give Terraform access.
    - `ssh_key`: Your SSH public key for accessing the VM.

  This file should not be shared publicly as it contains sensitive information.

#### 2. **Run Bootstrap Playbook**

The `bootstrap.yml` playbook is used to prepare the target server (or VM) for Ansible management. This includes setting up users, SSH access, and ensuring essential packages are installed.

- **Key Tasks in `bootstrap.yml`**:
    - Ensure the `sudo` package is installed.
    - Create a new administrative user with key-based SSH access.
    - Configure SSH for secure connections (disabling password login, setting key-based authentication, etc.).

**Command**:
```bash
ansible-playbook bootstrap.yml -i inventories/main/hosts
```

#### 3. **Deploy Applications**

Once the target environment is ready, you can deploy the applications and configure Nginx, SSL certificates, and the React app.

- **Key Tasks**:
    - Update the `group_vars/all.yml` file with your domain and clone path.
    - Run the full Ansible playbook to deploy the React app, configure Nginx, and set up SSL.

**Command**:
```bash
ansible-playbook -i inventories/main/hosts playbook.yml
```

#### 4. **Verify Deployment**

After running the playbooks, verify that the website is running and accessible via HTTPS.

- Access the portfolio site at `https://bingops.com`.

---

### Final Notes

- Ensure all sensitive information such as API tokens and SSH keys are stored securely in the `credentials.auto.tfvars` file.
- All variables can be customized in `group_vars/all.yml` and the respective `defaults/main.yml` files under each role.
- The project supports automatic SSL renewal and SSH access hardening for long-term security.
