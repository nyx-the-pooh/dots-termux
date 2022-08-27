# Antidote plugin manager setup

## clone antidote if necessary
if ! [[ -e ${ZDOTDIR:-~}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
fi

## load antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

## plugins go here
source <(antidote init)
antidote bundle <<EOBUNDLES
	zsh-users/zsh-autosuggestions
	zdharma-continuum/fast-syntax-highlighting
	bigH/git-fuzzy path:bin kind:path
	sheerun/home
EOBUNDLES

# Plugin configuration
for file in "$ZDOTDIR/plugins.d/"*; do
	source $file
done

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PROMPT="%F{000}%(?.%K{green}.%K{red}) %(?.⌂.✘) %F{249}%K{236} %1~ %k%f "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Smart cd
eval "$(zoxide init zsh)"

# Generate autocompletions
source <(cod init $$ zsh)

