ContactSniffer是一个企业联系方式的嗅探器，主要用来访问一些指定网站里面的企业电话信息，将其导出到word/pdf等文件上，方便打印输出。

目前采集到的资料如下所示：
 - 使用Python【人生苦短，我用Python】
 - 以Json作为内容的截取方式【格式相对简洁】
 - 导出生成Word文档、pdf文件（[python-docx](https://github.com/mikemaccana/python-docx)、[PDFMiner](http://pypi.python.org/pypi/pdfminer/)、[相关博客](http://blog.csdn.net/bingxue7921/article/details/7951638)、[Python写爬虫——抓取网页并解析HTML](http://www.cnblogs.com/bluestorm/archive/2011/06/20/2298174.html)、[python解析json](http://www.cnblogs.com/kaituorensheng/p/3877382.html)）
 - 【4】将其打包成一个独立的可执行文件（py2exe）
 - 【5】修改的历史记录（自带历史记录恢复的功能，也就是传说中的版本管理，整合lib2git进去，pygit2）
 - 【6】分析网页上面有效的字段信息
 - 【7】网络访问库，可能需要模拟浏览器访问的方式来完成此功能
 - 【8】反向代理，避开IP封禁
