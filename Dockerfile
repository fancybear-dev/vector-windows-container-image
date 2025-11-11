# This was largely based on; https://github.com/djboris9/vector-windows/blob/main/Dockerfile

ARG WINDOWS_VERSION

FROM mcr.microsoft.com/windows/servercore:$WINDOWS_VERSION as vector

ARG VECTOR_VERSION

WORKDIR "/windows/temp"

ADD install-vector.ps1 install-vector.ps1

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN install-vector.ps1 -VectorVersion $env:VECTOR_VERSION

FROM mcr.microsoft.com/windows/nanoserver:$WINDOWS_VERSION as runtime

COPY --from=vector ["C:/Program Files/Vector", "C:/Program Files/Vector"]

ENTRYPOINT ["C:\\Program Files\\Vector\\bin\\vector.exe"]