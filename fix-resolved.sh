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

sudo chmod +x fix-resolved.sh

