# Put your custom themes in this folder.
# See: https://github.com/ohmyzsh/ohmyzsh/wiki/Customization#overriding-and-adding-themes
# 
# Example:

ZSH_THEME_VIRTUALENV_PREFIX="%{$fg[cyan]%}(%{$fg[white]%}"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$fg[cyan]%})%{$fg[white]%}-"

function virtualenv_info {
    [ $CONDA_DEFAULT_ENV ] && echo "($CONDA_DEFAULT_ENV) "
    [ $VIRTUAL_ENV ] && echo "$ZSH_THEME_VIRTUALENV_PREFIX"`basename $VIRTUAL_ENV`"$ZSH_THEME_VIRTUALENV_SUFFIX"
}

PROMPT='%{$fg[cyan]%}┌[%{$fg_bold[white]%}%n%{$reset_color%}%{$fg[cyan]%}@%{$fg_bold[white]%}%M%{$reset_color%}%{$fg[cyan]%}]%{$fg[white]%}-$(virtualenv_info)%{$fg[cyan]%}(%{$fg_bold[white]%}%~%{$reset_color%}%{$fg[cyan]%})$(git_prompt_info)
└> % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}-%{$fg[cyan]%}[%{$reset_color%}%{$fg[white]%}git://%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[cyan]%}]-"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
