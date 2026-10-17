<#
    ligar.ps1 — liga este repositório à pasta ~/.claude (Windows)

    skills/, agents/ e commands/ viram JUNCTION (atalho de pasta): ~/.claude/skills
    passa a ser a mesma pasta que <repositório>/skills. Editar de um lado é editar
    o outro, e o git enxerga na hora. Nada é copiado.

    CLAUDE.md é copiado (atalho de arquivo no Windows pede permissão de admin).
    Editou o CLAUDE.md do repositório? Rode de novo.

    Primeira máquina: se a sua ~/.claude já tiver skills, agentes ou comandos, eles
    são copiados para o repositório antes de ligar, e a pasta antiga fica guardada
    com o sufixo _ANTIGO_<data>. Nada é apagado.

        .\ligar.ps1
#>
param(
    [string]$Repo    = $PSScriptRoot,
    [string]$Destino = "$env:USERPROFILE\.claude"
)
$ErrorActionPreference = 'Stop'

function Test-Junction($caminho) {
    if (-not (Test-Path $caminho)) { return $false }
    return [bool]((Get-Item $caminho -Force).Attributes -band [IO.FileAttributes]::ReparsePoint)
}

if (-not (Test-Path $Destino)) { New-Item -ItemType Directory -Path $Destino | Out-Null }
$data = Get-Date -Format 'yyyyMMdd-HHmm'

foreach ($pasta in 'skills', 'agents', 'commands') {
    $alvo = Join-Path $Repo $pasta
    $link = Join-Path $Destino $pasta
    if (-not (Test-Path $alvo)) { New-Item -ItemType Directory -Path $alvo | Out-Null }

    if (Test-Junction $link) {
        $atual = (Get-Item $link -Force).Target | Select-Object -First 1
        if ($atual -eq $alvo) { Write-Host "  ja ligado: $link" -ForegroundColor DarkGray; continue }
        # Junction apontando para outro lugar: remove só o atalho, nunca o conteúdo.
        [System.IO.Directory]::Delete($link, $false)
    }
    elseif (Test-Path $link) {
        # Pasta real: traz para o repositório o que ainda não existe lá e guarda a original.
        Get-ChildItem $link -Force | Where-Object { -not (Test-Path (Join-Path $alvo $_.Name)) } |
            ForEach-Object { Copy-Item $_.FullName (Join-Path $alvo $_.Name) -Recurse }
        $guardado = "$link`_ANTIGO_$data"
        Move-Item $link $guardado
        Write-Host "  conteudo de $link copiado para o repositorio" -ForegroundColor Yellow
        Write-Host "  original guardado em $guardado (apague quando conferir)" -ForegroundColor Yellow
    }
    New-Item -ItemType Junction -Path $link -Target $alvo | Out-Null
    Write-Host "  ligado: $link -> $alvo" -ForegroundColor Green
}

$claudeRepo    = Join-Path $Repo 'CLAUDE.md'
$claudeDestino = Join-Path $Destino 'CLAUDE.md'
if (-not (Test-Path $claudeRepo) -and (Test-Path $claudeDestino)) {
    Copy-Item $claudeDestino $claudeRepo
    Write-Host '  CLAUDE.md da maquina copiado para o repositorio' -ForegroundColor Yellow
}
if (Test-Path $claudeRepo) {
    Copy-Item $claudeRepo $claudeDestino -Force
    Write-Host '  CLAUDE.md copiado do repositorio' -ForegroundColor Green
}

Write-Host ''
Write-Host 'Pronto. Feche e reabra o Claude Code.' -ForegroundColor Green
Write-Host 'Atencao: para desligar, nunca use Remove-Item -Recurse em ~/.claude/skills.'
Write-Host 'Isso apaga o conteudo do repositorio. Use: [System.IO.Directory]::Delete("<caminho>", $false)'
