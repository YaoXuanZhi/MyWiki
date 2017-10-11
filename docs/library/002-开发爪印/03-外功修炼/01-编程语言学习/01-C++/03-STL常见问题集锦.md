#### 通过DLL里面的C接口来传递一个类指针
假设DLL需要导出一个类的时候，可以这样实现，将这个类用一个函数包裹起来，最终这个函数导出，在这个函数中将这个类new出来，并且传出其双指针，然后自己进行管理。

#### 完成一个界面库雏形
另外，测试一下自己编写的窗口框架类，是否对标准控件的支持比较差，建议查看一下，另外，还炫耀专门处理各种常见的参数处理。
开发完这个项目之后，自己编写其他开发工具的时候，自己一个人完成所有软件工程开发流程的设计以及实施，不能再按照公司的流程来做了。因为中小企业根本没有这个想法，只是为了生存而已。

#### 对std::list进行排序的注意事项
std::list::sort() : 自带排序功能，不能使用std::sort()，因为std::list模板里面的内存管理方式的特殊性，因此不能使用std::vector和std::map中常用的std::sort()算法库来进行排序

#### 在std::vector、std::map等数据类型之中如何正确地删除元素
正确的操作姿势如下所示：
```c++
			for(vector<CLIENT_INFOEX>::iterator it=m_vcInfoEX.begin();it!=m_vcInfoEX.end();)
			{
				int iTempID=atoi(UnicodeToANSIEx(it->info.szServerIDFromClient).c_str());
				if(iServerID==iTempID)
				{
					it=m_vcInfoEX.erase(it);
				}else{
					++it;
				}
			}
```

#### 如何保存一些不重复的元素
使用std::set<>来实现，通过insert()函数来直接插入新元素。
