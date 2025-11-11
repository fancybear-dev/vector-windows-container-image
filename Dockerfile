# This was largely based on; https://github.com/djboris9/vector-windows/blob/main/Dockerfile

ARG WINDOWS_VERSION

FROM mcr.microsoft.com/windows/nanoserver:$WINDOWS_VERSION

ARG VECTOR_VERSION

WORKDIR "C:/Program Files/Vector"

ADD install-vector.ps1 /windows/temp/install-vector.ps1

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN /windows/temp/install-vector.ps1 -VectorVersion $VECTOR_VERSION

RUN setx /M PATH "%PATH%;C:\Program Files\Vector\bin"

ENTRYPOINT ["vector.exe"]