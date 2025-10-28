#!/usr/bin/env bash

# Adicione aqui diretórios adicionais que não estão no diretório atual
ADDITIONAL_DIRS=("[u]p one dir" "[n]ew window" "[q]uit")

# Cria uma string com um item por linha para o printf
additional_items=""
for dir in "${ADDITIONAL_DIRS[@]}"; do
  additional_items+="$dir\n"
done

tmux popup -E "
  # Função recursiva para navegar pelos diretórios
  # \$1 = diretório atual
  # \$2 = diretório anterior (para down)
  select_dir() {
    local current_dir=\"\$1\"
    local prev_dir=\"\$2\"

    local name=\$(
      cd \"\$current_dir\" &&
      {
        ls -d */ 2>/dev/null | sed 's#/##'
        # Adiciona [d]own apenas se houver diretório anterior
        if [ -n \"\$prev_dir\" ]; then
          printf '[d]own one dir\n'
        fi
        printf '${additional_items}'
      } |
      fzf --reverse --header=\"Dir: \$current_dir\"
    )

    if [ -z \"\$name\" ]; then
      exit 0
    fi

    # Processa comandos especiais
    case \"\$name\" in
      '[u]p one dir')
        parent_dir=\$(dirname \"\$current_dir\")
        select_dir \"\$parent_dir\" \"\$current_dir\"
        ;;
      '[d]own one dir')
        if [ -n \"\$prev_dir\" ]; then
          select_dir \"\$prev_dir\" \"\"
        fi
        ;;
      '[n]ew window')
        # Pede o nome da window
        window_name=\$(bash -c 'read -p \"Window name: \" name && echo \"\$name\"' </dev/tty)

        if [ -n \"\$window_name\" ]; then
          if tmux list-windows -F '#W' | grep -q \"^\$window_name\$\"; then
            tmux select-window -t \"\$window_name\"
          else
            tmux new-window -n \"\$window_name\" -c \"\$current_dir\"
          fi
        fi
        ;;
      '[q]uit')
        exit 0
        ;;
      *)
        # Comportamento padrão para diretórios
        if tmux list-windows -F '#W' | grep -q \"^\$name\$\"; then
          tmux select-window -t \"\$name\"
        else
          tmux new-window -n \"\$name\" -c \"\$current_dir/\$name\" 'nvim .'
        fi
        ;;
    esac
  }

  base_dir=\$(tmux display-message -p '#{pane_current_path}')
  select_dir \"\$base_dir\" \"\"
"

# # session=$(tmux display-message -p "#S")
#
#
# # if [ "$session" = "voa" ]; then
#
# # Cabeçalho do menu
# # cmd="tmux display-menu -T '#[align=centre]Apps' -x C -y C"
# # cmd="tmux list-sessions | sed -E 's/:.*$//' | grep -v \"^$(tmux display-message -p '#S')\$\" | fzf --reverse | xargs tmux switch-client -t"
#
# xargs_cmd="echo 'abcd'"
#
# tmux_action() {
#   local name="$1"
#
#   # Itera sobre cada pasta do diretório
#   for dir in "$BASE_DIR"/*/; do
#     [ -d "$dir" ] || continue
#     # name=$(basename "$dir")
#
#     # action="new-window -n $name -c '$dir' 'nvim .'"
#     action=""
#
#     # if tmux list-windows -F '#W' | grep -q 'api'; then echo "tem sim"; else echo "nao"; fi
#     if tmux list-windows -F '#W' | grep -q "$name"; then
#       action+="select-window -t '$name'"
#     else
#       action+="new-window -n '$name' -c '$dir' 'nvim .'"
#     fi
#
#     # adiciona uma entrada ao menu
#     # cmd+=" \"$name\" '' \"$action\""
#     cmd+="$action"
#   done
# }
#
# # Adiciona a opção de saída
# # cmd+=" 'Sair' q ''"
#
# # echo "$cmd"
#
# cmd=$(tmux popup "tmux display-message -p '#{pane_current_path}' | ls | fzf --reverse | xargs ${tmux_action} ")
#
# # Executa o menu
# eval "$cmd"

# else
#   tmux display-message 'Nao implementado'
# fi
