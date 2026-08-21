# O Script escrito para ser executado em terminal "Power Shell" em ambiente Windows versão 11, irá converter arquivos DOCX para Markdown usando Pandoc
# Execute como Administrador se necessário

# 1. Perguntar o nome do arquivo a ser procurado
$nomeArquivo = Read-Host "Digite o nome do arquivo a ser procurado (sem extensão)"

# Verificar se o usuário digitou algo
if ([string]::IsNullOrWhiteSpace($nomeArquivo)) {
    Write-Host "Nome do arquivo não pode ser vazio. Saindo..." -ForegroundColor Red
    exit
}

# 2. Ir para a pasta C:\Users\Documents
$caminhoDocumentos = "C:\Users\Documents"
if (Test-Path $caminhoDocumentos) {
    Set-Location -Path $caminhoDocumentos
    Write-Host "Navegando para: $caminhoDocumentos" -ForegroundColor Green
} else {
    Write-Host "Pasta C:\Users\Documents não encontrada. Tentando pasta padrão do usuário..." -ForegroundColor Yellow
    $caminhoDocumentos = [Environment]::GetFolderPath("MyDocuments")
    if (Test-Path $caminhoDocumentos) {
        Set-Location -Path $caminhoDocumentos
        Write-Host "Navegando para: $caminhoDocumentos" -ForegroundColor Green
    } else {
        Write-Host "Erro: Pasta de documentos não encontrada. Saindo..." -ForegroundColor Red
        exit
    }
}

# 3. Criar uma pasta com o nome do arquivo
$pastaDestino = Join-Path -Path $caminhoDocumentos -ChildPath $nomeArquivo
if (Test-Path $pastaDestino) {
    Write-Host "Pasta '$nomeArquivo' já existe. Usando pasta existente." -ForegroundColor Yellow
} else {
    New-Item -ItemType Directory -Path $pastaDestino -Force | Out-Null
    Write-Host "Pasta '$nomeArquivo' criada em: $caminhoDocumentos" -ForegroundColor Green
}

# 4. Selecionar todos os arquivos com o nome especificado e extensão DOCX
$arquivos = Get-ChildItem -Path $caminhoDocumentos -Filter "$nomeArquivo*.docx" -File

# Verificar se encontrou arquivos
if ($arquivos.Count -eq 0) {
    Write-Host "Nenhum arquivo encontrado com o nome '$nomeArquivo' e extensão .docx" -ForegroundColor Red
    Write-Host "Arquivos encontrados na pasta:" -ForegroundColor Yellow
    Get-ChildItem -Path $caminhoDocumentos -Filter "*.docx" -File | ForEach-Object { Write-Host "  - $($_.Name)" -ForegroundColor Gray }
    exit
}

Write-Host "`nEncontrados $($arquivos.Count) arquivo(s) para processar:" -ForegroundColor Cyan
foreach ($arquivo in $arquivos) {
    Write-Host "  - $($arquivo.Name)" -ForegroundColor Gray
}

# 5. Executar o comando Pandoc para cada arquivo encontrado (converter para Markdown)
$contador = 0
$arquivosProcessados = @()

Write-Host "`nIniciando conversão para Markdown com Pandoc..." -ForegroundColor Cyan

foreach ($arquivo in $arquivos) {
    $caminhoCompleto = $arquivo.FullName
    $nomeSemExtensao = [System.IO.Path]::GetFileNameWithoutExtension($arquivo.Name)
    
    # Definir caminho de saída na pasta criada com extensão .md
    $caminhoSaida = Join-Path -Path $pastaDestino -ChildPath "$nomeSemExtensao.md"
    
    # Criar subpasta para imagens (extraídas do DOCX)
    $pastaImagens = Join-Path -Path $pastaDestino -ChildPath "images_$nomeSemExtensao"
    if (-not (Test-Path $pastaImagens)) {
        New-Item -ItemType Directory -Path $pastaImagens -Force | Out-Null
    }
    
    Write-Host "Convertendo: $($arquivo.Name) -> $caminhoSaida" -ForegroundColor Yellow
    Write-Host "  Imagens serão extraídas para: $pastaImagens" -ForegroundColor Gray
    
    try {
        # Comando Pandoc para converter DOCX para Markdown com extração de figuras
        # Opções:
        #   -f docx: formato de entrada
        #   -t markdown: formato de saída
        #   --extract-media: extrai imagens para a pasta especificada
        #   --wrap=none: não quebra linhas automaticamente
        #   --atx-headers: usa cabeçalhos no estilo ATX (com #)
        $comando = "pandoc -f docx -t markdown `"$caminhoCompleto`" -o `"$caminhoSaida`" --extract-media=`"$pastaImagens`" --wrap=none --atx-headers"
        
        # Executar o comando
        Invoke-Expression -Command $comando
        
        # Verificar se o arquivo MD foi criado
        if (Test-Path $caminhoSaida) {
            # Verificar se o arquivo MD contém referências às imagens
            $conteudoMD = Get-Content -Path $caminhoSaida -Raw -ErrorAction SilentlyContinue
            if ($conteudoMD -match '!\[.*\]\(.*\)') {
                Write-Host "  ✓ Conversão bem-sucedida! Imagens extraídas e referenciadas no Markdown." -ForegroundColor Green
            } else {
                Write-Host "  ✓ Conversão bem-sucedida! (Nenhuma imagem encontrada no documento)" -ForegroundColor Green
            }
            $contador++
            $arquivosProcessados += $arquivo.Name
        } else {
            Write-Host "  ✗ Falha na conversão. Verifique se o Pandoc está instalado." -ForegroundColor Red
        }
    } catch {
        Write-Host "  ✗ Erro ao processar $($arquivo.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

# 6. Informar quantos arquivos foram executados com sucesso
Write-Host "`n" + "="*60 -ForegroundColor Cyan
Write-Host "RELATÓRIO DE CONVERSÃO" -ForegroundColor Cyan
Write-Host "="*60 -ForegroundColor Cyan
Write-Host "Total de arquivos encontrados: $($arquivos.Count)" -ForegroundColor White
Write-Host "Arquivos convertidos com sucesso: $contador" -ForegroundColor Green

if ($contador -gt 0) {
    Write-Host "`nArquivos convertidos:" -ForegroundColor Yellow
    foreach ($arquivo in $arquivosProcessados) {
        $nomeSemExtensao = [System.IO.Path]::GetFileNameWithoutExtension($arquivo)
        $caminhoMD = Join-Path -Path $pastaDestino -ChildPath "$nomeSemExtensao.md"
        $pastaImagens = Join-Path -Path $pastaDestino -ChildPath "images_$nomeSemExtensao"
        Write-Host "  ✓ $arquivo -> $caminhoMD" -ForegroundColor Green
        if (Test-Path $pastaImagens) {
            $qtdImagens = (Get-ChildItem -Path $pastaImagens -File).Count
            if ($qtdImagens -gt 0) {
                Write-Host "    📷 $qtdImagens imagem(ns) extraída(s) para: $pastaImagens" -ForegroundColor Gray
            }
        }
    }
    Write-Host "`nArquivos Markdown salvos em: $pastaDestino" -ForegroundColor Cyan
}

if ($contador -lt $arquivos.Count) {
    $falhas = $arquivos.Count - $contador
    Write-Host "Arquivos com falha: $falhas" -ForegroundColor Red
    Write-Host "`nPossíveis causas:" -ForegroundColor Yellow
    Write-Host "  - Pandoc não está instalado no sistema" -ForegroundColor Gray
    Write-Host "  - Pandoc não está no PATH do sistema" -ForegroundColor Gray
    Write-Host "  - Arquivo DOCX pode estar corrompido ou com senha" -ForegroundColor Gray
    Write-Host "  - Permissão de escrita na pasta de destino" -ForegroundColor Gray
}

Write-Host "`nProcesso concluído!" -ForegroundColor Cyan
