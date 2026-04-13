# 🚀 Ultimate DevOps Terminal Setup

Transform your terminal into a **supercharged DevOps command center** with this comprehensive setup script! Get Zsh, Oh My Zsh, Powerlevel10k, and intelligent autocomplete for all major DevOps tools configured in minutes.

## ✨ Features

### 🎨 **Beautiful & Fast Interface**
- **Powerlevel10k theme** - Lightning-fast, customizable prompt
- **Nerd Fonts** - Beautiful icons and symbols
- **Git integration** - Real-time git status in your prompt
- **Execution time** - See how long commands take
- **Custom color scheme** - Optimized for DevOps workflows

### 🛠️ **DevOps Tool Integration**
- **Kubernetes** (`kubectl`) - Full autocomplete + context display
- **Docker** - Container and image completion
- **Terraform** - Resource and command completion
- **AWS CLI** - Complete service and command support
- **Azure CLI** - Full Azure resource completion
- **Google Cloud** - GCP service completion
- **Helm** - Chart and release completion
- **Git** - Branch, file, and command completion

### ⚡ **Productivity Boosters**
- **Intelligent autosuggestions** - History-based command suggestions
- **Fuzzy search** (FZF) - `Ctrl+R` for lightning-fast history search
- **Syntax highlighting** - Color-coded command validation
- **Smart aliases** - Shortcuts for common DevOps commands
- **Case-insensitive completion** - Works with any capitalization

### 🌍 **Cross-Platform Support**
- ✅ **macOS** (Homebrew integration)
- ✅ **Ubuntu/Debian** (apt package manager)
- ✅ **CentOS/RHEL** (yum/dnf package manager)
- ✅ **Arch Linux** (pacman package manager)

## 🚀 Quick Start

### One-Line Installation

```bash
curl -fsSL https://raw.githubusercontent.com/thisiskicker/shell-configuration/refs/heads/master/setup-devops-shell.sh | bash
```

### Manual Installation

1. **Download the script:**
   ```bash
   wget https://raw.githubusercontent.com/thisiskicker/shell-configuration/main/setup-devops-shell.sh
   chmod +x setup-devops-shell.sh
   ```

2. **Run the setup:**
   ```bash
   ./setup-devops-shell.sh
   ```

3. **Restart your terminal or run:**
   ```bash
   exec zsh
   ```

4. **Configure your prompt:**
   ```bash
   p10k configure
   ```

> **Safe to re-run:** The script is idempotent. Already-installed components (Oh My Zsh, Powerlevel10k, plugins, fzf) are skipped. Existing `~/.zshrc` and `~/.p10k.zsh` files are backed up with a timestamp before being overwritten, and an existing `~/.p10k.zsh` is left untouched entirely.

## 📋 Prerequisites

- **Root/sudo access** (for package installation)
- **Internet connection** (for downloading dependencies)
- **Git** (automatically installed if missing)
- **Curl/wget** (automatically installed if missing)

## 🎯 What Gets Installed

### Core Components
- **Zsh** - Advanced shell with powerful features
- **Oh My Zsh** - Framework for managing Zsh configuration
- **Powerlevel10k** - The fastest and most customizable theme
- **MesloLGS NF Font** - Nerd Font with perfect icon support

### Essential Plugins
- **zsh-autosuggestions** - History-based command suggestions
- **zsh-syntax-highlighting** - Real-time command validation
- **zsh-completions** - Additional completion scripts
- **FZF** - Fuzzy finder for files and command history

### DevOps Tools Autocomplete
- Kubernetes (`kubectl`)
- Docker & Docker Compose
- Terraform
- AWS CLI
- Azure CLI
- Google Cloud CLI
- Helm
- Git (enhanced)

## 🎨 Font Configuration

The script installs **MesloLGS NF** fonts automatically. You need to configure your terminal to use them:

### Quick Font Setup by Terminal:

| Terminal | Instructions |
|----------|-------------|
| **iTerm2** | Preferences → Profiles → Text → Font → "MesloLGS NF" |
| **Terminal.app** | Preferences → Profiles → Font → "MesloLGS NF" |
| **GNOME Terminal** | Right-click → Preferences → Text → Custom font → "MesloLGS NF" |
| **Windows Terminal** | Settings → Profiles → Appearance → Font face → "MesloLGS NF" |
| **VS Code** | Settings → Terminal Font Family → `'MesloLGS NF'` |

**Test your font setup:**
```bash
echo "Icons test: ⚡ 🚀 ❯  📁 🔀 ✓ ✗ ⚠ 🐳 ☸ ⎈"
```

## 🔧 Configuration

### Custom Aliases Included

#### Kubernetes
```bash
k='kubectl'                    # Short kubectl
kgp='kubectl get pods'         # Get pods
kgs='kubectl get services'     # Get services  
kgd='kubectl get deployments'  # Get deployments
kd='kubectl describe'          # Describe resources
kl='kubectl logs'              # View logs
kx='kubectl exec -it'          # Execute into pods
```

#### Docker
```bash
dc='docker-compose'            # Short docker-compose
dcu='docker-compose up'        # Compose up
dcd='docker-compose down'      # Compose down
dps='docker ps'                # List containers
dim='docker images'            # List images
```

#### Terraform
```bash
tf='terraform'                 # Short terraform
tfi='terraform init'           # Initialize
tfp='terraform plan'           # Plan changes
tfa='terraform apply'          # Apply changes
tfd='terraform destroy'        # Destroy infrastructure
```

#### Git
```bash
gs='git status'                # Git status
ga='git add'                   # Git add
gc='git commit'                # Git commit
gp='git push'                  # Git push
gl='git pull'                  # Git pull
glog='git log --oneline --graph --decorate --all'
```

### Advanced Features

#### FZF Integration
- **`Ctrl+R`** - Fuzzy search command history
- **`Ctrl+T`** - Fuzzy search files
- **`Alt+C`** - Fuzzy search directories

#### Smart History
- 10,000 command history persisted to `~/.zsh_history`
- Duplicate removal
- Shared history across sessions
- Ignore commands starting with space

## 🔍 Autocomplete Examples

### Kubernetes Autocomplete
```bash
k get po<TAB>              # Shows all pods
k describe pod my-<TAB>    # Completes pod names starting with "my-"
k logs -f <TAB>            # Shows pod names for log following
k exec -it <TAB>           # Shows running pods
```

### Terraform Autocomplete
```bash
tf <TAB>                   # Shows all terraform commands
tf apply -var <TAB>        # Shows available variables
tf state <TAB>             # Shows state commands
```

### Docker Autocomplete
```bash
docker run <TAB>           # Shows available images
docker exec <TAB>          # Shows running containers
docker-compose <TAB>       # Shows compose commands
```

## 🎛️ Customization

### Powerlevel10k Configuration
Run the configuration wizard anytime:
```bash
p10k configure
```

### Custom Prompt Elements
Edit `~/.p10k.zsh` to modify:
- Prompt segments
- Colors and icons
- Git status display
- Execution time format
- Directory truncation

### Adding Custom Aliases
Edit `~/.zshrc` and add your aliases:
```bash
# Custom DevOps aliases
alias myalias='your-command'
alias deploy='kubectl apply -f'
alias logs='kubectl logs -f'
```

### Plugin Management
Add more plugins to the `plugins` array in `~/.zshrc`:
```bash
plugins=(
    # ... existing plugins
    your-new-plugin
)
```

## 🆘 Troubleshooting

### Common Issues

#### Font Icons Not Showing
1. **Verify font installation:**
   ```bash
   fc-list | grep -i meslo  # Linux/macOS
   ```

2. **Refresh font cache (Linux):**
   ```bash
   fc-cache -fv
   ```

3. **Restart terminal completely**

4. **Check terminal font settings** - Must be exactly "MesloLGS NF"

#### Autocomplete Not Working
1. **Restart terminal:**
   ```bash
   exec zsh
   ```

2. **Rebuild completion cache:**
   ```bash
   rm ~/.zcompdump*
   compinit
   ```

3. **Check tool installation:**
   ```bash
   which kubectl terraform docker  # Verify tools are installed
   ```

#### Slow Terminal Startup
1. **Check for problematic plugins** in `~/.zshrc`
2. **Disable unused completions**
3. **Run Powerlevel10k in lean mode**
4. **Rebuild the completion cache** — a stale cache can slow startup:
   ```bash
   rm ~/.zcompdump*; exec zsh
   ```

#### Theme Not Loading
1. **Verify Powerlevel10k installation:**
   ```bash
   ls ~/.oh-my-zsh/custom/themes/powerlevel10k
   ```

2. **Check ZSH_THEME in ~/.zshrc:**
   ```bash
   grep ZSH_THEME ~/.zshrc
   ```

3. **Reinstall theme:**
   ```bash
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
   ```

### Getting Help

If you encounter issues:

1. **Check the logs** during installation
2. **Verify your OS is supported**
3. **Ensure you have sudo/admin privileges**
4. **Check your internet connection**

## 🔄 Updating

### Update Oh My Zsh
```bash
omz update
```

### Update Powerlevel10k
```bash
git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull
```

### Update Plugins
```bash
# Update all custom plugins
for plugin in ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/*; do
    if [[ -d "$plugin/.git" ]]; then
        git -C "$plugin" pull
    fi
done
```

## 🗑️ Uninstallation

To remove the setup:

1. **Restore original shell:**
   ```bash
   chsh -s /bin/bash  # or your original shell
   ```

2. **Backup and remove config:**
   ```bash
   mv ~/.zshrc ~/.zshrc.backup
   mv ~/.p10k.zsh ~/.p10k.zsh.backup
   ```

3. **Remove Oh My Zsh:**
   ```bash
   uninstall_oh_my_zsh
   ```

4. **Remove fonts (optional):**
   ```bash
   rm ~/Library/Fonts/MesloLGS*  # macOS
   rm ~/.local/share/fonts/MesloLGS*  # Linux
   ```
