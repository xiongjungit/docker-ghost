## Ghost 7.0.4 正式发布

![](http://static.ghostchina.com/image/a/10/ffe40181fc1023de4d2060d5d0ce2.png)

紧随 Ghost 官方脚步，Ghost 0.7.4 中文正式版发布了！这一版本包含了自 Ghost 0.7.3 版本发布以来所修正的 bug，主要是针对开放 API 功能的改进。

**0.7.1、0.7.2、0.7.3 这些版本哪去了？**

从 Ghost 0.7.0 版本发布以来，Ghost 中文网并没有跟进发布 0.7.1、0.7.2 以及 0.7.3 版本，主要是我们不希望让这么多、这么密集发布的版本给大家带来疲于升级的困扰。

首先说 0.7.1 版本，这一版本主要是针对 0.7.0 版本的 bug 修正，并且没有太大的 bug，也没有太多新东西，鉴于我们已经发布过 0.7.0 版本了，因此把 0.7.1 版本就捂下来了。

0.7.2 版本开始，Ghost 团队引入了开放 API 和 {{#get}} 助手函数，并且支持 Node v4.2 ，不过，正是由于引入了开放 API ，致使 Ghost 源码变动较大，自然出 bug 的几率更多，不适合过早尝试。

0.7.3 版本时 12 月 16 日发布的，主要是修复 0.7.2 版本的 bug。这个版本命太短了，刚过一周（也就是 12 月 22 日） 0.7.4 版本就发布了。

**主要改进综述**

- [新增] 通过 @blog 全局变量可以获取页面地址以及分页数据（postsperpage）

- [新增] {{#get}} 助手函数（测试中）

- [新增] 在主题文件中通过 Ajax 访问开发 API （测试中）

- [新增] 支持 Node v4.2

- [新增] 在博文设置页面可以通过拖拽改变标签的顺序

- [新增] 在标签、用户、博文的 URL 末尾添加 /edit/ 可以快速进入编辑页面

- [改进] 搜索结果中包含标签


**下载地址**

http://www.ghostchina.com/download/

强烈建议大家下载并使用 Ghost 0.7.4 中文版完整集成包，以免· npm install --production ·安装依赖包时被墙！

---


## Ghost 0.7.4 中文集成版 Dockerfile


这个仓库包含[Ghost v7.4 中文集成版本](http://www.ghostchina.com/) 的[Docker](https://www.docker.com/)自动创建 [automated build](https://registry.hub.docker.com/u/dockerfile/ghost/) Ghost镜像到 [Docker Hub Registry](https://registry.hub.docker.com/)公有库的 **Dockerfile** .


### 基础docker镜像

* [ubuntu 14.04 ](http://daocloud.io/library/ubuntu:14.04)


### 安装

此版本是mysql数据库版本，并且支持markdown表格。

* 安装 [Docker](https://www.docker.com/)

* 从 [daocloud.io](https://dashboard.daocloud.io)下载[自动创建的MySQL镜像](https://dashboard.daocloud.io/packages) 

```
docker pull daocloud.io/xiongjun_dao/docker-mysql:latest
```
或者 你可以从  Dockerfile 创建:

```
docker build -t="xman/mysql:5.6" github.com/xiongjungit/docker-mysql/5.6
```

* 从 [daocloud.io](https://dashboard.daocloud.io)下载 [自动创建的Ghost镜像](https://dashboard.daocloud.io/packages) 

```
docker pull daocloud.io/xiongjun_dao/docker-ghost:latest
```

或者你可以从 Dockerfile 创建:

```
docker build -t="xman/ghost:0.7.4" github.com/xiongjungit/docker-ghost
```

### 使用

####  启动MySQL容器

```
docker run -h ghostdb -d -p 3306:3306 -v /data/ghost/ghostdb/data:/var/lib/mysql --name ghostdb xman/mysql:5.6

sleep 3

docker logs mysql
```

* `ghostdb/data` 持续/共享的MySQL数据库

你会看到以下内容,其中给出了连接mysql数据库的用户名和密码

```
========================================================================
You can now connect to this MySQL Server using:

    mysql -uadmin -p5yIlmt4IXEYs -h<host> -P<port>

Please remember to change the above password as soon as possible!
MySQL user 'root' has no password but only allows local connections
========================================================================
```

需要进入到ghostdb容器中创建ghost数据库

```
docker exec -it ghostdb /bin/bash

mysql -uadmin -p5yIlmt4IXEYs -h127.0.0.1

create database ghost

```

#### 启动Ghost容器

```
docker run -h ghost -d -p 80:2368 -v /data/ghost/content:/ghost/content --link ghostdb:db --name ghost xman/ghost
```

* `content/data/`: 持续/共享的数据

* `content/images/`: 持续/共享的图像

* `content/themes/`: 更多主题

* 需要修改的地方

启动后会报错并关闭,查看日志`docker logs ghost`

```
Migrations: Database initialisation required for version 004
Migrations: Creating tables...
Migrations: Creating table: posts

ERROR: ER_ACCESS_DENIED_ERROR: Access denied for user 'admin'@'172.17.0.3' (using password: NO)
```

发现连接数据库出错

需要修改容器中的`/ghost/config.js`

查看文件位置

```
docker inspect -f {{.Mounts}} ghost|awk '{print $6}'
```

进入到上面指令显示出的本地目录修改`config.js`文件

```
//修改为使用mysql数据库
     production: {
        url: 'http://127.0.0.1',
        mail: {},
        database: {
            client: 'mysql',
            connection: {
                host     : '172.17.0.2',
                user     : 'admin', //用户名
                password : '5yIlmt4IXEYs', //密码
                database : 'ghost', //数据库名
                charset  : 'utf8'
            }
        },
```

`url: 'http://127.0.0.1',` 需要修改为你自己的url地址

`password : '5yIlmt4IXEYs', //密码` 密码需要修改为上面myql容器随机生成的密码

接下来启动刚才报错的ghost容器

```
docker start ghost
```

再次查看日志`docker logs ghost`


```
> ghost@0.7.4 start /ghost
> node index

Migrations: Up to date at version 004
Ghost is running in production... 
Your blog is now available on http://1.2.3.4 
Ctrl+C to shut down
```

等待几秒钟后, 在浏览器中打开 `http://<host>` 博客或者 `http://<host>/ghost` 博客后台。

## 代码创建和维护

* QQ: 479608797

* 邮件:  fenyunxx@163.com

* [github](https://github.com/xiongjungit/docker-ghost)

* [dockerhub](https://hub.docker.com/r/dockerxman/)
