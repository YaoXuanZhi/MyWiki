>目前在后端开发之中，喜欢VSCode作为Lua开发的童鞋们，可以用它来搭建工作流了，这里面只是简单地介绍一个可用的工作环境配置过程，因此也可以将其视作一个Lua的开发环境搭建教程(〃'▽'〃)

#### 安装LuaIde插件
目前此款插件已经收费，由网友kangping个人在业余时间维护的，手上有闲钱的建议支持下( • ̀ω•́ )✧，最新版本的插件功能更加强劲，可惜这些新增的功能对我的吸引力不太，因此小编还是采用LuaIde 0.3.7版本，这个是kangping在VSCode上最后的免费版本里面了，大部分好用的功能这里面都已提供，如下所示：

![](assets/004/02/04/07-1506695487000.png)

#### 添加代码片段（snippet）
为了提高编码的效率，一些常用的代码片段最好被打包在一起，另外为了兼顾团队代码的风格统一，代码规范也就不能忘记。这里面小编参考了入职指导里面的《Lua编码规范建议[白皮书]》一文，将一些常用的代码规范整理在一起，将其添加到VSCode的 用户代码段即可，具体操作如下：【文件】–>【首选项】->【用户代码片段】，在弹出的VSCode的输入框中，选中**lua**作为代码片段的语言，在刚打开的`lua.json`文件之中，插入以下Json内容即可；或者也可以直接将其插入到luaide(或kangping.luaide-0.3.7)的snippets.json文件之中`（C:\Users\Administrator\.vscode\extensions\LuaIDELite\snippets\snippets.json）`

```json
{
        "td_file": {
                "prefix": "xx_file", 
                "body": [
                        "--[[", 
                        "-- @brief:       $TM_FILENAME    (功能说明)", 
                        "-- @date:        2017-10-08", 
                        "-- @author:      xxx", 
                        "-- @modified:", 
                        "-- xxx 2017-01-09 根据xxx需求，修改xxx", 
                        "-- xxx 2017-01-19 根据xxx需求，修改xxx", 
                        "--]]"
                ], 
                "description": "插入文件说明"
        }, 
        "td_enum": {
                "prefix": "xx_enum", 
                "body": [
                        "local ${1:RewardStatus} = {", 
                        "    ${2:NONE}    = 0,    -- 未达成", 
                        "    ${3:CAN}     = 1,    -- 可以领取", 
                        "    ${4:GOT}     = 2,    -- 已领取", 
                        "}"
                ], 
                "description": "插入枚举常量"
        }, 
        "td_func": {
                "prefix": "xx_func", 
                "body": [
                        "--[[", 
                        "-- @func  - {函数说明}", 
                        "-- @param  ${2:param1st}  - {参数说明}", 
                        "-- @param  ${3:param2nd}  - {参数说明}", 
                        "-- @return  - {返回值说明}", 
                        "--]]", 
                        "local function ${1:FunctionName}(${2:param1st}, ${3:param2nd})", 
                        "    ${4:return}", 
                        "end"
                ], 
                "description": "插入函数"
        }
}
```

#### 其它
想必小伙帮的心中都有喜欢的开发习惯，而在项目组里面，通常采用sublime或vim来编码，在这里面，推荐两个VSCode插件吧，可以将这些编辑器的使用习惯在VSCode之中沿用

 - vim：可以在VSCode中使用Vim模式
 - sublime Text Keymap：将VSCode的快捷键映射成Sublime风格

#### 工作流演示
![](assets/004/02/04/snipaste_20170928_12287.gif)

#### 吐槽

由于kangping力推luaide收费版，因此luaIde在使用旧版luaide的时候，如果启动了VSCode的自动更新功能，那么旧版插件会强制更新到收费版，而这个收费版会屏蔽掉LuaIde 0.3.7里面已经实现的大部分功能!!!∑(ﾟДﾟノ)ノ
为了突破这个限制，小编将此插件的版本号调高到10.0.0了，借此绕过了强制升级机制￣ω￣=
另外，由于项目组要求，Lua里面不能出现 **\t** 字符，因此，稍微修改了此插件的源码，将格式化Lua文件的代码后生成的 **\t** 字符全部替换成 **四个空格**。φ(>ω<*)

这是小小改动版٩(๑>◡<๑)۶ ：[luaidelite.zip](assets/004/02/04/luaidelite.zip)

安装方式如下所示（记得将原版Luaide删除哦(￣▽￣)／）：

![](assets/004/02/04/07-1506695612000.png)