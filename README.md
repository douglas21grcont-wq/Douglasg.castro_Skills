# Douglasg.castro_Skills

Coleção de skills e agentes para automação de desenvolvimento com Claude Code.

Cada skill resolve um problema recorrente. Todas 100% em português, com licença MIT.

---

## 🎯 Skills

### spec-driven
**O que faz:** Automatiza código de qualidade via Specs claras + orquestração de agentes (Opus plano + Sonnet código + Haikus auditam em paralelo).

**Quando usar:** Bug complexo, refatoração, mudança em produção, qualquer projeto onde você quer zero ping-pong.

**Tempo:** 15-20 minutos (você) + 2-3 minutos (agentes, paralelo).

**Exemplo:** Layout responsivo quebrado em mobile → escreve Spec → agente gera 4 arquivos CSS + 3 auditorias PASS → você testa → commit.

**Instalar:** [skills/spec-driven/INSTALAR.md](skills/spec-driven/INSTALAR.md)

**Material de referência:**
- [Spec concreta (exemplo real)](skills/spec-driven/referencias/spec-mobile-test.html) — responsividade mobile
- [Fluxo visual (Spec → Plano → Executa → Audita)](skills/spec-driven/referencias/fluxo-spec-driven.html)
- [Acionamento prático (passo a passo do dia a dia)](skills/spec-driven/referencias/acionamento-spec-driven.html)

---

## 🤖 Agentes

### spec-executor
**O que faz:** Orquestrador que executa Specs. Lê a Spec, dispara Opus (plano) + Sonnet (código) + Haikus (auditoria), consolida relatório.

**Status:** Pronto para uso (despachado automaticamente via `/spec-driven`)

**Localização:** [agents/spec-executor.md](agents/spec-executor.md)

---

---

## 📋 Estrutura do repositório

```
Douglasg.castro_Skills/
├── skills/
│   └── spec-driven/
│       ├── SKILL.md
│       ├── INSTALAR.md
│       └── referencias/
│           ├── spec-mobile-test.html (exemplo real)
│           ├── fluxo-spec-driven.html (visual)
│           └── acionamento-spec-driven.html (passo a passo)
├── agents/
│   └── spec-executor.md (orquestrador)
└── README.md
```

---

## 🚀 Instalação rápida

### Windows
```powershell
git clone https://github.com/douglas21grcont-wq/Douglasg.castro_Skills.git
cp -r Douglasg.castro_Skills/skills/spec-driven $env:USERPROFILE/.claude/skills/
cp -r Douglasg.castro_Skills/agents/ $env:USERPROFILE/.claude/agents/
```

### macOS / Linux
```bash
git clone https://github.com/douglas21grcont-wq/Douglasg.castro_Skills.git
cp -r Douglasg.castro_Skills/skills/spec-driven ~/.claude/skills/
cp -r Douglasg.castro_Skills/agents/ ~/.claude/agents/
```

Reabra Claude Code. A skill carrega automaticamente.

---

## 💡 Como usar spec-driven

1. **Identifique um problema** (bug, refatoração, mudança)
2. **Dispare:** `/spec-driven`
3. **Capture a Spec** (problema, regras, critérios — 2-3 min)
4. **Agente executa** (Opus plano + Sonnet código + Haikus auditam — 2-3 min)
5. **Receba relatório** (código + 3 auditorias + checklist)
6. **Teste e commit** (você valida no device/ambiente real — 5-10 min)

**Tempo total:** ~20 minutos

---

## Créditos

Criadas por Douglas Garcia ([@Douglasg.castro](https://instagram.com/douglasg.castro))

Licença: MIT
