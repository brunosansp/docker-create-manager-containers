Comandos Docker

"Uma imagem é um conjunto de camadas empilhadas para formar determinada regra de execução de um container."

/*Rodar um container sem travar o terminal passando a flag -d*/
docker run -d <ImageName>

/*Listando os containers que estão rodando*/
docker ps

/*Verificando o tamanho do container*/
docker ps -s
Se incluírmos o a junto ao -s, ficando -sa, serão exibidos também os containers parados

/*Pausando um container*/
docker pause <containerID>

/*Despausando um container pausado*/
docker unpause <containerID>

/*Parando de rodar o container*/
docker stop <containerID>

/*Dando start em um container parado*/
docker start <containerID>

/*Colocando um container para dormir*/
docker run <imageName> sleep 1d

/*lista as imagens já existentes no sistema*/
docker images

/*Exibe as camadas da imagem*/
docker history <containerID | imageName>

/*Inspeciona a imagem trazendo diversas informações*/
docker inspect <containerID>

/*Para executar algum comando no terminal bash do container*/
docker exec -it <containerID> bash

/*Executa imagem em modo de interação com o bash*/
docker run -it <ImageName> bash
EX: docker run -it ubuntu bash

/*Mapeando porta automaticamente com a flag -P*/
docker run -d -P <ImageName>
=> Esse mapeamento é automático, para visualizar a porta mapeada use o comando:
	docker port <containerID>
	Ex: Se o resultado contiver 80/tcp -> :::49154 a porta a ser utilizada é 49154
		=> http://localhost:49154

/*Forçando remoção do container, dessa forma o container é parado e removido*/
docker rm <containerID> --force

/*Mapeando porta manualmente com a flag -p*/
docker run -d -p 8080:80 <imageName>
=> dessa forma estou dizendo que minha porta 8080 deve refletir a porta 80 do container, ficando assim:
	=> http://localhost:8080


/*Gerando imagem a partir de um Dockerfile*/
docker build -t brunosantos/app-node:1.0
=> Este arquivo Dockerfile deve estar dentro da pasta raíz do projeto a ser buildado e o comando 
executado nesta mesma pasta.

/*Parando todos os containers de maneira segura*/
docker stop $(docker container ls -q)

/*Fazendo build de uma imagem de acordo com configs no Dockerfile*/
docker build -t brunosantos/app-node:1.0 .

/*Tagueando a imagem para subir ao Docker Hub no caso de o usuário ser diferente da imagem local*/
docker tag brunosantos/app-node:1.0 brunosansp/app-node:1.0

/*Subindo imagem para o Docker Hub*/
docker login -u <user> //primeiro fazer login, será solicitada senha no terminal
docker push brunosansp/app-node:1.0

/*Removendo todos os containers*/
docker container rm $(docker container ls -aq)
Se necessário podemos usar acrescentar o --force no final do comando

/*Removendo imagens*/
docker rmi $(docker image ls -aq)
Se necessário podemos usar acrescentar o --force no final do comando

/*Persistência de dados*/
Bind mounts(--mount) => Com bind mounts, é possível escrever os dados em uma camada persistente baseado na estrutura de pastas do host.
Volumes(-v) => Com volumes, é possível escrever os dados em uma camada persistente.

	docker run -it -v /home/shogun/wsp/temp/volume-docker:/app ubuntu bash

	Podemos utilizar o --mount por ser mais semântico.
	docker run -it --mount type=bind,source=/home/shogun/wsp/temp/volume-docker,target=/app ubuntu bash
	
	É mais recomendado utilizar volumes
	docker volume create <nome-volume>
	docker run -it -v nome-volume:/app ubuntu bash
		Podemos fazer o seguinte teste:
			cd app
			touch arquivo.txt
			saia da interação do docker e procure o arquivo criado e persistido localmente
			Os arquivos salvos no volume ficam em ~/va/lib/docker/volumes/_data

	A forma mais recomendada é usar volumes com --mount:
		docker run -it --mount source=meu-volume,target=/app ubuntu bash

	Existe também o tmpfs para Persistência. Obs: tmpfs somente funciona em ambientes Linux.
	docker run -it --tmpfs=/app ubuntu bash
	ou
	docker run -it --mount type=tmpfs,destination=/app ubuntu bash