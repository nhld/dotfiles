#!/usr/bin/env zsh

function mkd() {
  mkdir -p "$@" && cd "$_" || exit
}
