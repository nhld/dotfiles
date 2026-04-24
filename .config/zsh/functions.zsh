#!/usr/bin/env zsh

function mkd() {
  mkdir -p "$@" && builtin cd "$_" || exit
}
