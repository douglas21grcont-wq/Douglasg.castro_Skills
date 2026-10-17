# Instalar "claude-entre-computadores"

Este pacote deixa o mesmo Claude Code em todos os seus computadores: as skills,
os agentes, os comandos e o CLAUDE.md ficam num repositório git seu, e cada
computador aponta para ele. Criou uma skill em casa, ela aparece no trabalho com
um `git pull`.

Tempo: uns 15 minutos na primeira máquina, 2 minutos nas outras.

## O que você precisa

- Git instalado (`git --version` responde).
- Uma conta no GitHub (ou GitLab, Bitbucket: qualquer remoto privado serve).
- Claude Code instalado nos computadores.

## Passo a passo: primeira máquina

**1. Crie um repositório privado e vazio no GitHub.**
Nome sugerido: `meu-claude`. Marque **Private**. Não adicione README.

**2. Clone fora de qualquer pasta de nuvem.**
OneDrive, Google Drive, Dropbox e iCloud corrompem repositório git.

Windows (PowerShell):
```powershell
mkdir C:\projetos -Force ; cd C:\projetos
git clone https://github.com/<seu-usuario>/meu-claude.git
```
macOS / Linux:
```bash
mkdir -p ~/projetos && cd ~/projetos
git clone https://github.com/<seu-usuario>/meu-claude.git
```

**3. Copie os arquivos do modelo para a raiz do seu repositório.**
Desta pasta (`claude-entre-computadores/modelo/`), copie:
- `ligar.ps1` (Windows) e `ligar.sh` (macOS/Linux)
- `gitignore-modelo`, renomeado para `.gitignore`

**4. Rode o ligar.**
Windows:
```powershell
cd C:\projetos\meu-claude
powershell -ExecutionPolicy Bypass -File .\ligar.ps1
```
macOS / Linux:
```bash
cd ~/projetos/meu-claude
bash ligar.sh
```
O que acontece:
- As skills, agentes e comandos que você já tinha em `~/.claude` são **copiados
  para o repositório**.
- A pasta original fica guardada ao lado, com o nome `skills_ANTIGO_<data>`. Nada é apagado.
- `~/.claude/skills`, `agents` e `commands` passam a ser atalhos para o repositório.
- O CLAUDE.md vai para o repositório também.

**5. Confira e envie.**
Abra o Claude Code e digite `/`: suas skills e comandos devem aparecer como antes.
Depois:
```bash
git add .
git commit -m "meu claude"
git push
```
Quando tudo estiver certo, pode apagar as pastas `_ANTIGO_` da `~/.claude`.

## Passo a passo: outro computador

1. Instale git e Claude Code.
2. Clone o **seu** repositório fora da nuvem (passo 2 acima).
3. Rode o `ligar` (passo 4 acima).
4. Abra o Claude Code. Está tudo lá.

## Rotina do dia a dia

| quando | o que fazer |
|---|---|
| ao começar | `git pull` no repositório |
| ao terminar | `git add .` → `git commit -m "o que mudou"` → `git push` |
| editou o CLAUDE.md (Windows) | rode o `ligar.ps1` de novo, porque no Windows ele é cópia |
| uma skill quebrou depois de uma edição | `git log` mostra o que mudou; `git checkout <versão> -- skills/<nome>` volta |
| formatou o computador | instale git e Claude Code, clone e rode o `ligar` |

## Cuidados

- **Para desligar, nunca apague `~/.claude/skills` com `Remove-Item -Recurse` ou `rm -rf`.**
  Num atalho de pasta isso apaga o conteúdo do repositório.
  Windows: `[System.IO.Directory]::Delete("$env:USERPROFILE\.claude\skills", $false)`.
  macOS/Linux: `rm ~/.claude/skills` (sem `-r`).
- **Repositório privado.** Seu CLAUDE.md tem o seu jeito de trabalhar, às vezes nome de cliente.
- **Senha, token e `.env` ficam fora do git.**

## Instalar a skill (opcional)

A skill `claude-entre-computadores` ensina o Claude a montar e diagnosticar esse
esquema para você ("minha skill não aparece no outro computador").

1. Copie a pasta `claude-entre-computadores/` (com o `SKILL.md`) para
   `~/.claude/skills/` (Windows: `%USERPROFILE%\.claude\skills\`). Se você já fez o
   passo a passo acima, copie para `skills/` do seu repositório.
2. Feche e reabra o Claude Code.
3. Teste: `quero o mesmo Claude em casa e no trabalho`.

Ou como plugin:
```
/plugin marketplace add douglas21grcont-wq/Douglasg.castro_Skills
/plugin install douglasg-castro-skills
```
