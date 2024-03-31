# React Portfolio Deployment for bingops.com

This Ansible project automates the deployment of a React-based portfolio website on [bingops.com](https://www.bingops.com), made by [Oslo418](https://github.com/Oslonline/) opensource at [bingo-portfolio](https://github.com/Oslonline/bingo-portfolio) . It configures the server with Nginx, sets up SSL certificates using Let's Encrypt, and deploys the React application. Additionally, it ensures SSH access is properly configured for secure administration.

## Project Structure

- `bootstrap.yml`: Initial playbook to set up Ansible on the target server.
- `playbook.yml`: Main playbook that runs the entire setup and deployment process.
- `group_vars/all.yml`: Contains variables applicable to all hosts.
- `inventories/main/hosts`: Inventory file for defining hosts and groups.
- `roles/`: Contains Ansible roles for each task.
- `letsencrypt`: Configures SSL certificates using Let's Encrypt.
- `nginx`: Sets up and configures Nginx as a web server and reverse proxy.
- `portfolio`: Deploys the React application.
- `ssh`: Ensures SSH is properly configured for secure access.

## Prerequisites

- Ansible installed on your control machine.
- A target server running a supported version of Linux.
- Domain name `bingops.com` pointed to your server's IP address.

## Usage

1. **Prepare Inventory**: Update `inventories/main/hosts` with the IP address or hostname of your server.

2. **Set Variables**: Customize variables in `group_vars/all.yml` and role-specific `defaults/main.yml` files as needed.

3. **Run Playbook**: Execute the main playbook to deploy the portfolio.

```bash
ansible-playbook -i inventories/main/hosts playbook.yml
```

4. **Verify Deployment**: Access `https://bingops.com` to view the deployed React portfolio.

## Role Details

- **LetsEncrypt**: Automatically obtains and renews SSL certificates.
- **Nginx**: Configures Nginx to serve the React app and handle HTTPS.
- **Portfolio**: Clones the React app from a Git repository and builds it.
- **SSH**: Hardens SSH access for improved security.

## Credits

Thanks to **Oslo418**, here are its social links :
- His website : [oslo418.com](https://www.oslo418.com/)
- Github : [Oslonline](https://github.com/Oslonline)
- Twitter : [Oslo418](https://twitter.com/Oslo418)
