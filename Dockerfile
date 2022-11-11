# Imagem de contêiner que executa seu código
FROM openjdk:20-slim-buster

#Instala o Rundeck CLi
RUN apt update -y && apt-get -y install curl \
  && curl -s https://packagecloud.io/install/repositories/pagerduty/rundeck/script.deb.sh | os=any dist=any bash \
  && apt-get install -y rundeck-cli 
# Copia o arquivo de código do repositório de ação para o caminho do sistema de arquivos `/` do contêiner
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
# Arquivo de código a ser executado quando o contêiner do docker é iniciado (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
