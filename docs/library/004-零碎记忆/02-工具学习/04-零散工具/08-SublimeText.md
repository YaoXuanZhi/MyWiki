##### Ctrl+R --> 查看源码的符号表

##### Ctrl+D --> (选中文本时)快速定位到下一个相同文本

##### Ctrl+Shift+L --> (选中文本时)进入块编辑(如果开启了Vim模式还需要按下Shift+I)

##### Ctrl+H --> 替换文本

##### Alt+F3 --> 快速当前被选中关键字中出现的所有位置

##### Ctrl+Shift+P --> 唤出命令面板

##### Ctrl+Num --> 快速在多个窗口切换焦点，Num从1开始

##### Ctrl+K,Ctrl+B --> 快速在多个窗口切换焦点，Num从1开始

##### Shift+Alt+Num --> 快速打开多窗口模式，Num从1开始，如Shift+Alt+5 是打开四个小窗口

#### [正则表达式查找/替换](http://blog.csdn.net/kniost/article/details/54347874)
>按下`Ctrl+H`，接着按下`Alt+R`之后，会启用正则表达式匹配模式，此时我们可以接着类似Perl的正则表达式来查找、替换文本加了，需要注意的是，被匹配的文本必须要用()来包裹起来，此时匹配成功的多处字符串可以通过`$n`形式来检索，n必须>=1，如下所示：
 - Find as:`(^first)`、`(^min|^max|^battle)`
 - Replace with:`_M.$1`
 
 比如，将L"xxx"替换成_T("xxx")
 
 - Find as:`L"([\S\s]*?)"`
 - Replace with:`_T("$1")`

#### 插件推荐
 - [Package Control:一款Sublime Text的插件管理器](http://packagecontrol.io)
   ```python
    import urllib.request,os,hashlib; h = '6f4c264a24d933ce70df5dedcf1dcaee' + 'ebe013ee18cced0ef93d5f746d80ef60'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
   ```
 - [sublime-gbk:兼容Windows平台的默认文件编码](https://github.com/akira-cn/sublime-gbk)
 - [YouCompleteMe:一款强大的源码智能提示插件，需要额外安装ycm服务端](https://github.com/Valloric/ycmd)
 - [PlainTasks:一款基于ToDo实现的待办事项管理插件](https://github.com/aziz/PlainTasks)
 - [Zeal:用来离线查看API文档的插件，需要另外下载Zeal Portable](https://github.com/vaanwd/Zeal)
