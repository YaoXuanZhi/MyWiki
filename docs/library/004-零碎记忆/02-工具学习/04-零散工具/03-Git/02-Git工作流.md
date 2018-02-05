#### 分支管理规范(基于Gitflow工作流)
 - **master**：没有什么东西，仅是一些关联的tag，因从不在master上开发
 - **feature**：主要是自己玩了，差不多的时候要合并回develop去。从不与master交互
 - **develop**：主要是和feature以及release交互
 - **release**：总是基于develop，最后又合并回develop。当然对应的tag跑到master这边去了。生命周期很短，只是为了发布，如果是采用Github来发布的话，那么其实是不需要专门新建这个分支的
 - **hotfix**：总是基于master，并最后合并到master和develop。生命周期较短，用了修复bug或小粒度修改发布，或者采用**issue-#1061**形式，当然这种方式更加好，另外，其实也可以专门打下一个tag的

---

#### 提交日志规范(基于Angular规范)
```log
<type>(<scope>): <subject> #header
// 空一行
<body>
// 空一行
<footer> 
```

##### type
 - **feat**：新功能（feature）
 - **fix**：修补bug，最好可以打下一个**issue-#1061**类似的日志，然后在关闭的时候log，一般为**Closes issue-#234**之类
 - **docs**：文档（documentation），如果在GitHub上面，可以专门为此创建一个docs文件夹，将项目主页通过Project Page发布
 - **style**： 格式（不影响代码运行的变动），这个可有可无
 - **refactor**：重构（即不是新增功能，也不是修改bug的代码变动）
 - **test**：增加测试，或者编写单元测试案例
 - **chore**：构建过程或辅助工具的变动

>以上为Angular规范的一部分，并且提供Change log自动生成工具，如[conventional-changelog](https://github.com/conventional-changelog/conventional-changelog)，当然，我们也可以用Python或其它工具编写一个类似功能的自动生成工具，基于libgit2、pysvn等类库获取Git、Svn的提交日志，然后对其进行词法解析，生成一些markdown代码段即可

---

##### 引用
 - [Git工作流指南](http://blog.jobbole.com/76843/)
   - [Git工作流指南：集中式工作流(PS：这个也是SVN工作流)](http://blog.jobbole.com/76847/)
   - [Git工作流指南：功能分支工作流](http://blog.jobbole.com/76857/)
   - [Git工作流指南：Gitflow工作流](http://blog.jobbole.com/76867/)
   - [Git工作流指南：Forking工作流(PS：适合参与到他人的开源项目中)](http://blog.jobbole.com/76861/)
   - [Git工作流指南：Pull Request工作流](http://blog.jobbole.com/76854/)
 - [Commit message 和 Change log 编写指南](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)