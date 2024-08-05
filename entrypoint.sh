#!/usr/bin/env bash
setup() {
  echo "Preparing  $P in $PWD "
  if [ ! -d "$P" ]; then
    crewai create "$P" && cd "$P"
    python3 -m venv .venv
  else
    cd "$P"
  fi
}

if [ -n "$P" ]; then
  setup
fi
exec "$@"
