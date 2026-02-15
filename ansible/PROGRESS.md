# Ansible Migration Task List

## Phase 0: Setup and Preparation
- [x] Create Ansible project structure
- [x] Set up inventory and configuration files
- [x] Create testing framework
- [x] Document testing procedure

## Phase 1: Core System Setup (Priority 1) ✅
- [x] Migrate `00-os-basics.sh` (GRUB, stow, networking tools)
- [x] Migrate `10-bash.sh` (bash configuration)
- [x] Migrate `12-zsh.sh` (zsh installation and config)
- [x] Migrate `13-git.sh` (git configuration with stow)
- [x] Migrate `15-ssh.sh` (SSH configuration)
- [x] Test Phase 1 on fresh VM/container

## Verificación de Fase 1 ✅

El playbook `phase1-core-system.yml` se ejecutó correctamente en Docker:
- ✅ **os_basics**: GRUB backup, stow y herramientas de red (nmap, net-tools, etc.)
- ✅ **bash_config**: Dotfiles de bash desplegados con stow.
- ✅ **zsh**: oh-my-zsh, plugins, fzf, fasd y **eza** (vía repo oficial).
- ✅ **git_config**: Configuración de git desplegada.
- ✅ **ssh_config**: Manejo robusto de directorios privados (se salta si no existen).


## Phase 2: Desktop Environment (Priority 1)
- [ ] Migrate `14-kde.sh` (KDE configuration)
- [ ] Migrate dotfiles deployment (bash, git, kde, keepass, safeeyes, vscode, zsh)
- [ ] Test Phase 2 on fresh VM/container

## Verificación de Inicialización ✅

El script `init.sh` se ejecutó correctamente en Docker y verificó:
- ✅ Instalación de Git
- ✅ Instalación de Ansible 2.10.8
- ✅ Sudo funciona correctamente
- ✅ Variables cargadas
- ✅ Estructura de directorios lista

## Phase 3: Development Tools (Priority 2)
- [ ] Migrate `30-docker.sh` (Docker installation and configuration)
- [ ] Migrate `35-nvm.sh` (NVM and Node.js versions)
- [ ] Migrate `36-vscode.sh` (VS Code installation)
- [ ] Migrate `36-antigravity.sh` (Antigravity setup)
- [ ] Test Phase 3 on fresh VM/container

## Phase 4: Browsers and Communication (Priority 2)
- [ ] Migrate `16-browsers.sh` (browser installations)
- [ ] Migrate `93.discord.sh` (Discord)
- [ ] Test Phase 4 on fresh VM/container

## Phase 5: Work-Specific Tools (Priority 3)
- [ ] Migrate `17-personal-repositories.sh`
- [ ] Migrate `37-amqp-tools.sh`
- [ ] Migrate `50-wifec-open-vpn.sh`
- [ ] Migrate `60-immfly-wifec.sh`
- [ ] Migrate `66-viasat-vpn.sh`
- [ ] Migrate `66-wifec-kubernetes.sh`
- [ ] Test Phase 5 on fresh VM/container

## Phase 6: Productivity Applications (Priority 3)
- [ ] Migrate `20-rclone.sh`
- [ ] Migrate `61-obsidian.sh`
- [ ] Migrate `62-postman.sh`
- [ ] Migrate `63-sqlectron.sh`
- [ ] Migrate `65-real-vnc.sh`
- [ ] Migrate `70-keepass.sh`
- [ ] Migrate `71-libreoffice.sh`
- [ ] Migrate `72-okular.sh`
- [ ] Test Phase 6 on fresh VM/container

## Phase 7: Media and Utilities (Priority 4)
- [ ] Migrate `80-safeeyes.sh`
- [ ] Migrate `90-vlc.sh`
- [ ] Migrate `91-pinta.sh`
- [ ] Migrate `92-obs-studio.sh`
- [ ] Test Phase 7 on fresh VM/container

## Phase 8: Support Scripts and Final Integration
- [ ] Migrate support scripts (setvpn.sh, switch-between-audio-outputs.sh, update-.air-repos.sh)
- [ ] Create master playbook with tags for selective execution
- [ ] Create documentation for running playbooks
- [ ] Full end-to-end test on fresh VM
- [ ] Update README with Ansible instructions

## Phase 9: Cleanup and Deprecation
- [ ] Mark old shell scripts as deprecated
- [ ] Create migration guide
- [ ] Archive shell scripts (optional)
