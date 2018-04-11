#### 编辑文件命令
 - 编辑文件--`vim filename`
 - 编辑文件--`less -R filename`

#### 查看系统内存使用情况
 - 执行在终端下执行`top`命令，要想退出查看模式，输入`q`即可，如下图所示：
 - 执行`cat /proc/meminfo`命令来查看，简单版的命令是`free -h`
 - 执行`sudo atop`命令来查看，不过这个方式需要获得root权限，否则将会失败
 - 执行`htop`命令查看，可以实现一个高彩色的进程间管理的命令行界面(推荐)

#### 重启Linux系统
 - `Ctrl+D`

#### 查看文件
 - 查看指定文件后面追加的内容：`tail -f filename`
 - 查看新增的报错日志：`tail -f filename | grep -n "ERR"`
 - 搜索N次匹配的日志：`grep -m 1 'ERROR' filename`
 - 多字段搜索日志：`grep -E 'WARN|ERR' filename > err.log`
 - 按照时间范围搜索日志：`awk '$2>"17:30:00" && $2<"18:00:00"' filename`

#### 查看当前目录的文件
 - 查看当前目录的文件简介：`ls`
 - 查看当前目录的文件详细信息：`ll`

#### 控制台日志级别高亮
这个日志高亮，在Linux上统一被称为Console Codes，具体资料可以直接阅读[Console Codes](http://www.man7.org/linux/man-pages/man4/console_codes.4.html)，另外，在Windows 10上也开始支持这种日志格式，不过在Windows 10以下系统的时候可以借助Console API来实现类似的效果。

#### 通过XShell来上传/下载CentOS上的文件
 - 安装lrzsz：`yum install -y lrzsz`
 - 上传文件到Linux：`rz filename`
 - 从Linux上下载文件：`sz filename`
 - [通过XShell来下载CentOS上的文件](https://jingyan.baidu.com/article/219f4bf7eedef9de442d380f.html)