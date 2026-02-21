#!/bin/bash
set -e

echo "Mise à jour et installation des dépendances"
sudo apt update
sudo apt install -y curl wget git tar unzip sudo


mkdir -p ~/actions-runner
cd ~/actions-runner

echo "Télécharger le runner GitHub"
curl -o actions-runner-linux-x64-2.331.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.331.0/actions-runner-linux-x64-2.331.0.tar.gz

echo "Extraire le runner"
tar xzf actions-runner-linux-x64-2.331.0.tar.gz

./config.sh remove --unattended || true #true empêche le script de s’arrêter si aucun runner n’existe.

echo "Configurer le runner"
./config.sh --url https://github.com/Alpha-balde/latex-ci --token AKMEQ2VPU5PSATSKMF7YBT3JTD4XW --unattended --name latex-runner --labels self-hosted

echo "Installer et démarrer le service systemd"
sudo ./svc.sh install
sudo ./svc.sh start
