---
name: spec-driven
description: Cria Specs técnicas claras, dispara agente orquestrador (Opus plano + Sonnet código + Haikus auditam) e consolida relatório final.
---

# Spec-Driven Development

Automatize código com qualidade: escreva **Specs** claras, deixe os agentes executarem e auditarem em paralelo.

## O que é

Uma **Spec** = documento estruturado que captura:
- **Problema** (o quê precisa ser feito e por quê)
- **Regras de negócio** (restrições, critérios de aceitação)
- **Escopo** (quais arquivos/módulos)

Depois que a Spec está pronta, um **agente orquestrador** faz:
1. **Opus** divide em plano de 10 etapas
2. **Sonnet** executa o plano (edita arquivos)
3. **3 Haikus** auditam em paralelo (design system, responsividade, acessibilidade)
4. **Consolida** um relatório final com código + auditorias

**Resultado:** código gerado, validado e pronto para você testar.

## Quando usar

- ✓ Bug complexo que precisa de contexto (layout, integração, regras de negócio)
- ✓ Refatoração com critérios claros (design system, responsividade, performance)
- ✓ Mudança em produção que não pode errar
- ✓ Qualquer projeto onde você quer **zero ping-pong** (agente erra uma vez, volta certo)

## Como funciona

### Passo 1: Você dispara
```
/spec-driven
```

### Passo 2: Captura a Spec
A skill guia você com perguntas:
- Qual é o projeto? (nome seu, repositório, componente)
- Qual é o problema/objetivo?
- Quais são as regras de negócio?
- Qual é o escopo (arquivos)?

Ou você traz uma Spec pronta (markdown/texto estruturado).

### Passo 3: Skill monta Spec em artifact
Você revisa rápido (≈1 min), aprova.

### Passo 4: Agente `spec-executor` orquestra
- Opus lê Spec → divide em 10 etapas
- Sonnet executa cada etapa (edita seus arquivos)
- 3 Haikus auditam em paralelo
- Consolida relatório com código + checklist

### Passo 5: Você recebe relatório
- Código gerado (diffs legíveis)
- 3 auditorias (PASS/FAIL)
- Próximos passos

### Passo 6: Você testa
Abre o código, testa em device/ambiente real. Se OK → commit. Se não → refina Spec e tenta de novo.

## Exemplo real

**Problema:** Layout responsivo quebrado em mobile (viewport ≤768px).

**Spec criada:**
- Objetivo: 100% funcional mobile
- Regras: Design system consistente, botões ≥44px, tabelas scroll interno
- Critérios: 8 checklist items

**Resultado do agente:**
- 4 arquivos editados (CSS com @media queries)
- 3 auditorias passaram (design system, responsividade, acessibilidade)
- Código pronto, você testa, commit feito.

**Tempo:** 15-20 minutos (você) + 2-3 minutos (agente, paralelo).

## Integração com handoff

Não tem histórico? Sem problema — Spec é clara o suficiente.

Próxima iteração? `handoff.md` captura o que aprendeu:
- "Overflow-x: auto funciona melhor que card conversion"
- "Verificar gráficos complexos antes (requerem validação visual)"

Agente lê `handoff.md` antes de começar (se existir).

## Fluxo completo

1. **Você:** `/spec-driven` → captura problema em 2 minutos
2. **Skill:** Monta Spec estruturada → você aprova (1 min)
3. **Agente:** Opus (plano) + Sonnet (código) + 3 Haikus (auditam em paralelo) → 2-3 min
4. **Você:** Recebe relatório com código + auditorias → revisa (5 min)
5. **Você:** Testa em device real → commit (10 min)

## Próximos passos

Escolha um problema real do seu projeto e dispara: `/spec-driven`. A skill guia você de lá.
