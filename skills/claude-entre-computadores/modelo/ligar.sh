#!/usr/bin/env bash
# ligar.sh — liga este repositório à pasta ~/.claude (macOS / Linux)
#
# skills/, agents/, commands/ e CLAUDE.md viram symlink (atalho): ~/.claude/skills
# passa a ser a mesma pasta que <repositório>/skills. Editar de um lado é editar o
# outro, e o git enxerga na hora. Nada é copiado.
#
# Primeira máquina: se a sua ~/.claude já tiver skills, agentes ou comandos, eles
# são copiados para o repositório antes de ligar, e o original fica guardado com o
# sufixo _ANTIGO_<data>. Nada é apagado.
#
#     bash ligar.sh
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
DESTINO="${CLAUDE_HOME:-$HOME/.claude}"
DATA="$(date +%Y%m%d-%H%M)"
mkdir -p "$DESTINO"

ligar() {  # $1 = alvo no repositório, $2 = atalho em ~/.claude
  local alvo="$1" link="$2"
  if [ -L "$link" ]; then
    if [ "$(readlink "$link")" = "$alvo" ]; then echo "  já ligado: $link"; return; fi
    rm "$link"   # remove só o atalho
  elif [ -e "$link" ]; then
    if [ -d "$link" ]; then
      mkdir -p "$alvo"
      cp -Rn "$link"/. "$alvo"/ 2>/dev/null || true   # não sobrescreve o que já existe
    elif [ ! -e "$alvo" ]; then
      cp "$link" "$alvo"
    fi
    mv "$link" "${link}_ANTIGO_${DATA}"
    echo "  conteúdo de $link levado ao repositório; original em ${link}_ANTIGO_${DATA}"
  fi
  ln -s "$alvo" "$link"
  echo "  ligado: $link -> $alvo"
}

for pasta in skills agents commands; do
  mkdir -p "$REPO/$pasta"
  ligar "$REPO/$pasta" "$DESTINO/$pasta"
done
if [ -e "$REPO/CLAUDE.md" ] || [ -e "$DESTINO/CLAUDE.md" ]; then
  ligar "$REPO/CLAUDE.md" "$DESTINO/CLAUDE.md"
fi

echo
echo "Pronto. Feche e reabra o Claude Code."
