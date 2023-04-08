#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Run as Root. E.g: sudo $0"
  exit
if

# Install softwares
echo "-> Installing necessary packages.."
apt install \
  bat btop build-essential \
  cmake cmatrix curl \
  exa \
  fd-find findutils fonts-ubuntu fzf \
  g++ gettext git \
  libtool-bin \
  make \
  ninja-build ncurses-term npm \
  openssh-server openssh-sftp-server \
  pkg-config python3 python3-pip \
  ripgrep \
  show-motd ssh-import-id stow \
  taskwarrior-tui taskwarrior texinfo timewarrior tmux tree \
  unzip update-motd

# Install neovim nightly; Pre-requisites already installed from above package installation
function install_neovim_nightly() {
  echo "-> Installing Neovim Nightly.."
  mkdir ~/TempFold && pushd $_
  echo "-> # Cloning neovim repo.."
  git clone "https://github.com/neovim/neovim"
  cd neovim
  echo "-> # Building neovim nightly.."
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  make install
  echo "-> # Done.."
  popd
  echo "-> # Cleaning up files.."
  rm -rf ~/TempFold
}

function install_lunarvim() {
  echo "-> Installing LunarVim.."
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
}

function setup_configs() {
  # Setting up lunarvim, tmux, starship-prompt and bash configs using stow
  echo "-> Setting up Dotfiles.."
  cd ~
  git clone "https://github.com/aniketgm/Dotfiles"
  pushd Dotfiles
  stow lunarvim --target=~
  echo "-> # LunarVim done.."
  stow tmux --target=~
  echo "-> # Tmux done.."
  stow bash --target=~
  echo "-> # Bash done.."
  stow starship-prompt --target=~
  echo "-> # Starship-Prompt done.."
  popd

  # Clone tmux packages
  echo "-> # Cloning tmux dependencies.."
  [ ! -d "~/.local/share" ] && mkdir -p ~/.local/share
  pushd ~/.local/share
  git clone https://github.com/tmux-plugins/tmux-resurrect
  git clone https://github.com/tmux-plugins/tmux-continuum
  popd
  echo "-> # Done.."
}

if ! command -v nvim &> /dev/null; then
  install_neovim_nightly
fi

if ! command -v lvim &> /dev/null; then
  install_lunarvim
fi

setup_configs

