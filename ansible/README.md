# Ansible Setup for Kubuntu

Este directorio contiene la configuración de Ansible para automatizar la instalación y configuración de Kubuntu.

### Instalar en Kubuntu desde cero

Cuando arranque el menú de instalación, elegir la opción "Instalación mínima". Esto instalará automáticamente Git. Cuando termine el asistente y reinicie el sistema, actualiza todos los paquetes pendientes. Cuando termine, abre "Web Browser" y navega a este repositorio público en github.com para ir copiando y pegando los comandos.

A continuación, abre Konsole, y ejecuta los siguientes comandos:

```bash
cd /tmp
git clone https://github.com/samuelcasanova/linux-setup-private.git
```

Entra tu usuario, samuelcasanova, y como password el personal access token (Settings --> Developer settings --> Personal access tokens --> Tokens (classic) --> Create new token with repo scope).

```bash
cp -r linux-setup-private/dotfiles/ssh/.ssh/* ~/.ssh/
cd ~/.ssh/
find . -type f ! -name "config" ! -name "known_hosts" ! -name "*.pub" ! -name "*.pemf" | xargs chmod 600
find . -type f -name "*.pub" | xargs chmod 600
find . -type f -name "*.pem" | xargs chmod 600
cd ~
mkdir -p git/setups
git clone git@github.com:samuelcasanova/linux-setup.git
git clone git@github.com:samuelcasanova/linux-setup-private.git
```

A continuación instala ansible:

```bash
sudo apt-get update
sudo apt-get install -y ansible
```

### 1. Verifica la configuración de ansible y ejecuta todos los playbooks

Prueba la configuración de ansible y ejecuta todos los playbooks:

```bash
cd ~/git/setups/linux-setup/ansible
ansible-playbook playbooks/test-connection.yml
ansible-playbook playbooks/main.yml
```

If you get an error about an issue doing sudo, try to do `sudo ls` and then try again.

### Post-instalación

There are some needed steps after the installation:

1. **Brave**: Open the browser and configure the personal account. Get the token from other computer or mobile.
2. **Obsidian**: Now open the Obsidian app and configure the vault pointint to ~/git/secondbrain'. Make sure you have installed and enable the following plugins: emoji shortcodes, file hider and Git (with backup and pull intervals to 1 minute).
3. **Keepass**: Open the app and configure the vault pointint to the Onedrive kdbx file.
4. **Antigravity**: Open the app and configure the account to connect to Google.


## 🚀 Inicio Rápido

### 1. Verificar la Configuración

```bash
cd ~/git/setups/linux-setup/ansible

# Test de conexión básico
ansible-playbook playbooks/test-connection.yml
```

## 🧪 Testing con Docker

### Construir la Imagen de Test

```bash
cd tests
docker build -t kubuntu-ansible-test .
```

### Ejecutar un Playbook en Docker

```bash
# Usando el script helper
./tests/test-playbook.sh test-connection.yml

# Con argumentos adicionales de Ansible
./tests/test-playbook.sh step1-core-system.yml --check --diff

# Modo verbose
./tests/test-playbook.sh step1-core-system.yml -v
```

### Testing Manual en Docker

```bash
# Ejecutar contenedor interactivo
docker run -it --rm \
    -v ~/git/setups/linux-setup:/home/samuel/git/setups/linux-setup:ro \
    -w /home/samuel/git/setups/linux-setup/ansible \
    kubuntu-ansible-test \
    /bin/bash

# Dentro del contenedor, ejecutar playbooks
ansible-playbook playbooks/test-connection.yml
```

## 📁 Estructura del Proyecto

```
ansible/
├── ansible.cfg              # Configuración de Ansible
├── inventory/
│   ├── local.yml           # Inventario para localhost
│   └── group_vars/
│       └── all.yml         # Variables globales
├── playbooks/
│   ├── test-connection.yml # Playbook de prueba
│   ├── main.yml           # Playbook principal
│   └── step*.yml          # Playbooks por paso
├── roles/
│   └── ...                # Roles de Ansible
├── files/                 # Archivos estáticos
├── templates/             # Templates Jinja2
└── tests/
    ├── Dockerfile         # Imagen Docker para testing
    └── test-playbook.sh   # Script helper para testing
```

## 🎯 Uso de Playbooks

### Ejecutar en Sistema Real

```bash
cd ~/git/setups/linux-setup/ansible

# Modo dry-run (no hace cambios)
ansible-playbook playbooks/step1-core-system.yml --check --diff

# Ejecución real
ansible-playbook playbooks/step1-core-system.yml

# Con tags específicos
ansible-playbook playbooks/main.yml --tags "docker,vscode"

# Saltar ciertos tags
ansible-playbook playbooks/main.yml --skip-tags "grub"
```

### Modo Verbose

```bash
# Nivel 1: Info básica
ansible-playbook playbooks/test-connection.yml -v

# Nivel 2: Más detalles
ansible-playbook playbooks/test-connection.yml -vv

# Nivel 3: Debug completo
ansible-playbook playbooks/test-connection.yml -vvv
```

## 📝 Variables

Las variables se definen en `inventory/group_vars/all.yml`:

- `setup_user`: Usuario del sistema (samuel)
- `home_dir`: Directorio home
- `setup_repo`: Ruta al repositorio
- `node_versions`: Versiones de Node.js a instalar
- `docker_users`: Usuarios que pueden usar Docker

Puedes sobrescribir variables en tiempo de ejecución:

```bash
ansible-playbook playbooks/main.yml -e "setup_user=otro_usuario"
```

## 🔄 Pasos de Instalación

El proyecto está organizado en pasos incrementales que se pueden ejecutar por separado o todos juntos vía `main.yml`:

1.  **Step 1: Core System**: Base del SO, Bash, Zsh, Git, SSH, KeePass y RClone.
2.  **Step 2: Desktop Environment**: KDE, SafeEyes, Audio Switcher, Navegadores, LibreOffice, Okular, VLC, Pinta y OBS Studio.
3.  **Step 3: Development Tools**: Docker, NVM, VS Code, Antigravity, Python, Entorno Immfly y Repositorios Personales.
4.  **Step 4: Work and Productivity Tools**: Herramientas AMQP, VPN, Kubernetes, Discord, Obsidian, Postman y Sqlectron.

## 🐛 Troubleshooting

### Ansible no encuentra el inventario

```bash
# Verificar que estás en el directorio correcto
cd ~/git/setups/linux-setup/ansible

# O especificar el inventario manualmente
ansible-playbook -i inventory/local.yml playbooks/test-connection.yml
```

### Error de permisos con sudo

```bash
# Verificar que tu usuario está en sudoers
sudo -v

# Si necesitas password, añade --ask-become-pass
ansible-playbook playbooks/main.yml --ask-become-pass
```

### Docker no encuentra el volumen

```bash
# Usar ruta absoluta
docker run -v /home/samuel/git/setups/linux-setup:/home/samuel/git/setups/linux-setup:ro ...
```

## 📚 Recursos

- [Documentación de Ansible](https://docs.ansible.com/)
- [Ansible Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)
- [Módulos de Ansible](https://docs.ansible.com/ansible/latest/collections/index_module.html)

## 🤝 Contribuir

Este es un proyecto personal, pero las sugerencias son bienvenidas.

## 📄 Licencia

Uso personal.
