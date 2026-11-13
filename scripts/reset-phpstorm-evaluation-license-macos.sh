#!/bin/bash
# Compatível com o Bash 3.2 incluído no macOS.
set -euo pipefail

usage() {
    echo "Uso: bash $0 [--dry-run]"
    echo "  --dry-run  Lista os caminhos que seriam removidos sem alterar nada."
}

DRY_RUN=false
case "${1:-}" in
    --dry-run) DRY_RUN=true ;;
    -h|--help) usage; exit 0 ;;
    "") ;;
    *) usage >&2; exit 1 ;;
esac
if [ "$#" -gt 1 ]; then
    usage >&2
    exit 1
fi

if [ "$(uname -s)" != "Darwin" ]; then
    echo "Este script é exclusivo para macOS." >&2
    exit 1
fi

if pgrep -if '/[p]hpstorm\.app/Contents/|[c]om\.intellij\.idea\.Main.*[Pp]hp[Ss]torm' >/dev/null; then
    echo "Feche o PhpStorm antes de executar este script." >&2
    exit 1
fi

shopt -s nullglob
JETBRAINS_DIR="$HOME/Library/Application Support/JetBrains"
FOUND=false
LATEST_CONFIG=""
LATEST_VERSION=""

# Compara cada componente numérico (2026.10 é posterior a 2026.3).
version_is_newer() {
    awk -v candidate="$1" -v current="$2" 'BEGIN {
        n = split(candidate, a, ".")
        m = split(current, b, ".")
        for (i = 1; i <= n || i <= m; i++) {
            if (a[i] + 0 > b[i] + 0) exit 0
            if (a[i] + 0 < b[i] + 0) exit 1
        }
        exit 1
    }'
}

remove_target() {
    local target="$1"
    [ -e "$target" ] || [ -L "$target" ] || return 0
    FOUND=true
    if [ "$DRY_RUN" = true ]; then
        printf '[Simulação] Remover: %s\n' "$target"
    else
        rm -rf -- "$target"
        printf 'Removido: %s\n' "$target"
    fi
}

# Não atravessar um link no diretório base.
if [ -d "$JETBRAINS_DIR" ] && [ ! -L "$JETBRAINS_DIR" ]; then
    for config in "$JETBRAINS_DIR"/PhpStorm[0-9]*; do
        [ -d "$config" ] && [ ! -L "$config" ] || continue
        version="${config##*/PhpStorm}"
        [[ "$version" =~ ^[0-9]+(\.[0-9]+)*$ ]] || continue
        if [ -z "$LATEST_CONFIG" ] || version_is_newer "$version" "$LATEST_VERSION"; then
            LATEST_CONFIG="$config"
            LATEST_VERSION="$version"
        fi
    done

    remove_target "$JETBRAINS_DIR/consentOptions"
    if [ -n "$LATEST_CONFIG" ]; then
        remove_target "$LATEST_CONFIG/phpstorm.key"
    fi
fi

if [ "$FOUND" = false ]; then
    echo "Nenhum consentOptions ou phpstorm.key da versão mais recente foi encontrado."
elif [ "$DRY_RUN" = false ]; then
    echo "Concluído."
fi
