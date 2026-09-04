# Instalar a skill "handoff-projeto"

Skills são pastas que o Claude Code carrega sozinho quando o assunto aparece.
Esta cria e mantém um `handoff.md` na raiz do seu projeto — um resumo vivo do
estado dele, para a próxima sessão (ou a próxima máquina) retomar sem se perder.

## Claude Code (terminal / VS Code)

1. Baixe a pasta `handoff-projeto/` (com `SKILL.md` e `template.md` dentro).
2. Mova para a pasta de skills do seu usuário:
   - **Windows:** `%USERPROFILE%\.claude\skills\handoff-projeto\`
   - **macOS / Linux:** `~/.claude/skills/handoff-projeto\`
3. **Recomendado — leitura automática no início da sessão.**
   Abra o seu `CLAUDE.md` global (`~/.claude/CLAUDE.md`; crie se não existir) e
   adicione a linha:
   ```
   Se existir ./handoff.md na raiz, leia antes de começar qualquer tarefa.
   ```
   Sem essa linha a skill ainda funciona, mas só quando você pedir por voz
   ("lê o handoff", "onde paramos").
4. Feche e reabra o Claude Code.
5. **Teste:**
   - No fim de uma sessão, num projeto qualquer: `gera o handoff`.
     Ela cria `handoff.md` na raiz, preenchido com o estado atual.
   - Na sessão seguinte: `onde paramos?` — ela lê o `handoff.md` e resume
     próximos passos, o que não tentar de novo, e o que já está estável.

## Instalar como plugin (alternativa, 1 comando)

```
/plugin marketplace add douglas21grcont-wq/Douglasg.castro_Skills
/plugin install douglasg-castro-skills
```

## claude.ai (sem terminal)

Configurações → Habilidades → nova habilidade → cole o conteúdo do `SKILL.md`.
O `template.md` você cola junto, no fim, como referência do formato do arquivo.

## Como funciona, em uma frase

Toda sessão nova lê o `handoff.md`; toda sessão que fecha o atualiza. As seções
"O que NÃO fazer" e "Histórico de sessões" só crescem — nunca se apaga o que já
custou para aprender.
