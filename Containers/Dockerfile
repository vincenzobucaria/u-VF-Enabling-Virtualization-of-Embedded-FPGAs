# Usa una base Python leggera
FROM ubuntu:22.04

# Imposta non-interattivo per evitare prompt da apt
ENV DEBIAN_FRONTEND=noninteractive

# Aggiorna e installa pacchetti base
RUN apt update && apt install -y \
    python3 python3-pip \
    nano \
    bash \
    && apt clean

# Crea directory di lavoro
WORKDIR /usr/src/app

# Copia la libreria e lo script
COPY client/ client/
COPY requirements.txt .

# Installa le dipendenze Python
RUN pip install --no-cache-dir -r requirements.txt

# Punto di ingresso quando il container parte
