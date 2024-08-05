#!/usr/bin/env bash
function sv() {
  if [ -d ".venv" ]; then
    source ".venv/bin/activate"
  fi
}
sv
