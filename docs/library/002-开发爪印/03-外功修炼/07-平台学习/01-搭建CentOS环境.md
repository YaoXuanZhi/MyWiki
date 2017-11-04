## 搭建CentOS环境

### 1.下载相关资源

##### CentOS镜像资源下载
首推[阿里云开源站](http://mirrors.aliyun.com/centos/6.8/isos/x86_64/)，本人采用的是CentOS 6.8版本，是在[CentOS 6.8 正式版下载](http://www.centoscn.com/CentosSoft/iso/2016/0530/7314.html)下找到下载链接的
 - [CentOS-6.9-i386-minimal(x86bit)](https://mirrors.aliyun.com/centos/6/isos/i386/CentOS-6.9-i386-minimal.iso)

##### VMWare安装包下载
推荐下载VMware 12.0版本，原因很简单，安装包体积才200M，而且可以正常安装CentOS镜像，已经够用啦。

---

### 2.在VMware下安装CentOS
可以通过VMware来安装，注意，不要立即安装这个CentOS镜像，而是设置好了虚拟磁盘、网络映射等虚拟机参数后再启动虚拟机来安装它。否则极其容易出错哦

##### 先安装VMware，然后输入相关序列号即可，网上教程众多
这里面就提供一些截图吧

##### 在VMware下加载CentOS镜像
本人采用的是`CentOS-6.8-x86_64-minimal.iso`，无它，体积小，毕竟主要是用来熟悉Linux下的服务端的开发流程，安装x64版的可能会遇到一些问题（也就是下面的VMware警告啦），建议安装x86bit的CentOS镜像来学习，这样能少折腾一点。

---

### 3.配置CentOS环境
通常而言，大部分后端开发人员都是使用xShell通过ssh来连到CentOS终端，执行一些系统命令操作，大部分实际开发活动还是停留在Windows下面的，说句实在话，还是在Windows下查资料比较舒服一些，因此需要设置CentOS的主机Ip，方便终端管理器连接，设置的Linux命令类似 `ifconfig eth0 192.168.252.3`，然后xshell新建会话，填入这个 `192.168.252.3` 即可，端口号可以通过 `vi /etc/sysconfig/iptables` 来查看，如下图所示：

![](assets/002/03/07/01-1509764843000.png)

![](assets/002/03/07/01-1509764677000.png)

---

### FAQ：
##### 如何才能够知道当前Linux镜像对应的Linux版本呢？
按照下图来判断，然后选择对应的客户机操作系统版本就不会出错了

![](assets/002/03/07/01-1499365441000.png)

##### VMware提示：已将该虚拟机配置为使用 64 位客户机操作系统。但是，无法执行 64 位操作
在Windows x64下，极有可能碰到`VMware提示：已将该虚拟机配置为使用 64 位客户机操作系统。但是，无法执行 64 位操作`，已经有网友很好地总结了这个问题了，具体链接在这。[VMware提示：已将该虚拟机配置为使用 64 位客户机操作系统。但是，无法执行 64 位操作。解决方案](http://blog.csdn.net/jdbc/article/details/51301700)。

虽然上面的思路是正确的，不过本人觉得还有一些细节需要补充下，遇到此问题的用户电脑大体有以下特征，请对号入座:
 - 开发者的真机基本都是安装`Windows x64bit`系统的，比如`Win10 x64bit`
 - 加载了Linux发行版里面的x64bit镜像，比如`CentOS-6.8-x86_64-minimal.iso`

另外，博客上面提到设置BIOS，这个关键点也是正确的，但是表述方面比较模糊，毕竟VMWare创建的每个虚拟机都可以设置BIOS，究竟是需要设置真机上的VT-X还是虚拟机上的VT-X呢？当然，假设开发者真的遇上了这个问题，那么自然是无法进入虚拟机的BIOS设置界面的，因此仅剩下真机上的BIOS设置了（并且实际通过`LeoMoon CPU-V`工具来检测的也是真机上的BIOS设置）；另外，通常而然，BIOS的设置界面里，对应的设置项(Virtualization Technology)通常在**Security**选项页内，不过也并不排除其可能出现在其他选项页；最后，在加载Linux镜像，安装系统的时候，请退出所有安全软件。

### 推荐学习站点
 - [官方网站](https://www.centos.org/)
 - [CentOS中文网站](http://www.centoscn.com)
 - [vim官方网站](http://www.vim.org/)
 - [鸟哥的私房菜-第九章、vim 程式編輯器](http://linux.vbird.org/linux_basic/0310vi.php)