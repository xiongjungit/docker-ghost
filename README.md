## Ghost 7.0。4 正式发布

![](http://static.ghostchina.com/image/a/21/de1b2911072f5a4eff82abdb62632.png)

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

* [dockerfile/nodejs](http://dockerfile.github.io/#/nodejs)


### 安装

1. 安装 [Docker](https://www.docker.com/).

2. 下载 [自动创建的Ghost镜像](https://registry.hub.docker.com/u/dockerfile/ghost/) 从 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull dockerfile/ghost`

   (或者你可以从 Dockerfile 创建: `docker build -t="dockerfile/ghost" github.com/dockerfile/ghost`)


### 使用

    docker run -d -p 80:2368 dockerfile/ghost

#### 定制 Ghost

    docker run -d -p 80:2368 -v <override-dir>:/ghost-override dockerfile/ghost

`<override-dir>` 可以包含绝对路径的目录:

*  `config.js`: 从 [这里](https://github.com/TryGhost/Ghost/blob/master/config.example.js)复制自定义配置文件 (必须更改 `127.0.0.1` 为 `0.0.0.0`)

* `content/data/`: 持续/共享的数据

* `content/images/`: 持续/共享的图像

* `content/themes/`: 更多主题

等待几秒钟后, 在浏览器中打开 `http://<host>` 博客或者 `http://<host>/ghost` 博客后台。

## 代码创建和维护

* QQ: 479608797

* 邮件:  fenyunxx@163.com

* [github](https://github.com/xiongjungit/docker-ghost)

* [dockerhub](https://hub.docker.com/r/dockerxman/)
