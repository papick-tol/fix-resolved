
Встановлення Home Assistant Supervised

Лінукс ставити краше з лайфСД з вже запущеного дебіан.

https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/debian-live-12.11.0-amd64-xfce.iso

Розгортати на флешку цим:

https://github.com/pbatard/rufus/releases/download/v4.9/rufus-4.9p.exe

![clipboard_image_996bc57497e4d8536442a330d2bec0b8](https://github.com/user-attachments/assets/e82ed72e-88af-4ec6-b689-0cc79a35f6b3)
![clipboard_image_8329ae04268fbacf2968e429b6d33e74](https://github.com/user-attachments/assets/aa48e0d7-d025-464a-9039-aa6658d71629)
![clipboard_image_9291ad488a7856b9fc21bb1d32d93439](https://github.com/user-attachments/assets/1f11c5d2-8ea7-44dd-9afa-e45a03ef9e1d)
![clipboard_image_9f5c1f8c2ea79b1155ba7b10ae79768d](https://github.com/user-attachments/assets/fac46827-1839-4659-b342-c1437911c491)
![clipboard_image_2c94d405f884ef7aff734b1646467db5](https://github.com/user-attachments/assets/03a9151c-44c0-42c6-a3c8-2c7e9d4d7384)
<img width="1281" height="801" alt="clipboard_image_4c226ba7612232a1489615dd4bd16bf3" src="https://github.com/user-attachments/assets/d8fbee2a-b463-4f18-9459-389f57347e98" />
![clipboard_image_de14c307fe93659e9071db0a7918e90c](https://github.com/user-attachments/assets/f4938412-43e8-4ae0-a3bb-5ff98e77d8fd)

Лінукс ставити краше з лайфСД з вже запущеного дебіан.

https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/debian-live-12.11.0-amd64-xfce.iso

https://github.com/pbatard/rufus/releases/download/v4.9/rufus-4.9p.exe

#=====================================================================
#
sudo apt-get update
# Ставимо SSH (задно і Midnight Commander) після цього можна вже під'єднатися по мережі Putty:

sudo apt install openssh-server mc

дізнатися ІР адресу можна командою

ip a

# Тепер можна під'єднатися Putty і дали копи-паст: 
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
 
	[info] Waiting for https://checkonline.home-assistant.io/online.txt - network interface might be down...
 
	[info] Waiting for https://checkonline.home-assistant.io/online.txt - network interface might be down...
  
	[info] Waiting for https://checkonline.home-assistant.io/online.txt - network interface might be down...
#
Коли застряне на: 

[info] Waiting for https://checkonline.home-assistant.io/online.txt - network interface might be down...

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
# далі натиснути:
F2
#
y 
#
ентер

# виконати fix-resolved.sh

sudo chmod +x fix-resolved.sh
#
sudo ./fix-resolved.sh
#
