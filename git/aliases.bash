alias gl="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias glc="git log --graph --color --date=relative --stat"
alias gcm="g"
alias delete-merged='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'

