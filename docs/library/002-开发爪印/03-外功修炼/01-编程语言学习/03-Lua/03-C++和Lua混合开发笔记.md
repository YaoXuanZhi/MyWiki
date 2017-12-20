#### C++和Lua的bind库（胶水层）介绍
 - luabind:最重量级，和boost绑定在一起，基于lua 5.1
 - tolua++:重量级，提供一个专门用于导出接口的工具tolua++.exe，方便集成到项目里面，许多游戏引擎采用，比如cocos2dx等，基于lua 5.1
 - lua-Thinker:轻量级，听说是luabind的简化版，参考了luabind的实现
 - fflua:轻量级，比lua-Thinker更完善些，支持的特性更多

#### lua调试器资料
 - [clidebugger](https://github.com/ToddWegner/clidebugger)
 - [lua层面上的ldb调试器](https://github.com/tjsymbol/ldb)
 - [c层面上的ldb调试器](https://github.com/lichuang/ldb.git)