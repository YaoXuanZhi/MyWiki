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


