#!/bin/bash

IP_WEB=192.168.50.10
IP_WEB_02=192.168.50.13
NGINX=192.168.50.15

if [ "$(cat /home/vagrant/last_deploy)" = "blue" ]; then
  echo "O último deploy foi o blue."
  echo "Iniciando o processo de atualização no green..."

  scp -o StrictHostKeyChecking=no -i /home/vagrant/devops alura-forum-green.war vagrant@192.168.33.11:/home/vagrant/alura-forum.war
  ssh -o StrictHostKeyChecking=no -i /home/vagrant/devops vagrant@192.168.33.11 'sudo mv /home/vagrant/alura-forum.war /var/lib/tomcat8/webapps/alura-forum.war'

  ssh -o StrictHostKeyChecking=no -i /home/vagrant/devops vagrant@192.168.33.20 'cp /vagrant/deploy/green/nginx.conf.green /etc/nginx/nginx.conf'
  ssh -o StrictHostKeyChecking=no -i /home/vagrant/devops vagrant@192.168.33.20 'sudo service nginx reload'

  echo "green" > /home/vagrant/last_deploy

  echo "Deploy concluído com sucesso."
else
  echo "O último deploy foi o green."
  echo "Iniciando o processo de atualização no blue..."

  scp -o StrictHostKeyChecking=no -i /home/vagrant/devops alura-forum-blue.war vagrant@192.168.33.12:/home/vagrant/alura-forum.war
  ssh -o StrictHostKeyChecking=no -i /home/vagrant/devops vagrant@192.168.33.12 'sudo mv /home/vagrant/alura-forum.war /var/lib/tomcat8/webapps/alura-forum.war'

  ssh -o StrictHostKeyChecking=no -i /home/vagrant/devops vagrant@192.168.33.20 'cp /vagrant/deploy/blue/nginx.conf.blue /etc/nginx/nginx.conf'
  ssh -o StrictHostKeyChecking=no -i /home/vagrant/devops vagrant@192.168.33.20 'sudo service nginx reload'

  echo "blue" > /home/vagrant/last_deploy

  echo "Deploy concluído com sucesso."
fi
