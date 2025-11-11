ARG WINDOWS_VERSION

FROM mcr.microsoft.com/windows/servercore:$WINDOWS_VERSION

WORKDIR /temp

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Invoke-WebRequest -OutFile vector.zip -Uri https://github.com/vectordotdev/vector/releases/download/v0.51.0/vector-0.51.0-x86_64-pc-windows-msvc.zip
RUN Expand-Archive -Path vector.zip -DestinationPath C:\Program Files\vector
RUN Remove-Item -Path vector.zip

WORKDIR C:/Program Files/Vector

ENV PATH="C:\\Program Files\\Vector\\bin;C:\\Windows\\System32;C:\\Windows;C:\\Windows\\System32\\WindowsPowerShell\\v1.0"

ENTRYPOINT ["vector.exe"]