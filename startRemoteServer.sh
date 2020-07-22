#!/bin/bash
serverPassword='xxx'

#远程启动服务
function startRemoteServer(){
	echo -e
	sshpass -p $serverPassword ssh root@39.106.4.177 -o StrictHostKeyChecking=no 'sh /shell/startAllServer.sh'
	echo -e
}

startRemoteServer