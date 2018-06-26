### [Msys2官网](http://www.msys2.org/)
>有关msys2的一些信息，这里就不复述了，直接在官网首页上看吧，这里简述一下msys2的两个版本----msys2-i686-xxx.exe和msys2-x86_64-xxx.exe，这两货的区别在于msys2-x86_64-xxx.exe集成了msys、mingw32、ming64这三个环境，而msys2-i686-xxx.exe只有msys这个独立环境，因此按照需要下载吧，如果没有什么特殊需求的话，msys2-i686-xxx.exe一般就足够了。多唠叨一句，msys2建议安装在非系统盘，它的目录占用空间增长得贼快。

#### 包管理
>关于Msys2的内置包管理，作者采用了ArchLinux发行版里的pacman来管理包依赖，当然，这两货的用法是一样的，但是两者提供的镜像源铁定不同啦，另外msys2的pacman针对windows作了一些适配处理，当然有鉴于c/c++的各种冗杂的环境依赖所限，pacman与python的pip以及node.js的npm等同类型工具相比还是复杂了点，不过还算凑合吧。在其他的Linux发行版中，CentOS采用yum、Ubuntu采用apt-get等等

##### 一些常用的指令
 - `pacman --help`:查看帮助
 - `pacman -Syu`:自动更新所有软件包
 - `pacman -Sl | less -R`:查看所有可安装软件包
 - `pacman -S package-name`:安装xxx软件包
 - `pacman -Ss package-name`:查询xxx软件包的信息
 - `pacman --help --query`:查看某条命令的可用选项
 - `pacman -S make gcc gdb`:常用的工作配置
 - 快速部署Vim的工作环境，可以参考[自用vimrc](https://github.com/YaoXuanZhi/vimrc)

### 关联到右键菜单中
在msys32/64中创建RunMsys2.bat、RegMsys2.bat这两个文件，然后将以下内容复制过去，然后以管理员身份执行RegMsys2.bat即可。

```sh
::RunMsys2.bat
:::::::::::::::: Msys2 Execute Version 1.0 BY 耀轩之 ::::::::::::::::
@echo off

rem ember value of GOTO: is used to know recursion has happened.
if "%1" == "GOTO:" goto %2

if NOT "x%WD%" == "x" set WD=

rem ember command.com only uses the first eight characters of the label.
goto _WindowsNT

start /min %COMSPEC% /e:4096 /c %0 GOTO: _Resume %0 %1 %2 %3 %4 %5 %6 %7 %8 %9
goto EOF

rem ember that we execute here if we recursed.
:_Resume
for %%F in (1 2 3) do shift
if NOT EXIST %WD%msys-2.0.dll set WD=.\usr\bin\

rem ember that we get here even in command.com.
:_WindowsNT

if NOT EXIST %WD%msys-2.0.dll set WD=%~dp0usr\bin\

set MSYSTEM=MINGW32
rem To activate windows native symlinks uncomment next line
rem set MSYS=winsymlinks:nativestrict
rem Set debugging program for errors
rem set MSYS=error_start:%WD%../../mingw32/bin/qtcreator.exe^|-debug^|^<process-id^>
set MSYSCON=mintty.exe
if "x%1" == "x-consolez" set MSYSCON=console.exe
if "x%1" == "x-mintty" set MSYSCON=mintty.exe

if "x%MSYSCON%" == "xmintty.exe" goto startmintty
if "x%MSYSCON%" == "xconsole.exe" goto startconsolez

:startmintty
if NOT EXIST %WD%mintty.exe goto startsh

set _T=%*
set _T=%_T:"=%

pushd "%_T%" 2>nul && (call :folder & popd) || call :file
exit

:startconsolez
cd %WD%..\lib\ConsoleZ
start console -t "MinGW" -r "%*"
exit

:startsh
start %WD%sh --login -i %*
exit

:file
call :getdir %_T%
%WD%mintty -i %~dp0msys2.ico %~dp0usr/bin/bash --login -c "cd '%_DIR%' && vim '%_T%'"
exit

:folder
%WD%mintty -i %~dp0msys2.ico %~dp0usr/bin/bash --login -c "cd '%_T%';exec bash"
exit

:getdir
::获得此文件的所在目录路径
set _DIR=%~dp1
```

```sh
::RegMsys2.bat
:::::::::::::::: Msys2 Register Version 1.0 BY 耀轩之 ::::::::::::::::
@echo off
::判断是否已经获取了管理员身份
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo 请使用右键管理员身份运行&&Pause >NUL&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableDelayedExpansion

::设置右键菜单项的名称
@set desc="用Msys2打开"
::设置搭建编译环境的BAT
@set runbat="RunMsys2.bat"
::设置子路径名称
@set subname="Msys2"
::去掉双引号，主要是为了兼容包含了空格的文件名或路径
@set "runbat=%runbat:"=%"
@set "subname=%subname:"=%"

::添加注册表信息
@reg add "HKEY_CLASSES_ROOT\Directory\background\shell\%subname%" /v "" /t REG_SZ /d %desc%
@reg add "HKEY_CLASSES_ROOT\Directory\background\shell\%subname%" /v "Icon" /t REG_EXPAND_SZ /d "%~dp0\msys2.ico"
@reg add "HKEY_CLASSES_ROOT\Directory\background\shell\%subname%\command" /v ""  /t REG_EXPAND_SZ /d "\"%~dp0%runbat%\" \"%%V\"

@reg add "HKEY_CURRENT_USER\Software\Classes\*\shell\%subname%" /v "" /t REG_SZ /d %desc%
@reg add "HKEY_CURRENT_USER\Software\Classes\*\shell\%subname%" /v "Icon" /t REG_EXPAND_SZ /d "%~dp0\msys2.ico"
@reg add "HKEY_CURRENT_USER\Software\Classes\*\shell\%subname%\command" /v "" /t REG_EXPAND_SZ /d "\"%~dp0%runbat%\" \"%%V\"

@reg add "HKEY_CLASSES_ROOT\Directory\shell\%subname%" /v "" /t REG_SZ /d %desc%
@reg add "HKEY_CLASSES_ROOT\Directory\shell\%subname%" /v "Icon" /t REG_EXPAND_SZ /d "%~dp0\msys2.ico"
@reg add "HKEY_CLASSES_ROOT\Directory\shell\%subname%\command" /v "" /t REG_EXPAND_SZ /d "\"%~dp0%runbat%\" \"%%V\"
```

>考虑到markdown的在线渲染会出现字符转义的情况，这里提供附件下载----[msys2_menu.zip](assets/004/02/03/msys2_menu.zip)。注意，RunMsys2.bat就是从msys2-i686-xxx.exe的mingw32.bat中提取出来的，在此基础上新加了两个功能，如果外部传入的参数是文件夹，则bash会直接定位到此文件夹下，如果是文件，则直接用vim来打开，如图所示：
>![](assets/004/02/03/03-1529738893000.png)

### FAQ
>执行`pacman -S gcc`后去吃个午饭，回来发现msys2的Mintty无故退出，再次执行相同指令时报错，日志如下：

  ```log
  安装gcc时遇到了这个问题
  错误：无法初始化事务处理 (无法锁定数据库)
  错误：无法锁定数据库：File exists
    如果你确认软件包管理器没有在运行，
    你可以删除 /var/lib/pacman/db.lck。
  ```

>查到的资料：[《pacman locked but /var/lib/pacman/db.lck doesn't exist.》](https://bbs.archlinux.org/viewtopic.php?pid=1045162)，这个链接讨论的报错和笔者遇到的报错有点相似(可惜他是遇到not exist的情况=.=)，不过这个网友遇到的问题是由于磁盘空间不足导致的，本人此时的磁盘空间充足，因此不具备参考性。后来依照提示，执行`rm -f /var/lib/pacman/db.lck`删除了db.lck，再次执行安装指令就可以正常安装了

---

### [Cmder官网](http://cmder.net/)
关于它的详情，看官网最好啦，本人也整理过一些资料----[《ConEmu项目资料》](?file=004-零碎记忆/03-把玩项目/03-ConEmu/01-项目资料 "项目资料")

#### 添加第三方软件
通常是修改init.bat来实现的，这里以cmake做个例子简要说明下：
>在`.../vendor/init.bat`文件里插入`call %~dp0extracmd.bat`，然后在同级目录下新建一个extracmd.bat文件，在里面填入`set path=%path%;E:/tools/cmake/bin;`就可以了

---

### Msys2与Cmder的异同
#### 相同之处
  - 都是Windows下模拟linux的执行环境，两者都可以执行部分linxu指令，比如less、grep、vim、ls、bash、ssh等等

#### 差异之处
 - Msys2的定位和Cygwin是一样的，都是将自己视为linux环境，终端程序采用了mintty(这货是putty的阉割版)，而cmder里的终端程序是ConEmu，因此还是将自己看作成windows环境，只不过兼容了部分linux的命令而已
 - Msys2内置了Pacman作为包管理，而cmder是没有包管理的，通常是通过修改`set path=%path%;xxx;`来添加第三方软件的支持
 - Cmder里的ConEmu提供了更加丰富的窗口管理功能，以及各种主题设置等等，Msys2里的Mintty只有终端功能><
 - 在Msys2中编译出来的程序必须依赖MSYS-2.0.DLL、MSYS-GCC_S-1.DLL，而Cmder是不需要的
 - Cmder(Conemu)在窗口最大化切换时，vim、less等工具的文本并不会重新布局，而Msys2(Mintty)是可以的

