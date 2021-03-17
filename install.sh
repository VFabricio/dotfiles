#! /usr/bin/env bash

make_symlink()
{
  local full_dotfile=$1
  local full_target=$2

  echo "Linking $full_target to $full_dotfile..."
  if [[ $dry_run == false ]]; then
    ln -sf $full_dotfile $full_target
  fi
}

install()
{
  local dotfile_path=$1
  local dotfile=$2
  local target_path=$3

  local full_target
  if [[ $4 == "--dotted" ]]; then
    full_target="$target_path/.$dotfile"
  else
    full_target="$target_path/$dotfile"
  fi

  if [[ -e $full_target ]]; then
    echo "Target $full_target already exists. Should it be overwritten? [y/n]"
    local option
    read -n 1 option
    printf '\n'
    if [[ $option == 'y' ]]; then
      make_symlink "$dotfile_path/$dotfile" $full_target
    else
      echo "Skipping $dotfile..."
    fi
  else
    make_symlink "$dotfile_path/$dotfile" $full_target
  fi
}

if [[ -z $HOME ]]; then
  echo 'This script requires the $HOME variable to be set. Set it to your personal directory and try again.'
  exit 0
fi

dotfiles_path=$(pwd)
dry_run=true
while getopts "f" option; do
  case $option in
    f)
      dry_run=false
    ;;
    *)
      echo "Usage: ./install.sh [-f]. By default, it does a dry run. To actually install the files use the -f flag."
      exit 0
    ;;
  esac
done

if [[ $dry_run == true ]]; then
  echo "Doing a dry run. Use ./install.sh -f to really install the files."
fi

install "${dotfiles_path}/alacritty" "alacritty.yml" "$HOME/.config/alacritty"
install "${dotfiles_path}/dunst" "dunstrc" "$HOME/.config/dunst"
install "${dotfiles_path}/fish" "config.fish" "$HOME/.config/fish"
install "${dotfiles_path}/git" "gitconfig" "$HOME" --dotted
install "${dotfiles_path}/i3" "config" "$HOME/.config/i3"
install "${dotfiles_path}/kitty" "kitty.conf" "$HOME/.config/kitty"
install "${dotfiles_path}/nvim" "init.vim" "$HOME/.config/nvim"
install "${dotfiles_path}/nvim" "coc-settings.json" "$HOME/.config/nvim"
install "${dotfiles_path}/polybar" "config" "$HOME/.config/polybar"
install "${dotfiles_path}/rofi" "oxide.rasi" "$HOME/.config/rofi"
install "${dotfiles_path}/tmux" "tmux.conf" "$HOME" --dotted
install "${dotfiles_path}/polybar-scripts" "player-mpris-tail.py" "$HOME/Scripts/polybar-scripts"
