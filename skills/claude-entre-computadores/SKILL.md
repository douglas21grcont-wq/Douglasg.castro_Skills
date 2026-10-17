---
name: claude-entre-computadores
description: Monta e mantém o mesmo Claude Code em vários computadores, guardando skills, agentes, comandos e CLAUDE.md num repositório git ligado à pasta ~/.claude por atalho de pasta. Use quando o usuário disser "quero o mesmo Claude em casa e no trabalho", "como levo minhas skills para outro computador", "formatei o PC e perdi as skills", "sincroniza minhas skills", "minha skill não aparece no outro computador".
---

# Claude entre computadores

Skills, agentes, comandos e o CLAUDE.md moram num **repositório git** e não na
pasta `~/.claude`. A `~/.claude` só aponta para o repositório por atalho de pasta
(junction no Windows, symlink no macOS/Linux). Resultado: editar uma skill já é
editar o repositório, e o outro computador recebe com `git pull`.

## Regras que não mudam

1. **Repositório fora de pasta de nuvem.** Nunca dentro de OneDrive, Google Drive,
   Dropbox ou iCloud: a sincronização da nuvem e o git brigam pelos mesmos arquivos
   e o repositório corrompe (`fatal: mmap failed` é o sintoma comum). Use algo como
   `C:\projetos\meu-claude` ou `~/projetos/meu-claude`. Git edita, nuvem no máximo lê.
2. **Repositório privado.** CLAUDE.md e skills costumam ter nome de cliente, caminho
   e jeito de trabalhar. Público só o que foi limpo de propósito.
3. **Nunca apagar `~/.claude/skills` com `Remove-Item -Recurse` ou `rm -rf`.**
   Num atalho de pasta isso apaga o conteúdo do repositório. Para desligar:
   Windows `[System.IO.Directory]::Delete("<caminho>", $false)`, macOS/Linux `rm <atalho>` (sem `-r`).
4. **Segredo não entra.** `.env`, token e senha ficam fora (o `gitignore-modelo` já cobre o básico).

## Montar pela primeira vez

Siga o `INSTALAR.md` desta pasta. Resumo:
1. Criar um repositório **privado** vazio no GitHub.
2. Clonar fora da nuvem.
3. Copiar para a raiz dele os arquivos de `modelo/` (`ligar.ps1`, `ligar.sh`, e o
   `gitignore-modelo` renomeado para `.gitignore`).
4. Rodar o `ligar` da sua plataforma. Na primeira máquina ele traz as skills que já
   existem para dentro do repositório e guarda a pasta original com `_ANTIGO_<data>`.
5. `git add . ; git commit -m "meu claude" ; git push`.
6. No outro computador: clonar e rodar o `ligar`. Pronto.

## Rotina

- **Ao começar:** `git pull` no repositório.
- **Ao terminar:** `git add . ; git commit -m "o que mudou" ; git push`.
- **Editou o CLAUDE.md no Windows?** Rode o `ligar.ps1` de novo (no Windows ele é
  cópia; skills, agentes e comandos não precisam).
- **Computador formatado:** instalar git e Claude Code, clonar, rodar o `ligar`.

## Diagnóstico rápido

| sintoma | causa provável | o que fazer |
|---|---|---|
| skill nova não aparece no outro PC | faltou `git push` de um lado ou `git pull` do outro | `git status` e `git log -1` nos dois |
| `~/.claude/skills` virou pasta comum | algum instalador recriou a pasta | rodar o `ligar` de novo (ele guarda a pasta e religa) |
| git reclama de arquivo corrompido | repositório dentro de pasta de nuvem | clonar de novo fora da nuvem e copiar só o que não estava commitado |
| CLAUDE.md diferente entre as máquinas (Windows) | editou a cópia em `~/.claude` | editar no repositório e rodar o `ligar.ps1` |
| aparece `skills/.trash/` no git | o app do Claude guarda ali skills ao trocar de conta | já está no `gitignore-modelo` |

Ao ajudar o usuário, confira o caminho real antes de rodar qualquer comando
(`$env:USERPROFILE` no Windows, `$HOME` no macOS/Linux) e nunca rode o `ligar`
sem ele saber que vai mexer na `~/.claude`.
