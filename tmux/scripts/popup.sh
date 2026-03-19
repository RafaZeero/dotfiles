#!/usr/bin/env bash

COMMANDS=(
  "[p]npm dev"
  "[y]arn dev"
  "[g]o run"
  "[m]ake run"
  "[u]v run ipython"
  "[c]ustom command"
  "[q]uit"
)

commands_items=""
for cmd in "${COMMANDS[@]}"; do
  commands_items+="$cmd\n"
done

tmux display-popup -E "
  run_cmd() {
    local current_dir=\"\$(tmux display-message -p '#{pane_current_path}')\"

    local selected=\$(printf \"$commands_items\" | fzf --reverse --header=\"Run command in: \$current_dir\")

    [ -z \"\$selected\" ] && exit 0

    case \"\$selected\" in
      '[p]npm dev')
        cmd='pnpm dev'
        ;;
      '[y]arn dev')
        cmd='yarn dev'
        ;;
      '[g]o run')
        cmd='go run .'
        ;;
      '[m]ake run')
        cmd='make run'
        ;;
      '[u]v run ipython')
        cmd='uv run ipython'
        ;;
      '[c]ustom command')
        cmd=\$(bash -c 'read -p \"Command: \" input && echo \"\$input\"' </dev/tty)
        ;;
      '[q]uit')
        exit 0
        ;;
    esac

    [ -z \"\$cmd\" ] && exit 0

    session_name=\$(echo \"\$current_dir\" | sed \"s|\$HOME/||\" | tr '/' '-' | tr ' ' '-')

    # Se sessão já existe → attach
    tmux has-session -t \"\$session_name\" 2>/dev/null

    if [ \$? -eq 0 ]; then
      tmux attach -t \"\$session_name\"
    else
      tmux new-session -s \"\$session_name\" -c \"\$current_dir\" \"bash -lc '\$cmd'\"
    fi
  }

  run_cmd
"
