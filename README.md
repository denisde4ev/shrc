# .bashrc.d
My personal dotfiles (started from Arco Linux .bashrc)

``` bash
(
# WARNING: NOT FULY TESTED YET
set -x;
cd -- &&
git clone git@ssh.gitgud.io:denisde4ev/cfg.git ~/cfg && [[ -d ~/cfg ]] &&
alias config='git --git-dir ~/cfg/.git --work-tree ~' &&
eval 'config config --local status.showUntrackedFiles no' &&
alias config >> ~/.bashrc &&
command -v __load_completion &>/dev/null {
 __load_completion git &&
 complete=$(complete -p | grep -Ee '\bgit\b' | sed 's/\bgit\b/config/g') &&
 eval "${complete:-false}" &&  # `config' as `git' completeons and add it to .bashrc
 
#            TODO:
#  cat << ----EOF
# user input needed, completion for git found:
#  -> ${complete@Q}
# 1) its as expected __git_wrap__git_main
# 2) let me type
# 3) no, I don't want completion at all"
#----EOF
 complete_fn=$(sed -En 's/.+\b(\w*_git\w*)\b.*\bconfig\b.*/\1/gp' <<< $complete) &&
 command -v "$complete_fn" &>/dev/null &&
 complete_fn="$complete_fn(){ __load_completion git && $complete_fn "'"$@"; }'
 complete_="$complete; $complete_fn"  &&
 
 echo "complete_" >> ~/.bashrc && 
 
}


ls -alF ~/cfg;
config status
set +x;
)
```
