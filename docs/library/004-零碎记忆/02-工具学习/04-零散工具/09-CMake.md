>CMake是一个跨平台项目构建工具，主要对标C/C++项目。其师出于automake，有其独有的DSL，详情请移步到[CMake官网](https://cmake.org/)

---

#### 安装CMake
对于Linux，这个挺简单的，CentOS执行`yum install cmake`，Ubuntu执行`apt-get install cmake`，如果觉得Linux发行版安装的cmake版本太旧，那么从官网上下载源码编译吧，当然，到[cmake download page](https://cmake.org/download/)上下载也是个不错的途径

而对于Windows，个人是建议直接到[cmake download page](https://cmake.org/download/)上下载二进制版本，将其添加到系统环境变量path上即可。电脑上安装了Msys2的话，也可以通过`pacman -S cmake`来安装；安装了cmder的话，在`.../vendor/init.bat`里插入`set path=%path%;xxx:/xxx/cmake-xxx/bin;`也是可以的，如下图所示：

![](assets/004/02/04/09-1529930004000.png)

---

#### 入门教程
>cmake由于其语法丰富，比较适合管理大型的跨平台c/c++工程，而在轻量级的项目里，premake、xmake、qmake都是不错的方案呢。在终端上输入`cmake -h`后，可以看到cmake 3.12.0中已经支持了vs、codeblocks、codelite、eclipse等IDE和高级文本编辑器了

至于cmake的入门教程，由于网上相关资料已经汗牛充栋了，这里就不重复了，读者可以直接移步到[《CMake 入门实战》中文](http://www.hahack.com/codes/cmake/)和[《cmake-tutorial》官方英文](https://cmake.org/cmake-tutorial/)，先过一遍中文教程，心里有底之后 ，再过一遍cmake官方教程即可入门了，剩下的知识点在项目需要用到时再学吧，毕竟只是个项目管理工具而已

下面整理了一些常用的操作命令说明:
 - project() ---- 指定工程名称，在vs中就是.sln的名字
 - add_subdirectory() ---- 设置子CMakeLists的所在路径
 - configure_file() ---- 设置配置文件，一般用来预处理项目版本以及配合find_package、find_library、option等命令控制某些功能是否开启用的
 - add_executable() ---- 添加一个可执行二进制项目，对应vs里的cli、gui项目
 - add_library() ---- 添加一个动/静态链接库库项目，SHARED是动态链接库，STATIC是静态链接库

 - set() ---- 设置变量，如果想多个CMakeLists.txt共用某个变量，那么需要将其指定为CACHE，如`set(contribdir ${contribdir} ${CMAKE_CURRENT_SOURCE_DIR}/stb CACHE INTERNAL "contrib library" )`
 - unset() ---- 删除变量，通常用来删除临时变量
 - option() ---- 设置操作项，可通过ON/OFF来控制开关，这个配置项在cmake-gui中以复选框的形式显示，通常与configure_file结合使用
 - message() ---- 设置项目生成时的日志输出，甚至可以控制cmake的执行，比如FATAL_ERROR可终止cmake的往下执行

 - source_group() ---- 将文件列表设为某个子群组，对应vs里的include、src等目录，如`source_group("contrib/include" ${CURRENT_HEADERS})`
 - file() ---- 快速搜索文件，将其存放在某个变量里，支持多路径搜索，多用于搜索头文件、资源文件什么的，配合source_group将之添加到工程里
 - aux_source_directory() ---- 搜索指定路径下的源文件，通常是.cpp、.c、.cxx等后缀名的文件，结果存放在某个变量里
 - add_definitions() ---- 添加预处理宏，针对当前CMakeLists下的所有项目，如果只想为某个项目添加特定的预处理宏，那么需要使用set_tests_properties，如`set_tests_properties(person_dll PROPERTIES COMPILE_DEFINITIONS "DEMO_USE_DLL")`
 - add_custom_command() 添加自定义命令，可以设置执行时机(编译前、链接中、编译后)，比如生成了.dll后，想将其复制到主项目的可执行文件所在目录中，就需要它了，还有各种自定义生成指令也是用到了它

 - target_link_libraries() ---- 设置要链接的库文件
 - include_directories() ---- 添加头文件的搜索路径，只对当前CMakeLists.txt生效
 - link_directories() ---- 添加链接库的搜索路径，只对当前CMakeLists.txt生效

 - find_package() ---- 查找第三方包，比如某项目依赖了第三方开源库curl来实现一个下载器，那么就可以通过这条指令来判断开发者是否安装了curl，如果 没开启，则禁用下载功能，通常与CMAKE_MODULE_PATH组合使用，如`SET(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)`
 - find_path() ---- 搜索某路径下的文件，多用于搜索头文件、链接库，以此来控制功能的开关，举个例子，某个项目集成了一个未开源的第三方库svgload，这个第三方库时以显式调用的方式提供，也就是说，提供了.h、.dll和.lib这三个文件，但是不给源码，此时就可以通过这条指令来尝试搜索项目，看有没有这个svgload开发包了，如果没有的话，通过预编译关闭掉svg的加载功能，当然，也可以采用find_package()来实现
 - find_library() ---- 搜索某路径下的链接库，find_pat其实也可以替代它，两者用法相似

---

##### 非官方例子
由于工作中用到的东西有点多，脑子记不过来，因此在此特意记下几个常用的例子，这里以图片转换器为例:

>基本功能：加载常见的图片格式，如jpg、png、bmp、svg等，将其转换成其它图片格式，目前仅提供CLI版本用作演示

>技术选型如下:
```txt
                +-------->ImageLoadModule(gdi+、stb_image.h、libgif、naosvg、skia、freeimage等)，加载磁盘上的图片资源到内存中
                |
                |
ImageConverter--|--------->AutoCompleteModule(linenoise、readline等)，为CLI程序提供命令自动补全的功能
                |
                |
                +-------->ImageSaveModule(gdi+、stb_image_write.h、freeimage等)，将内存中的图片数据保存到磁盘
```

##### ImageViewer0.1
>这只是一个初始版，仅仅是搜索项目下的源文件，将其添加到VS上，可以编译执行了，附件：[ImageConverter0.1.zip](assets/004/02/04/ImageConverter0.1.zip)

```makefile
# 指定cmake的最小版本
cmake_minimum_required(VERSION 2.8)
# 指定工程名称，ImageConverter.sln
project(ImageConverter)
# 搜索当前目录下的源码文件，用srcs存储起来
aux_source_directory(. srcs)
# 配置一个可执行文件项目，ImageConverterDemo.vcxproj
add_executable(ImageConverterDemo ${srcs})
```

##### ImageViewer0.2
>接下来搭建这个项目的基础部分，定好各种组件的接口，这里先以gdi+作为图片的编解码器，附件：[ImageConverter0.2.zip](assets/004/02/04/ImageConverter0.2.zip)

```makefile
# 指定cmake的最小版本
cmake_minimum_required(VERSION 2.8)

# 指定工程名称，ImageConverter.sln
project(ImageConverter)

# 搜索目录下的源码文件
aux_source_directory(. srcs)

FILE(GLOB_RECURSE coresrcs 
    ./core/*.cpp
)

FILE(GLOB_RECURSE miscsrcs 
    ./misc/*.cpp
)

# 搜索目录下的头文件
FILE(GLOB_RECURSE coreheaders 
    ./core/*.h
)

FILE(GLOB_RECURSE mischeaders 
    ./misc/*.h
)

# 添加到项目筛选器上
source_group("src" FILES ${srcs})
source_group("src\\core" FILES ${coresrcs})
source_group("src\\misc" FILES ${miscsrcs})

source_group("include\\misc" FILES ${mischeaders}) 
source_group("include\\core" FILES ${coreheaders}) 

# 添加头文件搜索路径
include_directories(./core)
include_directories(./misc)

# 配置一个可执行文件项目，ImageConverterDemo.vcxproj
add_executable(ImageConverterDemo ${srcs} ${coresrcs} ${miscsrcs} ${coreheaders} ${mischeaders})
```

##### ImageViewer0.2
>这里调用了第三方类库nanosvg来支持svg文件的读取，主要演示了如何通过Git来管理第三方类库，以及如何在cmake里面整合第三方类库源码的过程，简略描述如下：
  >借助option来配置svg的功能开启，如果为ON，则这里以SUPPORT_SVG_TYPE作为开启的条件，通过`add_definitions(-DSUPPORT_SVG_TYPE)`来添加预处理宏，源码里以`SUPPORT_SVG_TYPE`作为预编译宏，整理所有与svg相关的代码逻辑，另外，也要在CMakeLists.txt中，以`if(SUPPORT_SVG_TYPE)`判断是否执行追加相关头文件搜索路径，添加相关文件名到工程等命令
  >借助configure_file来配置一个外部的头文件，用来传入程序的版本号，当然，也可以配合option来做其他事情
  >附件：[ImageConverter0.5.zip](assets/004/02/04/ImageConverter0.5.zip)

```makefile
# 指定cmake的最小版本
cmake_minimum_required(VERSION 2.8)

# 指定工程名称，ImageConverter.sln
project(ImageConverter)

# 配置版本号
set (APP_VERSION_MAJOR 1)
set (APP_VERSION_MINOR 0)

# 配置是否开启SVG的支持
option (SUPPORT_SVG_TYPE "support .svg file" ON)  

# 加入一个配置头文件，用于处理 CMake 对源码的设置
configure_file (
  "${PROJECT_SOURCE_DIR}/config.h.in"
  "${PROJECT_SOURCE_DIR}/config.h"
 )

aux_source_directory(. srcs)
source_group("src" FILES ${srcs})

FILE(GLOB_RECURSE coresrcs 
    ./core/*.cpp
)
source_group("src\\core" FILES ${coresrcs})

FILE(GLOB_RECURSE miscsrcs 
    ./misc/*.cpp
)
source_group("src\\misc" FILES ${miscsrcs})

FILE(GLOB_RECURSE coreheaders 
    ./core/*.h
)
source_group("include\\core" FILES ${coreheaders}) 

FILE(GLOB_RECURSE mischeaders 
    ./misc/*.h
)
source_group("include\\misc" FILES ${mischeaders}) 

if(SUPPORT_SVG_TYPE)
FILE(GLOB_RECURSE nanosvgheaders 
    ./modules/nanosvg/src/*.h
    ./modules/nanosvg/example/*.h
)
source_group("modules\\include\\nanosvg" FILES ${nanosvgheaders}) 
include_directories(./modules/nanosvg/src)
include_directories(./modules/nanosvg/example)
add_definitions(-DSUPPORT_SVG_TYPE)
endif(SUPPORT_SVG_TYPE)

# 添加头文件搜索路径
include_directories(./core)
include_directories(./misc)

# 配置一个可执行文件项目，ImageConverterDemo.vcxproj
add_executable(ImageConverterDemo ${srcs} ${coresrcs} ${miscsrcs} ${coreheaders} ${mischeaders} ${nanosvgheaders})
```

---

### FAQ
##### 不熟悉xxx命令，如何快速检索相关资料呢
>对于不熟悉的cmake command，有两种方法可以快速找到其使用说明，这里以`find_path`为例

 - 直接在终端上输入`cmake -h find_path`来查询即可，如下图所示:
 - 直接问度娘或谷歌，输入`cmake find_path`来搜索即可，通常搜索引擎前三就是cmake官方的文档，后面的搜索结果是网友的一些博客了
 
![](assets/004/02/04/09-1530522434000.png)

##### SublimeText、VSCode等编辑器应该安装什么插件来快速编辑cmake呢
 - SublimeText----CMakeEditor
 - VSCode----CMakeTool+CMake