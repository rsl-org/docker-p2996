#!/usr/bin/env bash
set -e

echo "Creating user: $LOCAL_USER with UID: $LOCAL_UID and GID: $LOCAL_GID"

if ! getent group "$LOCAL_GID" >/dev/null 2>&1; then
  groupadd -g "$LOCAL_GID" "$LOCAL_USER"
fi

if ! id -u "$LOCAL_USER" >/dev/null 2>&1; then
  useradd -u "$LOCAL_UID" -g "$LOCAL_GID" -G wheel -d $LOCAL_HOME -s /bin/zsh "$LOCAL_USER"
fi

if ! grep -q '^%wheel ALL=(ALL) NOPASSWD:ALL' /etc/sudoers; then
  echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
fi

chown -R $LOCAL_USER:$LOCAL_GID $LOCAL_HOME
sudo -u $LOCAL_USER ZSH=$LOCAL_HOME/.oh-my-zsh sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sed -i 's/robbyrussell/eastwood/g' $LOCAL_HOME/.zshrc