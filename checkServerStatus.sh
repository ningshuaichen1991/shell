#!/bin/bash
time=$(date '+%Y-%m-%d %H:%M:%S')

#redis启动检查
function checkRedisStatus(){
	#redis启动的目录
	redis_server_exec=/usr/local/redis/src/redis-server
	#redis的配置文件目录
	redis_conf=/usr/local/redis/redis.conf
	#每个redis服务端口，每一个端口的配置文件启动一个redis服务
	ports=('6379')
	#获取所有的redis服务的进程信息
	redis=`ps -aux | grep $redis_server_exec`
	#判断端口是否存在于redis服务信息中
	for port in ${ports[*]};do
	#这句话的意思是判断port这个字符串是否在redis这个字符串中
	if [[ $redis =~ $port ]]
	then
		echo "redis服务已经启动成功，端口号：$port  $time ！！！！！！！！！！！！"
	else
		echo "redis服务没有启动，  $time ！！！！！！！！！！！！！！！"
	fi
	done
}

#tomcat启动检查
function checkTomcatServer(){
	CATALINA_BASE=/usr/local/apache-tomcat-9.0.34
	QUERY_ID=`ps aux |grep "java"|grep "Dcatalina.base=$CATALINA_BASE "|grep -v "grep"|awk '{ print $2}'`
	if [ -n "$QUERY_ID" ] ; then
		QUERY_PORT=`netstat -antup | grep LISTEN | grep $QUERY_ID`
        	echo "Tomcat 启动成功，进程id：${QUERY_ID}，端口信息为：" $QUERY_PORT 
	else 
		echo "tomcat未启动，查看日志命令：tail -n 100  -f $CATALINA_BASE/logs/catalina.out"
		
         fi
}


#nginx启动检查
function nginxCheckStart(){
	serviceName=nginx
	if ps -ef | grep $serviceName | egrep -v grep >/dev/null
	then
		echo "nginx服务启动成功，$time  ！！！！！！！！！！！！！！！ "
	else
		echo "nginx服务没有启动，$time  ！！！！！！！！！！！！！！！"
	fi
}

#activemq启动检查
function checkActiveMQStatus(){
	SERVER_BASE=activemq
        QUERY_ID=`ps aux |grep "java"|grep $SERVER_BASE|grep -v "grep"|awk '{ print $2}'`
        if [ -n "$QUERY_ID" ] ; then
                QUERY_PORT=`netstat -antup | grep LISTEN | grep $QUERY_ID`
                echo "activemq 启动成功，进程id：${QUERY_ID}，端口信息为：" $QUERY_PORT 
        else
                echo "activemq 服务未启动，$time ！！！！！！！！！！"

        fi

}


checkRedisStatus

checkTomcatServer

nginxCheckStart

checkActiveMQStatus
