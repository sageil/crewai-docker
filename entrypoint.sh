#!/usr/bin/env bash
setup() {
  echo "Preparing  $P in $PWD "
  if [ ! -d "$P" ]; then
    crewai create "$P" && cd "$P"
    poetry lock
  else
    cd "$P"
  fi
}

if [ -n "$P" ]; then
  setup
fi
exec "$@"
