>Hexo是一个同Jelly类似的博客系统，基于NodeJs实现，目前与Github Page深度结合，因此作为常在Github上翻找的开发人员而言，用它来搭建自己的技术博客是非常常见的。本人早期采用amWiki来搭建自己的私人Wiki，因为Wiki这种形式的确比较适合梳理个人的知识体系，但是目录层级会比较深，因此其实并不方便游客浏览，因此着手基于Hexo搭建一个博客，希望这些知识可以回馈给网友

---
##### Hexo入门指导
>推荐直接到[Hexo官方](https://hexo.io/zh-cn/)上看，这里就不复述了
 - 快速在浏览器预览博客 `hexo clean & hexo g & hexo s`
 - 快速将博客发布到Github上 `hexo clean & hexo g & hexo s`

---

#### 让Hexo支持LaTex公式渲染
>目前坊间流传的方案有三个：一是手动添加mathJax的各种链接；二是采用[hexo-math](https://github.com/hexojs/hexo-math)，此作者将手动方案通过Npm插件打包在一起了；三是采用`hexo-renderer-mathjax`，这里只记录第三种，第一方案手动改动的东西太多，第二种方案动手尝试过，没有成功，不往下深究了直接弃用

 1. **卸载冲突Npm插件，安装所需插件**
   ```sh
   npm uninstall hexo-renderer-marked --save
   npm install hexo-renderer-kramed --save
   npm install hexo-renderer-mathjax --save
   ```

 2. **解决语义冲突** 修改`node_modules\kramed\lib\rules\inline.js`中的第11行：
   ```js
   //  escape: /^\\([\\`*{}\[\]()#$+\-.!_>])/,
   escape: /^\\([`*\[\]()#$+\-.!_>])/,
   ```
   以及第20行：
   ```js
   //  em: /^\b_((?:__|[\s\S])+?)_\b|^\*((?:\*\*|[\s\S])+?)\*(?!\*)/,
   em: /^\*((?:\*\*|[\s\S])+?)\*(?!\*)/,
   ```

 3. **更换MathJax的CDN** 在`/node_modules/hexo-renderer-mathjax/mathjax.html`中把`<script>`更改为：`<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-MML-AM_CHTML"></script>`

 4. **让Hexo开启MathJax的支持** 在`_config.yml`中插入以下语句：
   ```yml
   mathjax:
       enable: true
   ```

 5. **需要在指定的文章中开启MathJax的支持** 在文章的`front-matter`中添加`mathjax: true`，如下所示：
   ```md
   title: Hello World
   mathjax: true
   ```

##### MathJax的例子
 - >对于不含特殊符号的公式，可以直接使用MathJax的inline math表达式.
 - >如果含有特殊符号，则需要人肉escape，如\之类的特殊符号在LaTex表达式中出现频率很高，这样就很麻烦，使用tag能够省不少事。

 - MathJax Inline:
   ```md
   Simple inline $a = b + c$.
   ```
 - MathJax Block:
   ```md
   $$\frac{\partial u}{\partial t}
   = h^2 \left( \frac{\partial^2 u}{\partial x^2} +
   \frac{\partial^2 u}{\partial y^2} +
   \frac{\partial^2 u}{\partial z^2}\right)$$
   ```
 - Tag inline:
   ```md
   This equation {&#37; math \cos 2\theta = \cos^2 \theta - \sin^2 \theta =  2 \cos^2 \theta - 1 %} is inline.
   ```

 - Tag Block:
   ```md
   {&#37; math_block %}
   \begin{aligned}
   \dot{x} & = \sigma(y-x) \\
   \dot{y} & = \rho x - y - xz \\
   \dot{z} & = -\beta z + xy
   \end{aligned}
   {&#37; endmath_block %}
   ```

##### Refrence:
 - [Hexo MathJax插件](http://catx.me/2014/03/09/hexo-mathjax-plugin/)
 - [如何在 hexo 中支持 Mathjax？](https://blog.csdn.net/u014630987/article/details/78670258)
 - [在Hexo中使用mathjax渲染数学公式](https://blog.csdn.net/u013282174/article/details/80666123)