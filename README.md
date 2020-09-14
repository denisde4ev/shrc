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
command -v __load_completion &>/dev/null && { # 
  __load_completion git &&
  complete=$(complete -p | sed -n 's/\bgit\b/config/gp') &&
  eval "${complete:-false}" &&  # `config' as `git' completeons and add it to .bashrc
 
  complete_fn=$(sed -En 's/.+\b(\w*_git\w*)\b.*\bconfig\b.*/\1/gp' <<< $complete) && {
    [[ $complete_fn ]] && 
    command -v "$complete_fn" &>/dev/null &&
    complete_fn="$complete_fn(){ __load_completion git && $complete_fn "'"$@"; }' #\
   
  }
 
  echo "${complete:?}; ${complete_fn:?}" >> ~/.bashrc
 
}


ls -alF ~/cfg;
config status
set +x;
)
```
