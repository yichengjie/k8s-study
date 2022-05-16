1. 增加host域名
    ```text
    vi /etc/hosts
    192.168.99.110 art.local
    ```
2. 修docker配置配置http的支持
    ```text
    vi /etc/docker/daemon.json
    {
    "registry-mirrors": [
      "https://registry.docker-cn.com",
      "https://dockerhub.azk8s.cn",
      "https://reg-mirror.qiniu.com",
      "http://hub-mirror.c.163.com",
      "https://docker.mirrors.ustc.edu.cn"
    ],
    "insecure-registries": ["art.local:8081"]
    }
    ```
3. 重启docker ```systemctl restart docker```
4. 登录镜像中心
    ```text
    docker login art.local:8081
    Username: admin
    Password:
    ```
5. 