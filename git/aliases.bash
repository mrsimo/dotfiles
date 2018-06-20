alias gl="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias glc="git log --graph --color --date=relative --stat"
alias gcm="g"
alias delete-merged='git branch -a --no-color --merged | egrep -v "^  (remotes/.*|master)|^\*" | xargs -rn 1 git branch -d ; git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'
alias push="git push"

