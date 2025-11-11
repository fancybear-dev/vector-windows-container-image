# This was largely based on; https://github.com/djboris9/vector-windows/blob/main/Dockerfile

ARG WINDOWS_VERSION
ARG VECTOR_VERSION

from alpine:latest as downloader

WORKDIR /vector

RUN apk add --no-cache curl unzip && \
    curl -L -o vector.zip https://github.com/vectordotdev/vector/releases/download/v$VECTOR_VERSION/vector-$VECTOR_VERSION-x86_64-pc-windows-msvc.zip && \
    unzip vector.zip && \
    rm vector.zip

FROM mcr.microsoft.com/windows/servercore:$WINDOWS_VERSION

WORKDIR C:/Program Files/Vector

ENV PATH="C:\\Program Files\\Vector\\bin;C:\\Windows\\System32;C:\\Windows;C:\\Windows\\System32\\WindowsPowerShell\\v1.0"

COPY --from=downloader ["/vector/", "C:/Program Files/Vector"]

ENTRYPOINT ["vector.exe"]