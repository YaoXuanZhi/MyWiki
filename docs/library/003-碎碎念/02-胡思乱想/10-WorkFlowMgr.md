WorkFlowMgr是一款工作流管理器，借助开源项目SVN、Git的项目管理特性，基于网上一些关于项目工作流的分析，提炼而成的一款产品，项目灵感来源于[Git工作流指南](http://blog.jobbole.com/76843/)和[TortoiseGit Page](https://github.com/TortoiseGit/TortoiseGit)，对于一些成建制的开源项目而言，设定一款团队专用的工作流无疑是非常重要的，各个项目成员的交流可以用各种即时通讯工具QQ、微信、Github的issue等等都行，但是无论项目成员如何复杂，为了能够让不同的成员都在此项目的发展始终如一地统一，这样的话，新旧成员的交流隔膜才会最薄。而这里面，比较看重的无疑是Bug跟踪、新特性交流、文档维护、开发日志管理、版本发布流程等了，当然，这上面提到的都是纯开发者团队的一些项目管理，加上产品经理、策划之后，这些都会大变样，因此本人在此仅仅是提供一种适合纯开发者成员的小团队的一些想法。

#### 【功能特性】
 - 配置相关
   - 采用yaml格式作为配置
 - 界面相关
   - 丰富的过场动画，允许用户修改动画
   - 透明度设置以及鼠标穿透
   - 类似酷狗音乐盒的界面过渡动画
 - 扩展相关
   - 提供Lua方式来拓展功能
 - 交互相关
   - 允许开发者自行定制shell指令
   - 提供多种工作流管理模式
   - 托盘菜单高度定制
   - 全局热键，允许用户自定义
 - 提供简易的ToDoList管理，具体可以参考Sublime Text的PlainTasks 插件和VSCode的 To Do Lists插件
   ```md
   ###### ToDoLists1st(建议在非gbk文件编码中使用):
     - ☐ 打开此任务
     - ❑ 正在进行此任务
     - ✔ 此任务已被取消
     - ✘ 此任务已被完成

   ###### ToDoLists2nd(建议在gbk文件编码中使用):
     - [+] 新增任务
     - [→] 正在进行
     - [x] 取消该任务
     - [√] 完成此任务
   ```

 - 支持项目规范格式检查，提供各种图形界面的数据展示
 - 提供类似Github/gitlab issue的功能，用来跟踪Bug以及用户反馈
   - 当然，假设该仓库是放置在Github或者Gitlab上的，那么直接利用其功能即可，不然，还是自己在本地里面维护一个issue.yaml文件吧，将commit hash和issue关联在一起管理

#### 引用
 - [Git工作流指南](http://blog.jobbole.com/76843/)
   - [Git工作流指南：集中式工作流(PS：这个也是SVN工作流)](http://blog.jobbole.com/76847/)
   - [Git工作流指南：功能分支工作流](http://blog.jobbole.com/76857/)
   - [Git工作流指南：Gitflow工作流](http://blog.jobbole.com/76867/)
   - [Git工作流指南：Forking工作流(PS：适合参与到他人的开源项目中)](http://blog.jobbole.com/76861/)
   - [Git工作流指南：Pull Request工作流](http://blog.jobbole.com/76854/)
 - [Commit message 和 Change log 编写指南](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)
 - [TortoiseGit Page](https://github.com/TortoiseGit/TortoiseGit)
 - [如何使用 Issue 管理软件项目？](http://www.ruanyifeng.com/blog/2017/08/issue.html)
 - [请问各位，公司内部的接口文档是怎么管理的？](https://www.v2ex.com/t/390148?p=1)
