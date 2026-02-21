#!/bin/bash
set -e

echo "vagrant ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/vagrant
sudo chmod 440 /etc/sudoers.d/vagrant

# Ajouter l'utilisateur vagrant au groupe docker
sudo usermod -aG docker vagrant || true

# Met à jour les packages et installe les dépendances
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

# Ajouter la clé GPG et le dépôt officiel Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Installer Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin



# Vérifier l'installation
docker --version