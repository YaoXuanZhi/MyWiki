##### [C或C++开发环境搭建](?file=002-开发爪印/03-外功修炼/01-编程语言学习/01-C++/02-C或C++开发环境搭建 "C或C++开发环境搭建")
搭配cpptools插件，集成MinGW和MSVC的编译环境
##### [Python的开发环境的搭建](?file=002-开发爪印/03-外功修炼/01-编程语言学习/04-Python/01-Python的开发环境的搭建 "Python的开发环境的搭建")
需要安装Python 2.x或3.x的安装包
##### [Lua开发环境搭建](?file=002-开发爪印/03-外功修炼/01-编程语言学习/03-Lua/01-Lua开发环境搭建 "Lua开发环境搭建")
搭配LuaIde插件
##### Vim模式编辑
>从VSCode的应用商店上安装Vim插件，然后执行`文件->首选项->键盘快捷方式`菜单项，打开`keybindings.json`，然后将下面的json代码段Copy到此文件上：

```json
[
    {
        "key": "ctrl+v",
        "command": "editor.action.clipboardPasteAction",
        "when": "editorTextFocus && !editorReadonly"
    },
    {
        "key": "ctrl+q",
        "command": "extension.vim_ctrl+v",
        "when": "editorTextFocus && vim.active && vim.use<C-v> && !inDebugRepl && vim.mode != 'Insert'"
    }
]
```

##### API文档浏览器（API Documentation Browser）
 - [zeal官网](https://zealdocs.org/)
 - [zeal on Github](https://github.com/zealdocs/zeal)
 - [zeal download](https://zealdocs.org/download.html)

>Zeal是一个基于Qt实现的跨平台的离线文档浏览器(Offline Documentation Browser)，而在Mac下也有一个更加强大的同类产品Dash。在VSCode下，我们可以安装一款插件**Dash**，然后我们就可以在VSCode里面编辑源码的时候，通过选中文本后，按下`Ctrl + h`等快捷键来调用Zeal/Dash等外部文档浏览器来查询了，对于个人而言，它相当于一个更加通用的H3Viewer。注意，这里，Dash插件会自动检测当前VSCode正在编辑的源码类型，然后以此确定将要查找的文档，如下图所示：

![](assets/004/02/03/02/03-1517909116000.gif)

 - 快捷键如下：
  - `Ctrl+h`：将会根据当前源码类型以及被选中的文本在Zeal/Dash的指定文档上查找
  - `Ctrl+alt+h`：将会根据当前被选中的文本在Zeal/Dash的所有文档上查找
  - `Ctrl+shift+h`：打开Zeal/Dash界面，并开启当前源码类型对应的文档搜索
  - `alt+h`：将会根据当前源码类型以及用户输入的文本在Zeal/Dash的指定文档上查找