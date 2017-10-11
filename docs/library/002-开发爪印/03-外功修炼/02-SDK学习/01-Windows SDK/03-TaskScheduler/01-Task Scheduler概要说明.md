## TaskScheduler概要说明

<br>
&#160;&#160;&#160;&#160;&#160;&#160;
到目前为止，Windows用户基本过渡到Xp系统及其以上了，因此这篇文章的兼容性仅仅照顾到Xp版本及Xp版本之上的Windows系统啦。想看官方的在线连接，[<a href="https://msdn.microsoft.com/EN-US/library/windows/desktop/aa383614(v=vs.85).aspx" target="blank" >点我吧</a>]

### MSDN上的简单描述
&#160;&#160;&#160;&#160;&#160;&#160;
Task Scheduler 1.0: Client requires Windows Vista, Windows XP, Windows 2000 Professional, Windows Me, or Windows 98. Server requires Windows Server 2008, Windows Server 2003 or Windows 2000 Server.

&#160;&#160;&#160;&#160;&#160;&#160;
Task Scheduler 2.0: Client requires Windows Vista. Server requires Windows Server 2008.

### 对于Xp系统而言
&#160;&#160;&#160;&#160;&#160;&#160;
该系统仅仅可以使用Task Scheduler 1.0来操作任务计划项。

### 对于Vista及其以上系统而言
&#160;&#160;&#160;&#160;&#160;&#160;
这些系统不仅支持Task Scheduler 1.0来操作旧版本的任务计划项，同时也支持新型的任务计划项。

### 如何开发TaskScheduler相关程序
&#160;&#160;&#160;&#160;&#160;&#160;
MSDN里已经明确说明了，为任务计划开发提供了对应的COM接口，按照COM接口开发的一般套路即可以进行TaskScheduler开发了。

>个人理解：
注意，在Task Scheduler 1.0之中，我们一般是通过操作ITaskScheduler对象来操作任务计划的而在Task Scheduler 2.0中，则一般采用ITaskService对象来操作，并且在2.0的时候，也引入了一些新型的概念，所以说，需要了解这些概念才可以操作对应的任务计划。

***

#### Task Schduler1.0和2.0在Vista系统版本及其之上的区别
![任务计划管理器版本区别](assets/001/01-1054b769.png)

![任务计划管理器版本区别](assets/001/01-64bb6da2.png)
