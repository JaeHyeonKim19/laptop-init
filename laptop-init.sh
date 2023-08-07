#!/bin/bash

# chmod +x laptop-init.sh

echo "laptop init script start"

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo "Homebre is already installed."
fi

applications_folder="/Applications"
# Check if iterm2 is installed
if [ ! -d "$applications_folder/iTerm.app" ]; then
    echo "iterm2 is not installed. Installing iterm2..."
    brew install --cask iterm2
else
    echo "itemr2 is already installed."
fi

omz_path="$HOME/.oh-my-zsh"
# Check if oh-my-zsh is installed
if [ ! -d "$omz_path" ]; then
    echo "Oh-My-Zsh is not installed. Installing Oh-My_Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh-My-Zsh is already installed."
fi

zshrc_file="$HOME/.zshrc"
# Check if the ~/.zshrc file exists
if [ -f "$zshrc_file" ]; then
    # Backup the original ~/.zshrc file
    cp "$zshrc_file" "$zshrc_file.bak"

    # Update ZSH_THEME to "agnoster"
    sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="agnoster"/' "$zshrc_file"

    echo "ZSH_THEME has been set to 'agnoster' in ~/.zshrc."
else
    echo "The ~/.zshrc file does not exist. Make sure Zsh is installed and configured properly."
fi

autosuggestions_repo_url="https://github.com/zsh-users/zsh-autosuggestions"
omz_destination_path="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
# Clone the zsh-autosuggestions repository

# Check if zsh-autosuggestions is installed
if ! grep -q "zsh-autosuggestions" ~/.zshrc; then
    echo "zsh-autosuggestions plugin is not installed."
    git clone "$autosuggestions_repo_url" "$omz_destination_path"
    sed -i '' '/^plugins=(/ s/)$/ zsh-autosuggestions)/' ~/.zshrc
else
    echo "zsh-autosuggestions plugin is installed."
fi

highlighting_repo_url="https://github.com/zsh-users/zsh-syntax-highlighting.git"
zsh_destination_path="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

# Check if the zsh-syntax-highlighting plugin is already installed
if [ -d "$zsh_destination_path" ]; then
    echo "zsh-syntax-highlighting plugin is already installed."
else
    # Clone the zsh-syntax-highlighting repository
    git clone "$highlighting_repo_url" "$zsh_destination_path"

    # Add the plugin to the list of plugins in ~/.zshrc
    echo "source $zsh_destination_path/zsh-syntax-highlighting.zsh" >> ~/.zshrc
    echo "zsh-syntax-highlighting plugin has been added to ~/.zshrc."
fi

# Enable syntax highlighting in the current interactive shell
# source "$zsh_destination_path/zsh-syntax-highlighting.zsh"

echo "laptop init script end. Please restart terminal and Don't forget setting iterm2 preferences(font, coler, etc...)"
