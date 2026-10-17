# Instalar "claude-entre-computadores"

Este pacote deixa o mesmo Claude Code em todos os seus computadores: as skills,
os agentes, os comandos e o CLAUDE.md ficam num repositório git seu, e cada
computador aponta para ele. Criou uma skill em casa, ela aparece no trabalho com
um `git pull`.

## Instalação em um comando

Precisa só do **git** instalado (`git --version` responde) e do Claude Code.

**Windows** (PowerShell):
```powershell
irm https://raw.githubusercontent.com/douglas21grcont-wq/Douglasg.castro_Skills/master/skills/claude-entre-computadores/instalar.ps1 | iex
```

**macOS / Linux** (terminal):
```bash
curl -fsSL https://raw.githubusercontent.com/douglas21grcont-wq/Douglasg.castro_Skills/master/skills/claude-entre-computadores/instalar.sh | bash
```

### Como rodar o comando

O comando não vai no Claude Code nem no navegador: ele é colado no **terminal** do
computador.

| sistema | onde abrir | como rodar |
|---|---|---|
| Windows | menu Iniciar, digite **PowerShell** e abra o "Windows PowerShell" (não precisa ser como administrador) | clique com o botão direito na janela para colar (ou Ctrl+V) e tecle **Enter** |
| macOS | Spotlight (Cmd+Espaço), digite **Terminal** e abra | Cmd+V para colar e tecle **Enter** |
| Linux | o terminal da sua distribuição (Ctrl+Alt+T na maioria) | Ctrl+Shift+V para colar e tecle **Enter** |

Dica: no VS Code, o terminal integrado (menu Terminal → Novo Terminal) também serve.

Se aparecer erro de "execução de scripts desabilitada" no Windows, rode antes, uma vez:
`Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` e confirme com `S`. Depois, rode o comando de novo.

### Ou peça para o Claude Code instalar

Se você já tem o Claude Code aberto, não precisa do terminal: cole este pedido na
conversa e ele faz o passo a passo por você (vai pedir permissão para rodar os comandos;
leia e aprove).

```
Instale o pacote claude-entre-computadores para mim. Leia o INSTALAR.md em
https://raw.githubusercontent.com/douglas21grcont-wq/Douglasg.castro_Skills/master/skills/claude-entre-computadores/INSTALAR.md
e rode o comando de instalação do meu sistema. Pergunte o endereço do meu
repositório privado do GitHub quando precisar.
```

O resultado é o mesmo do comando no terminal.

O comando pergunta uma coisa só: o endereço do seu repositório privado no GitHub.

- **Primeiro computador:** deixe em branco. Se você tem o [GitHub CLI](https://cli.github.com)
  logado (`gh auth login`), ele cria o repositório privado `meu-claude` sozinho. Sem o
  GitHub CLI, tudo fica pronto neste computador e você liga ao GitHub depois
  (`git remote add origin <endereço>` e `git push -u origin main`).
- **Outros computadores:** cole o endereço do repositório (ex.:
  `https://github.com/voce/meu-claude.git`).

O que ele faz: cria `C:\projetos\meu-claude` (ou `~/projetos/meu-claude`) no disco
local, traz as skills, agentes, comandos e o CLAUDE.md que você já tem (nada é
apagado; a pasta original fica guardada com `_ANTIGO_<data>`), liga a `~/.claude` ao
repositório e grava a primeira versão. Depois, feche e reabra o Claude Code.

Prefere fazer à mão, ou quer entender cada etapa? Siga o passo a passo abaixo.

## Passo a passo manual: primeira máquina

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

## Passo a passo manual: outro computador

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
