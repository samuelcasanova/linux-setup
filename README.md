# Personal Linux Setup

This repo stores the Ansible configuration, dotfiles, and support files needed to set up a new Kubuntu laptop from scratch.

Everything here is driven by Ansible — there is no separate shell-script installer anymore.

## Fresh Install

When the Kubuntu installer boots, choose "Minimal installation". This installs Git automatically. Once the wizard finishes and the system reboots, update all pending packages.

Open Konsole and run:

```bash
cd /tmp
git clone https://github.com/samuelcasanova/linux-setup-private.git
```

Enter your username, samuelcasanova, and use a personal access token as the password (Settings → Developer settings → Personal access tokens → Tokens (classic) → Create new token with repo scope).

```bash
cp -r linux-setup-private/dotfiles/ssh/.ssh/* ~/.ssh/
cd ~/.ssh/
find . -type f ! -name "config" ! -name "known_hosts" ! -name "*.pub" ! -name "*.pemf" | xargs chmod 600
find . -type f -name "*.pub" | xargs chmod 600
find . -type f -name "*.pem" | xargs chmod 600
cd ~
mkdir -p git/setups
cd git/setups
git clone git@github.com:samuelcasanova/linux-setup.git
git clone git@github.com:samuelcasanova/linux-setup-private.git
```

Initialize the system (installs Git and Ansible) and configure passwordless sudo for your user:

```bash
cd ~/git/setups/linux-setup
./init.sh
echo 'samuel ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/samuel
```

> Ansible escalates privileges task by task with `become: yes`. Without NOPASSWD, the local connection plugin can't pass the password to `sudo` and fails with a timeout.

## Running the Playbooks

Verify the Ansible setup, then run all the playbooks:

```bash
cd ~/git/setups/linux-setup
ansible-playbook playbooks/test-connection.yml
ansible-playbook playbooks/main.yml
```

If you need to re-run a single role:

```bash
ansible localhost -m include_role -a "name=<role_name>" -e "setup_repo=$(pwd)"
```

### Dry Run / Verbose Mode

```bash
# Dry-run (no changes made)
ansible-playbook playbooks/step1-core-system.yml --check --diff

# Real run
ansible-playbook playbooks/step1-core-system.yml

# Specific tags
ansible-playbook playbooks/main.yml --tags "docker,vscode"

# Skip certain tags
ansible-playbook playbooks/main.yml --skip-tags "grub"

# Verbosity levels: -v, -vv, -vvv
ansible-playbook playbooks/test-connection.yml -vvv
```

## Installation Steps

The project is organized into incremental steps that can be run separately or all together via `main.yml`:

1. **Step 1 — Core System**: OS basics, Bash, Zsh, Git, SSH, KeePass, SMB share mount.
2. **Step 2 — Desktop Environment**: KDE, keyboards, SafeEyes, audio switcher, browsers, LibreOffice, Okular, VLC, Pinta, OBS Studio, Cryptomator.
3. **Step 3 — Development Tools**: Docker, NVM, VS Code, Antigravity, Python, Immfly environment, personal repositories.
4. **Step 4 — Work and Productivity Tools**: AMQP tools, VPN, Kubernetes, Discord, Obsidian, Postman, Sqlectron, AWS CLI.

There's also `playbooks/vpn.yml`, a standalone playbook for just the VPN roles (`wifec_vpn`, `inseat_vpn`).

## Post-Install

Some steps still need to be done manually after the playbooks finish:

1. **Google account**: log into your personal Google account in Chrome, then Immfly, then Testing.
2. **Displays**: set the main display as "Primary" and reorder monitors as needed.
3. **Brave**: open the browser and configure the personal account (get the token from another computer or mobile).
4. **Obsidian**: configure the vault pointing to `~/git/secondbrain`. Install and enable the emoji shortcodes, file hider, and Git plugins (with backup/pull intervals set to 1 minute).
5. **KeePass**: configure the vault pointing to the OneDrive `.kdbx` file.
6. **VS Code**: configure the account to connect to Claude.

## Testing with Docker

### Build the Test Image

```bash
cd tests
docker build -t kubuntu-ansible-test .
```

### Run a Playbook in Docker

```bash
# Using the helper script
./tests/test-playbook.sh test-connection.yml

# With extra Ansible arguments
./tests/test-playbook.sh step1-core-system.yml --check --diff

# Verbose mode
./tests/test-playbook.sh step1-core-system.yml -v
```

### Manual Testing in Docker

```bash
# Run an interactive container
docker run -it --rm \
    -v ~/git/setups/linux-setup:/home/samuel/git/setups/linux-setup:ro \
    -w /home/samuel/git/setups/linux-setup \
    kubuntu-ansible-test \
    /bin/bash

# Inside the container, run playbooks
ansible-playbook playbooks/test-connection.yml
```

## Project Structure

```
linux-setup/
├── ansible.cfg              # Ansible configuration
├── init.sh                  # Initializes a fresh box (installs Git + Ansible)
├── inventory/
│   ├── local.yml            # Inventory for localhost
│   └── group_vars/
│       └── all.yml          # Global variables
├── playbooks/
│   ├── test-connection.yml  # Connectivity test playbook
│   ├── main.yml              # Main playbook (imports all steps)
│   ├── step*.yml             # Playbooks per step
│   └── vpn.yml                # Standalone VPN-only playbook
├── roles/                   # One role per piece of software/config
├── dotfiles/                # Dotfiles deployed via GNU Stow
├── support-files/           # Static assets referenced by a few roles
└── tests/
    ├── Dockerfile            # Docker image for testing
    └── test-playbook.sh      # Test helper script
```

## Variables

Variables are defined in `inventory/group_vars/all.yml`:

- `setup_user`: system user (samuel)
- `home_dir`: home directory
- `setup_repo`: path to this repository
- `setup_repo_private`: path to the sibling `linux-setup-private` repo, which holds secrets (SSH keys, VPN configs, SMB credentials, etc.)
- `smb_mounts`: SMB/CIFS shares to persist via `/etc/fstab` (see the `smb_mount` role)
- `node_versions`: Node.js versions to install
- `docker_users`: users allowed to use Docker

You can override variables at runtime:

```bash
ansible-playbook playbooks/main.yml -e "setup_user=other_user"
```

## Troubleshooting

### Ansible can't find the inventory

```bash
# Make sure you're in the right directory
cd ~/git/setups/linux-setup

# Or specify the inventory explicitly
ansible-playbook -i inventory/local.yml playbooks/test-connection.yml
```

### sudo permission error / become timeout

Ansible uses `become: yes` per task and can't pass a password to `sudo` through the local connection plugin. The fix is passwordless sudo:

```bash
echo 'samuel ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/samuel
```

### Docker can't find the volume

```bash
# Use an absolute path
docker run -v /home/samuel/git/setups/linux-setup:/home/samuel/git/setups/linux-setup:ro ...
```

## Resources

- [Ansible Documentation](https://docs.ansible.com/)
- [Ansible Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)
- [Ansible Modules Index](https://docs.ansible.com/ansible/latest/collections/index_module.html)

## Contributing

This is a personal project, but suggestions are welcome.

## License

Personal use.
