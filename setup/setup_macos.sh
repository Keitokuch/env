#! /usr/bin/env bash 

OS=macos


get_zsh() {
    if ! [[ -x $(command -v zsh) ]]; then
        brew install zsh zsh-completions
        if [[ -x "/bin/zsh" ]]; then
            chsh -s "/bin/zsh"
        else 
            chsh -s $(which zsh) 
        fi
        MSG+=(">>> installed zsh <<<")
    else
        MSG+=("=== zsh already installed ===")
    fi 
}


get_curl() {
    if ! [[ -x $(command -v curl) ]]; then
        brew install curl
        MSG+=(">>> installed curl <<<")
    else
        MSG+=("=== curl already installed ===")
    fi 
}


get_nodejs() {
    if ! [[ -x $(command -v node) ]]; then
        brew install node
        MSG+=(">>> installed nodejs <<<")
    else 
        MSG+=("=== nodejs already installed ===")
    fi 
}

