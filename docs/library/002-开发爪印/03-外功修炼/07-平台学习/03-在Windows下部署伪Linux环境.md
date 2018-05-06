## Msys2环境部署

#### 修改镜像源

#### 安装各个常用组件包(基于pacman)
```sh
pacman -S git winpty
pacman -Sy
```

##### C/C++ 开发相关
>安装MinGW全家桶gcc、gdb、make、cmake等等

```sh
pacman -S mingw-w64-x86_64-gcc mingw-w64-x86_64-gdb mingw-w64-x86_64-make mingw64/mingw-w64-x86_64-cmake
```

##### Node.js 开发相关
>并不推荐采用官方的包，因为Node.js的包源太旧了，截止到现在，还停留在**v0.10.0**上，但是实际已经更新到**v.8.6**了，个人建议，不如直接从官网上下载Node.js安装包，手动安装。因此这里的步骤如下：注意，需要将Node.js的所在路径关联到`usr/bin`之中

#### 将Msys2集成到Windows下的右键菜单中

##### RegMsys2.bat
```shell
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

##### RunMsys2.bat
```shell
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
%WD%mintty -i %~dp0msys2.ico %~dp0usr/bin/bash --login -c "cd '%_DIR%';vim '%_T%'"
exit

:folder
%WD%mintty -i %~dp0msys2.ico %~dp0usr/bin/bash --login -c "cd '%_T%';exec bash"
exit

:getdir
::获得此文件的所在目录路径
set _DIR=%~dp1
```

>将**RegMsys2.bat**和**RunMsys2.bat**这两个.bat文件拷贝到`.../msys64/`路径下，选中**RegMsys2.bat**然后执行右键菜单里的**以管理员身份运行**命令即可，在右键菜单里就可以看到有一个**以Msys2打开**的菜单项，执行这个菜单命令即可，注意，不能包含非ASCII字符哦，因为msysw默认字符编码为utf-8

