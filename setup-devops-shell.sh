#!/bin/bash

# Ultimate Zsh + Powerlevel10k Setup Script
# For the DevOps legends who want the best terminal experience!
# Compatible with macOS, Ubuntu, Debian, CentOS, RHEL, and Arch Linux

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_banner() {
    echo -e "${PURPLE}"
    echo "================================================"
    echo "   🚀 DevOps Terminal Setup Script 🚀"
    echo "   Zsh + Powerlevel10k + Oh My Zsh"
    echo "================================================"
    echo -e "${NC}"
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ -f /etc/debian_version ]]; then
        OS="debian"
    elif [[ -f /etc/redhat-release ]]; then
        OS="redhat"
    elif [[ -f /etc/arch-release ]]; then
        OS="arch"
    else
        OS="unknown"
    fi
    print_status "Detected OS: $OS"
}

# Install dependencies based on OS
install_dependencies() {
    print_status "Installing dependencies..."
    
    case $OS in
        "macos")
            if ! command -v brew &> /dev/null; then
                print_status "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            brew install zsh git curl wget
            ;;
        "debian")
            sudo apt update
            sudo apt install -y zsh git curl wget fontconfig
            ;;
        "redhat")
            sudo yum install -y zsh git curl wget fontconfig || sudo dnf install -y zsh git curl wget fontconfig
            ;;
        "arch")
            sudo pacman -Sy --noconfirm zsh git curl wget fontconfig
            ;;
        *)
            print_error "Unsupported OS. Please install zsh, git, curl, and wget manually."
            exit 1
            ;;
    esac
    
    print_success "Dependencies installed!"
}

# Install Nerd Fonts (essential for Powerlevel10k icons)
install_nerd_fonts() {
    print_status "Installing Nerd Fonts..."
    
    FONT_DIR=""
    case $OS in
        "macos")
            FONT_DIR="$HOME/Library/Fonts"
            ;;
        *)
            FONT_DIR="$HOME/.local/share/fonts"
            mkdir -p "$FONT_DIR"
            ;;
    esac
    
    # Download MesloLGS NF fonts (recommended by Powerlevel10k)
    cd /tmp
    curl -fLo "MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    curl -fLo "MesloLGS NF Bold.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    curl -fLo "MesloLGS NF Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    curl -fLo "MesloLGS NF Bold Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
    
    mv MesloLGS*.ttf "$FONT_DIR/"
    
    # Refresh font cache on Linux
    if [[ "$OS" != "macos" ]]; then
        fc-cache -fv
    fi
    
    print_success "Nerd Fonts installed!"
    print_warning "Please set your terminal font to 'MesloLGS NF' for the best experience!"
}

# Install Oh My Zsh
install_oh_my_zsh() {
    print_status "Installing Oh My Zsh..."
    
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        print_warning "Oh My Zsh already installed, backing up existing config..."
        cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)" 2>/dev/null || true
    fi
    
    # Install Oh My Zsh non-interactively
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    print_success "Oh My Zsh installed!"
}

# Install Powerlevel10k theme
install_powerlevel10k() {
    print_status "Installing Powerlevel10k theme..."
    
    # Clone Powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    
    print_success "Powerlevel10k installed!"
}

# Install useful Zsh plugins
install_zsh_plugins() {
    print_status "Installing essential Zsh plugins..."
    
    ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
    
    # zsh-autosuggestions
    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    fi
    
    # zsh-syntax-highlighting
    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    fi
    
    # zsh-completions
    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]]; then
        git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
    fi
    
    # fzf for fuzzy finding (amazing for command history!)
    if [[ ! -d "$HOME/.fzf" ]]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all
    fi
    
    print_success "Zsh plugins installed!"
}

# Configure autocomplete for DevOps tools
configure_autocomplete() {
    print_status "Setting up autocomplete for DevOps tools..."
    
    COMPLETION_DIR="$HOME/.zsh/completions"
    mkdir -p "$COMPLETION_DIR"
    
    # kubectl completion (if kubectl is installed)
    if command -v kubectl &> /dev/null; then
        kubectl completion zsh > "$COMPLETION_DIR/_kubectl"
        print_status "✅ kubectl autocomplete configured"
    fi
    
    # helm completion (if helm is installed)
    if command -v helm &> /dev/null; then
        helm completion zsh > "$COMPLETION_DIR/_helm"
        print_status "✅ helm autocomplete configured"
    fi
    
    # terraform completion (if terraform is installed)
    if command -v terraform &> /dev/null; then
        terraform -install-autocomplete 2>/dev/null || true
        print_status "✅ terraform autocomplete configured"
    fi
    
    # docker completion (if docker is installed)
    if command -v docker &> /dev/null; then
        curl -fsSL https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker > "$COMPLETION_DIR/_docker" 2>/dev/null || true
        print_status "✅ docker autocomplete configured"
    fi
    
    # docker-compose completion
    if command -v docker-compose &> /dev/null; then
        curl -fsSL https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose > "$COMPLETION_DIR/_docker-compose" 2>/dev/null || true
        print_status "✅ docker-compose autocomplete configured"
    fi
    
    # AWS CLI completion (if aws is installed)
    if command -v aws &> /dev/null; then
        # AWS CLI v2 has built-in completion
        print_status "✅ AWS CLI autocomplete will be configured in .zshrc"
    fi
    
    # gcloud completion (if gcloud is installed)
    if command -v gcloud &> /dev/null; then
        gcloud completion zsh > "$COMPLETION_DIR/_gcloud" 2>/dev/null || true
        print_status "✅ gcloud autocomplete configured"
    fi
    
    # az completion (if azure cli is installed)
    if command -v az &> /dev/null; then
        az completion --shell zsh > "$COMPLETION_DIR/_az" 2>/dev/null || true
        print_status "✅ Azure CLI autocomplete configured"
    fi
    
    print_success "DevOps tools autocomplete configured!"
}

# Configure .zshrc with our awesome setup
configure_zshrc() {
    print_status "Configuring .zshrc with DevOps-optimized settings..."
    
    cat > "$HOME/.zshrc" << 'EOF'
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins for DevOps productivity
plugins=(
    git
    docker
    docker-compose
    kubectl
    helm
    terraform
    aws
    azure
    gcloud
    node
    npm
    python
    pip
    golang
    rust
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    history-substring-search
    command-not-found
    sudo
    web-search
    jsontools
    urltools
    encode64
    fzf
)

source $ZSH/oh-my-zsh.sh

# ===============================================
# AUTOCOMPLETE CONFIGURATION (DevOps Edition!)
# ===============================================

# Enable completion system
autoload -Uz compinit
compinit

# Add custom completions directory to fpath
fpath=($HOME/.zsh/completions $fpath)

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Menu selection for completions
zstyle ':completion:*' menu select

# Colorful completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Group completions by category
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'

# Better kubectl completion
if command -v kubectl &> /dev/null; then
    source <(kubectl completion zsh)
    complete -F __kubectl k  # Enable completion for 'k' alias
fi

# Helm completion
if command -v helm &> /dev/null; then
    source <(helm completion zsh)
fi

# AWS CLI completion
if command -v aws &> /dev/null; then
    complete -C aws_completer aws
fi

# Azure CLI completion  
if [[ -f /usr/local/etc/bash_completion.d/az ]]; then
    autoload -U +X bashcompinit && bashcompinit
    source /usr/local/etc/bash_completion.d/az
fi

# Google Cloud completion
if [[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]]; then
    source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# Terraform completion (if installed via terraform -install-autocomplete)
if [[ -f ~/.terraform.d/terraform_autocomplete ]]; then
    autoload -U +X bashcompinit && bashcompinit
    complete -C terraform terraform
    complete -C terraform tf  # Enable completion for 'tf' alias
fi

# Docker and Docker Compose completion
if [[ -f ~/.zsh/completions/_docker ]]; then
    source ~/.zsh/completions/_docker
fi
if [[ -f ~/.zsh/completions/_docker-compose ]]; then
    source ~/.zsh/completions/_docker-compose
fi

# Enable history-based autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# User configuration
export LANG=en_US.UTF-8
export EDITOR='vim'

# DevOps aliases for productivity
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kd='kubectl describe'
alias ke='kubectl edit'
alias kl='kubectl logs'
alias kx='kubectl exec -it'
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfv='terraform validate'
alias tff='terraform fmt'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias dcr='docker-compose restart'
alias dps='docker ps'
alias dpa='docker ps -a'
alias dim='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dstop='docker stop $(docker ps -q)'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate --all'
alias gdiff='git diff'
alias gstash='git stash'

# Kubernetes context switching
alias kctx='kubectl config use-context'
alias kns='kubectl config set-context --current --namespace'

# Environment variables for tools
export PATH="$HOME/.local/bin:$PATH"

# FZF configuration for fuzzy finding
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_OPTS="--preview 'cat {}' --preview-window=right:60%"

# History configuration for better autocomplete
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load FZF if installed
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
EOF
    
    print_success ".zshrc configured with comprehensive autocomplete support!"
}

# Create a basic Powerlevel10k config
create_p10k_config() {
    print_status "Creating Powerlevel10k configuration..."
    
    cat > "$HOME/.p10k.zsh" << 'EOF'
# Powerlevel10k DevOps Configuration
if [[ -o 'aliases' ]]; then
  'builtin' 'unsetopt' 'aliases'
  local p10k_lean_restore_aliases=1
else
  local p10k_lean_restore_aliases=0
fi

() {
  emulate -L zsh -o extended_glob

  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  # The list of segments shown on the left.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    os_icon                 # os identifier
    dir                     # current directory
    vcs                     # git status
    newline                 # \n
    prompt_char             # prompt symbol
  )

  # The list of segments shown on the right.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status                  # exit code of the last command
    command_execution_time  # duration of the last command
    background_jobs         # presence of background jobs
    context                 # user@hostname
    time                    # current time
  )

  # Basic style options
  typeset -g POWERLEVEL9K_MODE=nerdfont-complete
  typeset -g POWERLEVEL9K_ICON_PADDING=moderate
  typeset -g POWERLEVEL9K_BACKGROUND=
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=
  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION='${P9K_VISUAL_IDENTIFIER// }'
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

  # Directory configuration
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=31
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=

  # Git configuration
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=76
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=76
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=178

  # Command execution time
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=101

  # Status
  typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
  typeset -g POWERLEVEL9K_STATUS_OK=false
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=9

  # Time
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=66
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'

  # Prompt char
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=76
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=196
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
}

(( ! p10k_lean_restore_aliases )) || setopt aliases
'builtin' 'unset' 'p10k_lean_restore_aliases'
EOF
    
    print_success "Powerlevel10k configuration created!"
}

# Set Zsh as default shell
set_default_shell() {
    print_status "Setting Zsh as default shell..."
    
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        # Add zsh to /etc/shells if it's not there
        if ! grep -q "$(which zsh)" /etc/shells; then
            echo "$(which zsh)" | sudo tee -a /etc/shells
        fi
        
        # Change default shell
        chsh -s "$(which zsh)"
        print_success "Default shell set to Zsh!"
        print_warning "Please restart your terminal or run 'exec zsh' to start using Zsh"
    else
        print_success "Zsh is already your default shell!"
    fi
}

# Main execution
main() {
    print_banner
    
    print_status "Starting DevOps terminal setup..."
    
    detect_os
    install_dependencies
    install_nerd_fonts
    install_oh_my_zsh
    install_powerlevel10k
    install_zsh_plugins
    configure_autocomplete
    configure_zshrc
    create_p10k_config
    set_default_shell
    
    echo -e "${GREEN}"
    echo "🎉 SUCCESS! Your DevOps terminal is ready!"
    echo "================================================"
    echo "✅ Zsh installed and configured"
    echo "✅ Oh My Zsh framework installed"
    echo "✅ Powerlevel10k theme activated"
    echo "✅ Essential DevOps plugins enabled"
    echo "✅ Comprehensive autocomplete configured"
    echo "✅ Nerd Fonts installed"
    echo "✅ Productivity aliases configured"
    echo "✅ FZF fuzzy finder installed"
    echo ""
    echo "🚀 AUTOCOMPLETE FEATURES:"
    echo "• kubectl (k) - Tab complete pods, services, etc."
    echo "• terraform (tf) - Complete resources and commands"
    echo "• docker & docker-compose - Complete containers, images"
    echo "• AWS, Azure, GCloud CLI - Complete all commands"
    echo "• Git - Complete branches, files, commands"
    echo "• History-based suggestions as you type!"
    echo ""
    echo "📝 NEXT STEPS:"
    echo "1. Restart your terminal or run: exec zsh"
    echo "2. Set terminal font to 'MesloLGS NF'"
    echo "3. Run 'p10k configure' to customize your prompt"
    echo "4. Try typing 'k get po' and press TAB for autocomplete!"
    echo "5. Use Ctrl+R for fuzzy history search"
    echo "6. Enjoy your supercharged DevOps terminal! 🚀"
    echo -e "${NC}"
}

# Run the script
main "$@"