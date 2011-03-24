# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

autoload colors; colors;

git_branch() {
  echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

# git_dirty() {
#   st=$(git status 2>/dev/null | tail -n 1)
#   if [[ $st == "" ]]
#   then
#     echo ""
#   else
#     if [[ $st == "nothing to commit (working directory clean)" ]]
#     then
#       echo "$(git_prompt_info) "
#     else
#       echo "$(git_prompt_info)+ "
#     fi
#   fi
# }

git_dirty() {
  echo "$(git_prompt_info) "
}

git_prompt_info () {
 ref=$(git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

project_name_color () {
  name=$(project_name)
  echo "%{\e[0;35m%}${name}%{\e[0m%}"
}

unpushed () {
  git cherry -v origin/$(git_branch) 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo "%{\e[1;36m%} + %{\e[0m%}"
  fi
}

rvm_prompt(){
  if $(which rvm &> /dev/null)
  then
    echo "%{$fg[magenta]%}$(~/.rvm/bin/rvm-prompt)%{\e[0m%} "
  else
    echo ""
  fi
}

export PROMPT=$'$(rvm_prompt)%{$fg[green]$(git_dirty)%{$fg[blue][ %{$fg[white]%~ %{$fg[blue]] $ %{$fg[white]'

set_prompt () {
  # export RPROMPT="$(need_push)$(project_name_color)$(git_dirty)"
}

precmd() {
  set_prompt
}
