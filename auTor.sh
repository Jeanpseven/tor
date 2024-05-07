#!/bin/bash

# Verifica se o Tor está instalado
if ! command -v tor &> /dev/null
then
    echo "Tor não está instalado. Instalando..."
    sudo apt update
    sudo apt install tor
fi

# Pede ao usuário para inserir o tempo de cooldown em segundos
echo "Insira o tempo de cooldown em segundos:"
read cooldown

# Define a porta padrão do Tor
port=9050

# Loop para executar o Tor continuamente
while true
do
    # Tenta iniciar o Tor na porta padrão
    tor --SocksPort $port
    
    # Verifica se a porta está ocupada
    while [ $? -ne 0 ]
    do
        # Incrementa a porta e tenta novamente
        ((port++))
        tor --SocksPort $port
    done

    # Aguarda o tempo de cooldown antes de reiniciar
    sleep $cooldown
done
