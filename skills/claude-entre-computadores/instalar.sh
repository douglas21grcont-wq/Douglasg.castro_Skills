#!/usr/bin/env bash
# instalar.sh — instala o "claude-entre-computadores" com um comando (macOS / Linux)
#
#   curl -fsSL https://raw.githubusercontent.com/douglas21grcont-wq/Douglasg.castro_Skills/master/skills/claude-entre-computadores/instalar.sh | bash
#
# Cria (ou reaproveita) ~/projetos/meu-claude no disco local, pergunta o endereço do
# seu repositório privado (em branco + GitHub CLI logado = cria um), traz o que já
# existe na ~/.claude para o repositório sem apagar nada, liga e grava a 1ª versão.
set -euo pipefail

PASTA="${PASTA:-$HOME/projetos/meu-claude}"
FONTE="${FONTE:-https://raw.githubusercontent.com/douglas21grcont-wq/Douglasg.castro_Skills/master/skills/claude-entre-computadores}"
AQUI="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || true)"

pegar() {  # $1 = caminho relativo no pacote, $2 = destino
  if [ -n "$AQUI" ] && [ -f "$AQUI/$1" ]; then cp "$AQUI/$1" "$2"
  else curl -fsSL "$FONTE/$1" -o "$2"; fi
}

command -v git >/dev/null || { echo "Git não encontrado. Instale e rode de novo."; exit 1; }
case "$PASTA" in *OneDrive*|*"Google Drive"*|*Dropbox*|*iCloud*|*CloudStorage*)
  echo "A pasta $PASTA está numa nuvem. Use uma pasta do disco local."; exit 1;; esac

TEM_GH=0; command -v gh >/dev/null && TEM_GH=1
REPO="${REPO-__perguntar__}"
if [ ! -d "$PASTA/.git" ]; then
  if [ "$REPO" = "__perguntar__" ]; then
    echo
    echo "Endereço do seu repositório PRIVADO no GitHub (ex.: https://github.com/voce/meu-claude.git)"
    [ $TEM_GH = 1 ] && echo "Primeira máquina? Deixe em branco e o repositório privado será criado." \
                    || echo "Deixe em branco para começar só neste computador."
    read -r -p "Endereço: " REPO < /dev/tty
  fi
  if [ -n "$REPO" ]; then git clone "$REPO" "$PASTA"
  else mkdir -p "$PASTA"; git -C "$PASTA" init -b main >/dev/null; fi
fi
[ "$REPO" = "__perguntar__" ] && REPO=""

pegar modelo/ligar.sh "$PASTA/ligar.sh"
[ -f "$PASTA/.gitignore" ] || pegar modelo/gitignore-modelo "$PASTA/.gitignore"
bash "$PASTA/ligar.sh"

if [ -z "$(git -C "$PASTA" config user.email || true)" ]; then
  git -C "$PASTA" config user.name "$(whoami)"; git -C "$PASTA" config user.email "$(whoami)@$(hostname).local"
fi
git -C "$PASTA" add -A
git -C "$PASTA" diff --cached --quiet || git -C "$PASTA" commit -m "Claude Code: $(hostname)" >/dev/null

if [ -z "$(git -C "$PASTA" remote)" ]; then
  if [ -z "$REPO" ] && [ $TEM_GH = 1 ] && gh auth status >/dev/null 2>&1; then
    gh repo create meu-claude --private --source "$PASTA" --push >/dev/null
    echo "  repositório privado meu-claude criado no seu GitHub"
  fi
else
  git -C "$PASTA" push -u origin HEAD
fi

echo
echo "Repositório: $PASTA"
echo "No outro computador, rode o mesmo comando e cole o endereço do repositório."
