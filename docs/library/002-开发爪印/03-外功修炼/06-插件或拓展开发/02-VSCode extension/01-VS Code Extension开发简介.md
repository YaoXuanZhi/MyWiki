# VS Code Extension开发简介

### 介绍VS Code
VS Code和Atom一样，都是基于Electron二次开发所得的。目前，Microsoft官方已经为其增加了中文语言版本了，并且为了吸引广大的开发者来参与到VS Code大家庭里，提供了一种名为extension的开发方式给开发者。其实这种开发方式是结合了Node.js和javascript的，当然，随着前端的兴起，这里面也提供了一些更加方便的开发方式，比如使用了TypeScript等开发语句。

---

### 介绍VS Code 的拓展机制
目前VS Code支持定制的地方非常多，目前比如可以定制资源管理器的菜单栏、文本编辑器标题栏和右键菜单栏等等，还有文件图标、文件信息等等文件其实都是可以通过VS Code Extension来修改的。

目前要想着手开发一个VSCode的插件，需要安装一个Node.js的运行环境，然后利用Npm包管理器来部署VSCode的开发环境，下面是具体的过程：

 - 下载Node.js安装包或压缩包：到[Node.js官网](https://nodejs.org/en/)或国内靠谱的Node.js的网站上下载Node.js的安装包或压缩包
 - 部署Node.js的运行环境：这里面提供两种方式，第一种方式是直接通过安装包，这就不用详细说明了，一路Next下去即可。另外一种方法则是，下载压缩包，然后手动将Node.js的压缩包的解压位置（推荐将其解压到磁盘第一个子级目录下，因为它的文件夹层级太多了），然后手动将解压路径添加到电脑的环境变量之中，另外一种方式则是将它添加到右键菜单之中（个人推荐这种方式），具体做法如下所示：

```cmd
::nodevarsPlus.bat
@echo off
@title 欢迎使用Node.js

SET PATH=%~dp0;%PATH%;

:: now bring current sessions to cmd with /k args (stay)
call cmd /k
```

```cmd
::添加到菜单.bat
::此右键菜单在文件夹/桌面上右击时出现
@echo off
::判断是否已经获取了管理员身份
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo 请使用右键管理员身份运行&&Pause >NUL&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableDelayedExpansion
::设置右键菜单项的名称
@set desc="进入Node.js运行环境"
::设置搭建编译环境的BAT
@set runbat="nodevarsPlus.bat"
::设置子路径名称
@set subname="Node_js"
::去掉双引号，主要是为了兼容包含了空格的文件名或路径
@set "runbat=%runbat:"=%"
@set "subname=%subname:"=%"
::添加注册表信息
@reg add "HKEY_CLASSES_ROOT\Directory\background\shell\%subname%" /v "" /t REG_SZ /d %desc%
@reg add "HKEY_CLASSES_ROOT\Directory\background\shell\%subname%\command" /v ""  /t REG_SZ /d "%~dp0%runbat%"
```

将上面两个bat文件放置在Node.js的目录下，然后右键管理运行`添加到菜单.bat`即可，如图所示：

![](assets/002/03/06/02/01-1506347584000.png)

---

#### 一些本人遇到的坑
在通过Npm来安装一些包的时候，发现弹出了`npm ERR! code EINTEGRITY`错误，关于此问题网上众说纷纭，这里面是本人整理到的一些常见解决方案，其中本人认为第三种方案是最合理、有效的，刚刚安装Node.js的Windows下没有这个`.npmrc`文件，选择一个国内可用的Npm包的镜像资源，填充到此文件之中即可。

【1】[npm ERR! code EINTEGRITY](http://blog.csdn.net/Mr_rain/article/details/74551497)

【2】清理npm的缓存：`npm cache clean --force`

【3】在Windows下，出现这个问题极有可能是Node.js的安装目录下缺少`.npmrc`文件，手动创建此文件后，在里面插入一个Npm包的镜像源即可，如在`.npmrc`文件中插入`registry = https://registry.npm.taobao.org` 内容并保存。（PS：更加简单的办法则是，直接将目录下的`.npmrc`文件复制到Node.js的目录下）

如果上述方法解决不到问题，那么极有可能是被防火墙给墙了，因此，此时有必要更换一下镜像源来再次尝试下载对应的Npm包了，国内有这么一篇教程可以有效更换Npm包的镜像源。[使用npm安装一些包失败了的看过来（npm国内镜像介绍）](http://cnodejs.org/topic/4f9904f9407edba21468f31e)。在这里面，本人摘抄一些关键点来说明下。

--- 

##### 1.通过config命令
 - `npm config set registry https://registry.npm.taobao.org`
 - `npm config set registry http://registry.cnpmjs.org`
 - `npm info underscore （如果上面配置正确这个命令会有字符串response）`

##### 2.命令行指定
 - `npm --registry https://registry.npm.taobao.org info underscore` 

##### 3.编辑 ~/.npmrc 加入下面内容
 - `registry = https://registry.npm.taobao.org`
