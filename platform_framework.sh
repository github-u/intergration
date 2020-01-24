#!/bin/bash
echo "start git pull project..."
cd ~/git-repositories/admin
git pull

echo "start compile ..."
mvn clean package -DskipTests=true

echo "stop app ..."
/home/admin/admin/apache-tomcat-9.0.30/bin/shutdown.sh

echo "start remove old target ..."
rm -rf ~/admin/apache-tomcat-9.0.30/webapps/platform*

echo "start copy new target ..."
cp platform-framework/target/platform.war ~/admin/apache-tomcat-9.0.30/webapps/

echo "start app ..."
cd ~/admin
/home/admin/admin/apache-tomcat-9.0.30/bin/startup.sh

echo "deploy done !"