## 理解ITaskScheduler对象
想看官方的在线连接，[<a href="https://msdn.microsoft.com/EN-US/library/windows/desktop/aa383614(v=vs.85).aspx" target="blank" >点我吧</a>]

![](assets/002/03/02/01/03/02-b3d97b9b.png)

>在Task Scheduler 1.0之中，提供了这么一个COM对象来让开发者操作任务计划项。一般而言，我们可以直接通过此方法来删除、创建、修改、遍历某些任务计划项等等。但是要注意，Task Scheduler 1.0在Vista及其以上系统中仅仅可以操作其中的一部分,正如之前所罗列的,仅当这些任务计划项的配置为Xp等低版本的Windows系统的时候才可以由其操作，[如图所示](assets/002/03/02/01/03/02-c909c677.png)。因此，要想操作Vista及其以上系统里的所有任务计划项，那么请使用Task Schduler 2.0。

## 操作Task Scheduler 1.0的常见套路
&#160;&#160;&#160;&#160;&#160;&#160;
对于TaskScheduler 1.0而言，开发包括了以下常见步骤，如下所示：

- 1.使用`CoInitialize()`函数来初始化COM接口，代码片段如下所示：
<br>
```c++
CoInitialize(NULL);
```

- 2.`CoInitializeSecurity()`函数来设置此接口的安全级别，避免被杀毒软件报毒
代码片段如下所示：
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

- 3.使用`CoCreateInstance()`函数来初始化一个`ITaskScheduler`对象。代码片段如下所示：
<br>
```C++
ITaskScheduler *m_pITS=NULL;
CoCreateInstance(CLSID_CTaskScheduler,
		NULL,
		CLSCTX_INPROC_SERVER,
		IID_ITaskScheduler,
		(void ** )&m_pITS);
```

- 4.调用`ITaskScheduler`对象里面提供的各种操作方法，来执行相应的操作。如下图所示：

![Task Scheduler1.0的常用操作](assets/002/03/02/01/03/02-0b44cbf0.png)

![MSDN提供的Task Scheduler1.0的操作例子](assets/002/03/02/01/03/02-5bdc66d0.png)

>注意，假设修改了某个任务计划项的名称或者某些标记，那么需要使用`IPersistFile`对象来将更改后的任务计划项的信息应用到Windows系统之中，否则，将会失效。
```C++
IPersistFile *pIPersistFile;
m_hResult = pITask->QueryInterface(IID_IPersistFile, (void ** )&pIPersistFile);
if (SUCCEEDED(m_hResult))
{
  m_hResult = pIPersistFile->Save(NULL,
    TRUE);
  if (FAILED(m_hResult))
  {
    _tprintf(_T("Failed calling IPersistFile::Save: "));
    //FOUTDEG(_T("error = 0x%x\n"), m_hResult);
    bResult = false;
  }
}
pIPersistFile->Release();
```

- 5.操作完成之后，使用`CoUninitialize()`函数来将COM接口释放。当然在此之前，需要对各个COM对象，比如`ITaskScheduler`、`IPersistFile`等COM对象执行`Release()`函数进行内存释放

>注意事项：第一，COM对象纵使不执行`Release()`，也是不会被Vld等内存泄漏检测库检测到内存泄漏的，因为这些对象本身就是驻留在操作系统上的，所以为了出现由于忘记释放这个COM对象引起的诸多问题，建议养成一种习惯，在各个COM对象的后面添加上`XXX->Release();`语句。第二，重申一点关于修改某个任务计划项的问题，必须使用IPersistFile对象来将更改应用到操作系统上。比方说，在Xp系统下，我们可以明确看到,其任务计划管理器上会有一个[“应用”按钮](assets/001/02-e6f7f2c0.png)，实质就是通过IPersistFile对象来将当前对任务计划项的修改应用到操作系统之上。第三，MSDN上面已经提供了一些常用的Task Scheduler 1.0的各种操作方法了，建议直接阅读这些样例工程来学习Task Scheduler 1.0的开发。
