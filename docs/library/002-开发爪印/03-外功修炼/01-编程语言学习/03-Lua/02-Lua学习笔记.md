### 在*Lua*实现带默认参数的函数
在lua之中，它没有提供像C++那样的不同参数列表的同名函数是不同的机制，在它的内部里面，其实现了一种很朴素的做法，假设定义了一个有n个形参的函数`SetArgs(arg1...argn)`，那么假设开发者在实际调用此函数的时候，假设填充的参数的个数小于n，那么后面没有添加的参数的实参都默认被设为nil，此时通过or运算符来设定默认值即可；另外，也并不支持`SetArgs(arg1 = 1,arg2 = 2, argn = n )`之类的语句，如下所示：

```lua
myTable = { a= 1, b=2, c=3, d=4 } 

--一种难以言喻的操作
function myTable:SetParam(a1,b1,c1,d1)
    self.a = a1 or "a1"
    self.b = b1 or "b1"
    self.c = c1 or "c1"
    self.d = d1 or "d1"
end

--并没有这种骚操作
--function myTable:SetParam(a1 = "a1",b1 = "b1",c1 = "c1",d1 = "c1")
--    self.a = a1
--    self.b = b1
--    self.c = c1
--    self.d = d1
--end

local temp = myTable
temp:SetParam("Adobe")
print(temp.a)
print(temp.b)
print(temp.c)
print(temp.d)

print("end")
```

### 模拟C++的类的继承机制

更多相关资料请看[Metatable In Lua 浅尝辄止](http://www.cnblogs.com/simonw/archive/2007/01/17/622032.html)

```lua

--lua仿写类似C++的类
--注意，lua的默认参数比较奇葩，在成员函数内部，直接添加xxx1 or xxx2即可
people = { }

function people:new( newName, newIdentity )
    obj = {}
    obj.name = newName or "unknown name1"
    obj.identity = newIdentity or "unknown identity1"
    setmetatable(obj,self)
    self.__index = self
    return obj
end

--添加成员函数
function  people:GetName()
    return self.name
end

function  people:GetIdentity()
    return self.identity
end

function  people:PrintInfo()
    print("object belong to people")
end

--student继承people，此时是相当于将people的元表拷贝到student里面了
student = people:new()

--问题是如何添加被继承的新的成员变量呢
function student:new( newName, newIdentity, newClassroom, newIndex )
    obj = people:new( newName, newIdentity )
    setmetatable(obj, self)
    self.__index = self

    --添加成员变量
    obj.classroom = newClassroom or "unknown classroom2"
    obj.index = newIndex or "unknown index2"
    return obj
end

--添加成员变量到子类里

function student:GetClassroom()
    return  self.classroom
end

function student:GetIndex()
    return  self.index
end

--重载基类的成员函数
function  student:PrintInfo()
    print("object belong to student")
end

print("startup")
temp = student:new("childname", 56579887, "classroom1st", "1")

--开启了下面语句之后可以发现，此时temp的数值会被temp3所影响
temp3 = student:new("childname3", 4987, "classroom3rd", 10)

baseObj =people:new("basename", 110)

baseObj3 =people:new("basename3", 10000000)

print("---------打印类实例的信息--------")
print("在子类实例中调用基类成员函数")
print(temp:GetIdentity())
print(temp:GetName())

print("在子类实例中调用子类成员函数")
print(temp:GetClassroom())
print(temp:GetIndex())

temp:PrintInfo()

print("调用基类实例的成员函数")
print(baseObj:GetName())
print(baseObj:GetIdentity())

print("---------打印当前定义的基类与子类类型的数据--------")
print("以下为基类的信息")
--而name和name是在执行new函数的时候，才为其类实例追加的成员变量，
--而这些成员变量在原本的people里是没有的，因而为nil，正如people = {}
print(people.name)
print(people.name)
people:PrintInfo()

print("以下为子类类型的信息")
--name和identity是从people继承过来的，并且，在继承的时候，通过new函数临时为其创建的，因此数值有效
print(student.name)
print(student.identity)
--而classroom和index是在执行new函数的时候，才为其类实例追加的成员变量，
--而这些成员变量在原本的student是没有的，因而为nil，正如student = people:new{}
print(student.classroom)
print(student.index)
student:PrintInfo()

print("end")
--注意，在new()内，修改self里面的数值的时候，会导致类的成员变量也同时改变，因为，在Lua里面，本身是没有类这个概念的，我们只可以通过Table来模拟类似的类行为，根据Lua的固有限制，我们在通过new()等函数进行类实例创建的时候，使用临时Table来存放此类的特有的成员变量以及成员变量。
--在上述代码里面，student里的classroom和index是无效数值，都为nil，在student:new()函数体内，使用了临时变量obj来存放其基类的成员变量以及成员函数，通过setmetatable(obj,self)语句，让obj拥有了student里面的成员函数以及基类的特性。而之所以需要执行student = people:new()语句，这是为了可以让student继承people的特性了，否则，所有调用了student类实例所有用到基类的方法都将无效，总而言之，这个metatable的作用有点像C++里面的虚表，专门用来定位子类实例和基类之间的成员函数以及成员变量的地址的
```

其实类似的机制，云风大大已经回答得很好了，如下所示：

##### 基于[云风的个人空间 : Lua 中实现面向对象](http://blog.codingnow.com/cloud/LuaOO)实现

**class.lua**

```lua
--[[
-- brief:       让指定变量拥有C++类特性
-- modified:    
-- 创建此文件，并调整代码风格
-- note:以下代码是基于[云风的个人空间 : Lua 中实现面向对象](http://blog.codingnow.com/cloud/LuaOO)提供的源码修改而成
--]]

local _class={}

--[[
-- brief:       让指定变量拥有C++类特性
-- param:       super  待派生出子类的基类
-- return:      如果super为nil，则返回一个基类，如果不为nil，则返回一个派生自super的子类
-- modified:    
-- 依照Lua代码规范的要求，调整原本的代码风格
--]]
function class(super)
	local class_type={}
	class_type.Ctor=false
	class_type.super=super
	class_type.New=function(...)
			local obj={}
			do
				local create
				create = function(c,...)
					if c.super then
						create(c.super,...)
					end
					if c.Ctor then
						c.Ctor(obj,...)
					end
				end

				create(class_type,...)
			end
			setmetatable(obj,{ __index=_class[class_type] })
			return obj
		end
	local vtbl={}
	_class[class_type]=vtbl

	setmetatable(class_type,{__newindex=
		function(t,k,v)
			vtbl[k]=v
		end
	})

	if super then
		setmetatable(vtbl,{__index=
			function(t,k)
				local ret=_class[super][k]
				vtbl[k]=ret
				return ret
			end
		})
	end

	return class_type
end

return class
```

**demo.lua**

```lua
class = require("class")

--创建一个基类person
person = class()

--重载构造函数
function person:Ctor(newName,newID)
    print("person:Ctor("..newName..","..newID..")")
    --添加基类的成员变量
    self.id = newID or "unknown id1st"
    self.name = newName or "unknown name1st"
end

--添加基类的成员函数
function person:GetName()
    return self.name
end

function person:GetID()
    return self.id
end

function person:PrintInfo()
    print("create person instance")
end

--person类派生一个子类student
student = class(person)

--覆盖基类的Ctor()
function student:Ctor(newName, newID, newClassroom, newIndex)
    print("student:Ctor("..newName..", "..newID..", "..newClassroom..", "..newIndex..")")
    self.name = newName or "unknown name2nd"
    self.id = newID or "unknown id2nd"
--添加子类的成员变量
    self.classroom = newClassroom or "unknown classroom2nd"
    self.index = newIndex or "unknown index2nd"
end

--注意，在Lua之中并不支持不同参数列表的同名函数，因为
--在Lua之中，函数也是一个变量来的，存在同名函数的话，自然
--意味着这个变量被设置了多次，最终以离执行代码处最近一次设置生效
--function student:Ctor(newClassroom, newIndex)
--    print("student:Ctor("..newClassroom..", "..newIndex..")")
--    self.name = "unknown name3rd"
--    self.id = "unknown id3rd"
----添加子类的成员变量
--    self.classroom = newClassroom or "unknown classroom2nd"
--    self.index = newIndex or "unknown index2nd"
--end

--添加子类的成员函数
function person:GetClassroom()
    return self.classroom
end

function person:GetIndex()
    return self.index
end

--覆盖基类的PrintInfo()
function student:PrintInfo()
    print("create student instance")
end

--创建类实例，注意，使用的是“.New()”而不是“:New()”哦
temp = person.New("张三",1118)
print(temp:GetName())
print(temp:GetID())

obj1 = student.New("李四",878,"高三(12)",8779799)
--obj1 = student.New("李四",878)
print(obj1:GetName())
print(obj1:GetID())
print(obj1:GetClassroom())
print(obj1:GetIndex())
obj1:PrintInfo()
```

附件下载：[基于【云风的个人空间 ：Lua 中实现面向对象】源码实现.rar](assets/002/03/01/03/基于【云风的个人空间 ：Lua 中实现面向对象】源码实现.rar)

### 控制*Table*类型的访问权限

要想实现此效果，需要使用*Table*里面的*__index*和*__newindex*变量，更多详情请看[用*__index*和*__newindex*来限制访问](http://www.cnblogs.com/egmkang/archive/2011/09/27/2193096.html)，如下所示：

```lua
--访问权限控制函数
function cannotModifyHp(object)
    local proxy = {}
    local mt = {
        __index = object,
    __newindex = function(k,v)
        if k ~= "hp" then
        object[k] = v
        end
    end
    }
    setmetatable(proxy,mt)
    return proxy
end
 
object = {hp = 10,age = 11}
--function object.sethp(self,newhp)
--    self.hp = newhp
--end

function object:sethp(newhp)
    self.hp = newhp
end
 
o = cannotModifyHp(object)
 
o.hp = 100    --修改失效
print(o.hp)
 
o:sethp(111)    --修改失效
print(o.hp)
 
object:sethp(100)    --修改生效
print(o.hp)
```

### *Lua*上的闭包语法
本人在编写一个功能代码的时候，需要考虑到较为蛋疼的情况，最终使用Lua的闭包特性来简化了代码，如下所示：

```lua
--------------------配置信息--------------------
local questCheckConf = {
    {
        appearType = 50,
        count = 5,
        monsterId = 150,
        p
osX1 = 16,
        posX2 = 23,
        posY1 = 50,
        posY2 = 54,
        questId = 3,
        sceneId = 25,
    },
    {
        appearType = 51,
        count = 5,
        monsterId = 151,
        posX1 = 24,
        posX2 = 32,
        posY1 = 50,
        posY2 = 54,
        questId = 4,
        sceneId = 25,
    },
    {
        appearType = 51,
        count = 5,
        monsterId = 151,
        posX1 = 24,
        posX2 = 32,
        posY1 = 50,
        posY2 = 54,
        questId = 6,
        sceneId = 25,
    },
    {
        appearType = 51,
        count = 5,
        monsterId = 151,
        posX1 = 24,
        posX2 = 32,
        posY1 = 50,
        posY2 = 54,
        questId = 4,
        sceneId = 25,
    },
}

local functorTable = { }

---------------以下为原始的做法---------------
-- 先定义一个函数来存储所有并不相同的任务ID
local function GetKeyTable(unknownConf)
    local keyTable = { }
    for _, value in pairs(unknownConf) do
        keyTable[value.questId] = value.questId
    end
    return keyTable
end

-- 先获取一个不重复的任务ID的Table
local tempTable = GetKeyTable(questCheckConf)

function OnFinish(msg, questId)
    for _, value in pairs(questCheckConf) do
        if value.questId == questId then
            print(string.format("questid:%d  monsterid:%d  count :%d", value.questId, value.monsterId, value.count))
        end
    end
end

for index, value in pairs(tempTable) do
    -- 注册遍历到的任务ID的事件响应
    print(string.format("任务ID为%d", value))
    functorTable[value] = functorTable[value] or { }
    table.insert(functorTable[value], OnFinish)
end
---------------以上为原始的做法---------------

-----------------以下使用闭包实现---------------
-- function OnFinishEx(value)
--    return function(msg, questId)
--        print(string.format("questid:%d  monsterid:%d  count :%d", value.questId, value.monsterId, value.count))
--    end
-- end

-- for index, value in pairs(questCheckConf) do
--    -- 注册遍历到的任务ID的事件响应
--    print(string.format("任务ID为%d", value.questId))
--    -- 注意，假设已经存在了相同的任务ID后，那么直接在后面追加即可
--    functorTable[value.questId] = functorTable[value.questId] or { }
--    -- 直接传入当前配置信息
--    table.insert(functorTable[value.questId], OnFinishEx(value))
-- end
-----------------以上使用闭包实现---------------

-- 遍历函数子来自动注册
for questId, functor in pairs(functorTable) do
    for x, y in pairs(functor) do
        y(string.format("正在调用" .. x), questId)
    end
end
```

### *Lua*上的语法糖收集

> v:name(args) 可以被解析成 v.name(v,args) 或者 v.name(self,args) 

举个栗子，如下所示：

```lua
object = {hp = 10,age = 11}
function object.SetHp1st(self,newHp)
    self.hp = newHp
end

function object:SetHp2nd(newHp)
    self.hp = newHp
end
```

> function funcname() body end 等效于 funcname = function() body end



> function table.a.b.c.funcname() body end 等效于 table.a.b.c.funcname = function() body end



> local function funcname() body end 等效于 local funcname; funcname = function() body end 不等效于 local funcname = function() body end哦

### 和*C++*相比，那些常见的知识盲区

#####   *Lua*没有关系操作符***!=***，以***~=***来代替，其它的倒是和*C++*一样

```lua
--如果a不为10的话，那么打印a
if a ~= 10 then
  print(a)
end
```

##### Lua的函数体不要用***{body}***来包裹起来，只需要在后面添加上***end***即可，另外在*Lua*之中，***if***代码块不需要用***(body)***来包裹起来，只需要在判断之中，通过空格区分开来，然后在后面添加***then***即可，注意，有***elseif***而没有***else if***的语句哦，比如***if exp then body end*** 和 ***elseif exp then body***

```lua
function IsMatchedID(oldID, newID)
    if oldID == newID then
        return true
    elseif oldID > newID then
        print("oldID > newID")
        return false
    else
        print("oldID < newID")
        return false
    end
end

print(IsMatchedID(10,13))
print(IsMatchedID(10,10))
print(IsMatchedID(18,10))
```

###获取*Table*、字符串等类型的长度，不需要length()等函数来获取，直接用*#*即可

```lua
tempTable = {897,8,78,7,87,87,8,78,78,7,87,8,7}
print(#tempTable)
tempString = "fadfadfadf"
print(#tempString)
```

###重载运算符*Lua*的运算符

在*Lua*之中，我们可以通过*[Metatable（元表）](undefined)*来重载非数值运算符，能够重载的运算符如下所示：

|  运算符   |  在Lua里的关键字   |                    意义                    |
| :----: | :----------: | :--------------------------------------: |
| **+**  |   **add**    |                   加法运算                   |
| **-**  |   **sub**    |                   减法运算                   |
| *****  |   **mul**    |                   乘法运算                   |
| **/**  |   **div**    |                   除法运算                   |
| **%**  |   **mod**    |                取模运算，获取余值                 |
| **^**  |   **pow**    |                   幂运算                    |
| **--** |   **urm**    |                一元**-**操作符                |
| **..** |  **concat**  |                   连接操作                   |
| **#**  |   **len**    |           取数据类型的长度，比如table长度等            |
| **==** |    **eq**    |                 关系运算符：相等                 |
| **<**  |    **lt**    |                 关系运算符：小于                 |
| **<=** |    **le**    |               关系运算符：小于或等于                |
| **[]** |  **index**   |       通过下标访问**Table[key]**，仅用于读取数据       |
| **[]** | **newindex** | 通过下标**Table[key]** ，仅用于修改数据，如**Table[key] = value** |
| **未知** |   **call**   |             当**Lua**调用一个值时调用             |

以下演示了如何重载支持特定格式的表的运算符操作，如**+**和**-**

```lua
--定义2个表
--a = {5, 6,10,8,69,10,"hello"}
a = {5, 6}
b = {7, 8}

--用c来做Metatable
c = {}
--重定义加法操作
c.__add = function(op1, op2)
--    将所有元素进行配对相加
    local result = {} 
    local lenght1 = table.maxn(op1)
    local lenght2 = table.maxn(op2)
    if lenght1 == lenght2 then
       for index,item in ipairs(op1) do
           table.insert(result,op1[index]+op2[index])
       end
    end
    return result
--   --枚举op2的所有元素，将其插入到op1之中，相当于C++里面的重载运算符+
--   for key, item in ipairs(op2) do
--      print("key = "..key)
--      print("item = "..item)
--      --将item插入到op1之中
--      table.insert(op1, item)
--   end
--   return op1
end

c.__sub = function (op1,op2)
    local result = {} 
    local lenght1 = table.maxn(op1)
    local lenght2 = table.maxn(op2)
    if lenght1 == lenght2 then
       for index,item in ipairs(op1) do
           table.insert(result,op1[index]-op2[index])
       end
    end
    return result
end

--将a的Metatable设置为c
--将__add的方法应用到类b的Table数据中
--setmetatable(a, c)
setmetatable(b, c)
--d现在的样子是{5,6,7,8}
d = a + b
--d = b + a
for key1,value1 in ipairs(d) do
    print(value1)
end
--print(c.__add(a,b)[1])
--print(c.__add(a,b)[1])
e = a - b
--d = b + a
for key2,value2 in ipairs(e) do
    print(value2)
end
```

##### 常见错误
 - 由于lua是弱类型语言，因此，许多时候，一个变量可能是float、int、string或者table等难以区分出来，因此，在某些特定场合里面，最好使用`type()`来捕获此变量的类型，然后使用类似`tonumber()`的函数，将某变量转换成特定的数据类型吧，另外，在number类型的数值比较之中，需要留神待比较的变量是否可能为float类型，通常在这些场合里，使用`math.ceil()`来取整后再作比较
 - table类型变量都是穿引用过去的哦，在后端开发里面，一个大忌就是修改了存放到lua里面的配置表数据，毕竟不止一个玩家在读取这些配置内容
 - 在lua之中，为了避免某些语句的错误影响到后面的语句执行，必然需要处理其抛出的异常，当然，最常见的处理莫过于打印错误时的堆栈信息了，比如需要分发机器人的数据刷新的事件，以便让排行榜及时刷新，那么就会有以下代码段了：
 ```lua
 function OnUpdateRobotMsg(robotId)
    for _, func in ipairs(funcs) do
        xpcall(function () return func(robotId) end, _lua_error_handle)
    end
 end
```