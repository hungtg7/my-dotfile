# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

autoload -Uz compinit
compinit
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/141373/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	zsh-autosuggestions
	kubectl
	zsh-syntax-highlighting
    fzf-tab
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH=$PATH:~/Downloads/Visual\ Studio\ Code.app/Contents/Resources/app/bin
export PATH=$PATH:/Users/141373/.cargo/bin:~/go/bin
export PATH=$PATH:/Users/141373/Downloads
export PATH=$PATH:/opt/homebrew/bin/
export PATH=$PATH:/opt/homebrew/Cellar/openvpn/2.5.6/sbin/
export PATH=$PATH:/Users/141373/go/bin:/Users/141373/.local/bin/:/Users/141373/.cargo/bin/
export PATH=$PATH:/.cargo/bin/racer

# ssh config
ssh-add ~/.ssh/fossil_id_rsa
# ssh-add ~/.ssh/facen

# JAVA home
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

export KUBECONFIG=${HOME}/.kube/config

# Golang config for private repo
export GOPATH=/Users/141373/go
# export GOPRIVATE=bitbucket.org/misfitwearablesinc/*,cloud.cdgfossil.com/*

# Config PYO3 rust python runner
# export PYO3_PYTHON=/opt/homebrew/bin//python3.9
alias vi=nvim

# remove all docker container
function docker_rm_all {
    docker rm $(docker ps --filter status=exited -q)
}

# remove all docker image
function docker_rmi_all {
    docker stop $(docker ps --filter status=running -q)
    docker rm $(docker ps --filter status=exited -q)
}

# Seal secret for k8s
function k_seal_add {
	echo -n $1 \
		| kubectl create secret generic abc --dry-run --from-file=${2}=/dev/stdin -o json \
		| kubeseal --controller-namespace=kube-system --controller-name=sealed-secrets --format yaml --merge-into $3 --cert /Users/141373/fossil/k8s/tls.crt
}

function dk_rmi {
	docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
}

function vpn {
	sudo openvpn --config ~/Documents/Fossil/vpn/hungtg-fossil@vpn.misfit.com.ovpn --auth-user-pass  <(echo -e $VPN_USER"\n"${VPN_PASSWORD}${AUTHEN})
}


# k8s
source <(kubectl completion zsh)

alias k=kubectl
# source ~/.k8s.zsh

# Terminal theme
# source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
eval "$(starship init zsh)"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# Neo vim
# brew install neovim
# git clone https://github.com/dangngo/neovim-config.git ~/.config/nvim
# brew install romkatv/powerlevel10k/powerlevel10k
# echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
# brew install tree-sittersource /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
# source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
# source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
# source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
# source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
# source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
# source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Access tmux by default
# tmux

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

