# Instalar o time "auditoria-seguranca"

Este time tem três peças que trabalham juntas: uma **skill** (o especialista, carrega sozinho
quando o assunto aparece), um **agente** (a varredura pesada, para repositório grande) e um
**comando** (o atalho `/auditoria-seguranca`, que você dispara na mão). As três precisam ir para
pastas diferentes.

## Claude Code (terminal / VS Code)

1. Baixe as três pastas/arquivos deste repositório:
   - `skills/auditoria-seguranca/` (com `SKILL.md` dentro)
   - `agents/auditor-seguranca.md`
   - `commands/auditoria-seguranca.md`
2. Copie cada um para a pasta correspondente do seu usuário:
   - Windows:
     - `%USERPROFILE%\.claude\skills\auditoria-seguranca\`
     - `%USERPROFILE%\.claude\agents\auditor-seguranca.md`
     - `%USERPROFILE%\.claude\commands\auditoria-seguranca.md`
   - macOS / Linux:
     - `~/.claude/skills/auditoria-seguranca/`
     - `~/.claude/agents/auditor-seguranca.md`
     - `~/.claude/commands/auditoria-seguranca.md`
3. Feche e reabra o Claude Code.
4. Teste: digite `/auditoria-seguranca` num repositório seu, ou diga "audita a segurança desse
   projeto" — a skill deve carregar sozinha mesmo sem o comando.

Só a skill funciona sem o agente e o comando (ela carrega por conta própria quando o assunto
aparece) — mas sem o agente, repositórios grandes vão consumir mais contexto da sua conversa, e
sem o comando você perde o atalho de disparo direto.

## Instalar como plugin (alternativa, 1 comando)

```
/plugin marketplace add douglas21grcont-wq/Douglasg.castro_Skills
/plugin install douglasg-castro-skills
```

O plugin já traz as três peças juntas, nas pastas certas.

## claude.ai (sem terminal)

Configurações → Habilidades → nova habilidade → cole o conteúdo do `SKILL.md`. O agente e o
comando são recursos do Claude Code — no claude.ai só a skill funciona, sem o atalho `/` e sem o
despacho de varredura em paralelo.

---

## Como usar

**Auditoria simples ou repositório pequeno:** diga "audita a segurança desse projeto" ou disparar
`/auditoria-seguranca [caminho, opcional]`. A skill carrega, lê o código à procura de 15 categorias
de falha (segredo vazado, autorização/RLS, XSS, injeção, IDOR, lógica de negócio, upload, sessão,
CORS/SSRF, cabeçalhos, anti-automação, divulgação de informação, dependências, LGPD, armazenamento
no cliente) e grava um laudo `AUDITORIA-SEGURANCA.md` na raiz do repositório.

**Repositório grande:** a própria skill despacha o agente `auditor-seguranca` para não gastar o
contexto da conversa principal com a varredura inteira — você recebe só o relatório final.

**Antes de qualquer lançamento:** rode a auditoria como parte do checklist de ir ao ar, mesmo sem
achar nada suspeito à primeira vista — ela é pensada para ser preventiva, não reativa.

## O que ela NUNCA faz

- Não ataca sistema em produção nem de terceiros — só lê o código no disco, do seu próprio repositório.
- Não altera código nem toca em servidor.
- Não commita nem dá push — o laudo fica pronto pra você revisar e subir do seu jeito.

## Tempo esperado

- Repositório pequeno/médio, direto pela skill: alguns minutos.
- Repositório grande, via agente: alguns minutos em paralelo, sem consumir a sua conversa principal.
