Pdf2Markdown是一个基于Python实现的文档类型转换的工具类型项目，其实也可以将它当做一个单纯的Python模块，专门用来将PDF文档内容转换成Markdown文本格式，目前无论是福昕、Adobe的Pdf产品，都支持将PDF转换成word或html等格式，但是暂时还没有项目转换成Markdown，这里面有点可惜。不过由于本人在工作之余，希望学习一些Adobe的插件、脚本之类的开发，因此，经常需要查阅PDF文件，但是本人并不是很喜欢这些文档格式，用之作为打印的标准格式是不错，但是真心不太符合作为工具书查阅，而且编辑起来也不方便，需要专门安装一些特定PDF编辑软件，而这些软件都是一些大家伙，动辄500M的安装包，消受不起，因此喜欢编写一个文档自动化转换工具，将PDF转换成易于编辑，而文档内容排版又清晰的Markdown文件。以上就是本项目的开发动机了，不过许多时候，其实是为以后的文档翻译做一些前期工作，不用在后面辛辛苦苦手动Copy这些文档内容了。

另外，所生成的Markdown文件借助amWiki、[smallpath的blog框架](https://smallpath.me)、Gitbook、jekyll等也可以很方便地部署到网站上，这样一来二次编辑也显得非常方便，不过由于Markdown的拓展语法目前已经不下几十种了，因此，只考虑兼容标准的Markdown标准语法吧。

目前需要的第三方包如下所示：
 - 解析PDF模块(pdfminer)
 - 打包Python成Exe单文件包发布（pyinstaller）
 - 生成Markdown[markdown](https://github.com/Python-Markdown/markdown)
  - [Extensions API](https://pythonhosted.org/Markdown/extensions/api.html)

开发过程:
 - 先收集通过Pdfdoc将Markdown转换成的pdf文件，编写一个简单的词法解析器
 - 然后尝试用词法解析器来解析网络上的单页Pdf，完善词法解析器
 - 接着分析多页PDF的拆分，编写拆分代码 
 - 分析多页PDF文件的可能存在的目录，根据目录信息生成一个文库文件夹
 - 将PDF目录和多页PDF关联起来，另外修复PDF上面的超链接与其他页面的联系
 - 重构代码（PS:多用设计模式、多拆分模块）
