# Intentionally redundant with modules/shell/zsh.nix
export ZDOTDIR="${ZDOTDIR:-${XDG_CONFIG_HOME:-~/.config}/zsh}"

function _cache {
  (( $+commands[$1] )) || return 1
  local cache_dir="$XDG_CACHE_HOME/zsh"
  local cache="$cache_dir/$1"
  if [[ ! -f $cache || ! -s $cache ]]; then
      echo "Caching $1"
      mkdir -p $cache_dir
      "$@" >$cache
      chmod 600 $cache
  fi
  if [[ -o interactive ]]; then
      source $cache || rm -f $cache
  fi
}

function _source {
  for file in "$@"; do
    [ -r $file ] && source $file
  done
}

# Be more restrictive with permissions in $HOME; no one has any business reading
# things that don't belong to them.
if (( EUID != 0 )); then
  umask 027
else
  # Be even less permissive if root.
  umask 077
fi

# Auto-generated by my nix config
_source ${0:a:h}/extra.zshenv
