# 构建用于此作业的镜像
IMAGE=$(docker build . | tail -l | awk '{ print $NF }')
# 构建挂在到Docker的目录
MNT="$WORKSPACE/.."
# 在docker 里执行编译测试
CONTAINER=$(docker run -d -v "$MNT:/opt/project" $IMAGE /bin/bash -c 'cd /opt/project/workspace && rake spec')
CONTAINER=$(docker run -d -v $MNT:/opt/project/ $IMAGE /bin/bash -c 'cd /opt/project/workspace && rake spec')
# 进入容器，这样可以看到输出的内容
docker attatch $CONTAINER
# 等待程序退出，得到返回码
RC=$(docker wait $CONTAINER)
# 删除刚刚用到的容器
docker rm $CONTAINER
# 使用刚才返回码退出整个脚本
exit $RC