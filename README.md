# Douglasg.castro_Skills

Skills públicas para **Claude Code**, do canal [@Douglasg.castro](https://youtube.com/@Douglasg.castro).

Cada skill é uma pasta com um `SKILL.md` — instruções que o Claude Code carrega
sozinho quando o assunto aparece. Conteúdo em português.

## Skills

| Skill | O que faz | Instalar |
| ----- | --------- | -------- |
| [`handoff-projeto`](skills/handoff-projeto/) | Um `handoff.md` vivo na raiz do projeto: cada sessão lê para retomar de onde parou, cada sessão que fecha atualiza. Não repete abordagem que já falhou. | [INSTALAR.md](skills/handoff-projeto/INSTALAR.md) |

## Instalação rápida (qualquer skill)

**Manual:**
1. Baixe este repositório (botão `Code → Download ZIP`, ou `git clone`).
2. Copie a pasta da skill de `skills/<nome>/` para:
   - Windows: `%USERPROFILE%\.claude\skills\<nome>\`
   - macOS / Linux: `~/.claude/skills/<nome>\`
3. Feche e reabra o Claude Code.

Cada skill tem um `INSTALAR.md` com o passo a passo específico dela (algumas pedem
uma linha no seu `CLAUDE.md`).

**Como plugin (1 comando):**
```
/plugin marketplace add douglas21grcont-wq/Douglasg.castro_Skills
/plugin install douglasg-castro-skills
```

## Licença

MIT — use, adapte e compartilhe. Ver [LICENSE](LICENSE).
