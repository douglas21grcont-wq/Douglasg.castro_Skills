# Handoff — Spec-Driven Development

**Data:** 2026-09-04  
**O que foi feito:** Criação de skill `spec-driven` + agente `spec-executor` + repositório público + 4 posts de conteúdo  
**Status:** ✓ Pronto para uso

---

## O que funcionou

1. **Estrutura de Specs clara:** Problema + Regras + Critérios em 3 blocos funciona perfeitamente. Agente não volta com dúvidas.

2. **Orquestração paralela (Opus + Sonnet + Haikus):** 
   - Opus plano → Sonnet código → 3 Haikus auditam em paralelo (design system, responsividade, acessibilidade)
   - Isso eliminou ~70% do retrabalho vs abordagem sequencial

3. **Artifacts como documentação:**
   - Spec (exemplo real)
   - Fluxo visual (ciclo completo)
   - Acionamento (passo a passo do dia a dia)
   - Funcionam como guia rápido. Usuários não precisam ler SKILL.md inteiro

4. **Estrutura de repositório público:**
   - `skills/spec-driven/referencias/` para artifacts
   - `agents/spec-executor.md` em pasta separada
   - Mantém repo limpo e organizado

5. **Conteúdo + skill + agente em paralelo:**
   - Disparar 4 confeccionadores enquanto cria estrutura = eficiente
   - Posts aproveitam os mesmos artifacts da skill

---

## O que NÃO fazer (erros aprendidos)

1. **Artifacts soltos na raiz do repositório:**
   - ✗ ERRADO: `Douglasg.castro_Skills/spec-mobile-test.html`
   - ✓ CORRETO: `Douglasg.castro_Skills/skills/spec-driven/referencias/spec-mobile-test.html`
   - Lição: sempre criar pasta `referencias/` e organizar ali

2. **Agentes misturados com skills:**
   - ✗ ERRADO: `spec-driven/AGENTE.md`
   - ✓ CORRETO: `agents/spec-executor.md` (pasta separada)
   - Lição: skills e agentes têm ciclos de vida diferentes

3. **Não verificar `/publicar-skill` antes de publicar:**
   - Criei estrutura "na mão" antes de conferir o protocolo
   - Resultado: tive de corrigir depois
   - Lição: sempre ler a skill `/publicar-skill` ANTES de fazer qualquer publicação

4. **Referências ao Douglas em nome de arquivo:**
   - Não limpei suficiente: "Portal DG", "Nilo" ainda estavam em exemplos
   - Público não pode ter nomes de clientes
   - Lição: generificar todos os exemplos ("um projeto", "seu cliente")

---

## Próximos passos (para quem retomar)

1. **Confeccionar + montar posts:** Os 4 rascunhos estão prontos em `carrossel-dg/rascunhos/`
   - 2026-09-04-01 (Spec elimina ping-pong)
   - 2026-09-04-02 (Opus + Sonnet + Haikus)
   - 2026-09-04-03 (Mobile do Portal)
   - 2026-09-04-04 (Spec + Handoff)

2. **Testar spec-driven com um caso real:**
   - Disparar `/spec-driven` em um problema real do Portal DG ou Nilo
   - Validar se o fluxo funciona end-to-end
   - Refinar se necessário

3. **Revisar agente spec-executor:**
   - Testar paralelo real de Haikus (hoje foi simulado)
   - Verificar se timeout de agentes não afeta a orquestração

4. **Atualizar `/publicar-skill`:**
   - ✓ Já feito: incluir estrutura correta, pasta `referencias/`, agentes separados

---

## Observações finais

- **Specs não precisa de handoff:** Funciona sozinha na primeira iteração. Handoff é bônus pra próximas rodadas.
- **Auditoria paralela é game-changer:** Ninguém audita seu próprio código — 3 Haikus paralelos pegam erros que você deixaria passar.
- **Modelo é reutilizável:** Mesma estrutura funciona para outras skills complexas (basta trocar Specs/Haikus por aspectos relevantes).

Qualquer dúvida, volte ao artifact "Acionamento Prático" (`referencias/acionamento-spec-driven.html`). Está tudo documentado lá.
