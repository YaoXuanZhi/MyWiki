ProtoEditor是一个网络协议编辑器，主要是用来替代公司内部使用的协议编辑器（C#版），由于本人无法获取到这个内部工具的源码，因此在工作过程中，遇到了一些程序异常的问题时就无法着手解决，因此有了此项目，目的很纯粹，重写这个简单的协议编辑器，提升一些工作效率，另外，也希望借此项目来总结这段时间Lua引擎的嵌入开发以及对插件软件框架的理解。

#### 【功能特性】：
 - 使用XML来作为协议的存储文件，因为这样可以实现协议文件的版本管理，而且也比Json文件紧凑
 - 提供Lua的脚本接口，可以通过它来定制此程序的右键菜单以及导出协议包对应的Lua源码或者C++源码等
 - 内置Libgit2第三方库组件，用来拓展为配置文件的版本管理，另外，也提供二进制的插件接口供用户定制，主要用来分析提交者的日志，从而快速定位到具体的修改记录
 - 增强协议包文件的搜索功能
 - 将这个编辑器添加到SOUI的Demo列表上吧，方便大家学习哈（注意，SOUI的路径上不要包含非ASCII字符以及空格哦，否则可能会出现编译异常的情况哦，毕竟用上了qmake和cmake这两个对非ASCII字符不友好的家伙==!）
