WEB=192.168.33.11
WEB_02=192.168.33.12
NGINX=192.168.33.20
CI=192.168.50.12
SSH=ssh -o StrictHostKeyChecking=no -i infra/ssh-keys/devops
PROJECT_FOLDER=/home/docker8721/do-25

ssh/web:
	 $(SSH) vagrant@$(WEB)

ssh/web-02:
	$(SSH) vagrant@$(WEB_02)

ssh/nginx:
	$(SSH) vagrant@$(NGINX)

ssh/ci:
	$(SSH) vagrant@$(CI)

maven/clean:
	cd $(PROJECT_FOLDER) && mvn clean

maven/package: maven/clean
	cd $(PROJECT_FOLDER) && mvn package -DskipTests

vagrant/up:
	cd infra && vagrant up