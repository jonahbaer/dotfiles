#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Makes color highlighting with ls default
alias ls='ls --color=auto'

# Bash prompt configuration
PS1='[\u@\h \W]\$ '
