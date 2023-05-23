# alpinelinux-install-xray

# fork & clone repo

fork 完成后，修改自己仓库 `server.json`.

然后 clone 自己项目

```sh
git clone
```

# 进入目录

```sh
cd alpinelinux-install-xray && git pull
```

# 安装

```sh
chmod u+x install.sh && ./install.sh
```

# 启动

包含杀死之前的 xray 进程。

```sh
./start.sh
```

# 查看启动记录和端口

```sh
cat ./log.txt

```

访问自己的 IP 和端口查看

# 额外命令，查看启动命令。不需要用

```sh
ps aux
```

一般会找到下面的显示。

`8464 root      0:00 ./xray/xray -c server.json`
