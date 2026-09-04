# Instalar a skill "spec-driven"

Skills são pastas que o Claude Code carrega sozinho quando o assunto aparece.

## Claude Code (terminal / VS Code)

1. Baixe esta pasta (`spec-driven/`) com o `SKILL.md` e `AGENTE.md` dentro.
2. Mova para a pasta de skills do seu usuário:
   - Windows: `%USERPROFILE%\.claude\skills\spec-driven\`
   - macOS / Linux: `~/.claude/skills/spec-driven/`
   A pasta precisa conter `SKILL.md` e `AGENTE.md`.
3. Feche e reabra o Claude Code.
4. Teste: `/spec-driven` — a skill deve carregar.

## Instalar como plugin (alternativa, 1 comando)

```
/plugin marketplace add douglas21grcont-wq/Douglasg.castro_Skills
/plugin install douglasg-castro-skills
```

## claude.ai (sem terminal)

Configurações → Habilidades → nova habilidade → cole o conteúdo do `SKILL.md`.

---

## Como usar

Dispara: `/spec-driven`

A skill guia você a capturar uma Spec (documento técnico do seu problema). Depois um agente orquestra:
- Opus: plano (10 etapas)
- Sonnet: código (executa)
- 3 Haikus: auditam em paralelo

Resultado: código gerado + auditado + pronto para testar.

## Tempo esperado

- Sua parte: 2-3 minutos (capturar Spec) + 5-10 minutos (testar) + 1 minuto (commit)
- Agente: 2-3 minutos (em paralelo)

Total: ~15-20 minutos, economia de ~50% vs desenvolvimento manual com correções.
