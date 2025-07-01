FROM ghcr.io/rsl-org/fedora_p2996:latest

RUN dnf install -y zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN sed -i 's/robbyrussell/eastwood/g' /root/.zshrc
RUN chsh -s /bin/zsh