---
description: Audita a segurança de um repositório seu (análise estática) e grava o laudo com plano de ação
allowed-tools: Read, Grep, Glob, Bash, Write
---

Carregue a skill `auditoria-seguranca` e faça a auditoria defensiva de segurança do repositório
que eu indicar a seguir (se eu não indicar, use o projeto da pasta atual).

Regras: só ler e reportar — nunca alterar código, nunca tocar no servidor, nunca commitar/pushar,
nunca atacar sistema no ar. Só ativo meu.

Siga o checklist da skill, calibre os achados com honestidade (buraco aberto ≠ defesa em profundidade)
e grave o resultado em `AUDITORIA-SEGURANCA.md` na raiz do repo auditado, com veredito, achados por
severidade (com evidência arquivo:linha e correção), plano de ação priorizado e o que ficou fora de escopo.

Para varredura grande, despache o agente `auditor-seguranca`.
