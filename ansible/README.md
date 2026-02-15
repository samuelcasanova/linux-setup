# Ansible Setup for Kubuntu

Este directorio contiene la configuración de Ansible para automatizar la instalación y configuración de Kubuntu.

## 📋 Requisitos Previos

- **Ansible**: Necesario para ejecutar los playbooks
- **Docker**: Para testing (opcional, pero recomendado)
- **Python 3**: Viene preinstalado en Kubuntu

### Instalar Ansible en Kubuntu Nuevo

Si estás configurando un Kubuntu desde cero, primero necesitas instalar Ansible:

```bash
# Opción 1: Usar el script de instalación
cd ~/git/setups/linux-setup/ansible
./install-ansible.sh

# Opción 2: Instalación manual
sudo apt-get update
sudo apt-get install -y ansible
```

**Nota**: Ubuntu 22.04 instala Ansible 2.10.8, que es suficiente para este proyecto.

## 🚀 Inicio Rápido

### 1. Instalar Ansible (solo para ejecución en sistema real)

```bash
sudo apt-get update
sudo apt-get install -y ansible
```

### 2. Verificar la Configuración

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
./tests/test-playbook.sh phase1-core-system.yml --check --diff

# Modo verbose
./tests/test-playbook.sh phase1-core-system.yml -v
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
│   ├── main.yml           # Playbook principal (próximamente)
│   └── phase*.yml         # Playbooks por fase
├── roles/
│   └── ...                # Roles de Ansible (próximamente)
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
ansible-playbook playbooks/phase1-core-system.yml --check --diff

# Ejecución real
ansible-playbook playbooks/phase1-core-system.yml

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
- `use_stow`: Usar stow para dotfiles (true)
- `node_versions`: Versiones de Node.js a instalar
- `docker_users`: Usuarios que pueden usar Docker

Puedes sobrescribir variables en tiempo de ejecución:

```bash
ansible-playbook playbooks/main.yml -e "setup_user=otro_usuario"
```

## 🔄 Fases de Migración

El proyecto está organizado en fases incrementales:

1. **Phase 0**: Setup inicial (este paso) ✅
2. **Phase 1**: Core System (OS basics, bash, zsh, git, ssh)
3. **Phase 2**: Desktop Environment (KDE, dotfiles)
4. **Phase 3**: Development Tools (Docker, NVM, VS Code)
5. **Phase 4**: Browsers and Communication
6. **Phase 5**: Work-Specific Tools
7. **Phase 6**: Productivity Applications
8. **Phase 7**: Media and Utilities
9. **Phase 8**: Integration and Documentation

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
