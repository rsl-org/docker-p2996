FROM ghcr.io/rsl-org/fedora_p2996:latest

RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# zsh for root
RUN dnf install -y zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN sed -i 's/robbyrussell/eastwood/g' /root/.zshrc
RUN chsh -s /bin/zsh

# local user setup helper
COPY setup_user.sh /setup_user.sh
RUN chmod a+x /setup_user.sh

# vscode extension development
RUN dnf install -y nodejs npm
RUN npm install --global yo generator-code