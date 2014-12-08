#!/bin/bash
GIT_REPO='git@git.ipo.com:hf-dev-2'
PS3="select app name: "

select GIT_APP in exit $(cat $HOME/bin/git/app.conf); do
    case $GIT_APP in 
        exit)
            echo 'bye'
            break
            ;;
        *)
            echo "copy $GIT_REPO/${GIT_APP}.git into clipboard"
            echo -n "$GIT_REPO/${GIT_APP}.git" | pbcopy
            break
            ;;
    esac
done
