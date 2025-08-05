# Proto dosyalarından Dart kodlarını oluşturan PowerShell script'i

# Proje dizini
$projectDir = (Get-Location).Path

# Proto dosyalarının dizini
$protoDir = "$projectDir\lib\proto"

# Çıktı dizini
$outputDir = "$projectDir\lib\proto\generated"

# Çıktı dizini yoksa oluştur
if (!(Test-Path $outputDir)) {
    New-Item -ItemType Directory -Force -Path $outputDir
}

# Proto dosyalarını işle
Get-ChildItem -Path $protoDir -Filter "*.proto" | ForEach-Object {
    $protoFile = $_.FullName
    Write-Host "Generating Dart code from $($_.Name)..."

    # protoc komutunu çalıştır
    protoc --dart_out=grpc:$outputDir --proto_path=$protoDir $protoFile

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Successfully generated Dart code from $($_.Name)" -ForegroundColor Green
    } else {
        Write-Host "Failed to generate Dart code from $($_.Name)" -ForegroundColor Red
    }
}

Write-Host "All proto files processed." -ForegroundColor Cyan
