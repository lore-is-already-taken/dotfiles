# zmodload zsh/zprof
# ============================================================================
# Environment
# ============================================================================

# Fix the Java Problem
export _JAVA_AWT_WM_NONREPARENTING=1

# ============================================================================
# Powerlevel10k — instant prompt MUST stay at the top
# ============================================================================

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================================
# History
# ============================================================================

setopt histignorealldups sharehistory
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# ============================================================================
# Keybindings (emacs-style)
# ============================================================================

bindkey -e
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

# ============================================================================
# Completion system
# ============================================================================

# Carga rápida de compinit usando caché diario
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m-1) ]]; then
  compinit -C
else
  compinit
fi

# Single source of truth — last assignment wins, so we keep only the final
# values and drop the conflicting earlier ones.
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

# Load LS_COLORS for completion coloring (overrides the empty list-colors above)
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Process kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ============================================================================
# PATH — single declaration, ordered by priority
# ============================================================================

export PATH="$HOME/.local/bin:$HOME/bin:$HOME/go/bin:$HOME/.opencode/bin:/usr/local/go/bin:$PATH"

# ============================================================================
# Aliases (with existence checks for non-standard tools)
# ============================================================================

# lsd
if command -v lsd >/dev/null 2>&1; then
  alias ll='lsd -lh --group-dirs=first'
  alias la='lsd -a --group-dirs=first'
  alias l='lsd --group-dirs=first'
  alias lla='lsd -lha --group-dirs=first'
  alias ls='lsd --group-dirs=first'
fi

# bat — keep a `catn` escape hatch for real cat
if command -v batcat >/dev/null 2>&1; then
  alias cat='batcat'
fi
alias catn='/usr/bin/cat'

# ============================================================================
# Third-party integrations
# ============================================================================

# Powerlevel10k theme
[[ -f ~/powerlevel10k/powerlevel10k.zsh-theme ]] && source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Plugins (sourced from ~/repos — non-fatal if missing)
for plugin in ~/repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
              ~/repos/zsh-autosuggestions/zsh-autosuggestions.zsh \
              ~/repos/zsh-sudo/sudo.plugin.zsh; do
  [[ -f "$plugin" ]] && source "$plugin"
done

# NVM — lazy-loaded on first `nvm` call to keep startup fast
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && {
  nvm() {
    unset -f nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm "$@"
  }
}

# ============================================================================
# Functions
# ============================================================================

# Create a project directory with standard subfolders
mkt() {
  mkdir -p "${1:-.}"/{scan,content,scripts}
}

# Extract nmap information
extractPorts() {
  ports="$(grep -oP '\d{1,5}/open' "$1" | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
  ip_address="$(grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' "$1" | sort -u | head -n 1)"

  cat <<EOF > extractPorts.tmp

[*] Extracting information...
	[*] IP Address: $ip_address
	[*] Open ports: $ports

[*] Ports copied to clipboard
EOF
  cat extractPorts.tmp
  rm extractPorts.tmp
}

# Colored man pages
man() {
  env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}

# fzf with preview — preview chain is shared; pass layout via $1
_fzf_preview='[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -500'

fzf-lovely() {
  if [[ "$1" == "h" ]]; then
    fzf -m --reverse --preview-window down:20 --preview "$_fzf_preview"
  else
    fzf -m --preview "$_fzf_preview"
  fi
}

# Secure file deletion
rmk() {
  # check if scrub is installed
  if command -v scrub >/dev/null 2>&1; then
    scrub -p dod "$1"
  else
    echo "scrub not installed. Using shred only"
  fi

  # shred se ejecuta siempre, independientemente de lo anterior
  shred -zun 10 -v "$1"
}

# ============================================================================
# Finalize Powerlevel10k instant prompt — MUST stay at the bottom
# ============================================================================
(( ! ${+functions[p10k-instant-prompt-finalize]} )) || p10k-instant-prompt-finalize
