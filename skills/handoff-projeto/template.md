<!--
  HANDOFF VIVO DO PROJETO — fica na raiz do workspace (o diretório de onde o Claude
  Code é aberto), senão a regra do CLAUDE.md não o encontra.
  Regras: datas sempre absolutas (AAAA-MM-DD); §4 e §7 são append-only (nunca apagar).
  Se estiver dentro de um repo que faz deploy da raiz, excluir do deploy (não do git).
-->

# Handoff — [Projeto]

> **Ao encerrar a sessão:** commite/sincronize este arquivo no seu fluxo de commit.
> Em pasta sem git, ele sincroniza pela nuvem daquela pasta sozinho.

| Campo               | Valor                       |
| ------------------- | --------------------------- |
| Projeto             | [nome]                      |
| Última atualização  | [AAAA-MM-DD]                |
| Máquina             | [ex: notebook / desktop]    |
| Branch atual        | [ex: main]                  |

## 1. Escopo & Objetivo Geral
- **Objetivo do Projeto:** [objetivo macro do projeto / automação]
- **Contexto da Sessão:** [o que a fase atual está resolvendo]

## 2. Arquitetura & Stack Atual
- **Linguagem / Ambiente:** [ex: Python 3.12, PHP 8.3, Node.js]
- **Frameworks & IA / Automação:** [ex: MCP, Browser Use, Claude Code]
- **Integrações & APIs Ativas:** [ex: banco, fila, API externa]
- **Estrutura de Pastas Chave:**
  - `/caminho`: [o que é]

## 3. Estado Atual (o que já funciona)
> Marcar `[x]` só o que foi validado de fato.
- [ ] **[Componente/Feature]:** funcionando e validado em `[caminho/arquivo]`.
- [ ] **[Integração]:** estável com a API X via `[caminho/arquivo]`.

## 4. O que NÃO Fazer (decisões técnicas & abordagens falhas)
> APPEND-ONLY. Nunca apagar entrada. Só adicionar, com data. Isto evita loops de erro.
- **[AAAA-MM-DD] Abordagem falha:** [o que foi tentado]
  → *Motivo do fracasso:* [por que quebrou]
  → *Alternativa adotada:* [o contorno que funcionou]

## 5. Próximos Passos Imediatos
1. [ ] **Tarefa 1:** [próxima implementação prioritária].
2. [ ] **Tarefa 2:** [ajuste ou refatoração planejada].

## 6. Diretrizes & Restrições do Projeto
- [ex: processamento de dados sensíveis só localmente]
- [ex: não injetar scripts de log massivo em arquivos de produção]
- [ex: respeitar de forma absoluta as regras de arquitetura do diretório]

## 7. Histórico de Sessões
> APPEND-ONLY. Uma linha por sessão, mais recente embaixo.
- **[AAAA-MM-DD] · [máquina]** — [o que foi feito] · parou em: [ponto de retomada].
