#!/bin/bash
time=$(date '+%Y-%m-%d %H:%M:%S')


#tomcat启动检查
function checkTomcatServer(){
	CATALINA_BASE=/usr/local/apache-tomcat-9.0.34
	while(true)
	do
	  sleep 2
	  QUERY_ID=`ps aux |grep "java"|grep "Dcatalina.base=$CATALINA_BASE "|grep -v "grep"|awk '{ print $2}'`
	  if [ -n "$QUERY_ID" ] ; then
		QUERY_PORT=`netstat -antup | grep LISTEN | grep $QUERY_ID`
        	echo "循环检测开始，Tomcat 正在健康运行中，进程id：${QUERY_ID}，端口信息为：" $QUERY_PORT 
	else 
		echo "循环检测中，检测到tomcat未启动，开始启动！！！！！"
			tomcat_home=$CATALINA_BASE/bin/startup.sh #tomcat启动的目录
			echo "tomcat服务开始启动   $time  ！！！！！！！！！！！！！！！"
			$tomcat_home
			 sleep 10
         fi
	done
}



checkTomcatServer

