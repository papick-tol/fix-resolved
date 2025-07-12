Встановлення Home Assistant Supervised
Лінукс ставити краше з лайфСД з вже запущеного дебіан.
https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/debian-live-12.11.0-amd64-xfce.iso
https://github.com/pbatard/rufus/releases/download/v4.9/rufus-4.9p.exe

#==================================================================================================
apt-get update
#
sudo apt install openssh-server mc
#
sudo apt-get install apparmor jq wget curl udisks2 libglib2.0-bin network-manager dbus lsb-release systemd-journal-remote -y
#
curl -fsSL get.docker.com | sh
#
sudo docker run hello-world
#
wget https://raw.githubusercontent.com/papick-tol/fix-resolved/refs/heads/main/fix-resolved.sh
#
wget https://github.com/home-assistant/os-agent/releases/download/1.7.2/os-agent_1.7.2_linux_x86_64.deb
#
sudo dpkg -i os-agent_1.7.2_linux_x86_64.deb
#
wget https://github.com/home-assistant/supervised-installer/releases/latest/download/homeassistant-supervised.deb
#
sudo apt install ./homeassistant-supervised.deb
	Setting up homeassistant-supervised (3.1.0) ...
	[info] Reload systemd
	[info] Restarting NetworkManager
	[info] Enable systemd-resolved
	[info] Restarting systemd-resolved
	[info] Set up systemd-journal-gatewayd socket file
	[info] Enable systemd-journal-gatewayd
	[info] Start nfs-utils.service
	[info] Restarting docker service
	[info] Waiting for https://checkonline.home-assistant.io/online.txt - network interface might be down...

#
Відкрити новий термінал і в ньому:
#
??? якщо нема fix-resolved.sh
# створити:
 nano fix-resolved.sh
#

#!/bin/bash

echo "🔧 Відновлення systemd-resolved та resolv.conf..."

# Зняття захисту, якщо встановлено
sudo chattr -i /etc/resolv.conf 2>/dev/null

# Видалення існуючого файлу
sudo rm -f /etc/resolv.conf

# Створення правильного символічного посилання
sudo ln -s /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# Увімкнення та запуск systemd-resolved
sudo systemctl unmask systemd-resolved
sudo systemctl enable systemd-resolved --now

# Додавання DNS до конфігурації
sudo sed -i '/^\[Resolve\]/,/^\[/ s/^#\?DNS=.*$/DNS=8.8.8.8 1.1.1.1/' /etc/systemd/resolved.conf || echo -e "[Resolve]\nDNS=8.8.8.8 1.1.1.1" | sudo tee -a /etc/systemd/resolved.conf

# Перезапуск служби
sudo systemctl restart systemd-resolved

# Перезапуск hassio-supervisor
sudo systemctl restart hassio-supervisor

echo "✅ Готово! Перевір: resolvectl status і /etc/resolv.conf"
#
#=====================================================================
#
F2
#
y 
#
ентер

sudo chmod +x fix-resolved.sh
#
sudo ./fix-resolved.sh
#
