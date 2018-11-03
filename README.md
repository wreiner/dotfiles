# dotfiles

Various dotfiles for Linux users deployed using GNU stow.

## Usage

### Install and configure sudo

If not already done by the installation, install *sudo* with your package manager.

Add the configuration to a file in */etc/sudoers.d*:

```
%sudo ALL=(ALL) ALL
```

### Install ansible

Install ansible with your package manager.

### Copy playbook to host and run ansible

```
wget https://gitlab.com/wreiner/dotfiles/raw/master/ansible/setup-new-user.yml -P /tmp
ansible-playbook -K /tmp/setup-new-user.yml
```
