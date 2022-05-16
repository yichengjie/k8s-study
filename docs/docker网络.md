1.  查看ip映射: iptables-save
    ```text
    -A DOCKER-INGRESS -p tcp -m tcp --dport 8080 -j DNAT --to-destination 172.18.0.2:8080
    从这行可以看到所有访问8080端口都会被转发到172.18.0.2:8080上面
    ```
2. 查看docker的网络: docker network ls
    ```text
    NETWORK ID     NAME              DRIVER    SCOPE
    0f06f843cff0   docker_gwbridge   bridge    local
    tmmzs623ewoq   ingress           overlay   swarm
    ```
3. 查看网络详情: docker inspect docker_gwbridge,可以看到这个网络连接了一个叫　ingress-sbox　的容器。它的地址就是　172.18.0.2/16
4. 这个　ingress-sbox　其实并不是一个容器，而是一个网络的命名空间　network namespace，进入网络命令空间
5. 进入ingress-sbox命令空间中
    ```text
    docker run -it --rm -v /var/run/docker/netns:/netns --privileged=true nicolaka/netshoot nsenter --net=/netns/ingress_sbox sh
    ```
6. 查看ip地址: ip a, 通过查看地址，发现这个命名空间连接了两个网络，一个eth1是连接了　docker_gwbridge　，另外一个eth0连接了　ingress 这个网络
7. 查看ip路由规则: ip route
    ```text
    10.0.0.0/24 dev eth0 proto kernel scope link src 10.0.0.4 
    172.18.0.0/16 dev eth1 proto kernel scope link src 172.18.0.2 
    ```
8. 查看iptables映射： iptables -nvL -t mangle
    ```text
    Chain PREROUTING (policy ACCEPT 1379 packets, 496K bytes)
    pkts bytes target     prot opt in     out     source               destination         
    29  6547 MARK       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:8080 MARK set 0x102
    ```
9. 从上面可以看出，对8080端口的访问将转发到 0x102 (16进制)上， 0x102转为10进制为：258
10. 查看vip: ipvsadm
    ```text
    IP Virtual Server version 1.2.1 (size=4096)
    Prot LocalAddress:Port Scheduler Flags
      -> RemoteAddress:Port           Forward Weight ActiveConn InActConn
    FWM  258 rr
     -> 10.0.0.15:0                  Masq    1      0          0         
     -> 10.0.0.16:0                  Masq    1      0          0
    ```
11.  可以看到258 将对应10.0.0.15 和10.0.0.16两个ip, 这两个ip是容器中ip地址
