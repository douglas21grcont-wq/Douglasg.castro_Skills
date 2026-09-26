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

### auditoria-seguranca
**O que faz:** Auditoria defensiva e completa de segurança do seu código — 15 categorias (segredo vazado, autorização/RLS, XSS, injeção, IDOR, lógica de negócio, upload, sessão/JWT, CORS/SSRF, cabeçalhos, anti-automação, divulgação de informação, dependências, LGPD, armazenamento no cliente) + recomendações de infraestrutura. Só lê e reporta — nunca ataca sistema no ar, nunca altera código.

**Quando usar:** Antes de qualquer lançamento, ou sempre que quiser saber "isso está seguro?".

**Time completo:** skill (carrega sozinha) + agente `auditor-seguranca` (varredura pesada, repositório grande) + comando `/auditoria-seguranca` (atalho direto).

**Instalar:** [skills/auditoria-seguranca/INSTALAR.md](skills/auditoria-seguranca/INSTALAR.md)

---

## 🤖 Agentes

### spec-executor
**O que faz:** Orquestrador que executa Specs. Lê a Spec, dispara Opus (plano) + Sonnet (código) + Haikus (auditoria), consolida relatório.

**Status:** Pronto para uso (despachado automaticamente via `/spec-driven`)

**Localização:** [agents/spec-executor.md](agents/spec-executor.md)

---

### auditor-seguranca
**O que faz:** Varredura de segurança de repositório grande, sem gastar o contexto da conversa principal. Segue o checklist da skill `auditoria-seguranca` e devolve o laudo consolidado.

**Status:** Pronto para uso (despachado automaticamente pela skill, ou peça direto)

**Localização:** [agents/auditor-seguranca.md](agents/auditor-seguranca.md)

---

## ⚡ Comandos

### /auditoria-seguranca
**O que faz:** Atalho direto para disparar a auditoria de segurança sem precisar descrever o pedido.

**Localização:** [commands/auditoria-seguranca.md](commands/auditoria-seguranca.md)

---

---

## 📋 Estrutura do repositório

```
Douglasg.castro_Skills/
├── skills/
│   ├── spec-driven/
│   │   ├── SKILL.md
│   │   ├── INSTALAR.md
│   │   └── referencias/
│   │       ├── spec-mobile-test.html (exemplo real)
│   │       ├── fluxo-spec-driven.html (visual)
│   │       └── acionamento-spec-driven.html (passo a passo)
│   └── auditoria-seguranca/
│       ├── SKILL.md
│       └── INSTALAR.md
├── agents/
│   ├── spec-executor.md (orquestrador)
│   └── auditor-seguranca.md (varredura de segurança)
├── commands/
│   └── auditoria-seguranca.md (atalho `/auditoria-seguranca`)
└── README.md
```

---

## 🚀 Instalação rápida

### Windows
```powershell
git clone https://github.com/douglas21grcont-wq/Douglasg.castro_Skills.git
cp -r Douglasg.castro_Skills/skills/spec-driven $env:USERPROFILE/.claude/skills/
cp -r Douglasg.castro_Skills/skills/auditoria-seguranca $env:USERPROFILE/.claude/skills/
cp -r Douglasg.castro_Skills/agents/ $env:USERPROFILE/.claude/agents/
cp -r Douglasg.castro_Skills/commands/ $env:USERPROFILE/.claude/commands/
```

### macOS / Linux
```bash
git clone https://github.com/douglas21grcont-wq/Douglasg.castro_Skills.git
cp -r Douglasg.castro_Skills/skills/spec-driven ~/.claude/skills/
cp -r Douglasg.castro_Skills/skills/auditoria-seguranca ~/.claude/skills/
cp -r Douglasg.castro_Skills/agents/ ~/.claude/agents/
cp -r Douglasg.castro_Skills/commands/ ~/.claude/commands/
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
