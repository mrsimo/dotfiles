# ----------------------------------------------------------------------
# PROMPT
# ----------------------------------------------------------------------

# CLI & Prompt colors
export CLICOLOR=true
export LSCOLORS="exfxcxdxbxegedabagacad"

# COLORS

  NORMAL='\[\033[00m\]'
  BGREEN='\[\033[1;32m\]'
  BBLUE='\[\033[1;34m\]'
  GREEN='\[\033[0;32m\]'
  BLACK="\[\033[0;30m\]"
  RED="\[\033[0;31m\]"
  YELLOW="\[\033[0;33m\]"
  PURPLE="\[\033[0;35m\]"
  CYAN="\[\033[0;36m\]"
  WHITE="\[\033[0;37m\]"
  WHITEBOLD="\[\033[1;37m\]"
# /COLORS
#
# Pretty methods to print useful information

  git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2>/dev/null) || return
    echo "${ref#refs/heads/} "
  }

  git_branch() {
    echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
  }

  ruby_prompt(){
    rvp=$(rbenv version-name) || return
    echo "${rvp} ";
    echo "";
  }

# /Pretty methods

# Prompt
export PS1="${PURPLE}\$(ruby_prompt)${BGREEN}\$(git_prompt_info)${BBLUE}[${NORMAL}\w${BBLUE}] ${BBLUE}$ ${NORMAL}"

# Window title
export PROMPT_COMMAND='echo -ne "\033]0; ${PWD/#$HOME/~}\007"'

export TERM="xterm-color"
export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

# -------------------------------------------------------------------
# MOTD / FORTUNE
# -------------------------------------------------------------------

if [[ -n "$INTERACTIVE" ]]; then
  rm -f /tmp/prompt

  if [[ "$(uname)" == "Darwin" ]]; then
      _cpu_info=$(sysctl -n machdep.cpu.brand_string)
    _os_version=$(defaults read loginwindow SystemVersionStampAsString)
      _load_avg=$(w | head -n1 | ruby -ne 'puts $_[/(\d+\.\d+ \d+\.\d+ \d+\.\d+)+$/]')
      _local_ip=$(ifconfig | grep 'inet 192' | head -n1 | cut -d' ' -f2)
  else
                 _cpu_info=$(lscpu | grep "Model name" | cut -d ":" -f 2 | xargs)
               _os_version=$(lsb_release -ds)
                 _load_avg=$(cat /proc/loadavg | cut -d" " -f 1,2,3)
                 _local_ip=$(hostname -I | cut -d" " -f 1)

  fi

    echo "
  $(whoami)@$(hostname) $_cpu_info
  ---------------------------------------------------------------
  "                                                            >> /tmp/prompt
    echo "            OS: $_os_version" >> /tmp/prompt
    echo "   System load: $_load_avg"   >> /tmp/prompt
    echo "       Network: $(cat /tmp/myip) / $_local_ip
    "                           >> /tmp/prompt

    cat /tmp/prompt | lolcat -t
fi
