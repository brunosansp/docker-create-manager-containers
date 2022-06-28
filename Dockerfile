FROM node:14
WORKDIR /app-node
COPY . .
RUN npm install
ENTRYPOINT npm start

# OBS: Na instrução COPY o primeiro . é referente ao caminho de diretório do host(onde estará o nosso arquivo Dockerfile, a raíz do projeto) e o segundo . é o diretório de trabalho padrão dentro do container.
# A instrução FROM é usada para definirmos uma imagem como base para a nossa.
# Ex: docker build -t brunosantos/app-node:1.0 .
# OBS: No final do comando devemos passar em qual contexto, nesse caso o contexto é o diretório atual (a raíz).
# Documentação de referência: https://docs.docker.com/engine/reference/builder/


# Incrementando nosso Dockerfile
## carrega variáveis apenas no momento de build da imagem
ARG PORT_BUILD=3000
## carrega variáveis que serão utilizadas no container
ENV PORT=$PORT_BUILD
# => Ex em NodeJS:
# app.listen("3000", ()=>{
#   	console.log("Server is listening on port 3000")
# })

# //Podendo ficar assim:
# app.listen(process.env.PORT, ()=>{
#   	console.log("Server is listening on port 3000")
# })

## para exibir a porta padrão do container ao executar o comando docker ps
EXPOSE $PORT_BUILD

# Nosso Dockerfile ficaria assim:
FROM node:14
WORKDIR /app-node
ARG PORT_BUILD=3000
ENV PORT=$PORT_BUILD
EXPOSE $PORT
COPY . .
RUN npm install
ENTRYPOINT npm start