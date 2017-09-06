# 人生苦短，我用Python
目前在国内外高效里面，第一门语言往往采用Python来作为首要教学，主要是其简单易学，并且提供了易用的包管理方式`pip`，可以方便地将第三方包集成到项目里面，大部分Python的开发者都喜欢用它来做一些爬虫工作以及作自动化管理等，比如Google就大幅度采用Python来生成工程代码了，另外随着这段时间深度学习、数据挖掘的兴起，Python的可用之处就更多了，虽然它的执行效率让人诟病，但是它的优点吸引了越来越多的小伙伴加入到Python的大家庭里面了。

不过，目前Python版本分成了两个版本，分别为`Python 2.x` 和 `Python 3.x`，后者增加了一些新特性，另外，对于字符编码的处理也更加高效，不过目前大部分应用还是采用了`Python 2.x`，因此本人在此也是学习了此版本的语法和第三方包。

### 搭建Python的开发环境
根据项目需要，从[Python官网](https://www.python.org/)上下载Python 2.x或3.x的安装包并安装。注意，安装完Python之后，需要按F5刷新下桌面，否则Python的环境变量应用失效哦

个人建议采用VSCode，并且安装Python插件来实现，当然，用VS接着PTVS插件来搭建Python的开发环境也是不错的。这里面演示一下在VSCode下安装Python插件，在VSCode下按下 **Ctrl+Shift+P** 打开命令面板，然后输入`ext install python`，然后再输入`reload window`重启VS窗口即可，如下图所示：

![](assets/002/1.安装Python.gif)  

![](assets/002/2.在VSCode中安装Python插件.gif)  

### 调试Python脚本
在VSCode之中，调试的快捷键如下所示：
 - 【开始调试】F5
 - 【单步执行】F10
 - 【打下断点】F9
 - 【停止调试】Shift+F5

![](assets/002/4.在VSCode中调试Python.gif)  

### 包管理器：pip
##### pip的常用命令
 - 安装第三方包：`pip install packname[==version]`
 - 卸载第三方包：`pip unistall packname[==version]`
 - 查看已经安装的第三方包：`pip freeze`

使用过程：直接按下组合键 **Win+R** ，在弹出的运行窗口上，输入cmd来打开 **cmd.exe** ，然后输入pip的命令，如果遇到找不到pip的可执行文件，那么十有八九就是Python的环境变量没有添加成功，需要刷新下桌面或者重启下电脑，检查下环境变量`Path`，直接执行dos语句 `@echo %path%`既可以看到。

![](assets/002/3.安装pylint.gif)

##### 常用的第三方包
 - pylint -- `pip install pylint`
 - pyinstaller -- `pip install pyinstaller`
 - xlrd -- `pip install xlrd`
 - wxPython -- `pip install wxPython`

### 将Python打包成exe
##### 【pyinstaller】
 - [安装]：直接通过`pip install pyinstaller`来直接安装
 - [使用]：执行`pyinstaller -F xxx.py`即可打包

![](assets/002/5.安装pyinstaller并使用.gif)  

注意，被打包的Python的文件路径不能够包含非ASCII字符，否则将会打包出错

#### 【py2exe】
 - [安装]：在Python 3.x时，可以通过`pip install py2exe`来直接安装，但是对于Python 2.x而言，只能够通过[py2exe-0.6.9.win32-py2.7.exe](assets/002/py2exe-0.6.9.win32-py2.7.exe)来手动安装了
 - [使用]：需要先定义一个[setup.py](assets/002/setup.py)文件，在此文件内，设定打包的行为，然后执行`python setup.py py2exe`命令来打包

![](assets/002/6.安装py2exe并使用.gif)

### Python开发GUI程序
目前可以选取的方案是使用wxPython，具体教程请访问[官方网站](http://www.wxpython.org)，官网里面已经提供了丰富的样例工程，下面演示了如下打包这个GUI工程成exe的过程。

![](assets/002/7.安装wxPython并使用.gif)

附件：[pyProject.rar](assets/002/pyProject.rar)
