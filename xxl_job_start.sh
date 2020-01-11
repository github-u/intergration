#!/bin/bash
echo "====================start deploy ====================="
pid=$(ps aux |grep xxl-job-admin  | grep -v 'grep' | awk '{print $2}')

echo "checking existing, pid = $pid"
if [ "x$pid" == "x" ] ; 
then  
    echo "not exists, continue"; 
else  
    echo "exists, stop $pid ..."; 
    kill -15 $pid; 
fi

echo "start git pull project..."
cd ~/git-repositories/task
git pull

echo "start compile ..."
mvn clean package -DskipTests=true

echo "start copy target ..."
cp xxl-job-admin/target/xxl-job-admin-2.2.0-SNAPSHOT.jar ~/task

echo "start app ..."
cd ~/task
java -jar xxl-job-admin-2.2.0-SNAPSHOT.jar
