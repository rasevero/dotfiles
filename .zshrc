# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# do not ask for oh-my-zsh updates
export DISABLE_UPDATE_PROMPT=true
# Path to your oh-my-zsh installation.
export ZSH="/home/ricardo/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="powerlevel10k/powerlevel10k"
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
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
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colorize screen docker docker-compose systemd zsh-vim-mode zoxide fast-syntax-highlighting zsh-autosuggestions)

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.bash_aliases
[[ ! -f ~/.bash_funcs ]] || source ~/.bash_funcs

bindkey -v #vi mode

#history
setopt APPEND_HISTORY 
unsetopt SHARE_HISTORY

#directory history http://zsh.sourceforge.net/Intro/intro_6.html
export DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups

#fix invisible comment
#ZSH_HIGHLIGHT_STYLES[comment]='fg=gray,bold'

#my vars
export DOCKER_CLIENT_TIMEOUT=200
export COMPOSE_HTTP_TIMEOUT=200
export VISUAL=nvim
export EDITOR="$VISUAL"
export PATH=$HOME/.local/bin:$HOME/bin:$HOME/.yarn/bin:$HOME/.composer/vendor/bin:$PATH
export KEYTIMEOUT=1 #vi esc
export WORKDIR=$HOME/src
export PAGER="less -F"
export fpath=(~/.zsh/completions $fpath)

autoload -U compinit && compinit

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

#awise vars
[[ ! -f ~/.zsh/localvars ]] || source ~/.zsh/localvars

#caps as Mode_switch + hjkl as arrows:
#https://unix.stackexchange.com/questions/414926/bind-capshjkl-to-arrow-keys-caps-to-esc
#atualmente configurado na inicialização do xfce
#xmodmap ~/.xmodmap
#xcape -e 'Mode_switch=Escape'

#Ignorar key F14
bindkey -s '^[[26~' '\a'

#completar por data de modificação
#zstyle ':completion:*:(cd|cat|vim):*' file-sort modification
zstyle ':completion:*' file-sort modification

#FZF
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'

source ~/.zsh/nnn/quitcd.bash_sh_zsh

eval "$(zoxide init zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ricardo/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ricardo/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ricardo/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ricardo/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

#pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#fix history search with autosuggestions
bindkey -a j vi-down-line-or-history
bindkey -a k vi-up-line-or-history
bindkey '^n' vi-down-line-or-history
bindkey '^p' vi-up-line-or-history
