# Shared zsh functions — sourced by both term/zshrc (Linux) and term/zshrc-mac.
# Keep everything here portable; put OS-specific helpers in the rc file itself.

# Create a project directory with standard subfolders
mkt() {
  mkdir -p "${1:-.}"/{scan,content,scripts}
}

# Extract open ports + IP from an nmap scan and copy the ports to the clipboard
extractPorts() {
  local ports ip_address
  ports=$(grep -oE '[0-9]{1,5}/open' "$1" | awk -F/ '{print $1}' | xargs | tr ' ' ',')
  ip_address=$(grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' "$1" | sort -u | head -n 1)
  printf '\n[*] Extracting information...\n\n\t[*] IP Address: %s\n\t[*] Open ports: %s\n\n' "$ip_address" "$ports"
  if command -v pbcopy >/dev/null 2>&1; then
    printf '%s' "$ports" | pbcopy
  elif command -v xclip >/dev/null 2>&1; then
    printf '%s' "$ports" | xclip -selection clipboard
  else
    echo "[!] No clipboard tool found (pbcopy/xclip)" >&2
    return 0
  fi
  echo "[*] Ports copied to clipboard"
}

# Coloured man pages
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

# fzf with file preview ("h" for horizontal/reverse layout)
fzf-lovely() {
  local preview='[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file ||
                 (bat --style=numbers --color=always {} ||
                  highlight -O ansi -l {} ||
                  coderay {} || rougify {} || cat {}) 2>/dev/null | head -500'
  if [[ "$1" == "h" ]]; then
    fzf -m --reverse --preview-window down:20 --preview "$preview"
  else
    fzf -m --preview "$preview"
  fi
}

# Secure file deletion: scrub when available, shred always
rmk() {
  if command -v scrub >/dev/null 2>&1; then
    scrub -p dod "$1"
  else
    echo "scrub not installed. Using shred only"
  fi
  shred -zun 10 -v "$1"
}
