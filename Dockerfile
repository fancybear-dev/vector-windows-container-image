# This was largely based on; https://github.com/djboris9/vector-windows/blob/main/Dockerfile

ARG WINDOWS_VERSION

FROM mcr.microsoft.com/windows/servercore:$WINDOWS_VERSION

ARG VECTOR_VERSION

WORKDIR "C:/Program Files/Vector"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Write-Host "VECTOR_VERSION: $env:VECTOR_VERSION" ; `
    $url = "https://github.com/vectordotdev/vector/releases/download/v${env:VECTOR_VERSION}/vector-${env:VECTOR_VERSION}-x86_64-pc-windows-msvc.zip" ; `
    Write-Host "Download URL: $url" ; `
    Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile "vector.zip" ; `
    Expand-Archive -Path "vector.zip" -DestinationPath "." ; `
    Remove-Item "vector.zip" -Force

RUN setx /M PATH "%PATH%;C:\Program Files\Vector\bin"

ENTRYPOINT ["vector.exe"]