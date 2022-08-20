#!/bin/bash

__git_prompt() {

#    -e PS1=\"\[\\\033[1;32m\]\u\[\\\033[0m\]@\[\\\033[1;31m\]\h \[\\\033[0;37m\]\W\[\\\033[1;301m\]$\[\\\033[0m\] \"
    local userpart='`export XIT=$? \
        && [ ! -z "${GITHUB_USER}" ] && echo -n "\[\033[1;32m\]@${GITHUB_USER} " || echo -n "\[\033[1;32m\]\u" \
        && [ "$XIT" -ne "0" ] && echo -n "\[\033[1;31m\]➜" || echo -n "\[\033[0m\]"`'
    local gitbranch='`\
        if [ "$(git config --get codespaces-theme.hide-status 2>/dev/null)" != 1 ]; then \
            export BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null); \
            if [ "${BRANCH}" != "" ]; then \
                echo -n "\[\033[0;36m\](\[\033[1;36m\]${BRANCH}" \
                && if git ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1; then \
                        echo -n " \[\033[1;33m\]✗"; \
                fi \
                && echo -n "\[\033[0;36m\]) "; \

            fi; \
        fi`'
    local green='\[\033[1;32m\]'
    local yellow='\[\033[1;33m\]'
    local teal='\[\033[1;36m\]'
    local lightblue='\[\033[1;34m\]'
    local red='\[\033[1;31m\]'
    local removecolor='\[\033[0m\]'
    PS1="${userpart}${removecolor}@${red}\h${removecolor} ➜ \W ${gitbranch}${removecolor}\$ "
    export PS1=$PS1
    unset -f __git_prompt
}
__git_prompt

