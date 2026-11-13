#!/bin/bash

ALIAS_NAME="reset-phpstorm"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_SCRIPT="$SCRIPT_DIR/scripts/reset-phpstorm-all-versions.sh"

if [[ ! -f ~/.bash_aliases ]]; then
    echo "O arquivo ~/.bash_aliases não existe. Crie-o manualmente antes de executar este script."
    exit 1
fi

if [[ ! -f "$TARGET_SCRIPT" ]]; then
    echo "O script $TARGET_SCRIPT não foi encontrado."
    exit 1
fi

if ! grep -q "$ALIAS_NAME" ~/.bash_aliases; then
    echo "Adicionando '$ALIAS_NAME' alias ao ~/.bash_aliases..."
    sleep 2
    echo "."
    sleep 1
    echo ".."
    sleep 1
    echo "..."
    sleep 2
    echo "alias $ALIAS_NAME='$TARGET_SCRIPT'" >> ~/.bash_aliases
else
    echo "Alias já existe em ~/.bash_aliases."
fi

source ~/.bash_aliases
chmod +x "$TARGET_SCRIPT"

echo "Setup concluído! Você pode usar o alias '$ALIAS_NAME' para executar o script."
