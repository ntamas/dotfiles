autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

if (( $+commands[hg] ))
then
  hg="$commands[hg]"
else
  hg="/usr/bin/hg"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  st=$($git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ "$st" =~ ^nothing ]]
    then
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

hg_dirty() {
  st=$($hg prompt "{status}{branch}{ at {bookmark}}") 2>/dev/null || return
  flag=${st[1]}
  if [[ $flag == "?" ]]
  then
	st=${st[2,-1]}
    echo "on %{$fg_bold[yellow]%}${st}%{$reset_color%}"
  else
    if [[ $flag == "!" ]]
    then
	  st=${st[2,-1]}
      echo "on %{$fg_bold[red]%}${st}%{$reset_color%}"
    else
      echo "on %{$fg_bold[green]%}${st}%{$reset_color%}"
	fi
  fi
}

hg_prompt_info () {
  $hg prompt "{branch}{ at {bookmark}}" 2>/dev/null
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

ruby_version() {
  if (( $+commands[rbenv] ))
  then
    echo "$(rbenv version | awk '{print $1}')"
  fi

  if (( $+commands[rvm-prompt] ))
  then
    echo "$(rvm-prompt | awk '{print $1}')"
  fi
}

rb_prompt() {
  if ! [[ -z "$(ruby_version)" ]]
  then
    echo "%{$fg_bold[yellow]%}$(ruby_version)%{$reset_color%} "
  else
    echo ""
  fi
}

virtualenv_info() {
  [ $VIRTUAL_ENV ] && echo "$(basename $VIRTUAL_ENV)"
}

directory_name() {
  echo "%{$fg_bold[blue]%}%~%\/%{$reset_color%}"
}

username_and_hostname() {
  echo "%{$fg_bold[green]%}%n@%m%{$reset_color%}"
}

last_exit_code() {
  echo "%{$fg_bold[red]%}%(?.. [%?])%{$reset_color%}"
}

export PROMPT=$'\n$(username_and_hostname):$(directory_name) $(git_dirty)$(hg_dirty)$(need_push)\n› '
export RPROMPT="$(last_exit_code)"

precmd() {
  title "zsh" "%m" "%55<...<%~"
}
