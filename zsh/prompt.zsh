autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo "on %{$fg_bold[yellow]%}$(git_prompt_info)%{$reset_color%}"
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref -q HEAD || $git rev-parse --short HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

# This assumes that you always have an origin named `origin`, and that you only
# care about one specific origin. If this is not the case, you might want to use
# `$git cherry -v @{upstream}` instead.
need_push () {
  if [ $($git rev-parse --is-inside-work-tree 2>/dev/null) ]
  then
    number=$($git cherry -v origin/$(git symbolic-ref --short HEAD) 2>/dev/null | wc -l | bc)

    if [[ $number == 0 ]]
    then
      echo " "
    else
      echo " with %{$fg_bold[magenta]%}$number unpushed%{$reset_color%}"
    fi
  fi
}

virtualenv_info() {
  [ $VIRTUAL_ENV ] && echo "$(basename $VIRTUAL_ENV)"
}

directory_name() {
  echo "%{$fg_bold[blue]%}%~%\/%{$reset_color%}"
}

battery_status() {
  if test ! "$(uname)" = "Darwin"
  then
    exit 0
  fi

  if [[ $(sysctl -n hw.model) == *"Book"* ]]
  then
    $ZSH/bin/battery-status
  fi
}

username_and_hostname() {
  echo "%{$fg_bold[green]%}%n@%m%{$reset_color%}"
}

last_exit_code() {
  echo "%{$fg_bold[red]%}%(?.. [%?])%{$reset_color%}"
}

export PROMPT=$'\n$(username_and_hostname):$(directory_name) $(git_dirty)$(need_push)\n› '
export RPROMPT="$(last_exit_code)"

precmd() {
  title "zsh" "%m" "%55<...<%~"
}
