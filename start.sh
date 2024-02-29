#!/bin/bash

#systemctl restart ollama

cd /root/go/src/github.com/yiyanwannian/ollama

# cd $pwd

pid=$(ps -ef | grep 'backend/main.go' | grep -v grep | awk '{print $2}')
echo "pid=$pid"
if [ -n "$pid" ]; then
    kill -9 $pid
    echo "Process with PID $pid has been terminated."
else
    echo "No process found with 'backend/main.go'."
fi

export OLLAMA_MODELS="/datab/ollama/models"
export OLLAMA_HOST="0.0.0.0"

go run backend/main.go > /dev/null 2>&1 &

docker stop open-webui
docker rm open-webui


docker run -d -p 7744:8080 -e OLLAMA_API_BASE_URL=http://9.134.185.81:11434/api -v /root/go/src/github.com/open-webui/open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main

docker ps

echo "account"
echo "username: 77..80@qq.com"
echo "pwd: 77..80"