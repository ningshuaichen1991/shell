#!/bin/bash
#当前日期
time=$(date '+%Y-%m-%d %H:%M:%S')


#redis启动
function redisStart(){
	#redis启动的目录
	redis_server_exec=/usr/local/redis/src/redis-server
	#redis的配置文件目录
	redis_conf=/usr/local/redis/redis.conf
	#每个redis服务端口，每一个端口的配置文件启动一个redis服务
	ports=('6379')
	#获取所有的redis服务的进程信息
	redis=`ps -aux | grep $redis_server_exec`
	echo $redis
	#判断端口是否存在于redis服务信息中
	for port in ${ports[*]};do
	#这句话的意思是判断port这个字符串是否在redis这个字符串中
	if [[ $redis =~ $port ]]
	then
		echo "redis服务已经启动，无需再进行操作，端口号：$port  $time ！！！！！！！！！！！！"
	else
		echo "redis服务开始启动，端口号 ：$port  $time ！！！！！！！！！！！！！！！"
		$redis_server_exec $redis_conf &
	fi
	done
}


#activeMQ启动
#说明：
#ps -ef : 显示当前所有在运行的进程知
#|：管道，即其前面命令道的的输出回，作为后面命令的输入
#grep service_name :  在输出信息中，查找service_name数据行
#egrep -v grep： 不显示grep查找命令本身,并把结果重定向到/dev/null文件中
function activeMQStart(){
	serviceName=activemq
	if ps -ef | grep $serviceName | egrep -v grep >/dev/null
	then
		echo "ActiveMQ服务已经启动  ，无需再进行操作， $time  ！！！！！！！！！！！！！！！ "
	else
		#ActiveMQ启动的目录
		activeMQ_home=/usr/local/apache-activemq-5.15.12/bin/activemq
		echo "activeMQ服务开始启动   $time  ！！！！！！！！！！！！！！！"
		$activeMQ_home start &
	fi	
}


#nginx启动
function nginxStart(){
	serviceName=nginx
	if ps -ef | grep $serviceName | egrep -v grep >/dev/null
	then
		echo "nginx服务已经启动  ，无需再进行操作， $time  ！！！！！！！！！！！！！！！ "
	else
		#nginx启动的目录
		nginx_server_exec=/usr/local/nginx/sbin/nginx
		echo "nginx服务开始启动   $time  ！！！！！！！！！！！！！！！"
		$nginx_server_exec
	fi	
}


#tomcat服务启动
function tomcatStart(){
	serviceName=apache-tomcat-9.0.34 	
	
	if ps -ef | grep $serviceName | egrep -v grep >/dev/null
	then
		echo "tomcat服务已经启动  ，无需再进行操作， $time  ！！！！！！！！！！！！！！！ "
	else 
		tomcat_home=/usr/local/apache-tomcat-9.0.34/bin/startup.sh #tomcat启动的目录
		echo "tomcat服务开始启动   $time  ！！！！！！！！！！！！！！！"
		$tomcat_home
	fi	
}


redisStart

activeMQStart

nginxStart

tomcatStart












