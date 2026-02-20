# Ansible Migration Task List

## Step 1: Core System (Priority 1) ✅
- [x] Migrate `00-os-basics.sh` (os_basics)
- [x] Migrate `10-bash.sh`, `12-zsh.sh` (bash/zsh)
- [x] Migrate `13-git.sh`, `15-ssh.sh` (git/ssh)
- [x] Migrate `70-keepass.sh` (keepass)
- [x] Migrate `20-rclone.sh` (rclone)
- [x] Test Step 1 on fresh VM/container

## Step 2: Desktop and Media (Priority 1) ✅
- [x] Migrate `14-kde.sh` (kde)
- [x] Migrate `80-safeeyes.sh` (safeeyes)
- [x] Migrate `switch-between-audio-outputs.sh` (switch_audios)
- [x] Migrate `16-browsers.sh` (browsers)
- [x] Migrate `71-libreoffice.sh`, `72-okular.sh` (libreoffice/okular)
- [x] Migrate `90-vlc.sh`, `91-pinta.sh`, `92-obs-studio.sh` (vlc/pinta/obs_studio)
- [x] Test Step 2 on fresh VM/container

## Step 3: Development Tools (Priority 2) ✅
- [x] Migrate `30-docker.sh` (docker)
- [x] Migrate `35-nvm.sh` (nvm)
- [x] Migrate `36-vscode.sh`, `36-antigravity.sh` (vscode/antigravity)
- [x] Migrate Python role (python)
- [x] Migrate `60-immfly-wifec.sh` (immfly_setup)
- [x] Migrate `17-personal-repositories.sh` (personal_repos)
- [x] Test Step 3 on fresh VM/container

## Step 4: Work and Productivity (Priority 3) ✅
- [x] Migrate `37-amqp-tools.sh` (amqp_tools)
- [x] Migrate `50-wifec-open-vpn.sh` (wifec_vpn)
- [x] Migrate `66-wifec-kubernetes.sh` (kubernetes_tools)
- [x] Migrate `93.discord.sh` (discord)
- [x] Migrate `61-obsidian.sh` (obsidian)
- [x] Migrate `62-postman.sh`, `63-sqlectron.sh` (postman/sqlectron)
- [x] Test Step 4 on fresh VM/container

## Final Integration and Documentation
- [x] Create master playbook (`main.yml`)
- [ ] Create documentation for running playbooks
- [ ] Full end-to-end test on fresh VM
- [x] Update README with Ansible instructions

## Cleanup and Deprecation
- [ ] Mark old shell scripts as deprecated
- [ ] Create migration guide
- [ ] Archive shell scripts (optional)
