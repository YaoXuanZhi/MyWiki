# Vim使用教程

最近项目需要经常编辑Lua代码，尝试过很多相关的工具了，如`Sublime`、vs里面的`BabeLua`插件，还有`VSCode`里面的`LuaIDE`拓展以及自家的`Lua for windows`等等，对比之后，总发觉没有敲`C/C++`代码那么舒爽，于是观察了一下旁边的同事，发现他们都采用Vim这个神一般的编辑器，并且发现Vim在处理Lua的变量以及函数跳转方面比Sublime、BabeLua等好用多了，因此最终入手这个号称可以用来装逼的文本编辑器了。在Linux下，貌似默认安装了这个编辑器的，本人在安装`CentOS 6.8`的时候就是在终端里面使用它来编辑各种配置文件了，不过在Windows下我们可以采用GVim这个软件，它是Vim的Windows版本，以前个人稍微接触了一下，但是没有真正入手，这次为了以后的幸福生活着想，提高下Lua代码的编辑、浏览效率，因此决定重新学习它。

http://www.huangdc.com/421

#### 常用的Vim命令：
 - 切换到常态：`Esc`或`Ctrl+O`
 - 显示行号：`:set nu`
 - 取消行号：`:set nonu`
 - 往下查找：`/word` 配合n或N来索引下一个匹配项
 - 往上查找：`?word` 配合n或N来索引下一个匹配项
 - 创建文件：`:new filename` - 打开文件：`:vim filepath`
 - 保存文件并退出：`:wq!`
 - 不保存文件直接退出：`:q!`
 - 打开目录树：`:NERDTREE`
 - 打开函数列表：`tb`
 - 切换窗口：`Ctrl+W` [j k l n]
 - 在文件夹文件夹下查找文库本：`:Ag word`
 - 不采用插件直接自动补全：`Ctr+N` `Ctrl+P`
 - 快速输入文件名：在插入模式下，按下`Ctrl+X` `Ctrl+F`
 - 设置搜索时忽略字母的大小写差异：`:set ic`
 - 设置搜索使用字母的大小写匹配；`:set noic`
 - 搜索当前文件夹的文件：`;p`(常态下)
 - 进入块模式编辑：`Ctrl+v`
  - 在块的前面插入字符：`Shift+i`
  - 在块的后面插入字符：`Shift+a`
 - 假设安装了 **NERD Commenter** 插件，那么可以使用下列方式来进行代码注释：
   - 设置光标所在行的注释：`;cc`
   - 取消光标所在行的注释：`;cu`
   - 切换光标所在行的注释/非注释状态；`;c<space>`
 - 切换tab
   -  关闭当前的tab：`:tabc`
   -  关闭所有其他的tab：`:tabo`
   -  查看所有打开的tab：`:tabs`
   -  前一个：`:tabp`
   -  后一个：`:tabn`
 - 设置Vim的快捷键，直接在_VIMRC上插入这些语句即可：`map <F10> <Esc>:!explorer %:p:h<CR>`

#### 关于Vim的插件开发
 - [Vimscript 文档](https://www.w3cschool.cn/vim/gsenvozt.html )

#### 常见问题
 - [解决Vim"UltiSnips requires py >= 2.7 or py3"](http://blog.csdn.net/demorngel/article/details/72353760)