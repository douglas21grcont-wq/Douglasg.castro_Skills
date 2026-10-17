<#
    instalar.ps1 — instala o "claude-entre-computadores" com um comando (Windows)

        irm https://raw.githubusercontent.com/douglas21grcont-wq/Douglasg.castro_Skills/master/skills/claude-entre-computadores/instalar.ps1 | iex

    O que faz:
      1. Cria (ou reaproveita) a pasta C:\projetos\meu-claude no disco local.
      2. Pergunta o endereco do seu repositorio privado no GitHub:
         - primeira maquina com GitHub CLI logado: deixe em branco e ele cria um privado;
         - outra maquina: cole o endereco e ele baixa tudo.
      3. Traz as skills, agentes, comandos e CLAUDE.md que ja existem na ~/.claude
         para o repositorio (nada e apagado) e liga a ~/.claude a ele.
      4. Grava a primeira versao e envia, se houver repositorio no GitHub.
#>
param(
    [string]$Pasta   = 'C:\projetos\meu-claude',
    $Repo            = $null,   # sem tipo: [string] transformaria $null em '' e nunca perguntaria
    [string]$Destino = "$env:USERPROFILE\.claude",
    [string]$Fonte   = 'https://raw.githubusercontent.com/douglas21grcont-wq/Douglasg.castro_Skills/master/skills/claude-entre-computadores'
)
$ErrorActionPreference = 'Stop'

function G {
    # git escreve aviso no stderr; no PowerShell 5.1 com 'Stop' isso vira erro fatal.
    $e = $ErrorActionPreference; $ErrorActionPreference = 'Continue'
    try { & git @args 2>$null } finally { $ErrorActionPreference = $e }
}
function H {
    $e = $ErrorActionPreference; $ErrorActionPreference = 'Continue'
    try { & gh @args 2>$null } finally { $ErrorActionPreference = $e }
}

function Pegar($relativo, $destino) {
    # Rodando de uma copia local do pacote, usa o arquivo ao lado; senao baixa do GitHub.
    $local = if ($PSScriptRoot) { Join-Path $PSScriptRoot $relativo }
    if ($local -and (Test-Path $local)) { Copy-Item $local $destino -Force }
    else { Invoke-RestMethod "$Fonte/$($relativo -replace '\\','/')" -OutFile $destino }
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw 'Git nao encontrado. Instale em https://git-scm.com e rode o comando de novo.'
}
if ($Pasta -match 'OneDrive|Google Drive|Dropbox|iCloud') {
    throw "A pasta $Pasta esta numa nuvem. Use uma pasta do disco local, por exemplo C:\projetos\meu-claude."
}

$temGh = [bool](Get-Command gh -ErrorAction SilentlyContinue)
if (-not (Test-Path (Join-Path $Pasta '.git'))) {
    if ($null -eq $Repo) {
        Write-Host ''
        Write-Host 'Endereco do seu repositorio PRIVADO no GitHub (ex.: https://github.com/voce/meu-claude.git)' -ForegroundColor Cyan
        if ($temGh) { Write-Host 'Primeira maquina? Deixe em branco e o repositorio privado sera criado.' }
        else        { Write-Host 'Deixe em branco para comecar so neste computador (da para ligar ao GitHub depois).' }
        $Repo = Read-Host 'Endereco'
    }
    if ($Repo) {
        G clone $Repo $Pasta
        if ($LASTEXITCODE -ne 0) { throw "Nao foi possivel baixar $Repo. Confira o endereco e o login no GitHub." }
    } else {
        New-Item -ItemType Directory -Path $Pasta -Force | Out-Null
        G -C $Pasta init -b main | Out-Null
    }
}

Pegar 'modelo\ligar.ps1' (Join-Path $Pasta 'ligar.ps1')
$gi = Join-Path $Pasta '.gitignore'
if (-not (Test-Path $gi)) { Pegar 'modelo\gitignore-modelo' $gi }

& (Join-Path $Pasta 'ligar.ps1') -Repo $Pasta -Destino $Destino

if (-not (G -C $Pasta config user.email)) {
    # Git sem identidade configurada: usa uma local so para este repositorio.
    G -C $Pasta config user.name  $env:USERNAME
    G -C $Pasta config user.email "$env:USERNAME@$env:COMPUTERNAME.local"
}
G -C $Pasta add -A
G -C $Pasta diff --cached --quiet
if ($LASTEXITCODE -ne 0) { G -C $Pasta commit -m "Claude Code: $env:COMPUTERNAME" | Out-Null }

$remoto = G -C $Pasta remote
if (-not $remoto -and -not $Repo -and $temGh) {
    H auth status | Out-Null
    if ($LASTEXITCODE -eq 0) {
        H repo create meu-claude --private --source $Pasta --push | Out-Null
        Write-Host '  repositorio privado meu-claude criado no seu GitHub' -ForegroundColor Green
    }
} elseif ($remoto) {
    G -C $Pasta push -u origin HEAD
}

Write-Host ''
Write-Host "Repositorio: $Pasta" -ForegroundColor Green
Write-Host 'No outro computador, rode o mesmo comando e cole o endereco do repositorio.'
Write-Host 'Dia a dia: git pull ao comecar, git add . ; git commit -m "..." ; git push ao terminar.'
