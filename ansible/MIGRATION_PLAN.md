# Plan de Migración: Shell Scripts → Ansible

## Objetivo

Migrar gradualmente el repositorio de configuración de Kubuntu desde scripts shell a Ansible, permitiendo pruebas incrementales y manteniendo la funcionalidad existente durante la transición.

---

## Estructura del Proyecto Ansible

### Directorio Propuesto

```
linux-setup/
├── ansible/
│   ├── ansible.cfg
│   ├── inventory/
│   │   ├── local.yml
│   │   └── group_vars/
│   │       └── all.yml
│   ├── playbooks/
│   │   ├── main.yml                    # Playbook principal
│   │   ├── phase1-core-system.yml
│   │   ├── phase2-desktop.yml
│   │   ├── phase3-dev-tools.yml
│   │   ├── phase4-browsers.yml
│   │   ├── phase5-work-tools.yml
│   │   ├── phase6-productivity.yml
│   │   ├── phase7-media.yml
│   │   └── phase8-support-scripts.yml
│   ├── roles/
│   │   ├── os_basics/
│   │   ├── bash_config/
│   │   ├── zsh/
│   │   ├── git_config/
│   │   ├── ssh_config/
│   │   ├── kde/
│   │   ├── docker/
│   │   ├── nvm/
│   │   ├── vscode/
│   │   ├── browsers/
│   │   ├── discord/
│   │   └── ... (un rol por cada script)
│   ├── files/                          # Archivos estáticos
│   ├── templates/                      # Templates Jinja2
│   └── tests/
│       ├── Dockerfile         # Imagen Docker para testing
│       └── test-playbook.sh   # Script helper para testing
├── init.sh                # Script de inicialización (Git + Ansible)
├── PROGRESS.md            # Seguimiento de progreso
├── MIGRATION_PLAN.md      # Este archivo
├── dotfiles/                           # Mantener como está
├── install-software-scripts/           # Mantener durante la transición
└── README.md
```

---

## Estrategia de Migración por Fases

### Principios de la Migración

1. **Incremental**: Migrar en fases pequeñas y probables
2. **Coexistencia**: Scripts shell y Ansible coexistirán durante la transición
3. **Testing**: Cada fase se prueba antes de continuar
4. **Rollback**: Mantener scripts shell como respaldo
5. **Idempotencia**: Aprovechar la naturaleza idempotente de Ansible

### Fase 0: Preparación (1-2 horas)

**Objetivo**: Crear la infraestructura base de Ansible

#### Acciones

1. Instalar Ansible en el sistema
   ```bash
   sudo apt-get update
   sudo apt-get install -y ansible
   ```

2. Crear estructura de directorios
3. Configurar `ansible.cfg`:
   ```ini
   [defaults]
   inventory = inventory/local.yml
   roles_path = roles
   host_key_checking = False
   retry_files_enabled = False
   ```

4. Crear inventario local:
   ```yaml
   all:
     hosts:
       localhost:
         ansible_connection: local
         ansible_python_interpreter: /usr/bin/python3
   ```

5. Crear script de testing en VM/contenedor

#### Entregables

- Estructura de directorios Ansible
- Configuración básica funcionando
- Playbook de prueba que ejecuta `ping`

---

### Fase 1: Core System Setup (2-4 horas)

**Objetivo**: Migrar scripts fundamentales del sistema

#### Scripts a Migrar

- `00-os-basics.sh` → Role `os_basics`
- `10-bash.sh` → Role `bash_config`
- `12-zsh.sh` → Role `zsh`
- `13-git.sh` → Role `git_config`
- `15-ssh.sh` → Role `ssh_config`

#### Ejemplo: Role `os_basics`

```yaml
# roles/os_basics/tasks/main.yml
---
- name: Configure GRUB to boot Windows by default
  block:
    - name: Backup GRUB configuration
      copy:
        src: /etc/grub.d/
        dest: /tmp/grub.d/
        remote_src: yes
      become: yes

    - name: Move os-prober to boot Windows first
      command: mv /etc/grub.d/30_os-prober /etc/grub.d/09_os-prober
      args:
        creates: /etc/grub.d/09_os-prober
      become: yes

    - name: Update GRUB configuration
      command: grub-mkconfig -o /boot/grub/grub.cfg
      become: yes

- name: Install stow
  apt:
    name: stow
    state: present
  become: yes

- name: Install networking tools
  apt:
    name:
      - inetutils-traceroute
      - net-tools
      - nmap
      - curl
      - tree
    state: present
  become: yes
```

#### Testing

```bash
# Crear VM de prueba con Vagrant o Docker
cd ansible/tests
vagrant up  # o docker run

# Ejecutar playbook de Fase 1
ansible-playbook playbooks/phase1-core-system.yml --tags "test"

# Verificar instalaciones
ansible-playbook tests/verify-installation.yml
```

---

### Fase 2: Desktop Environment (2-3 horas)

**Scripts a Migrar**

- `14-kde.sh` → Role `kde`
- Dotfiles deployment → Integrar con roles existentes

#### Gestión de Dotfiles con Ansible

Ansible puede usar `stow` o gestionar dotfiles directamente:

**Opción A: Usar stow (mantener compatibilidad)**
```yaml
- name: Deploy git dotfiles with stow
  command: stow -v -d ~/git/setups/linux-setup/dotfiles/ -t ~ git
  args:
    creates: ~/.gitconfig
```

**Opción B: Gestión nativa de Ansible**
```yaml
- name: Deploy git configuration
  template:
    src: gitconfig.j2
    dest: ~/.gitconfig
    mode: 0644
```

---

### Fase 3: Development Tools (3-5 horas)

**Scripts a Migrar**

- `30-docker.sh` → Role `docker`
- `35-nvm.sh` → Role `nvm`
- `36-vscode.sh` → Role `vscode`
- `36-antigravity.sh` → Role `antigravity`

#### Desafíos Específicos

**NVM (Node Version Manager)**

El script actual requiere interacción del usuario. En Ansible:

```yaml
# roles/nvm/tasks/main.yml
---
- name: Get latest NVM version from GitHub
  uri:
    url: https://api.github.com/repos/nvm-sh/nvm/releases/latest
    return_content: yes
  register: nvm_latest

- name: Set NVM version
  set_fact:
    nvm_version: "{{ nvm_latest.json.tag_name | regex_replace('^v', '') }}"

- name: Download and install NVM
  shell: >
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v{{ nvm_version }}/install.sh | bash
  args:
    creates: ~/.nvm/nvm.sh

- name: Install Node.js versions
  shell: |
    source ~/.nvm/nvm.sh
    nvm install {{ item }}
  args:
    executable: /bin/bash
    creates: ~/.nvm/versions/node/{{ item }}
  loop:
    - v22
    - v20
    - v18
    - v16.16.0
    - v10
    - v8.4.0
```

---

### Fases 4-7: Aplicaciones (2-3 horas cada fase)

Estas fases siguen el mismo patrón:

1. Crear role para cada aplicación
2. Usar módulos de Ansible apropiados:
   - `apt` para paquetes del repositorio
   - `snap` para aplicaciones Snap
   - `get_url` + `apt` para .deb externos
   - `unarchive` para archivos tar/zip

#### Ejemplo: Obsidian (AppImage)

```yaml
# roles/obsidian/tasks/main.yml
---
- name: Create applications directory
  file:
    path: ~/Applications
    state: directory

- name: Download Obsidian AppImage
  get_url:
    url: https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.3/Obsidian-1.5.3.AppImage
    dest: ~/Applications/Obsidian.AppImage
    mode: 0755

- name: Create desktop entry
  template:
    src: obsidian.desktop.j2
    dest: ~/.local/share/applications/obsidian.desktop
```

---

### Fase 8: Support Scripts y Master Playbook (2-3 horas)

#### Master Playbook con Tags

```yaml
# playbooks/main.yml
---
- name: Kubuntu Setup - Complete Installation
  hosts: localhost
  become: no

  roles:
    # Phase 1: Core System
    - { role: os_basics, tags: ['phase1', 'core', 'os'] }
    - { role: bash_config, tags: ['phase1', 'core', 'shell'] }
    - { role: zsh, tags: ['phase1', 'core', 'shell'] }
    - { role: git_config, tags: ['phase1', 'core', 'git'] }
    - { role: ssh_config, tags: ['phase1', 'core', 'ssh'] }

    # Phase 2: Desktop
    - { role: kde, tags: ['phase2', 'desktop'] }

    # Phase 3: Development
    - { role: docker, tags: ['phase3', 'dev', 'docker'] }
    - { role: nvm, tags: ['phase3', 'dev', 'nodejs'] }
    - { role: vscode, tags: ['phase3', 'dev', 'editor'] }

    # ... más roles
```

#### Uso con Tags

```bash
# Ejecutar todo
ansible-playbook playbooks/main.yml

# Solo Fase 1
ansible-playbook playbooks/main.yml --tags "phase1"

# Solo Docker
ansible-playbook playbooks/main.yml --tags "docker"

# Desde una fase específica
ansible-playbook playbooks/main.yml --tags "phase3,phase4,phase5"

# Modo dry-run
ansible-playbook playbooks/main.yml --check --diff
```

---

## Variables y Personalización

### Variables Globales

```yaml
# inventory/group_vars/all.yml
---
ansible_user: samuel
home_dir: "/home/{{ ansible_user }}"
setup_repo: "{{ home_dir }}/git/setups/linux-setup"
setup_repo_private: "{{ home_dir }}/git/setups/linux-setup-private"

# Node versions to install
node_versions:
  - v22
  - v20
  - v18
  - v16.16.0
  - v10
  - v8.4.0

# Docker configuration
docker_users:
  - "{{ ansible_user }}"

# Browsers to install
browsers:
  - google-chrome-stable
  - firefox
```

---

## Testing Strategy

### 1. Testing Local con Check Mode

```bash
# Dry-run sin hacer cambios
ansible-playbook playbooks/main.yml --check --diff
```

### 2. Testing en VM con Vagrant

```ruby
# Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbooks/main.yml"
  end
end
```

### 3. Testing en Docker

```dockerfile
# tests/Dockerfile
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y python3 sudo
RUN useradd -m -s /bin/bash samuel
RUN echo "samuel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER samuel
WORKDIR /home/samuel
```

```bash
# Script de testing
docker build -t kubuntu-test tests/
docker run -v $(pwd):/ansible kubuntu-test ansible-playbook /ansible/playbooks/phase1-core-system.yml
```

### 4. Playbook de Verificación

```yaml
# tests/verify-installation.yml
---
- name: Verify installations
  hosts: localhost
  tasks:
    - name: Check if Docker is installed
      command: docker --version
      register: docker_version
      failed_when: docker_version.rc != 0

    - name: Check if NVM is installed
      shell: source ~/.nvm/nvm.sh && nvm --version
      args:
        executable: /bin/bash
      register: nvm_version
      failed_when: nvm_version.rc != 0

    - name: Verify git configuration
      command: git config --get user.name
      register: git_user
      failed_when: git_user.rc != 0
```

---

## Ventajas de Ansible sobre Scripts Shell

### 1. **Idempotencia**
- Ejecutar múltiples veces produce el mismo resultado
- No hay errores si algo ya está instalado

### 2. **Declarativo vs Imperativo**
- Describes el estado deseado, no los pasos
- Más fácil de entender y mantener

### 3. **Gestión de Errores**
- Manejo robusto de errores incorporado
- Rollback automático en muchos casos

### 4. **Modularidad**
- Roles reutilizables
- Fácil compartir entre proyectos

### 5. **Testing**
- Check mode para dry-run
- Fácil testing en VMs/contenedores

### 6. **Variables y Templates**
- Configuración centralizada
- Templates Jinja2 para archivos de configuración

### 7. **Tags**
- Ejecución selectiva
- Fácil ejecutar solo partes específicas

---

## Comparación: Shell Script vs Ansible

### Script Shell Actual

```bash
#!/bin/bash
echo -e '\nInstalling docker\n'
for pkg in docker.io docker-doc; do 
    sudo apt-get remove $pkg
done || if [ ${?} -gt 0 ]; then exit 1; fi

sudo apt-get update || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install docker-ce || if [ ${?} -gt 0 ]; then exit 1; fi
```

**Problemas:**
- No es idempotente (falla si ya está instalado)
- Manejo de errores verboso
- Difícil de testear

### Ansible Equivalente

```yaml
---
- name: Remove old Docker packages
  apt:
    name:
      - docker.io
      - docker-doc
    state: absent
  become: yes

- name: Install Docker
  apt:
    name: docker-ce
    state: present
    update_cache: yes
  become: yes
```

**Ventajas:**
- Idempotente automáticamente
- Manejo de errores incorporado
- Fácil de leer y mantener
- Testeable con `--check`

---

## Cronograma Estimado

| Fase | Tiempo Estimado | Acumulado |
|------|----------------|-----------|
| Fase 0: Preparación | 1-2 horas | 2h |
| Fase 1: Core System | 2-4 horas | 6h |
| Fase 2: Desktop | 2-3 horas | 9h |
| Fase 3: Dev Tools | 3-5 horas | 14h |
| Fase 4: Browsers | 1-2 horas | 16h |
| Fase 5: Work Tools | 2-3 horas | 19h |
| Fase 6: Productivity | 2-3 horas | 22h |
| Fase 7: Media | 1-2 horas | 24h |
| Fase 8: Integration | 2-3 horas | 27h |
| Fase 9: Cleanup | 1 hora | 28h |

**Total: 24-28 horas** (3-4 días de trabajo)

---

## Próximos Pasos

1. **Revisar y aprobar este plan**
2. **Decidir estrategia de testing** (VM, Docker, o sistema real)
3. **Comenzar con Fase 0**: Setup de Ansible
4. **Iterar fase por fase** con testing entre cada una

---

## Preguntas para el Usuario

> [!IMPORTANT]
> Antes de comenzar, necesito tu feedback sobre:

1. **¿Prefieres mantener `stow` para dotfiles o migrar a gestión nativa de Ansible?**
   - Mantener stow: más compatible con setup actual
   - Ansible nativo: más integrado, pero requiere más cambios

2. **¿Qué método de testing prefieres?**
   - VM con Vagrant (más realista)
   - Docker (más rápido)
   - Sistema real con `--check` mode (más arriesgado)

3. **¿Hay scripts que son críticos y deben migrarse primero?**
   - Por ejemplo, si usas Docker diariamente, podríamos priorizar Fase 3

4. **¿Quieres mantener los scripts shell como respaldo permanente o eliminarlos eventualmente?**
   - Coexistencia permanente
   - Deprecación gradual
   - Eliminación completa tras validación

5. **¿Tienes experiencia previa con Ansible?**
   - Esto ayuda a ajustar el nivel de detalle en la documentación
