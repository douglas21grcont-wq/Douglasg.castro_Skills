---
name: auditoria-seguranca
description: Auditoria defensiva de segurança dos seus sistemas — análise estática completa de código atrás de falhas típicas de vibe coding e além (segredo vazado, RLS frouxa, autorização só no front, XSS, injeção, IDOR, falha de lógica de negócio, upload inseguro, sessão/JWT, CORS/SSRF, cabeçalhos, dependências, LGPD) + recomendações de infraestrutura. Use quando disser "audita a segurança do meu site", "procura falha de segurança", "isso tá seguro?", "confere os buracos do painel", "audita o repo antes de subir", "pode ir ao ar?", ou pedir revisão de segurança de qualquer projeto seu. Atalho `/auditoria-seguranca`; agente `auditor-seguranca` para varredura grande. NÃO ataca sistema no ar nem de terceiro — só lê o seu próprio código.
---

# Auditoria de Segurança — seus sistemas

Revisão **defensiva e completa** de código: ler o seu próprio repositório atrás de falhas de
segurança, avaliar a infraestrutura e devolver um laudo com achados priorizados + plano de ação.
Nunca ataca sistema no ar, nunca toca em ativo de terceiro, nunca altera código ou servidor —
**só lê e reporta**.

## Postura: preventiva e obrigatória antes do go-live

Todo sistema web deveria passar por esta auditoria **antes de ir ao ar**. Ela atua de forma
**preventiva**: caça gargalos e riscos — de segurança e de disponibilidade — antes de virarem
incidente, não depois. Quando a sessão estiver perto de um lançamento/publicação, ofereça a
auditoria como parte do checklist, sem esperar o pedido explícito.

## Escada Ponytail antes de tudo

1. O repositório é seu (ou de um cliente que você gerencia)? Se não for, **parar** — não é escopo.
2. Já existe `AUDITORIA-SEGURANCA.md` na raiz? Ler antes, para medir o que mudou e não repetir.
3. Existe `handoff.md` ou documento equivalente? Ler para entender a stack antes de auditar.
4. Rodar ferramenta pronta (gitleaks/semgrep/npm audit) antes de caçar à mão o que elas já pegam.

## Checklist completo

Priorize pelo stack real do seu projeto — por exemplo, Supabase + front estático + Cloudflare, ou
PHP + SQLite + hospedagem compartilhada. Marque cada categoria como ✅ ok / achado 🔴🟡🟢 / n/a.

### 1. Segredos e exposição de código
- `git grep -nE "service_role|sb_secret_|SUPABASE_SERVICE|sk_live|sk_test|AKIA|BEGIN (RSA|OPENSSH)|password\s*="` no repo inteiro.
- **Histórico do git**: `git log --all -p | grep -E "sb_secret_|eyJhbGci|service_role|AKIA"` — segredo removido continua no histórico.
- Varredura por entropia / **gitleaks** para chaves não óbvias.
- Chave `anon`/`publishable` no front **não é falha** — registrar como nota, não achado.
- `.gitignore` cobre `.env`, `*.pem`, chaves SSH, `_backup/`, `.temp/`?
- **Artefato de build vazando fonte**: `dist/` com source maps (`.map`), comentários, ou `.git/` publicado no servidor.
- Arquivos de backup no deploy (`.bak`, `~`, `.old`, `config.php.save`).

### 2. Autorização / RLS (Supabase)
- Toda tabela com `enable row level security`? Política default é **negar**?
- Escrita gated por função de papel (`eh_gestor()`) e não por "estar logado"?
- Funções de segurança são `security definer` **com `search_path` travado**? (Sem isso → sequestro de search_path.)
- Auditar **cada** `SECURITY DEFINER`: ela faz só o que promete? Recebe input do usuário sem validar?
- O que `anon` pode fazer? `grant insert/select/... to anon` — o `with check`/`using` limita formato, valor e escopo?
- **Column-level**: colunas sensíveis (custo, margem, telefone) protegidas mesmo em tabela lida por perfil?
- **Storage buckets**: público vs privado; políticas de bucket; usa signed URL para arquivo privado?
- **Realtime**: canal exige autorização, ou vaza mudança de linha para anônimo?
- **Edge Functions / RPC**: validam quem chama? Segredo só no ambiente, nunca no cliente?
- Autorização mora no banco (RLS) ou só no front (botão escondido, mas a rota responde)?

### 3. XSS
- `innerHTML =`, `insertAdjacentHTML`, `document.write`, `dangerouslySetInnerHTML` com dado de tabela/usuário sem escape → XSS armazenado.
- **DOM XSS**: `location.hash`/`search`/`referrer` jogado no DOM sem sanitizar.
- Vetor mais sério: dado que o **anônimo** insere renderizado na **sessão autenticada** de um perfil com mais permissão.
- Campo de texto livre aceita `<`/`>` no banco? Aí a defesa vira 100% o escape do front — frágil; validar na origem (`with check`).

### 4. Injeção
- SQL por concatenação → prepared statements. RPC do Supabase montando SQL dinâmico com input.
- Template/command injection em scripts de automação.

### 5. Controle de acesso a objeto (IDOR)
- Id de pedido/cliente previsível (sequencial) + rota que não checa dono → enumerar dados alheios.
- Endpoint que confia em id vindo do cliente sem revalidar permissão no banco.

### 6. Lógica de negócio
- Manipulação de preço/quantidade/desconto no client aceita pelo back? (Ex.: uma loja que já força custo zero e valor > 0 no `with check` — conferir se cobre todos os campos.)
- Cupom/kit reutilizável, quantidade negativa, race condition de estoque (dois checkouts, mesma peça).
- Estado de pedido pulando etapas (nasce "pago").

### 7. Upload de arquivo
- Valida tipo real (magic bytes, não só extensão) e tamanho? Nome sanitizado? Servido de origem separada, sem execução?

### 8. Autenticação e sessão
- Mensagem de erro genérica (sem enumerar contas)? **Rate limit / lockout** no login?
- Expiração de JWT curta? Refresh token rotacionado? Logout invalida sessão?
- Política de senha mínima; **MFA** disponível para o gestor?
- Cookie de sessão: `HttpOnly`, `Secure`, `SameSite`?
- **CSRF token** em formulário que altera estado (apps com cookie de sessão).
- Session fixation: id de sessão troca no login?

### 9. CORS / SSRF
- CORS: `Access-Control-Allow-Origin: *` combinado com credenciais? Origem refletida sem allowlist?
- SSRF: função server-side / Edge Function que faz `fetch` de URL vinda do usuário.

### 10. Cabeçalhos e transporte
- **CSP** (`default-src 'self'`, `frame-ancestors 'none'`, `connect-src` só o que precisa), **HSTS**, `X-Content-Type-Options: nosniff`, `Referrer-Policy`, `Permissions-Policy`, `X-Frame-Options`.
- **SRI** (Subresource Integrity) em `<script>`/`<link>` de CDN — sem isso, CDN comprometido injeta código.
- HTTPS forçado; sem conteúdo misto (http em página https).

### 11. Anti-automação
- Rate limiting / **Turnstile** em formulário público (checkout, lead, contato) contra spam e enumeração.

### 12. Divulgação de informação
- Erro verboso com stack trace / query em produção. `console.log`/`console.error` com dado sensível.
- `robots.txt` ou sitemap entregando caminho do painel. Listagem de diretório ligada. `/.git` acessível.
- Comentário no HTML/JS revelando endpoint interno, id de conta, TODO com credencial.

### 13. Dependências / cadeia de suprimentos
- `npm audit` / versões desatualizadas / CVE conhecido nas libs.
- Script de CDN sem versão fixa (pin) nem SRI. Pacote com nome typosquatting.

### 14. Dado pessoal / LGPD
- Coleta o mínimo (telefone/e-mail com propósito claro)? Consentimento registrado (ex.: um campo `aceita_novidades` já implementado)?
- PII em log de auditoria ou em `localStorage`? Retenção definida? Direito de exclusão viável?

### 15. Armazenamento no cliente
- Token de sessão, chave secreta ou PII em `localStorage`/`sessionStorage` (acessível a qualquer XSS).

## Recomendações de infraestrutura (sempre incluir, se aplicável)

Além do código, avalie e sugira — só o que o stack real comporta:

**Atrás da Cloudflare:**
- **Cloudflare Access / Zero Trust** na frente de painel admin: login Cloudflare + allowlist de e-mail/IP antes mesmo de chegar no app. É a maior blindagem barata para um painel.
- **Rate Limiting** e **Turnstile** nas rotas públicas (checkout, lead).
- **WAF** com managed ruleset ligado; **Bot Fight Mode**.
- Arquivo **`_headers`** com o conjunto de cabeçalhos (Pages lê automático).
- **Always Use HTTPS**, **HSTS**, **DNSSEC**, registro **CAA** (só a CA autorizada emite cert).

**Supabase:**
- RLS default-deny em toda tabela nova (regra fixa, não caso a caso).
- **Network Restrictions**: limitar IP que fala com o Postgres, se o acesso for previsível.
- **PITR / backups** ligados e **testados** (restaurar de verdade uma vez).
- JWT com expiração curta; **MFA no dashboard** do Supabase; rotacionar chaves periodicamente.
- Buckets de Storage privados por padrão + signed URL; nunca `public` para arquivo com PII.
- Log drain / alerta de pico de erro ou de escrita anônima anômala.

**PHP em hospedagem compartilhada (ex.: Hostinger):**
- Cabeçalhos via `.htaccess`; HTTPS forçado; versão de PHP suportada.
- Backup automático do banco + teste de restauração; `.git` e arquivo de configuração fora da raiz web.

**Geral:**
- Monitoramento/alerta (uptime + erro), plano mínimo de resposta a incidente, e um segundo usuário gestor (evitar ponto único de acesso).

## Ferramentas open-source (sem custo de token de LLM)
- **gitleaks** (segredos, incl. histórico) · **semgrep** (padrões inseguros) · **npm audit** (CVE de dependência) ·
  **OWASP ZAP** / **nuclei** (teste dinâmico no **preview**, nunca produção sem motivo) ·
  **testssl.sh** (config TLS) · **Mozilla Observatory** (cabeçalhos).

## Calibragem dos achados (honestidade acima de alarme)
- Não infle. "A app está exposta agora" só quando há caminho real de exploração.
- Separe **buraco aberto** de **defesa em profundidade** (frágil, mas hoje coberto).
- Severidade: 🔴 crítico (exploração direta) · 🟡 médio (defesa em profundidade / condicional) · 🟢 baixo (higiene).
- Sempre dê **evidência** (arquivo:linha) e **correção concreta**, não só o nome do problema.
- Registre também o que está **certo** — dá confiança e evita falso alarme na próxima auditoria.

## Saída
Grave `AUDITORIA-SEGURANCA.md` na raiz do repositório auditado, com:
1. **Veredito** (uma frase de nível + o que está certo).
2. **Achados** com severidade, evidência (arquivo:linha), risco e correção.
3. **Plano de ação** em tabela priorizada (ação · severidade · esforço · onde).
4. **Infraestrutura recomendada** (o bloco acima, filtrado ao que faz sentido).
5. **Fora de escopo** (o que uma próxima cobriria: teste dinâmico, dependências, console Supabase).

**Nunca commite/pushe** — isso é seu, pelo seu fluxo normal de versionamento. Nunca altere o código
auditado. Para varredura grande (mais de 3 buscas), despache o agente `auditor-seguranca`.
