#!/usr/bin/env bash
set -e

echo "Creating user: $LOCAL_USER with UID: $LOCAL_UID and GID: $LOCAL_GID"

if ! getent group "$LOCAL_GID" >/dev/null 2>&1; then
  groupadd -g "$LOCAL_GID" "$LOCAL_USER"
fi

if ! id -u "$LOCAL_USER" >/dev/null 2>&1; then
  useradd -u "$LOCAL_UID" -g "$LOCAL_GID" -G wheel -d "$LOCAL_HOME" -s /bin/zsh "$LOCAL_USER"
fi

if ! grep -q '^%wheel ALL=(ALL) NOPASSWD:ALL' /etc/sudoers; then
  echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
fi

mkdir -p "$LOCAL_HOME"/.conan2/profiles
cp /root/.conan2/profiles/* "$LOCAL_HOME"/.conan2/profiles

chown -R "$LOCAL_USER":"$LOCAL_USER" "$LOCAL_HOME"
# local conan repository for in-dev versions of dependencies
sudo -u "$LOCAL_USER" git clone https://github.com/rsl-org/conan "$LOCAL_HOME"/conan-repository
sudo -u "$LOCAL_USER" conan remote add rsl "$LOCAL_HOME"/conan-repository

chown -R "$LOCAL_USER":"$LOCAL_GID" "$LOCAL_HOME"
sudo -u "$LOCAL_USER" ZSH="$LOCAL_HOME"/.oh-my-zsh sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sed -i 's/robbyrussell/eastwood/g' "$LOCAL_HOME"/.zshrc

echo "export PATH=\"/usr/bin:$PATH\"" >> "$LOCAL_HOME"/.zshrc
echo "export LD_LIBRARY_PATH=\"/usr/lib/x86_64-unknown-linux-gnu:$LD_LIBRARY_PATH\"" >> "$LOCAL_HOME"/.zshrc