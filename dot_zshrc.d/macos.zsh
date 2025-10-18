# macOS-specific shell adjustments
if command -v brew >/dev/null 2>&1; then
  COREUTILS_PREFIX="$(brew --prefix coreutils 2>/dev/null)"
  if [[ -d "${COREUTILS_PREFIX}/libexec/gnubin" ]]; then
    PATH="${COREUTILS_PREFIX}/libexec/gnubin:${PATH}"
  fi

  BREW_PREFIX="$(brew --prefix)"
  PATH="/usr/local/bin:/usr/local/sbin:${BREW_PREFIX}/bin:${PATH}"
  export PATH

  export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"
  FPATH="${BREW_PREFIX}/share/zsh-completions:${FPATH}"
  autoload -Uz compinit && compinit

  if [[ -r "${BREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "${BREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  fi
  if [[ -r "${BREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "${BREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  fi
fi
