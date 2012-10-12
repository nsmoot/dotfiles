export PLATFORM=`uname -s`
mkdir -p ~/.zsh/cache

# path
PATH="/usr/local/sbin:/usr/local/bin:$PATH"
PATH="$PATH:$HOME/bin"
export PATH

# languages
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_CTYPE=C

# completion
autoload -U compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # match uppercase from lowercase

# ls colors
if [ $PLATFORM = FreeBSD ] || [ $PLATFORM = Darwin ]; then
  CLR_DIR=Ex
  CLR_SYM_LINK=Gx
  CLR_SOCKET=Fx
  CLR_PIPE=dx
  CLR_EXE=Cx
  CLR_BLOCK_SP=Dx
  CLR_CHAR_SP=Dx
  CLR_EXE_SUID=hb
  CLR_EXE_GUID=ad
  CLR_DIR_STICKY=Ex
  CLR_DIR_WO_STICKY=Ex
  LSCOLORS="$CLR_DIR$CLR_SYM_LINK$CLR_SOCKET$CLR_PIPE$CLR_EXE$CLR_BLOCK_SP"
  LSCOLORS="$LSCOLORS$CLR_CHAR_SP$CLR_EXE_SUID$CLR_EXE_GUID$CLR_DIR_STICKY"
  LSCOLORS="$LSCOLORS$CLR_DIR_WO_STICKY"
  export LSCOLORS
  export CLICOLOR="YES"
fi

# aliases
if [ $PLATFORM = Linux ]; then
  alias ls='ls -F --color=auto'
else
  alias ls='ls -FG'
  alias top='top -ocpu'
fi
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'
alias dir='ll'
alias l='ll'
alias ll='ls -lh'
alias la='ls -A'
alias vi='vim'
if [ -x /usr/local/bin/mvim ]; then
  alias vim='mvim -v'
fi
alias s='screen'
alias tree='tree -C --dirsfirst'
alias rmpyc='find . -name "*.pyc" -delete'
alias ddu='find . -maxdepth 1 -type d -exec du -s {} \;'
alias unix2dos='recode lat1..ibmpc'
alias dos2unix='recode ibmpc..lat1'
alias t='vim -c ":$" ~/.todo'
alias todo='cat ~/.todo'
alias p='ping www.make.sh'

# viewing / editing
export PAGER='less'
export EDITOR='vim'
export MUTT_EDITOR='vim'

autoload colors; colors # ANSI color codes

# history
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=$HOME/.zsh/history
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# prompt
_virtualenv_prompt () {
  if [[ -n $VIRTUAL_ENV ]]; then
    echo "$reset_color workon$fg[green]" `basename "$VIRTUAL_ENV"`
  fi
}
export PROMPT='
%(?..[%{$fg[red]%}%?%{$reset_color%}] )%{$fg[magenta]%}%m%{$reset_color%}: %{$fg[cyan]%}%~$(_virtualenv_prompt)
%{$fg[yellow]%}$%{$reset_color%} '
setopt PROMPT_SUBST # perform substitution/expansion in prompts

# functions
abspath () {
  # abspath <directory>
  # Print the absolute path to a given file (using Python's `os.path.abspath()`).
  python -c 'import os, sys; print os.path.abspath(sys.argv[1])' "$@"
}

python_lib () {
  # python_lib
  # Print the full path to the current Python site-packages directory.
  echo `python -c 'import distutils.sysconfig; print distutils.sysconfig.get_python_lib()'`
}

pylink () {
  # pylink <package/module>
  # Symlink a Python package/module into the site-packages directory.
  ln -s $(abspath `pwd`/"$1") `python_lib`/`basename "$1"`
}

pyunlink () {
  # pyunlink <package/module>
  # Remove the link to a Python package/module from the site-packages directory.
  unlink `python_lib`/`basename "$1"`
}

# ruby
RBENV_DIR="$HOME/.rbenv"
if [ -d "$RBENV_DIR" ]; then
  export PATH="$RBENV_DIR/bin:$PATH"
  if command -v rbenv > /dev/null; then
    eval "$(rbenv init -)"
  fi
fi

# user-dependent settings
if [[ "`id -u`" -eq 0 ]]; then
  umask 022
else
  umask 077
fi

# local settings
if [ -f ~/.zshrc.local ]; then
  . ~/.zshrc.local
fi