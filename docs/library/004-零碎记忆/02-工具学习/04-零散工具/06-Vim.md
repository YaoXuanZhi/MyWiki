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
 - 重新加载文件`:e!`
 - 保存文件并退出：`:wq!`
 - 不保存文件直接退出：`:q!`
 - 打开函数列表：`tb`
 - 切换窗口：`Ctrl+W` [j k l n]
 - 在文件夹文件夹下查找文库本：`:Ag word`
 - 不采用插件直接自动补全：`Ctr+N` `Ctrl+P`
 - 快速输入文件名：在插入模式下，按下`Ctrl+X` `Ctrl+F`
 - 设置搜索时忽略字母的大小写差异：`:set ic`
 - 设置搜索使用字母的大小写匹配；`:set noic`
 - 搜索当前文件夹的文件：`;p`(常态下)
 - 回到刚才编辑的文件：`:e#`(常态下)
 - 进入块模式编辑：`Ctrl+v`
  - 在块的前面插入字符：`Shift+i`
  - 在块的后面插入字符：`Shift+a`
 - 假设安装了 **NERD Commenter** 插件，那么可以使用下列方式来进行代码注释：
   - 设置光标所在行的注释：`;cc`
   - 取消光标所在行的注释：`;cu`
   - 切换光标所在行的注释/非注释状态；`;c<space>`
 - 切换tab
   - 关闭当前的tab：`:tabc`
   - 关闭所有其他的tab：`:tabo`
   - 查看所有打开的tab：`:tabs`
   - 前一个：`:tabp`
   - 后一个：`:tabn`
 - 设置Vim的快捷键，直接在_VIMRC上插入这些语句即可：`map <F10> <Esc>:!explorer %:p:h<CR>`
 - 代码折叠
   - 打开关闭折叠：`zi`
   - 查看此行：`zv`
   - 关闭折叠：`zm`
   - 关闭所有：`zM`
   - 打开：`zr`
   - 打开所有：`zR`
   - 折叠当前行：`zc`
   - 打开当前折叠：`zo`
   - 删除折叠：`zd`
   - 删除所有折叠：`zD`
 - 命令集
   - 替换文本所有字符串：`:%s/oldstr/newstr/g`
 - 分割窗口调整
   - 纵向调整
     - 纵向扩大(行数增加)：`:ctrl+w +`
     - 纵向缩小(行数减少)：`:ctrl+w -` 
     - 显示行数调整为num行：`:res(ize) num`
     - 把当前窗口高度增加num行：`:res(ize)+num` 
     - 把当前窗口高度减少num行：`:res(ize)-num` 
   - 横向调整
     - 指定当前窗口为num列：`:vertical res(ize) num`
     - 把当前窗口增加num列：`:vertical res(ize)+num` 
     - 把当前窗口减少num列：`:vertical res(ize)-num` 
   - 文件浏览
     - 在侧边打开目录树：`:NERDTREE`
     - 打开目录浏览器：`:Ex`
     - 水平分割当前窗口，并打开一个窗口开启目录浏览器发：`:Sex`

 
#### 关于Vim的插件开发
 - [Vimscript 文档](https://www.w3cschool.cn/vim/gsenvozt.html)

#### 常见问题
 - [解决Vim"UltiSnips requires py >= 2.7 or py3"](http://blog.csdn.net/demorngel/article/details/72353760)

 - 解决粘贴到终端 Vim 缩进错乱
  >需要设置终端Vim的粘贴模式为粘贴保留格式：set paste

#### Chrome浏览器下的Vim模式
>在Chrome浏览器的应用商店里安装**Vimium**插件即可，不过，由于众所周知的原因，如果不自建梯子是访问不了的，此时可以到[Crx4Chrome](https://www.crx4chrome.com/crx)上下载并安装此插件。以下罗列一些常用的快捷键操作：

 - 标签页间操作
   - 跳到左侧标签页(Vimium)：`J(Shift+h)`
   - 跳到右侧标签页(Vimium)：`K(Shift+j)`
   - 跳到最左端标签页(Vimium)：`g0`
   - 跳到最右端标签页(Vimium)：`g$`
   - 查找已打开的标签页：`T(Shift+t)`
   - 关闭标签页(Vimium)：`x`
   - 跳到左侧标签页(内置)：`Ctrl+Shift+Tab`
   - 跳到右侧标签页(内置)：`Ctrl+Tab`
   - 关闭标签页(内置)：`Ctrl+w`

 - 页内移动
   - 往下移动：`j`
   - 往上移动：`k`
   - 往左移动：`h`
   - 往右移动：`h`
   - 移动到顶端：`gg`
   - 移动到底端：`G(Shift+g)`

 - 页内操作
   - 选择文本：`v`
   - 输入文本：`i`
   - 复制被选中文本：`y`
   - 找到当前页面的首个文本框输入：`gi`
   - 复制当前标签页链接：`yy`
   - 在本标签页内打开剪贴板上的链接：`p`
   - 新开标签页来打开剪贴板上的链接：`P(Shift+p)`
   - 打开可挑选的跳转面板：`f`
   - 在本标签页内往前跳转：`H(Shift+h)`
   - 在本标签页内往后跳转：`L(Shift+l)`
   - 在本标签页内刷新(Vimium)：`r`
   - 在本标签页内刷新(内置)：`F5`

 - 页内查找
   - 查找文本(Vimium)：`/`
   - 往下查找匹配项(Vimium)：`n`
   - 往上查找匹配项(Vimium)：`N(Shift+n)`
   - 查找文本(内置)：`Ctrl+F`

 - 书签/历史
   - 在本标签页来打开书签/历史的链接：`o`
   - 新开标签页来打开书签/历史的链接：`O(Shift+o)`
   - 在本标签页来打开书签的链接：`b`
   - 新开标签页来打开书签的链接：`B(Shift+b)`

#### Linux下安装Vim及其插件
```sh
# 安装Vundle插件
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
```

```sh
# 安装配色方案
mkdir ~/.vim/colors
wget -O ~/.vim/colors/monokai.vim https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim
```

#### 编译Ycm的支持(Linux)
```sh
# 建议直接安装CentOS 7.x以上，然后安装gcc+clang+llvm，这样gcc和clang就不需要升级了

yum install automake gcc gcc-c++ kernel-devel cmake 
yum install python-devel python3-devel

# 定位到bundle/YouCompleteME的路径下，执行以下指令来编译ycm
./install.sh --clang-completer

# 将ycm的默认配置Copy到~/.vim/目录下
cp ~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py ~/.vim/
```