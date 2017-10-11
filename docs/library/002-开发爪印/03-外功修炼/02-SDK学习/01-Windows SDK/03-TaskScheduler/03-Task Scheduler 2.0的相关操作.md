## 理解ITaskService对象
此对象需要依赖TaskshdWindows服务，如果此服务被关闭，那么此COM对象也将会失效。有关这个COM对象在MSDN里也多有提及，想看官方的在线连接，[<a href="http://msdn.microsoft.com/EN-US/library/aa384006(v=VS.85,d=hv.2).aspx" target="blank" >点我吧</a>]

>注意，Task Scheduler 2.0仅仅可以在Xp以上的Windows系统内可以正常使用哦。

## 操作Task Scheduler 2.0的常见套路
&#160;&#160;&#160;&#160;&#160;&#160;
对于TaskScheduler 120而言，开发包括了以下常见步骤，如下所示：

- 1.使用`CoInitialize()`函数来初始化COM接口，代码片段如下所示：
<br>
```c++
CoInitialize(NULL);
```

- 2.`CoInitializeSecurity()`函数来设置此接口的安全级别，避免被杀毒软件报毒
代码如下所示：
<br>
```c++
CoInitializeSecurity(
  NULL,
  -1,
  NULL,
  NULL,
  RPC_C_AUTHN_LEVEL_PKT_PRIVACY,
  RPC_C_IMP_LEVEL_IMPERSONATE,
  NULL,
  0,
  NULL
  );
```

- 3.使用`CoCreateInstance()`函数来初始化一个`ITaskService`对象。代码片段如下所示：
<br>
```C++
ITaskService *m_pService=NULL;
CoCreateInstance(CLSID_TaskScheduler,
		NULL,
		CLSCTX_INPROC_SERVER,
		IID_ITaskService,
		(void ** )&m_pService);
```

- 4.在`Task Scheduler 2.0`之中，与1.0的不同之处就是需要通过`ITaskService`对象里面的`Connect()`来连接上对应的Windows服务程序。代码片段如下所示：
<br>
```C++
m_pService->Connect(_variant_t(), _variant_t(),
		_variant_t(), _variant_t());
```

assets/002/03/02/01/03
- 5.调用`ITaskService`对象里面提供的各种操作方法，来执行相应的操作。如下图所示：

![Task Scheduler2.0的常用操作](assets/002/03/02/01/03/03-cd44aacf.png)

![MSDN提供的Task Scheduler2.0的操作例子](assets/002/03/02/01/03/02-b3d97b9b.png)

- 6.操作完成之后，使用`CoUninitialize()`函数来将COM接口释放。当然在此之前，需要对各个COM对象，比如`ITaskService等COM对象执行`Release()`函数进行内存释放
