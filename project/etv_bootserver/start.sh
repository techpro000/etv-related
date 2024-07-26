#!/bin/bash
#
# chkconfig:   - 20 80
# description: Starts and stops the App.
# author:vakinge

. /etc/profile

ENV=local
RUNNING_USER=root
ADATE=`date +%Y%m%d%H%M%S`
APP_NAME=etv-0.0.1
PORT=9376
MASTER=true

APP_HOME=`pwd`
dirname $0|grep "^/" >/dev/null
if [ $? -eq 0 ];then
   APP_HOME=`dirname $0`
else
    dirname $0|grep "^\." >/dev/null
    retval=$?
    if [ $retval -eq 0 ];then
        APP_HOME=`dirname $0|sed "s#^.#$APP_HOME#"`
    else
        APP_HOME=`dirname $0|sed "s#^#$APP_HOME/#"`
    fi
fi

if [ ! -d "$APP_HOME/logs" ];then
  mkdir $APP_HOME/logs
fi

LOG_PATH=$APP_HOME/logs/$APP_NAME.out
GC_LOG_PATH=$APP_HOME/logs/gc-$APP_NAME-$ADATE.log
#JMX监控需用到
JMX="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=1091 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
#JVM参数
JVM_OPTS="-Dname=$APP_NAME -Dfile.encoding=utf-8 -Dspring.profiles.active=$ENV -Dserver.port=$PORT -Dserver.is-master-server=$MASTER  -Duser.timezone=Asia/Shanghai -Xms512M -Xmx512M -XX:+HeapDumpOnOutOfMemoryError -Xloggc:$GC_LOG_PATH -XX:+PrintGCDetails -XX:NewRatio=1 -XX:SurvivorRatio=30 -XX:+UseParallelGC -XX:+UseParallelOldGC -Dcom.sun.management.jmxremote.rmi.port=8898 -XX:NativeMemoryTracking=detail"


JAR_FILE=/home/service/project/etv_bootserver/$APP_NAME.jar
pid=0
start(){
  checkpid
  if [ ! -n "$pid" ]; then
    JAVA_CMD="nohup java -Dfile.encoding=utf-8 -jar $JVM_OPTS $JAR_FILE > $LOG_PATH 2>&1 &"
    #su - $RUNNING_USER -c "$JAVA_CMD"
    nohup java -jar $JVM_OPTS $JAR_FILE >> $LOG_PATH 2>&1 &
    echo "---------------------------------"
    echo "启动完成，按CTRL+C退出日志界面即�?>>>>"
    echo "---------------------------------"
    sleep 2s
    #tail -f $LOG_PATH
  else
      echo "$APP_NAME is runing PID: $pid"   
  fi

}


status(){
   checkpid
   if [ ! -n "$pid" ]; then
     echo "$APP_NAME not runing"
   else
     echo "$APP_NAME runing PID: $pid"
   fi 
}

checkpid(){
    pid=`ps -ef |grep $JAR_FILE |grep -v grep |awk '{print $2}'`
}

stop(){
    checkpid
    if [ ! -n "$pid" ]; then
     echo "$APP_NAME not runing"
    else
      echo "$APP_NAME stop..."
      kill -9 $pid
    fi 
}

restart(){
    stop 
    sleep 1s
    start
}

case $1 in  
          start) start;;  
          stop)  stop;; 
          restart)  restart;;  
          status)  status;;   
              *)  echo "require start|stop|restart|status"  ;;  
esac
