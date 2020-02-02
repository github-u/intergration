#!/bin/bash
echo "start git pull project..."
cd ~/git-repositories/admin
git pull

echo "start compile ..."
mvn clean package -DskipTests=true

echo "stop app ..."
/home/admin/admin/apache-tomcat-9.0.30/bin/shutdown.sh

pid=$(ps aux |grep tomcat  | grep -v 'grep' | awk '{print $2}')
if [ "x$pid" != "x"] ;
  then kill -9 $pid
fi

for (( i=1; i <= 600; i+=1))
do 
   pid=$(ps aux |grep tomcat  | grep -v 'grep' | awk '{print $2}')
   if [ "x$pid" == "x" ] ; 
   then  
      break
  else  
    echo "stop tomcat in $i senconds"; 
    sleep 1
  fi
done

echo "start remove old target ..."
rm -rf ~/admin/apache-tomcat-9.0.30/webapps/platform*

echo "start copy new target ..."
cp platform-framework/target/platform.war ~/admin/apache-tomcat-9.0.30/webapps/

echo "start app ..."
cd ~/admin
/home/admin/admin/apache-tomcat-9.0.30/bin/startup.sh

echo "deploy start..." 
