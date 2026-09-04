---
name: handoff-projeto
description: >
  Passagem de bastão entre sessões de IA dentro de um mesmo projeto: um handoff.md
  vivo na raiz do repositório/pasta, lido a cada sessão para retomar de onde parou
  e atualizado no fim para a próxima. Use quando você disser "gera handoff",
  "atualiza o handoff", "fecha a sessão", "passa o bastão", "documenta o estado",
  "onde paramos", "retoma o projeto", "lê o handoff", "me põe em contexto", ou
  pedir para registrar o que NÃO tentar de novo. Funciona em qualquer projeto.
---

# Handoff de Projeto

Um arquivo `handoff.md` **na raiz do projeto atual**, versionado junto com o código.
É um documento **vivo**: cada sessão o lê para saber onde continuar e o atualiza antes
de encerrar. Assim, uma segunda sessão no mesmo repositório — inclusive em outra
máquina, via git — retoma sem re-descobrir tudo nem repetir erros.

Não confundir com a memória nativa do Claude Code: memória = fatos transversais seus;
handoff = estado vivo de **um** projeto.

## Onde fica

`handoff.md` fica **na raiz do workspace da sessão** (o diretório de onde o Claude Code
foi aberto) — é onde a regra do `CLAUDE.md` (ver `INSTALAR.md`) o encontra sozinho.
Não adianta pôr num subdiretório.

Se o workspace for um **container** que guarda o repo git de verdade num subdiretório:

- `git rev-parse` no cwd falha → o `handoff.md` do container **não é versionado**;
  sincroniza pelo mecanismo daquela pasta (nuvem), não por git. Está ok para um `.md`
  solto — só avise que é assim.
- Se preferir versionar, mova o `handoff.md` para dentro do subdiretório do repo **e**
  passe a abrir o workspace ali (senão a regra do `CLAUDE.md` não acha).

## Primeira vez num projeto (fazer uma vez)

**Segurança de deploy.** Só importa se o `handoff.md` cair **dentro** de um repo que
publica a raiz. Quando estiver:

- Checar `.github/workflows/*.yml`, `.deployignore` ou rsync/ssh/ftp no deploy.
- Se houver, **adicionar `handoff.md` à exclusão do deploy** (`.deployignore`,
  `paths-ignore`, `--exclude`) e avisar antes do próximo push.
- Nunca resolver com `.gitignore`: quebraria a sincronização entre máquinas via git.

## Início de sessão — LER e retomar

Quando abrir trabalho num projeto que tem `handoff.md`:

1. Ler o arquivo inteiro.
2. Resumir nesta ordem:
   - **§5 Próximos passos** — ponto de retomada;
   - **§4 O que NÃO fazer** — checar qualquer proposta contra esta lista antes de sugerir;
   - **§3 O que já funciona** — não mexer no que está estável.
3. Se o handoff citar arquivo/função/flag, conferir se ainda existe antes de agir.
4. Se estiver defasado do `git log` (commits novos que ele não menciona), avisar e
   sugerir atualizar antes de seguir.

## Fim de sessão — ATUALIZAR e acumular

Quando pedirem para fechar a sessão, gerar ou atualizar o handoff:

1. **Auto-detectar o que a máquina sabe** (não perguntar o que dá para ler):
   - Stack: `package.json`, `requirements.txt`/`pyproject.toml`, `composer.json`, `go.mod`.
   - Histórico: `git log --oneline -20`, `git status`, branch atual.
   - Estrutura: árvore das pastas-chave (2 níveis).
2. Se não existir `handoff.md`, copiar `template.md` para a raiz e fazer a etapa
   "Primeira vez num projeto".
3. **Atualizar as seções vivas** (§1–§3, §5, §6) com o estado de agora — reescrever
   o que mudou, manter o que continua válido.
4. **Acrescentar (nunca sobrescrever) em §4 e §7:**
   - **§4 "O que NÃO fazer"** é append-only: cada abordagem que falhou nesta sessão
     vira uma entrada nova, com data absoluta e o motivo. Nunca apagar entrada antiga.
   - **§7 "Histórico de sessões"**: uma linha por sessão — `AAAA-MM-DD · máquina · o
     que foi feito · onde parou`.
5. **Regras de escrita:**
   - Toda data em formato absoluto (`AAAA-MM-DD`). Nada de "ontem".
   - No bloco de metadados do topo: data da atualização e máquina.
   - Marcar `[x]` só o que foi validado de fato.
6. **Não commitar.** Avisar que o `handoff.md` está pronto para a pessoa subir no
   fluxo de commit dela. Em pasta sem git, avisar que a sincronização é pela nuvem
   daquela pasta.

## Restrições

- Um `handoff.md` por projeto, sempre na raiz (ou `.claude/`) — nunca centralizado.
- Não duplicar o que já está em `CLAUDE.md`, na memória nativa ou no `git log` — o
  handoff aponta, não copia.
- Diretrizes específicas do projeto (ex.: "dados sensíveis só na LLM local") vão na
  §6 do handoff daquele projeto, não nesta skill.
