prompt() {
    local last_exit=$?

    local reset='\[\e[0m\]'
    local red='\[\e[1;31m\]'
    local green='\[\e[0;32m\]'
    local yellow='\[\e[1;33m\]'
    local blue='\[\e[1;34m\]'
    local magenta='\[\e[1;35m\]'

    PS1=''
    [[ $last_exit -ne 0 ]] && PS1+="${red}[${last_exit}]${reset} "
    [[ -v IN_NIX_SHELL ]] && PS1+="${magenta}[nix-shell]${reset} "
    PS1+="${yellow}\u${reset}@${blue}\h${reset}:${green}\w${reset}$ "
}

PROMPT_COMMAND=prompt
