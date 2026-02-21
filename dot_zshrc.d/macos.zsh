# macOS-specific shell adjustments
if command -v brew >/dev/null 2>&1; then
  COREUTILS_PREFIX="$(brew --prefix coreutils 2>/dev/null)"
  COREUTILS_GNUBIN=""
  if [[ -d "${COREUTILS_PREFIX}/libexec/gnubin" ]]; then
    COREUTILS_GNUBIN="${COREUTILS_PREFIX}/libexec/gnubin"
  fi

  BREW_PREFIX="$(brew --prefix)"
  if [[ -n "${COREUTILS_GNUBIN}" ]]; then
    PATH="${COREUTILS_GNUBIN}:/usr/local/bin:/usr/local/sbin:${BREW_PREFIX}/bin:${PATH}"
  else
    PATH="/usr/local/bin:/usr/local/sbin:${BREW_PREFIX}/bin:${PATH}"
  fi
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
