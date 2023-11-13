# Node

## 浏览器内核

- 不同的浏览器有不同的内核组成
  - `Gecko`:早期被Netscape和Mozilla Firefox浏览器使用;
  - `Trident`:微软开发，被IE4~IE11浏览器使用，但是Edge浏览器已经转向Blink;
  - `Webkit`:苹果基于KHTML开发、开源的，用于Safari，Google Chrome之前也在使用;
  - `Blink`:是Webkit的一个分支，Google开发，目前应用于Google Chrome、Edge、Opera等;
  - 等等...
- 事实上，我们经常说的`浏览器内核指的是浏览器的排版引擎:`
- `排版引擎`(layout engine)，也称为`浏览器引擎`(browser engine)、`页面渲染引擎`(rendering engine) 或`样版引擎`。

### WebKit内核

- 这里我们先以WebKit为例，`WebKit`事实上由两部分组成的: 
  - `WebCore`:负责HTML解析、布局、渲染等等相关的工作; 
  - `JavaScriptCore`:解析、执行JavaScript代码;

![image-20230924161639663](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230924161639663.png)

- 在`小程序`中编写的`JavaScript代码就是被JSCore执行的;`

![image-20230924161618956](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230924161618956.png)

- 另外一个强大的JavaScript引擎就是`V8引擎`。



## 渲染引擎工作的过程

- 但是在这个执行过程中，HTML解析的时候遇到了JavaScript标签，应该怎么办呢? 
  - `会停止解析HTML，而去加载和执行JavaScript代码;`
- 当然，为什么不直接异步去加载执行JavaScript代码，而要在这里停止掉呢?
  - 这是因为`JavaScript代码可以操作我们的DOM;`
  - 所以浏览器希望将`HTML解析的DOM和JavaScript操作之后的DOM放到一起来`生成最终的`DOM树`，而不是 频繁的去生成新的DOM树;
- 那么，JavaScript代码由谁来执行呢? 
  - JavaScript引擎

![image-20231107090003330](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107090003330.png)



## JavaScript引擎

- 为什么需要JavaScript引擎呢?
  - 事实上我们编写的JavaScript无论你交给浏览器或者Node执行，最后都是需要被`CPU`执行的;
  - 但是CPU只认识自己的指令集，实际上是机器语言，才能被CPU所执行;
  - 所以我们需要JavaScript引擎帮助我们将JavaScript代码翻译成CPU指令来执行;
- 比较常见的JavaScript引擎有哪些呢?
- `SpiderMonkey`:第一款JavaScript引擎，由Brendan Eich开发(也就是JavaScript作者); 
- `Chakra`:微软开发，用于IT浏览器;
- `JavaScriptCore`:WebKit中的JavaScript引擎，Apple公司开发;
- `V8`:Google开发的强大JavaScript引擎，也帮助Chrome从众多浏览器中脱颖而出;



### V8引擎

- 我们来看一下官方对V8引擎的定义:
  - V8是用C ++编写的Google开源高性能JavaScript和WebAssembly引擎，它用于`Chrome`和`Node.js`等。
  - 它实现ECMAScript和WebAssembly，并在Windows 7或更高版本，macOS 10.12+和使用x64，IA-32， ARM或MIPS处理器的Linux系统上运行。
  - `V8可以独立运行`，也可以嵌入到任何C ++应用程序中。

![image-20231107090731948](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107090731948.png)

### V8引擎的原理

- V8引擎本身的源码非常复杂，大概有超过100w行C++代码，但是我们可以简单了解一下它执行JavaScript代码的原理:
- `Parse模块`会将`JavaScript代码转换成AST(抽象语法树)`，这是因为解释器并不直接认识JavaScript代码;
  - 如果函数没有被调用，那么是不会被转换成AST的;
  - Parse的V8官方文档:https://v8.dev/blog/scanner
- `Ignition`是一个解释器，会将`AST转换成ByteCode(字节码)`
  - 同时会收集TurboFan优化所需要的信息(比如函数参数的类型信息，有了类型才能进行真实的运算);
  - 如果函数只调用一次，Ignition会执行解释执行ByteCode;
  - Ignition的V8官方文档:https://v8.dev/blog/ignition-interpreter
- `TurboFan`是一个编译器，可以将`字节码编译为CPU可以直接执行的机器码;`
  - 如果一个函数被多次调用，那么就会被标记为热点函数，那么就会经过TurboFan转换成优化的机器码，提高代码的执行性能;
  - 但是，机器码实际上也会被还原为ByteCode，这是因为如果后续执行函数的过程中，类型发生了变化(比如sum函数原来执行的是number类型，后 来执行变成了string类型)，之前优化的机器码并不能正确的处理运算，就会逆向的转换成字节码;
  - TurboFan的V8官方文档:https://v8.dev/blog/turbofan-jit
- 上面是JavaScript代码的执行过程，事实上V8的内存回收也是其强大的另外一个原因，不过这里暂时先不展开讨论: 
  - `Orinoco`模块，负责垃圾回收，将程序中不需要的内存回收;
  - Orinoco的V8官方文档:https://v8.dev/blog/trash-talk



## Node.js是什么

- 官方对Node.js的定义:
  - `Node.js是一个基于V8 JavaScript引擎的JavaScript运行时环境。`
- 也就是说Node.js基于V8引擎来执行JavaScript的代码，但是不仅仅只有V8引擎:
  - 前面我们知道V8可以嵌入到任何C ++应用程序中，无论是Chrome还是Node.js，事实上都是嵌入了V8引擎来执行JavaScript代码;
  - 但是在`Chrome`浏览器中，还需要`解析、渲染HTML、CSS等相关渲染引擎`，另外还需要提供支持浏览器操作 的API、浏览器自己的事件循环等;
  - 另外，在`Node.js`中我们也需要进行一些额外的操作，比如`文件系统读/写、网络IO、加密、压缩解压文件等 操作;`



### 浏览器和Node.js架构区别

![image-20231107091249467](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107091249467.png)



### Node.js架构

- 我们来看一个单独的Node.js的架构图:
  - 我们编写的`JavaScript代码会经过V8引擎，再通过Node.js的Bindings，将任务放到Libuv的事件循环中;` 
  - `libuv`(Unicorn Velociraptor—独角伶盗龙)是使用C语言编写的库;
  - `libuv`提供了`事件循环、文件系统读写、网络IO、线程池等等内容;`
  - 具体内部代码的执行流程，我会在后续专门讲解事件和异步IO的原理中详细讲解;

![image-20231107091501777](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107091501777.png)



## Node的版本工具

- 在实际开发学习中，我们只需要使用一个Node版本来开发或者学习即可。
- 但是，如果你希望通过可以`快速更新或切换多个版本时`，可以借助于一些工具:
  - `nvm`:Node Version Manager;
  - `n`:Interactively Manage Your Node.js Versions(交互式管理你的Node.js版本)



### 版本管理工具:n

- 安装n:直接使用npm安装即可

![image-20231107092034825](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107092034825.png)

- 安装最新的lts版本:
  - 前面添加的sudo是权限问题;
  - 可以两个版本都安装，之后我们可以通过n快速在两个版本间切换;

![image-20231107092056046](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107092056046.png)



## JavaScript代码执行

- 如果我们编写一个js文件，里面存放JavaScript代码，如何来执行它呢?
- 目前我们知道有两种方式可以执行: 
  - 将代码交给`浏览器`执行;
  - 将代码载入到`node`环境中执行;
- 如果我们希望把代码交给`浏览器`执行:
  - 需要通过让浏览器加载、解析html代码，所以我们需要创建一个html文件;
  - 在html中通过script标签，引入js文件;
  - 当浏览器遇到script标签时，就会根据src加载、执行JavaScript代码;
- 如果我们希望把js文件交给`node`执行:
  - 首先电脑上需要安装Node.js环境，安装过程中会自动配置环境变量; 
  - 可以通过终端命令node js文件的方式来载入和执行对应的js文件;



### Node的REPL

- 什么是REPL呢?感觉挺高大上
  - REPL是Read-Eval-Print Loop的简称，翻译为`“读取-求值-输出”循环`; 
  - `REPL是一个简单的、交互式的编程环境;`
- 事实上，我们浏览器的console就可以看成一个REPL。
- Node也给我们提供了一个REPL环境，我们可以在其中演练简单的代码。



### Node程序传递参数

- 正常情况下执行一个node程序，直接跟上我们对应的文件即可:

```shell
 node index.js
```

- 但是，在某些情况下执行node程序的过程中，我们可能希望给node传递一些参数: 

```shell
node index.js env=development coderwhy
```

- 如果我们这样来使用程序，就意味着我们需要在程序中获取到传递的参数:
  - 获取参数其实是在`process`的内置对象中的;
  - 如果我们直接打印这个内置对象，它里面包含特别的信息:
  - 其他的一些信息，比如版本、操作系统等大家可以自行查看，后面用到一些其他的我们还会提到;
- 现在，我们先找到其中的`argv`属性:
  - 我们发现它是一个数组，里面包含了我们需要的参数;

![image-20231107092533827](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107092533827.png)

![image-20231107092656044](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107092656044.png)

```js
console.log(process.argv[2]);
console.log(process.argv[3]);

console.clear();

process.argv.forEach(item => {
  console.log(item);
})

function foo() {
  bar();
}

function bar() {
  console.trace();
}

foo();




```

### Node的输出

- `console.log`
  - 最常用的输入内容的方式:console.log
- `console.clear`
  - 清空控制台:console.clear
- `console.trace`
  - 打印函数的调用栈:console.trace
- 还有一些其他的方法，其他的一些console方法，可以自己在下面学习研究一下。
  -  https://nodejs.org/dist/latest-v14.x/docs/api/console.html



## 全局对象



### 特殊的全局对象

- 为什么我称之为特殊的全局对象呢?

  - 这些全局对象`可以在模块中任意使用，但是在命令行交互中是不可以使用的;`

    包括:`dirname`、`filename`、`exports`、`module`、`require()`

- `__dirname`:获取当前文件所在的路径: 

  - 注意:不包括后面的文件名

- `__filename`:获取当前文件所在的路径和文件名称: 

  - 注意:包括后面的文件名称

![image-20231107093039730](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107093039730.png)



### 常见的全局对象

- `process对象`:process提供了Node进程中相关的信息:
  - 比如Node的运行环境、参数信息等;
  - 后面在项目中，我也会讲解，如何将一些环境变量读取到 process 的 env 中;
- `console对象`:提供了简单的调试控制台，在前面讲解输入内容时已经学习过了。
  - 更加详细的查看官网文档:https://nodejs.org/api/console.html
- `定时器函数`:在Node中使用定时器有好几种方式:
  - `setTimeout(callback, delay[, ...args])`:callback在delay毫秒后执行一次;
  - `setInterval(callback, delay[, ...args])`:callback每delay毫秒重复执行一次;
  - `setImmediate(callback[, ...args])`:callbackI / O事件后的回调的“立即”执行;
  - `process.nextTick(callback[, ...args]):`添加到下一次tick队列中;



### global对象

- global是一个`全局对象`，事实上前端我们提到的process、console、setTimeout等都有被放到global中:

![image-20231107093438601](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107093438601.png)



#### global和window的区别

- 在`浏览器`中，全局变量都是在`window`上的，比如有document、setInterval、setTimeout、alert、console等等 
- 在`Node`中，我们也有一个`global`属性，并且看起来它里面有很多其他对象。
- 但是在浏览器中执行的JavaScript代码，如果我们在顶级范围内通过var定义的一个属性，默认会被添加到window 对象上:

![image-20231107093556151](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107093556151.png)

- 但是在node中，我们通过var定义一个变量，它只是在当前模块中有一个变量，不会放到全局中:

![image-20231107093606370](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107093606370.png)

# 模块化

## 认识模块化开发

### 什么是模块化

- 到底什么是模块化、模块化开发呢？
  - 事实上模块化开发最终的目的是`将程序划分成一个个小的结构；`
  - 这个结构中编写属于`自己的逻辑代码`，有`自己的作用域`，`定义变量名词时不会影响到其他的结构`；
  - 这个结构可以`将自己希望暴露的变量、函数、对象等导出给其结构使用；`
  - 也可以`通过某种方式，导入另外结构中的变量、函数、对象等；`
- 上面说提到的结构，就是模块；`按照这种结构划分开发程序的过程，就是模块化开发的过程；`
  - 无论你多么喜欢JavaScript，以及它现在发展的有多好，它都有很多的缺陷：
  - 比如var定义的变量作用域问题；
  - 比如JavaScript的面向对象并不能像常规面向对象语言一样使用class；
  - 比如JavaScript没有模块化的问题；
- 对于早期的JavaScript没有模块化来说，确确实实带来了很多的问题；



### 模块化的历史

- 在网页开发的早期，Brendan Eich 开发JavaScript仅仅作为一种脚本语言，做一些简单的表单验证或动画实现等，那个时候代码还是很少的：
  - 这个时候我们只需要讲JavaScript代码写到`<script>`标签中即可；
  - 并没有必要放到多个文件中来编写；甚至流行：通常来说 JavaScript 程序的长度只有一行。
  - 但是随着前端和JavaScript的快速发展，JavaScript代码变得越来越复杂了：
  - `ajax的出现，前后端开发分离`，意味着后端返回数据后，我们需要通过JavaScript进行前端页面的渲染；
  - `SPA的出现`，前端页面变得更加复杂：包括前端路由、状态管理等等一系列复杂的需求需要通过JavaScript来实现；
  - 包括Node的实现，JavaScript编写复杂的后端程序，没有模块化是致命的硬伤；
- 所以，模块化已经是JavaScript一个非常迫切的需求：
  - 但是JavaScript本身，直到`ES6（2015）才推出了自己的模块化方案；`
  - 在此之前，为了让JavaScript支持模块化，涌现出了很多不同的模块化规范：`AMD`、`CMD`、`CommonJS`等；



### 没有模块化带来的问题

- 早期`没有模块化`带来了很多的问题：比如`命名冲突`的问题
- 当然，我们有办法可以解决上面的问题：`立即函数调用表达式（IIFE）`
  - IIFE (Immediately Invoked Function Expression)
- 但是，我们其实带来了新的问题：
  - 第一，我必须`记得每一个模块中返回对象的命名`，才能在其他模块使用过程中正确的使用；
  - 第二，代码写起来混乱不堪，每个文件中的代码都需要`包裹在一个匿名函数中来编写；`
  - 第三，在没有合适的规范情况下，每个人、每个公司都可能会任意命名、甚至出现模块名称相同的情况；
- 所以，我们会发现，虽然实现了模块化，但是我们的实现过于简单，并且是没有规范的。
  - 我们需要`制定一定的规范来约束每个人都按照这个规范去编写模块化的代码；`
  - 这个规范中应该包括核心功能：`模块本身可以导出暴露的属性，模块又可以导入自己需要的属性；`
  - JavaScript社区为了解决上面的问题，涌现出一系列好用的规范，接下来我们就学习具有代表性的一些规范。

```js
const moduleA = (function() {
  let name = "why"
  let age = 18
  let height = 1.88
  console.log(name)

  return {
    name,
    age,
    height
  }
}())

// ECMAScript没有推出来自己的模块化方案: CommonJS/AMD/CMD
// ES6(ES2015)推出自己的模块化方案: ESModule

```

```js
//其他文件使用
console.log(moduleA.name)
```



## CommonJS

### CommonJS规范和Node关系

- 我们需要知道`CommonJS`是一个规范，最初提出来是在浏览器以外的地方使用，并且当时被命名为`ServerJS`，后来为了体现它的广泛性，修改为`CommonJS`，平时我们也会简称为`CJS`。
  - `Node`是CommonJS在服务器端一个具有代表性的实现；
  - `Browserify`是CommonJS在浏览器中的一种实现；
  - `webpack`打包工具具备对CommonJS的支持和转换；
- 所以，Node中对CommonJS进行了支持和实现，让我们在开发node的过程中可以方便的进行模块化开发：
  - `在Node中每一个js文件都是一个单独的模块；`
  - 这个模块中包括CommonJS规范的核心变量：`exports`、`module.exports`、`require`；
  - 我们可以使用这些变量来方便的进行模块化开发；
- 前面我们提到过模块化的核心是导出和导入，Node中对其进行了实现：
  - `exports`和`module.exports`可以负责对模块中的内容进行导出；
  - `require`函数可以帮助我们`导入其他模块（自定义模块、系统模块、第三方库模块）中的内容；`



### exports

- 注意：`exports是一个对象`，我们可以在这个对象中添加很多个属性，添加的属性会导出；

![image-20231018154521554](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231018154521554.png)

- 另外一个文件中可以导入：

![image-20231018154534369](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231018154534369.png)

- 上面这行完成了什么操作呢？理解下面这句话，Node中的模块化一目了然
  - 意味着`main中的bar变量等于exports对象；`
  - 也就是`require通过各种查找方式，最终找到了exports这个对象；`
  - 并且将这个`exports对象赋值给了bar变量`；
  - `bar变量就是exports对象了；`

![Node导入和导出的本质](https://cdn.jsdelivr.net/gh/OneOneT/images@main/Node%E5%AF%BC%E5%85%A5%E5%92%8C%E5%AF%BC%E5%87%BA%E7%9A%84%E6%9C%AC%E8%B4%A8.png)

```js
//utiles.js

const UTIL_NAME = "util_name"

function formatCount() {
  return "200万"
}

function formatDate() {
  return "2022-10-10"
}

console.log(exports) // {}

exports.UTIL_NAME = UTIL_NAME
exports.formatCount = formatCount
exports.formatDate = formatDate


```

```js
//main.js

// 1.直接获取导出的对象, 从对象中获取属性
// const util = require("./util.js")

// console.log(util.UTIL_NAME)
// console.log(util.formatCount())
// console.log(util.formatDate())

// 2.导入对象之后, 直接对其进行解构
// const {
//   UTIL_NAME,
//   formatCount,
//   formatDate
// } = require("./util.js")

// console.log(UTIL_NAME)
// console.log(formatCount())
// console.log(formatDate())

// 3.探讨require的本质
const bar = require("./bar.js");
console.log(bar.name); // bar

// 4s之后重新获取name
// setTimeout(() => {
//   console.log(bar.name)
// }, 4000)

// 2s之后通过bar修改了name
setTimeout(() => {
  bar.name = "kobe";
}, 2000);

```

#### 浅层拷贝

- 为了进一步论证，bar和exports是同一个对象:
  - 所以，bar对象是exports对象的浅拷贝(引用赋值);
  - 浅拷贝的本质就是一种引用的赋值而已;

![image-20231103165931284](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231103165931284.png)



### module.exports

- 但是Node中我们经常导出东西的时候，又是通过`module.exports`导出的：

> `module.exports`和`exports`有什么关系或者区别呢？

- 我们追根溯源，通过维基百科中对CommonJS规范的解析：
- `CommonJS中是没有module.exports的概念的；`
- 但是`为了实现模块的导出`，`Node中使用的是Module的类，每一个模块都是Module的一个实例，也就是module；`
- 所以在`Node中真正用于导出的其实根本不是exports，而是module.exports；`
- 因为`module才是导出的真正实现者；`



- 但是，为什么exports也可以导出呢？
  - 这是因为`module对象的exports属性是exports对象的一个引用；`
  - 也就是说 `module.exports = exports = main中的bar；`

![Node中module的exports的本质](https://cdn.jsdelivr.net/gh/OneOneT/images@main/Node%E4%B8%ADmodule%E7%9A%84exports%E7%9A%84%E6%9C%AC%E8%B4%A8.png)



```js
const name = "foo"
const age = 18
function sayHello() {
  console.log("sayHello")
}

// 1.在开发中使用的很少
// exports.name = name
// exports.age = age
// exports.sayHello = sayHello

// 2.将模块中内容导出
// 结论: Node导出的本质是在导出module.exports对象
// module.exports.name = name
// module.exports.age = age
// module.exports.sayHello = sayHello

// // console.log(exports.name, "----")
// // console.log(exports.age, "----")
// // console.log(exports.sayHello, "----")
// console.log(exports === module.exports)

// 3.开发中常见的写法
module.exports = {
  name,
  age,
  sayHello
}

// exports.name = "哈哈哈哈"
// module.exports.name = "哈哈哈哈"


```





### require

- 我们现在已经知道，`require是一个函数`，可以帮助我们引入一个文件（模块）中导出的对象。
- 那么，`require的查找规则`是怎么样的呢？
  - 这里我总结比较常见的查找规则：
  - 导入格式如下：`require(X)`
- 情况一：`X是一个Node核心模块`，比如`path`、`http`
  - `直接返回核心模块，并且停止查找`



- 情况二：`X是以 ./ 或 ../ 或 /（根目录）开头的`
  - 第一步：将X当做一个文件在对应的目录下查找；
    - 1.如果`有后缀名，按照后缀名的格式查找对应的文`
    - 2.如果`没有后缀名，会按照如下顺序`：
      - 1> 直接查找文件X
      - 2> 查找X.js文件
      - 3> 查找X.json文件
      - 4> 查找X.node文件
  - 第二步：`没有找到对应的文件，将X作为一个目录`
    - `查找目录下面的index文件`
      - 1> 查找X/index.js文件
      - 2> 查找X/index.json文件
      - 3> 查找X/index.node文件
  - `如果没有找到，那么报错：not found`



- 情况三：`直接是一个X（没有路径），并且X不是一个核心模块`
- /Users/coderwhy/Desktop/Node/TestCode/04_learn_node/05_javascript-module/02_commonjs/main.js中编写 require('why’)

![image-20231018160140570](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231018160140570.png)

- 如果上面的路径中都没有找到，那么报错：not found

```js
// 1.根据路径导入自己编写模块
// const utils = require("./utils")
// console.log(utils.formatDate())

// const foo = require("./foo")


// 2.导入node提供给内置模块
// const path = require("path")
// const http = require("http")
// console.log(path, http)


// 3.情况三: 名称不是路径, 也不是一个内置模块
// const why = require("why")
// console.log(why)

// const axios = require("axios")
// console.log(axios)

console.log(this)

```



### 模块的加载过程

- 结论一：`模块在被第一次引入时，模块中的js代码会被运行一次`
- 结论二：`模块被多次引入时，会缓存，最终只加载（运行）一次`
  - 为什么只会加载运行一次呢？
  - 这是因为每个模块对象module都有一个属性：loaded。
  - 为false表示还没有加载，为true表示已经加载；
- 结论三：`如果有循环引入，那么加载顺序是什么？`
  - 如果出现右图模块的引用关系，那么加载顺序是什么呢？
  - 这个其实是一种数据结构：`图结构`；
  - 图结构在遍历的过程中，有`深度优先搜索`（DFS, depth first search）和`广度优先搜索`（BFS, breadth first search）；
  - `Node采用的是深度优先算法`：main -> aaa -> ccc -> ddd -> eee ->bbb

![image-20231018160725351](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231018160725351.png)



### CommonJS规范缺点

- `CommonJS加载模块是同步的：`
  - `同步的意味着只有等到对应的模块加载完毕，当前模块中的内容才能被运行；`
  - 这个在服务器不会有什么问题，因为服务器加载的js文件都是本地文件，加载速度非常快；
- 如果将它应用于浏览器呢？
  - 浏览器加载js文件需要先从服务器将文件下载下来，之后再加载运行；
  - 那么采用同步的就意味着后续的js代码都无法正常运行，即使是一些简单的DOM操作；
- 所以在浏览器中，我们通常不使用CommonJS规范：
  - 当然在webpack中使用CommonJS是另外一回事；
  - 因为它会将我们的代码转成浏览器可以直接执行的代码；
- 在早期为了可以在浏览器中使用模块化，通常会采用`AMD`或`CMD`：
  - 但是目前一方面现代的浏览器已经支持ES Modules，另一方面借助于webpack等工具可以实现对CommonJS或者ES Module代码的转换；
- AMD和CMD已经使用非常少了；



## AMD

- `AMD`主要是应用于`浏览器`的一种模块化规范：
  - AMD是Asynchronous Module Definition（异步模块定义）的缩写；
  - 它采用的是`异步加载模块`；
  - 事实上AMD的规范还要早于CommonJS，但是CommonJS目前依然在被使用，而AMD使用的较少了；
- 我们提到过，规范只是定义代码的应该如何去编写，只有有了具体的实现才能被应用：
  - AMD实现的比较常用的库是`require.js`和`curl.js`；

### require.js的使用

- 第一步：下载require.js
  - 下载地址：https://github.com/requirejs/requirejs
  - 找到其中的require.js文件；
- 第二步：定义HTML的script标签引入require.js和定义入口文件：
  - `data-main属性的作用是在加载完src的文件后会加载执行该文件`

```html
<script src="./lib/require.js" data-main="./index.js"></script>
```

![image-20231018163434740](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231018163434740.png)



## CMD

- CMD规范也是应用于`浏览器`的一种模块化规范：
  - CMD 是Common Module Definition（通用模块定义）的缩写；
  - 它也采用的也是`异步加载模块`，但是它将CommonJS的优点吸收了过来；
  - 但是目前CMD使用也非常少了；
- CMD也有自己比较优秀的实现方案：
  - `SeaJS`

### SeaJS的使用

- 第一步：下载SeaJS
  - 下载地址：https://github.com/seajs/seajs
  - 找到dist文件夹下的sea.js
- 第二步：引入sea.js和使用主入口文件
  - seajs是指定主入口文件的

![image-20231018163822816](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231018163822816.png)



## ES Module

### 认识 ES Module

- JavaScript没有模块化一直是它的痛点，所以才会产生我们前面学习的社区规范：CommonJS、AMD、CMD等，所以在ECMA推出自己的模块化系统时，大家也是兴奋异常。
- `ES Module`和`CommonJS`的模块化有一些不同之处：
  - 一方面它使用了`import`和`export`关键字；
  - 另一方面它采用`编译期的静态分析`，并且也`加入了动态引用的方式；`
- ES Module模块采用export和import关键字来实现模块化：
  - `export`负责将模块内的内容导出；
  - `import`负责从其他模块`导入`内容；
- 了解：`采用ES Module将自动采用严格模式：use strict`

![前端使用模块化的方案](https://cdn.jsdelivr.net/gh/OneOneT/images@main/%E5%89%8D%E7%AB%AF%E4%BD%BF%E7%94%A8%E6%A8%A1%E5%9D%97%E5%8C%96%E7%9A%84%E6%96%B9%E6%A1%88.png)

### 浏览器使用Es module

- 这里我在`浏览器`中演示ES6的模块化开发：

```html
  <!-- 注意事项二: 在我们打开对应的html时, 如果html中有使用模块化的代码, 那么必须开启一个服务来打开 -->
  <script src="./foo.js" type="module"></script>
  <script src="./main.js" type="module"></script>

```

- 如果直接在浏览器中运行代码，会报如下错误：

![image-20231018170925918](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231018170925918.png)

- 这个在MDN上面有给出解释：
  -  https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Modules
  - 你需要注意本地测试 — 如果你通过本地加载Html 文件 (比如一个 file:// 路径的文件), 你将会遇到 `CORS` 错误，因为Javascript 模块安全性需要；
- 你需要通过一个`服务器`来测试；
- 我这里使用的VSCode插件：Live Server

```js
// 导入 import
// 注意事项一: 在浏览器中直接使用esmodule时, 必须在文件后加上后缀名.js
import { name, age, sayHello } from "./foo.js"

// const name = "main"

console.log(name)
console.log(age)
sayHello()

```



### exports

- `export`关键字将一个模块中的变量、函数、类等导出；
- 我们希望将其他中内容全部导出，它可以有如下的方式：
- 方式一：`在语句声明的前面直接加上export关键字`
- 方式二：`将所有需要导出的标识符，放到export后面的 {}中`
  - 注意：`这里的 {}里面不是ES6的对象字面量的增强写法，{}也不是表示一个对象的；`
  - 所以： export {name: name}，是错误的写法；
- 方式三：`导出时给标识符起一个别名`
  - 通过`as`关键字起别名

```js
// 3.导出方式三:
export const name = "why"
export const age = 18

export function sayHello() {
  console.log("sayHello")
}

export class Person {}

// console.log(name)

// 1.导出方式一: 
// export {
//   name,
//   age,
//   sayHello
// }

// 2.导出方式二: 导出时给标识符起一个别名(很少使用)
// export {
//   name as fname,
//   age,
//   sayHello
// }


```

### import

- `import`关键字负责从另外一个模块中导入内容

> 导入内容的方式也有多种：

- 方式一：`import {标识符列表} from '模块'；`
  - 注意：`这里的{}也不是一个对象，里面只是存放导入的标识符列表内容；`
- 方式二：`导入时给标识符起别名`
  - 通过`as`关键字起别名
- 方式三：通过 `*` 将模块功能放到一个模块功能对象（a module object）上

```js
// 1.导入方式一: 
// import { name, age, sayHello } from "./foo.js"

// 2.导入方式二: 导入时给标识符起别名
// import { name as fname, age, sayHello } from "./foo.js"

// 3.导入时可以给整个模块起别名
import * as foo from "./foo.js"

const name = "main"

console.log(name)
console.log(foo.name)
console.log(foo.age)
foo.sayHello()

```



### export和import结合使用

- 为什么要这样做呢？
  - 在开发和封装一个功能库时，通常我们希望`将暴露的所有接口放到一个文件中；`
  - 这样`方便指定统一的接口规范，也方便阅读；`
  - 这个时候，我们就可以使用export和import结合使用；

```js
import { formatCount, formatDate } from './format.js'
import { parseLyric } from './parse.js'

export {
  formatCount,
  formatDate,
  parseLyric
}

// 优化一:
// export { formatCount, formatDate } from './format.js'
// export { parseLyric } from './parse.js'

// 优化二:
// export * from './format.js'
// export * from './parse.js'

```



### default

- 前面我们学习的导出功能都是`有名字的导出（named exports）：`
  - 在导出export时指定了名字；
  - 在导入import时需要知道具体的名字；
- 还有一种导出叫做`默认导出（default export）`
  - `默认导出export`时可以`不需要指定名字`；
  - 在`导入时不需要使用 {}`，并且可以`自己来指定名字；`
  - 它也方便我们和现有的CommonJS等规范相互操作；
- 注意：`在一个模块中，只能有一个默认导出（default export）；`

```js
// 1.默认的导出:
// // 1.1. 定义函数
// function parseLyric() {
//   return ["歌词"]
// }

// const name = "aaaa"

// // export {
// //   parseLyric,
// //   name
// // }

// 1.2.默认导出
// export default parseLyric


// 2.定义标识符直接作为默认导出
export default function() {
  return ["新歌词"]
}

// export default function() {
//   return ["歌词"]
// }

// 注意事项: 一个模块只能有一个默认导出


```

### import函数

- 通过import加载一个模块，是`不可以放在逻辑代码中`的，比如：
- 为什么会出现这个情况呢？
  - 这是因为ES Module在被JS引擎解析时，就必须知道它的依赖关系；
  - 由于这个时候js代码没有任何的运行，所以无法在进行类似于if判断中根据代码的执行情况；
  - 甚至拼接路径的写法也是错误的：因为我们必须到运行时能确定path的值；
- 但是某些情况下，我们确确实实希望`动态的来加载某一个模块：`
  - 如果根据不懂的条件，动态来选择加载模块的路径；
  - 这个时候我们需要使用 `import()` 函数来动态加载；
    - `import函数返回一个Promise，可以通过then获取结果；`

```js
import { name, age, sayHello } from "./foo.js"

console.log(name, age)


// 2.import函数的使用
// let flag = true
// if (flag) {
//   // 不允许在逻辑代码中编写import导入声明语法, 只能写到js代码顶层
//   // import { name, age, sayHello } from "./foo.js" 
//   // console.log(name, age)

//   // 如果确实是逻辑成立时, 才需要导入某个模块
//   // import函数
//   // const importPromise = import("./foo.js")
//   // importPromise.then(res => {
//   //   console.log(res.name, res.age)
//   // })
//   import("./foo.js").then(res => {
//     console.log(res.name, res.age)
//   })

//   console.log("------")
// }

```

#### import.meta

- `import.meta`是一个给JavaScript模块暴露特定上下文的元数据属性的对象。
  - 它包含了这个`模块的信息`，比如说这个模块的URL；
  - 在ES11（ES2020）中新增的特性；





### ES Module的解析流程

- ES Module是如何被浏览器解析并且让模块之间可以相互引用的呢？
  -  https://hacks.mozilla.org/2018/03/es-modules-a-cartoon-deep-dive/
- ES Module的解析过程可以划分为三个阶段：
  - 阶段一：`构建（Construction）`，根据地址查找js文件，并且下载，将其解析成`模块记录`（Module Record）；
  - 阶段二：`实例化（Instantiation）`，对模块记录进行实例化，并且分配内存空间，解析模块的导入和导出语句，把模块指向对应的内存地址。
  - 阶段三：`运行（Evaluation）`，运行代码，计算值，并且将值填充到内存地址中；



![image-20231018172817899](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231018172817899.png)



#### 阶段一：构建阶段

![image-20231018173010070](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231018173010070.png)

#### 阶段二和三：实例化阶段 – 求值阶段

![image-20231018112326272](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231018112326272.png)



#### 总结:

1.构建阶段: 下载js文件(这时还没有执行代码),

2.实例化阶段: 确认js文件之间的关系，实例化阶段会会确认模块的环境记录，确认导出的变量(这时还没有赋值)

3.运行阶段: 求值，确认导出变量的值



## CommonJS和ES Module交互

- 结论一:`通常情况下，CommonJS不能加载ES Module`
  - 因为`CommonJS是同步加载的`，但是`ES Module必须经过静态分析`等，无法在这个时候执行JavaScript代码; 
  - 但是这个并非绝对的，某些平台在实现的时候可以对代码进行针对性的解析，也可能会支持;
  - Node当中是不支持的;
- 结论二:`多数情况下，ES Module可以加载CommonJS`
  - ES Module在加载CommonJS时，会将其module.exports导出的内容作为default导出方式来使用; 
  - 这个依然需要看具体的实现，比如webpack中是支持的、Node最新的Current版本也是支持的;
  - 但是在最新的LTS版本中就不支持;



# 事件循环和异步IO

## 什么是事件循环

- 事件循环是什么?
  - 事实上我把`事件循环`理解成我们编写的`JavaScript`和`浏览器或者Node之间的一个桥梁。`
- `浏览器的事件`循环是一个我们编写的`JavaScript代码和浏览器API调用(setTimeout/AJAX/监听事件等)的一个桥梁,` 桥梁之间他们通过`回调函数`进行沟通。
- `Node的事件循环`是一个我们编写的`JavaScript代码和系统调用(file system、network等)之间的一个桥梁,` 桥梁之间他们通过`回调函数`进行沟通的.

## 进程和线程

- `线程`和`进程`是操作系统中的两个概念: 
  - `进程(process)`:计算机已经运行的程序，是操作系统管理程序的一种方式; 
  - `线程(thread)`:操作系统能够运行运算调度的最小单位，通常情况下它被`包含在进程中`;
- 听起来很抽象，这里还是给出我的解释:
  - `进程:`我们可以认为，启动`一个应用程序`，就会默认`启动一个进程(也可能是多个进程);`
  - `线程`:每`一个进程`中，都会启`动至少一个线程`用来执行程序中的代码，这个线程被称之为`主线程`; 
  - 所以我们也可以说`进程是线程的容器;`
- 再用一个形象的例子解释:
  - 操作系统类似于一个大工厂;
  - 工厂中里有很多车间，这个车间就是进程;
  - 每个车间可能有一个以上的工人在工厂，这个工人就是线程;

### 多进程多线程开发

- `操作系统`是如何做到同时让多个进程(边听歌、边写代码、边查阅资料)同时工作呢? 
  - 这是因为`CPU`的运算速度非常快，它可以快速的在多个进程之间迅速的切换;
  - 当我们的进程中的线程获取获取到时间片时，就可以快速执行我们编写的代码;
  - 对于用于来说是感受不到这种快速的切换的;

![image-20231106172025510](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106172025510.png)

![image-20231106172051108](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106172051108.png)



## 浏览器事件循环

### 浏览器中的JavaScript线程

- 我们经常会说`JavaScript是单线程(可以开启workers)`的，但是JavaScript的线程应该有自己的容器进程:`浏览器或者Node。`
- 浏览器是一个进程吗，它里面只有一个线程吗?
  - 目前`多数的浏览器其实都是多进程`的，当我们打开一个tab页面时就会开启一个新的进程，这是为了防止一个页面卡死而造成 所有页面无法响应，整个浏览器需要强制退出;
  - 每个进程中又有很多的线程，其中包括执行JavaScript代码的线程;
- `JavaScript的代码执行是在一个单独的线程中执行的:`
  - 这就意味着JavaScript的代码，在`同一个时刻只能做一件事;` 
  - 如果这件事是非常耗时的，就意味着`当前的线程就会被阻塞;`
- 所以真正耗时的操作，实际上并不是由JavaScript线程在执行的:
  - 浏览器的每个进程是多线程的，那么其他线程可以来完成这个耗时的操作; 
  - 比如`网络请求`、`定时器`，我们只`需要在特性的时候执行应该有的回调即可;`

> 单线程-代码顺序如何执行

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  
  <script>
    let name = "why"
    name = "kobe"

    function bar() {
      console.log("bar function")
    }

    function foo() {
      console.log("foo function")
      // 1.在JavaScript内部执行
      // let total = 0
      // for (let i = 0; i < 1000000; i++) {
      //   total += i
      // }

      // 2.创建一个定时器
      setTimeout(() => {
        console.log("setTimeout")
      }, 10000);

      bar()
    }

    foo()

  </script>

</body>
</html>
```



### 浏览器的事件循环

如果在执行JavaScript代码的过程中，有`异步操作`呢?

- 中间我们插入了一个setTimeout的函数调用; 
- 这个函数被放到入`调用栈`中，`执行会立即结束，并不会阻塞后续代码的执行;`

![image-20230917205648561](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230917205648561.png)

![image-20230917205639370](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230917205639370.png)



### 浏览器宏任务和微任务

- 但是`事件循环`中并非只维护着一个队列，事实上是有两个队列:
  - `宏任务队列(macrotask queue)`:ajax、setTimeout、setInterval、DOM监听、UI Rendering等 
  - `微任务队列(microtask queue)`:Promise的then回调、 Mutation Observer API、queueMicrotask()等
- 那么事件循环对于两个队列的优先级是怎么样的呢?
  - `main script中的代码优先执行`(编写的顶层script代码);
  - 在`执行任何一个宏任务之前`(不是队列，是一个宏任务)，都会先`查看微任务队列中是否有任务需要执行`
    - 也就是`宏任务执行之前，必须保证微任务队列是空的;`
    - 如果不为空，那么就`优先执行微任务队列中的任务`(回调);

![image-20231106203500403](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106203500403.png)

```js
setTimeout(function () {
  console.log("set1");
  new Promise(function (resolve) {
    resolve();
  }).then(function () {
    new Promise(function (resolve) {
      resolve();
    }).then(function () {
      console.log("then4");
    });
    console.log("then2");
  });
});

new Promise(function (resolve) {
  console.log("pr1");
  resolve();
}).then(function () {
  console.log("then1");
});

setTimeout(function () {
  console.log("set2");
});

console.log(2);

queueMicrotask(() => {
  console.log("queueMicrotask1")
});

new Promise(function (resolve) {
  resolve();
}).then(function () {
  console.log("then3");
});

// pr1
// 2
// then1
// queuemicrotask1
// then3
// set1
// then2
// then4
// set2

```



```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  
  <script>

    console.log("script start")

    // function bar() {
    //   console.log("bar function")
    // }

    // function foo() {
    //   console.log("foo function")
    //   bar()
    // }
    // foo()

    // 定时器(添加到宏任务队列)
    setTimeout(() => {
      console.log("setTimeout0")
    }, 0)
    setTimeout(() => {
      console.log("setTimeout1")
    }, 0)

    // Promise中的then的回调也会被添加到队列中(微任务队列)
    console.log("1111111")
    new Promise((resolve, reject) => {
      console.log("2222222")
      console.log("-------1")
      console.log("-------2")
      resolve()
      console.log("-------3")
    }).then(res => {
      console.log("then传入的回调: res", res)
    })
    console.log("3333333")

    console.log("script end")

  </script>

</body>
</html>


```

### ![image-20231106204409752](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106204409752.png)Promise面试题

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  
  <script>
    console.log("script start")

    setTimeout(function () {
      console.log("setTimeout1");
      new Promise(function (resolve) {
        resolve();
      }).then(function () {
        new Promise(function (resolve) {
          resolve();
        }).then(function () {
          console.log("then4");
        });
        console.log("then2");
      });
    });

    new Promise(function (resolve) {
      console.log("promise1");
      resolve();
    }).then(function () {
      console.log("then1");
    });

    setTimeout(function () {
      console.log("setTimeout2");
    });

    console.log(2);

    queueMicrotask(() => {
      console.log("queueMicrotask1")
    });

    new Promise(function (resolve) {
      resolve();
    }).then(function () {
      console.log("then3");
    });

    console.log("script end")

  </script>

</body>
</html>
```

![image-20230917211523805](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230917211523805.png)

### promise async await 面试题

![image-20231106205128960](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106205128960.png)

![image-20231106205310343](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106205310343.png)

```html
//面试题一

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  
  <script>

    console.log("script start")

    function requestData(url) {
      console.log("requestData")
      return new Promise((resolve) => {
        setTimeout(() => {
          console.log("setTimeout")
          resolve(url)
        }, 2000);
      })
    }

    // 2.await/async
    async function getData() {
      console.log("getData start")
      const res = await requestData("why")
      
      console.log("then1-res:", res)
      console.log("getData end")
    }

    getData()
    
    console.log("script end")

    // script start
    // getData start
    // requestData
    // script end

    // setTimeout(await要等到有结果才执行下面代码)

    // then1-res: why
    // getData end

  </script>

</body>
</html>
```

![image-20230917211837459](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230917211837459.png)

![image-20230917212244448](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230917212244448.png)



```html
//面试题二

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>

  <script>
    async function async1 () {
      console.log('async1 start')
      await async2();
      console.log('async1 end')
    }

    async function async2 () {
      console.log('async2')
    }

    console.log('script start')

    setTimeout(function () {
      console.log('setTimeout')
    }, 0)
    
    async1();
    
    new Promise (function (resolve) {
      console.log('promise1')
      resolve();
    }).then (function () {
      console.log('promise2')
    })

    console.log('script end')

  </script>

</body>
</html>
```

![image-20231106210122205](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106210122205.png)

![image-20230917212607847](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230917212607847.png)



## Node的事件循环

### Node的架构分析

- 浏览器中的`EventLoop`是根据HTML5定义的规范来实现的，不同的浏览器可能会有不同的实现，而Node中是由`libuv`实现的。
- 这里我们来给出一个Node的架构图:
  - 我们会发现`libuv`中主要维护了一个`EventLoop`和`worker threads(线程池);`
  - `EventLoop`负责调用系统的一些其他操作:`文件的IO、Network、child-processes等`
- libuv是一个多平台的专注于`异步IO`的库，它最初是为Node开发的，但是现在也被使用到Luvit、Julia、pyuv等其他地方;

![image-20230919172541074](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230919172541074.png)



### 阻塞IO和非阻塞IO

- 如果我们希望在程序中对一个文件进行操作，那么我们就需要打开这个文件:通过`文件描述符`。
  - 我们思考:JavaScript可以直接对一个文件进行操作吗?
  - 看起来是可以的，但是事实上我们任何程序中的文件操作都是`需要进行系统调用(操作系统的文件系统);` 
  - 事实上对文件的操作，是一个操作系统的`IO操作(输入、输出);`
- `操作系统`为我们提供了`阻塞式调用`和`非阻塞式调用:`
  - `阻塞式调用`: 调用结果返回之前，当前线程处于`阻塞态(阻塞态CPU是不会分配时间片的)`，调用线程只有在得到调用结果之后才会继续执行。
  - `非阻塞式调用`: 调用执行之后，当前线程不会停止执行，只需要过一段时间来检查一下有没有结果返回即可。
- 所以我们开发中的很多耗时操作，都可以基于这样的 `非阻塞式调用`:
  - 比如网络请求本身使用了Socket通信，而Socket本身提供了select模型，可以进行非阻塞方式的工作; 
  - 比如文件读写的IO操作，我们可以使用操作系统提供的基于事件的回调机制;



### 非阻塞IO的问题

- 但是`非阻塞IO`也会存在一定的问题:我们并没有获取到需要读取(我们以读取为例)的结果
  - 那么就意味着为了可以知道是否读取到了完整的数据，我们需要频繁的去确定读取到的数据是否是完整的; 
  - 这个过程我们称之为`轮训`操作;
- 那么这个轮训的工作由谁来完成呢?
  - 如果我们的主线程频繁的去进行轮训的工作，那么必然会大大降低性能; 
  - 并且开发中我们可能不只是一个文件的读写，可能是多个文件;
  - 而且可能是多个功能:网络的IO、数据库的IO、子进程调用;
- `libuv`提供了一个`线程池(Thread Pool)`:
  - `线程池`会负责所有相关的操作，并且会通过`轮训`等方式等待结果;
  - 当`获取到结果时`，就可以`将对应的回调放到事件循环`(某一个事件队列)中;
  - 事件循环就可以负责接管后续的回调工作，告知JavaScript应用程序执行对应的回调函数;

![image-20230919203741530](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230919203741530.png)

### 阻塞和非阻塞，同步和异步的区别?

- `阻塞`和`非阻塞`，`同步`和`异步`有什么区别? 
- 阻塞和非阻塞是对于被调用者来说的;
  - 在我们这里就是`系统调用`，`操作系统`为我们提供了`阻塞调用`和`非阻塞调用`;
- `同步`和`异步`是对于`调用者`来说的;
  - 在我们这里就是自己的程序;
  - 如果我们在`发起调用`之后，不会进行其他任何的操作，`只是等待结果`，这个过程就称之为`同步调用`;
  - 如果我们再`发起调用`之后，并`不会等待结果，继续完成其他的工作`，`等到有回调时再去执行`，这个过程就是 `异步调用;`
- `Libuv`采用的就是`非阻塞异步IO`的调用方式;



### Node事件循环的阶段

- 我们最前面就强调过，`事件循环像是一个桥梁`，是连接着应用程序的`JavaScript和系统调用`之间的通道: 
  - 无论是我们的文件IO、数据库、网络IO、定时器、子进程，在完成对应的操作后，都会将对应的结果和回调函数放到事件循环(任务队列)中;
  - 事件循环会不断的从`任务队列中取出对应的事件(回调函数)`来执行;
-  但是一次完整的`事件循环Tick`分成很多个阶段:
  - `定时器(Timers)`:本阶段执行已经被 setTimeout() 和 setInterval() 的调度回调函数。
  - `待定回调(Pending Callback)`:对某些系统操作(如TCP错误类型)执行回调，比如TCP连接时接收到ECONNREFUSED。 
  - `idle, prepare`:仅系统内部使用。
  - `轮询(Poll)`:检索新的 I/O 事件;执行与 I/O 相关的回调;
  - `检测(check)`:setImmediate() 回调函数在这里执行。
  - `关闭的回调函数`:一些关闭的回调函数，如:socket.on('close', ...)。



### Node事件循环的阶段图解

![image-20230919171808183](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230919171808183.png)



### Node的宏任务和微任务

- 我们会发现从一次事件循环的Tick来说，Node的事件循环更复杂，它也分为`微任务`和`宏任务`: 
  - `宏任务(macrotask)`:setTimeout、setInterval、IO事件、setImmediate、close事件; 
  - `微任务(microtask)`:Promise的then回调、process.nextTick、queueMicrotask;
- 但是，Node中的事件循环不只是 微任务队列和 宏任务队列: 
  - 微任务队列:
    - `next tick queue`:process.nextTick;
    - `other queue`:Promise的then回调、queueMicrotask; 
  - 宏任务队列:
    - `timer queue`:setTimeout、setInterval; 
    - `poll queue`:IO事件;
    - `check queue`:setImmediate;
    - `close queue`:close事件;



### Node事件循环的顺序

- 所以，在每一次事件循环的tick中，会按照如下顺序来执行代码:

  - `next tick microtask queue`;

  - `other microtask queue;` 
  - `timer queue;`
  - `poll queue;`
  - `check queue;`

  - `close queue;`

![image-20230919210304157](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230919210304157.png)

### Node执行面试题

```js
async function async1() {
  console.log('async1 start')
  await async2()
  console.log('async1 end')
}

async function async2() {
  console.log('async2')
}

console.log('script start')

setTimeout(function () {
  console.log('setTimeout0')
}, 0)

setTimeout(function () {
  console.log('setTimeout2')
}, 300)

setImmediate(() => console.log('setImmediate'));

process.nextTick(() => console.log('nextTick1'));

async1();

process.nextTick(() => console.log('nextTick2'));

new Promise(function (resolve) {
  console.log('promise1')
  resolve();
  console.log('promise2')
}).then(function () {
  console.log('promise3')
})

console.log('script end')


// script start
// async1 start
// async2
// promise1
// promise2
// script end
// nextTick1
// nextTick2
// async1 end
//  promise3
// setTimeout0
// setImmediate
// setTimeout2
```

![image-20230919210131890](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230919210131890.png)



### setTimeout、setImmediate执行顺序分析

- 情况一: setTimeout、setImmediate
- 情况二: setImmediate、setTimeout

```js
setTimeout(() => {
  console.log("setTimeout");
}, 0);

setImmediate(() => {
  console.log("setImmediate");
});

// 问题: setTimeout setImmediate
```

#### 为什么会出现两种情况呢

- 为什么会出现不同的情况呢?
  - 在Node源码的deps/uv/src/timer.c中141行，有一个 `uv__next_timeout`的函数;
  - 这个函数决定了，`poll阶段要不要阻塞在这里`;
  - 阻塞在这里的目的是`当有异步IO被处理时，尽可能快的让代码被执行;`
- 和上面有什么关系呢?
- 情况一:如果`事件循环开启的时间(ms)是小于 setTimeout函数的执行时间的;`
  - 也就意味着先开启了`event-loop`，但是这个时候执行到timer阶段，并没有 `定时器的回调被放到入 timer queue中;`
  - 所以没有被执行，后续开启定时器和检测到有setImmediate时，就会`跳过 poll阶段，向后继续执行;`
  - 这个时候是先检测 setImmediate，第二次的tick中执行了timer中的 setTimeout;
- 情况二:如果`事件循环开启的时间(ms)是大于 setTimeout函数的执行时间的;` 
  - 这就意味着在第一次 `tick`中，`已经准备好了timer queue;`
  - 所以会`直接按照顺序执行即可;`

![image-20230919212147598](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230919212147598.png)

- 当setTime设置为0秒时，这个0秒可能不是真正意义上的0秒，可能是10ms或者20ms。在程序启动时，时间循环也需要开启时间，
- 假设为时间循环开启时间为20ms，stTime为10ms，这时setTime么已经加入到time queue中，就输入 `setTime-setImmediate` 
- 假设为时间循环开启时间为2ms，stTime为10ms，这时setTime么还没有加入到time queue中，就输入先 `setImmediate-setTime` 







# Node常用内置模块

## path

### 内置模块path

- path模块用于`对路径和文件进行处理`，提供了很多好用的方法。
- 并且我们知道在Mac OS、Linux和window上的路径时不一样的
  - window上会使用 \或者 \\ 来作为文件路径的分隔符，当然目前也支持 /; 
  - 在Mac OS、Linux的Unix操作系统上使用 / 来作为文件路径的分隔符;
- 那么如果我们在window上使用 \ 来作为分隔符开发了一个应用程序，要部署到Linux上面应该怎么办呢? 
  - 显示路径会出现一些问题;
  - 所以为了屏蔽他们之间的差异，在开发中对于路径的操作我们可以使用 `path` 模块;
- 可移植操作系统接口(英语:Portable Operating System Interface，缩写为POSIX)
  - Linux和Mac OS都实现了POSIX接口;
  - Window部分电脑实现了POSIX接口

### path常见的API

- 从路径中获取信息
  - `dirname`:获取文件的父文件夹; 
  - `basename`:获取文件名;
  - `extname`:获取文件扩展名;
- 路径的拼接
  - 如果我们希望将多个路径进行拼接，但是不同的操作系统可能使用的是不同的分隔符;
  - 这个时候我们可以使用`path.join`函数;
- 将文件和某个文件夹拼接
  - 如果我们希望将某个文件和文件夹拼接，可以使用 `path.resolve`; 
  - resolve函数会判断我们拼接的路径前面是否有 /或../或./;
  - 如果有表示是一个绝对路径，会返回对应的拼接路径;
  - 如果没有，那么会和当前执行文件所在的文件夹进行路径的拼接

```js
//路径拼接
const path = require('path');

const basePath = '/User/why';
const filename = 'abc.txt';

// const path = basePath + "/" + filename;

const filepath = path.resolve(basePath, filename);
console.log(filepath);


```

```js
const path = require('path');

// 1.获取路径的信息
// const filepath = '/User/why/abc.txt';

// console.log(path.dirname(filepath));
// console.log(path.basename(filepath));
// console.log(path.extname(filepath));

// 2.join路径拼接
const basepath = '../User/why';
const filename = './abc.txt';
const othername = './why.js';

const filepath1 = path.join(basepath, filename);
// console.log(filepath1);

// 3.resolve路径拼接
// resolve会判断拼接的路径字符串中,是否有以/或./或../开头的路径
// const filepath2 = path.resolve(basepath, filename, othername);
// console.log(filepath2);

const basepath2 = '/User/coderwhy';
// const filename2 = '/why/abc.txt'; // /why/abc.txt
// const filename2 = './why/abc.txt'; // /User/coderwhy/why/abc.txt
// const filename2 = 'why/abc.txt'; // /User/coderwhy/why/abc.txt

const filename2 = '../why/abc.txt'; // /User/coderwhy/why/abc.txt

const result = path.resolve(basepath2, filename2);
console.log(result);


```

### 在webpack中的使用

- 在webpack中获取路径或者起 `别名`的地方也可以使用

![image-20231106110312975](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106110312975.png)

## fs

- fs是File System的缩写，表示`文件系统`。
- 对于任何一个为服务器端服务的语言或者框架通常都会有自己的文件系统:
  - 因为服务器需要将各种数据、文件等放置到不同的地方;
  - 比如用户数据可能大多数是放到数据库中的(后面我们也会学习);
  - 比如某些配置文件或者用户资源(图片、音视频)都是以文件的形式存在于操作系统上的;
- Node也有自己的文件系统操作模块，就是fs:
  - 借助于Node帮我们封装的文件系统，我们可以在任何的操作系统(window、Mac OS、Linux)上面直接去操作文件;
  - 这也是Node可以开发服务器的一大原因，也是它可以成为前端自动化脚本等热门工具的原因;

![fs模块在Node服务器中作用](https://cdn.jsdelivr.net/gh/OneOneT/images@main/fs%E6%A8%A1%E5%9D%97%E5%9C%A8Node%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%B8%AD%E4%BD%9C%E7%94%A8.png)

### fs的API介绍

- Node文件系统的API非常的多:
  - https://nodejs.org/dist/latest-v14.x/docs/api/fs.html
- 但是这些API大多数都提供三种操作方式:
  - 方式一:`同步操作文件`:代码会被阻塞，不会继续执行;
  - 方式二:`异步回调函数操作文件`:代码不会被阻塞，需要传入回调函数，当获取到结果时，回调函数被执行;
  - 方式三:`异步Promise操作文件`:代码不会被阻塞，通过 fs.promises 调用方法操作，会返回一个Promise， 可以通过then、catch进行处理;

```js
//获取一个文件的状态
const fs = require('fs');

// 案例: 读取文件的信息
const filepath = "./abc.txt";

// 1.方式一: 同步操作
const info = fs.statSync(filepath);
console.log("后续需要执行的代码");
console.log(info);

// 2.方式二: 异步操作
// fs.stat(filepath, (err, info) => {
//   if (err) {
//     console.log(err);
//     return;
//   }
//   console.log(info);
//   console.log(info.isFile());
//   console.log(info.isDirectory());
// });
// console.log("后续需要执行的代码");

// 3.方式三: Promise
// fs.promises.stat(filepath).then(info => {
//   console.log(info);
// }).catch(err => {
//   console.log(err);
// });

// console.log("后续需要执行的代码");


```

### 文件描述符

- 文件描述符(File descriptors)是什么呢?
  - 在 POSIX 系统上，对于每个进程，内核都维护着一张当前打开着的文件和资源的表格。 
  - 每个打开的文件都分配了一个称为文件描述符的简单的数字标识符。
  - 在系统层，所有文件系统操作都使用这些文件描述符来标识和跟踪每个特定的文件。
  - Windows 系统使用了一个虽然不同但概念上类似的机制来跟踪资源。
- 为了简化用户的工作，Node.js 抽象出操作系统之间的特定差异，并为所有打开的文件分配一个数字型的文件描述 符。
  - `fs.open()` 方法用于分配新的文件描述符。
  - 一旦被分配，则`文件描述符可用于从文件读取数 据、向文件写入数据、或请求关于文件的信息。`

![操作系统中文件描述符](https://cdn.jsdelivr.net/gh/OneOneT/images@main/%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F%E4%B8%AD%E6%96%87%E4%BB%B6%E6%8F%8F%E8%BF%B0%E7%AC%A6.png)

```js
const fs = require('fs');

fs.open("./abc.txt", (err, fd) => {
  if (err) {
    console.log(err);
    return;
  }

  // 通过描述符去获取文件的信息
  fs.fstat(fd, (err, info) => {
    console.log(info);
  })
})


```



### 文件的读写

- 如果我们希望对文件的内容进行操作，这个时候可以使用文件的读写: 
  - `fs.readFile`(path[, options], callback):`读取文件的内容`;
  - `fs.writeFile`(file, data[, options], callback):`在文件中写入内容`;
- 在上面的代码中，你会发现有一个大括号没有填写任何的内容，这个是写入时填写的option参数: 
  - `flag`:写入的方式。
  - `encoding`:字符的编码;

```js
const fs = require('fs');


// 1.文件写入
// const content = "你好啊,李银河";

// fs.writeFile('./abc.txt', content, {flag: "a"}, err => {
//   console.log(err);
// });

// 2.文件读取
fs.readFile("./abc.txt", {encoding: 'utf-8'}, (err, data) => {
  console.log(data);
});


```

#### flag选项

- flag的值有很多:https://nodejs.org/dist/latest-v14.x/docs/api/fs.html#fs_file_system_flags 
  - `w` 打开文件写入，默认值;
  - `w+`打开文件进行读写，如果不存在则创建文件;
  - `r+` 打开文件进行读写，如果不存在那么抛出异常;
  - `r` 打开文件读取，读取时的默认值;
  - `a` 打开要写入的文件，将流放在文件末尾。如果不存在则创建文件;
  - `a+` 打开文件以进行读写，将流放在文件末尾。如果不存在则创建文件

#### encoding选项

- 我们再来看看编码:
  - 我之前在简书上写过一篇关于字符编码的文章:https://www.jianshu.com/p/899e749be47c
  - 目前基本用的都是`UTF-8编码`;
- 文件读取:
  - 如果不填写encoding，`返回的结果是Buffer`;

![image-20231106112026168](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106112026168.png)



### 文件夹操作

- 新建一个文件夹
  - 使用fs.mkdir()或fs.mkdirSync()创建一个新文件夹:
- 获取文件夹的内容 
- 文件重命名

```js
const fs = require('fs');
const path = require('path');

// 1.创建文件夹
const dirname = './why';
if (!fs.existsSync(dirname)) {
  fs.mkdir(dirname, err => {
    console.log(err);
  });
}

// 2.读取文件夹中的所有文件
// fs.readdir(dirname, (err, files) => {
//   console.log(files);
// });

// function getFiles(dirname) {
//   fs.readdir(dirname, { withFileTypes: true }, (err, files) => {
//     for (let file of files) {
//       // fs.stat(file) 可以, 但是有点麻烦
//       if (file.isDirectory()) {
//         const filepath = path.resolve(dirname, file.name);
//         getFiles(filepath);
//       } else {
//         console.log(file.name);
//       }
//     }
//   });
// }

// getFiles(dirname);

// 3.重命名
fs.rename("./why", "./kobe", err => {
  console.log(err);
})


// 3.文件夹的重命名



```



## events

### events模块

- Node中的核心API都是基于`异步事件驱动`的:
  - 在这个体系中，某些对象(发射器(Emitters))发出某一个事件;
  - 我们可以监听这个事件(监听器 Listeners)，并且传入的回 调函数，这个回调函数会在监听到事件时调用;
- 发出事件和监听事件都是通过`EventEmitter`类来完成的，它们都属 于events对象。
  - `emitter.on`(eventName, listener):`监听事件，也可以使用 addListener;`
  - `emitter.off`(eventName, listener):`移除事件监听，也可以使 用removeListener;`
  - `emitter.emit`(eventName[, ...args]):`发出事件，可以携带一 些参数;`

```js
const EventEmitter = require("events");

// 1.创建发射器
const emitter = new EventEmitter();

// 2.监听某一个事件
// addListener是on的alias简写
emitter.on('click', (args) => {
  console.log("监听1到click事件", args);
})

const listener2 = (args) => {
  console.log("监听2到click事件", args);
}
emitter.on('click', listener2)

// 3.发出一个事件
setTimeout(() => {
  emitter.emit("click", "coderwhy", "james", "kobe");
  emitter.off("click", listener2);
  emitter.emit("click", "coderwhy", "james", "kobe");
}, 2000);

```



### 常见的属性

- `EventEmitter`的实例有一些属性，可以记录一些信息:
  - `emitter.eventNames()`:返回当前 EventEmitter对象注册的事件字符串数组;
  - `emitter.getMaxListeners()`:返回当前 EventEmitter对象的最大监听器数量，可以通过setMaxListeners() 来修改，默认是10;
  - `emitter.listenerCount(事件名称)`:返回当前 EventEmitter对象某一个事件名称，监听器的个数;
  - `emitter.listeners(事件名称)`:返回当前 EventEmitter对象某个事件监听器上所有的监听器数组;

```js
const EventEmitter = require('events');

// 1.创建发射器
const emitter = new EventEmitter();

// 2.监听某一个事件
// addListener是on的alias简写
emitter.on('click', (args) => {
  console.log("监听1到click事件", args);
})

const listener2 = (args) => {
  console.log("监听2到click事件", args);
}
emitter.on('click', listener2)

emitter.on("tap", (args) => {
  console.log(args);
})

// 3.获取注册的事件
console.log(emitter.eventNames());
console.log(emitter.listenerCount("click"));
console.log(emitter.listeners("click"));


```

### 方法的补充

- `emitter.once(eventName, listener)`:事件监听一次
- `emitter.prependListener()`:将监听事件添加到最前面
- `emitter.prependOnceListener()`:将监听事件添加到最前面，但是只监听一次
- `emitter.removeAllListeners([eventName])`:移除所有的监听器

```js
const EventEmitter = require("events");

// 1.创建发射器
const emitter = new EventEmitter();

// 2.监听某一个事件
// addListener是on的alias简写
// 只执行一次
emitter.once('click', (arg1, arg2, arg3) => {
  console.log("监听1到click事件", arg1, arg2, arg3);
})

const listener2 = function(arg1, arg2, arg3) {
  // 特点: 绑定this, 也不绑定arguments数组
  console.log(arguments);
  console.log(this);
  console.log("监听2到click事件", arg1, arg2, arg3);
}

emitter.on('click', listener2)

// 将本次监听放到最前面
emitter.prependListener('click', (arg1, arg2, arg3) => {
  console.log("监听3到click事件", arg1, arg2, arg3);
})

emitter.on("scroll", (args) => {
  console.log("监听到scroll方法");
})


// 3.发出一个事件
setTimeout(() => {
  // emitter.removeAllListeners("click");
  emitter.emit("click", "coderwhy", "james", "kobe");
  emitter.emit("click", "coderwhy", "james", "kobe");
  emitter.emit("scroll", "coderwhy", "james", "kobe");
}, 2000);

console.log(arguments);
console.log(this);

```

# Buffer

## 数据的二进制

- 计算机中所有的内容:文字、数字、图片、音频、视频最终都会使用`二进制`来表示。
- JavaScript可以直接去处理非常直观的数据:比如字符串，我们通常展示给用户的也是这些内容。
- 不对啊，JavaScript不是也可以处理图片吗?
  - 事实上在网页端，图片我们一直是交给浏览器来处理的;
  - JavaScript或者HTML，只是负责告诉浏览器一个图片的地址;
  - 浏览器负责获取这个图片，并且最终讲这个图片渲染出来;
- 但是对于服务器来说是不一样的:
  - 服务器要处理的本地文件类型相对较多;
  - 比如某一个保存文本的文件并`不是使用 utf-8进行编码`的，而是用 `GBK`，那么我们必须`读取到他们的二进制数据，再通过GKB转换成对应的文字;`
  - 比如我们需要读取的是一张图片数据(二进制)，再通过某些手段对图片数据进行二次的处理(裁剪、格式转换、旋转、添加滤 镜)，Node中有一个`Sharp`的库，就是读取图片或者传入图片的`Buffer`对其再进行处理;
  - 比如在Node中通过`TCP建立长连接`，`TCP传输的是字节流，我们需要将数据转成字节再进行传入，并且需要知道传输字节的大小` (客服端需要根据大小来判断读取多少内容);

## Buffer和二进制

- 我们会发现，对于前端开发来说，通常很少会和二进制打交道，但是对于服务器端为了做很多的功能，我们必须直接去操 作其二进制的数据;
- 所以Node为了可以方便开发者完成更多功能，提供给了我们一个`类Buffer`，并且它是全局的。
- 我们前面说过，`Buffer中存储的是二进制数据`，那么到底是如何存储呢? 
  - 我们可以将`Buffer看成是一个存储二进制的数组`;
  - 这个`数组中的每一项，可以保存8位二进制:` 00000000
- 为什么是8位呢?
  - 在计算机中，很少的情况我们会直接操作一位二进制，因为一位二进制存储的数据是非常有限的; 
  - 所以通常会将8位合在一起作为一个单元，这个单元称之为一个`字节(byte);`
  - 也就是说 `1byte = 8bit`，`1kb=1024byte，` `1M=1024kb`;
  - 比如很多编程语言中的int类型是4个字节，long类型时8个字节;
  - 比如TCP传输的是字节流，在写入和读取时都需要说明字节的个数;
  - 比如RGB的值分别都是255，所以本质上在计算机中都是用一个字节存储的;

![Buffer底层存储和二进制表示](https://cdn.jsdelivr.net/gh/OneOneT/images@main/Buffer%E5%BA%95%E5%B1%82%E5%AD%98%E5%82%A8%E5%92%8C%E4%BA%8C%E8%BF%9B%E5%88%B6%E8%A1%A8%E7%A4%BA.png)



## Buffer和字符串

- `Buffer相当于是一个字节的数组`，数组中的每一项对于一个字节的大小: 
- 如果我们希望将一个字符串放入到Buffer中，是怎么样的过程呢?

![image-20231106114622625](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106114622625.png)

- 它是怎么样的过程呢?

![image-20231106114632181](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106114632181.png)

```js
const message = "Hello";

// 创建Buffer
// 0~15 0~15
// 0~f 0~f
// 00 ~ ff
// 1.创建方式一: 不推荐(过期)
// const buffer = new Buffer(message);
// console.log(buffer);

// 2.创建方式二:
const buffer = Buffer.from(message);
console.log(buffer);

```

### 中文

- 默认编码:utf-8

![image-20231106145737627](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106145737627.png)

- 如果编码和解码不同:

![image-20231106145748185](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106145748185.png)

```js
const message = "你好啊";

// 1.编解码相同
// 对中文进行编码: utf8
const buffer = Buffer.from(message);
console.log(buffer);

// // 对字节进行解码: utf8
console.log(buffer.toString());

// 2.编码使用utf16le, 解码使用utf8
const buffer2 = Buffer.from(message, "utf16le");
console.log(buffer2);
console.log(buffer2.toString("utf"));

```

## Buffer.alloc

- 来看一下Buffer.alloc:
  - 我们会发现创建了一个`8位长度的Buffer`，里面所有的数据默认为00;

![image-20231106150011345](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106150011345.png)

- 我们也可以对其进行操作

![image-20231106150028850](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106150028850.png)

```js
// 通过alloc的方式创建Buffer
const buffer = Buffer.alloc(8);
console.log(buffer);//<Buffer 00 00 00 00 00 00 00 00>

buffer[0] = 88;
buffer[1] = 0x88;
console.log(buffer);//<Buffer 58 88 00 00 00 00 00 00>

```



## Buffer和文件读取

- `文本文件`的读取:

![image-20231106150253222](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106150253222.png)

- `图片文件`的读取

![image-20231106150322953](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106150322953.png)

```js
const fs = require('fs');
const sharp = require('sharp');

// 读取文本文件
// fs.readFile("./foo.txt", (err, data) => {
//   console.log(data);
//   console.log(data.toString());
// });

// 读取图片文件
// fs.readFile("./bar.png", (err, data) => {
//   console.log(data);

//   fs.writeFile("./foo.png", data, err => {
//     console.log(err);
//   });
// });

// sharp库的使用
// sharp('./bar.png')
//   .resize(200, 200)
//   .toFile('./baz.png');

sharp('./foo.png')
  .resize(300, 300)
  .toBuffer()
  .then(data => {
    fs.writeFile('./bax.png', data, err => console.log(err));
  })

```



## Buffer的创建过程

- 事实上我们创建Buffer时，并`不会频繁的向操作系统申请内存`，它会默认先`申请一个8 * 1024个字节大小的内存， 也就是8kb`

![image-20231106150824955](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106150824955.png)



### Buffer.from源码

- 假如我们调用`Buffer.from`申请Buffer:
  - 这里我们以从字符串创建为例
  - node/lib/buffer.js:290行

![image-20231106150949787](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106150949787.png)



### fromString的源码

![image-20231106151037415](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106151037415.png)



### fromStringFast

- 接着我们查看`fromStringFast`:
  - 这里做的事情是判断剩余的长度是否还足够填充这个字符串;
  - 如果不足够，那么就要通过 createPool 创建新的空间;
  - 如果够就直接使用，但是之后要进行 poolOffset的偏移变化;
  - node/lib/buffer.js:428行

![image-20231106151206792](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106151206792.png)

![image-20231106151214201](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106151214201.png)



# Stream

## 认识Stream

- 什么是Stream（小溪、小河，在编程中通常翻译为流）呢？
  - 我们的第一反应应该是流水，源源不断的流动；
  - 程序中的流也是类似的含义，我们可以想象当我们从`一个文件中读取数据时，文件的二进制（字节）数据会源源不断的被读取到我们程序中；`
  - 而这个一连串的字节，就是我们程序中的流；
- 所以，我们可以这样理解流：
  - 是连续字节的一种表现形式和抽象概念；
  - `流应该是可读的，也是可写的；`
- 在之前学习文件的读写时，我们可以直接通过 `readFile`或者 `writeFile`方式读写文件，为什么还需要流呢？
  - 直接读写文件的方式，虽然简单，但是无法控制一些细节的操作；
  - `比如从什么位置开始读、读到什么位置、一次性读取多少个字节；`
  - `读到某个位置后，暂停读取，某个时刻恢复继续读取等等；`
  - 或者这个文件非常大，比如一个视频文件，一次性全部读取并不合适；



## 文件读写的Stream

- 事实上Node中很多对象是基于流实现的：
  - `http`模块的`Request`和`Response`对象；
- 官方文档：另外所有的流都是`EventEmitter`的实例。
- 那么在Node中都有哪些流呢？
- Node.js中有四种基本流类型：
  - `Writable`：可以向其写入数据的流（例如 fs.createWriteStream()）。
  - `Readable`：可以从中读取数据的流（例如 fs.createReadStream()）。
  - `Duplex`：同时为Readable和Writable（例如 net.Socket）。
  - `Transform`：Duplex可以在写入和读取数据时修改或转换数据的流（例如zlib.createDeflate()）。
- 这里我们通过fs的操作，讲解一下Writable、Readable



## Readable

- 之前我们读取一个文件的信息：

![image-20231106153230317](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106153230317.png)

- 这种方式是`一次性将一个文件中所有的内容都读取到程序（内存）中`，但是这种读取方式就会出现我们之前提到的很多问题：
  - `文件过大、读取的位置、结束的位置、一次读取的大小；`
- 这个时候，我们可以使用 `createReadStream`，我们来看几个参数，更多参数可以参考官网：
  - `start`：文件读取开始的位置；
  - `end`：文件读取结束的位置；
  - `highWaterMark`：一次性读取字节的长度，默认是64kb；

```js
const fs = require('fs');

// 传统的方式
// fs.readFile('./foo.txt', (err, data) => {
//   console.log(data);
// });

// 流的方式读取
const reader = fs.createReadStream("./foo.txt", {
  start: 3,
  end: 10,
  highWaterMark: 2
});

// 数据读取的过程
reader.on("data", (data) => {
  console.log(data);

  reader.pause();

  setTimeout(() => {
    reader.resume();
  }, 1000);
});

reader.on('open', () => {
  console.log("文件被打开");
})

reader.on('close', () => {
  console.log("文件被关闭");
})

```



### Readable的使用

- 创建文件的Readable

![image-20231106153635787](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106153635787.png)

- 我们如何获取到数据呢？
  - 可以通过`监听data事件`，获取读取到的数据；

![image-20231106153758128](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106153758128.png)

- 也可以做一些其他的操作：监听其他事件、暂停或者恢复

![image-20231106153821958](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106153821958.png)



## Writable

- 之前我们`写入一个文件`的方式是这样的：

![image-20231106153909603](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106153909603.png)

- 这种方式相当于`一次性将所有的内容写入到文件中`，但是这种方式也有很多问题：
  - 比如我们希望一点点写入内容，精确每次写入的位置等；
- 这个时候，我们可以使用 `createWriteStream`，我们来看几个参数，更多参数可以参考官网：
  - `flags`：默认是w，如果我们希望是追加写入，可以使用 a或者 a+；
  - `start`：写入的位置；

```js
const fs = require('fs');

// 传统的写入方式
// fs.writeFile("./bar.txt", "Hello Stream", {flag: "a"}, (err) => {
//   console.log(err);
// });

// Stream的写入方式
const writer = fs.createWriteStream('./bar.txt', {
  flags: "r+",
  start: 4
});

writer.write("你好啊", (err) => {
  if (err) {
    console.log(err);
    return;
  }
  console.log("写入成功");
});

writer.write("李银河", (err) => {
  console.log("第二次写入");
})

// writer.close();
// write("Hello World");
// close();
writer.end("Hello World");

writer.on('close', () => {
  console.log("文件被关闭");
})
```

### Writable的使用

- 我们进行一次简单的写入

![image-20231106154216309](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106154216309.png)

- 你可以监听open事件：

![image-20231106154226414](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106154226414.png)



### close的监听

- 我们会发现，我们并不能监听到 `close` 事件：
  - 这是因为`写入流在打开后是不会自动关闭的；`
  - 我们必须`手动关闭`，来告诉Node已经`写入结束`了；
  - 并且会发出一个 `finish` 事件的；
- 另外一个非常常用的方法是 `end`：end方法相当于做了两步操作： `write传入的数据和调用close方法；`

![image-20231106154507229](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106154507229.png)

![image-20231106154517098](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106154517098.png)



## pipe

- 正常情况下，我们可以`将读取到的 输入流，手动的放到 输出流中进行写入：`

![image-20231106154931633](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106154931633.png)

- 我们也可以通过`pipe`来完成这样的操作：

![image-20231106154943713](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106154943713.png)

```js
const fs = require('fs');

// 传统的写法
// fs.readFile('./bar.txt', (err, data) => {
//   fs.writeFile('./baz.txt', data, (err) => {
//     console.log(err);
//   })
// })

// Stream的写法
const reader = fs.createReadStream("./foo.txt");
const writer = fs.createWriteStream('./foz.txt');

reader.pipe(writer);
writer.close();


```



# http

## Web服务器

- 什么是Web服务器？
  - 当应用程序（客户端）需要某一个资源时，可以向一台服务器，通过`Http`请求获取到这个资源；
  - `提供资源的这个服务器，就是一个Web服务器；`
- 目前有很多开源的Web服务器：Nginx、Apache（静态）、Apache Tomcat（静态、动态）、Node.js

![image-20231106160127347](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106160127347.png)



## http模块

- 在Node中，提供web服务器的资源返回给浏览器，主要是通过`http模块`。

![image-20231106160226991](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106160226991.png)



### 创建服务器

- 创建服务器对象，我们是通过 `createServer` 来完成的
  - `http.createServer`会返回`服务器的对象`；
  - `底层`其实使用直接 `new Server` 对象。

![image-20231106160422343](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106160422343.png)

- 那么，当然，我们也可以自己来创建这个对象：

![image-20231106160437681](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106160437681.png)

- 创建`Server`时会传入一个回调函数，这个回调函数在被调用时会传入两个参数：
  - `req`：request请求对象，包含请求相关的信息；
  - `res`：response响应对象，包含我们要发送给客户端的信息；

```js
const http = require('http');

// 创建server的两种方式
const server1 = http.createServer((req, res) => {
  res.end("Server1");
});

// server1.listen(8000, () => {
//   console.log("server1启动成功~");
// });

// const server2 = http.createServer((req, res) => {
//   res.end("Server2");
// });

// const server2 = new http.Server((req, res) => {
//   res.end("Server2");
// });

// server2.listen(8001, () => {
//   console.log("server2启动成功~");
// });


// 2.监听方法的使用
server1.listen(8000, () => {
  console.log("server1启动成功~");
  // console.log(server1.address().port);
});

```



### 监听主机和端口号

- Server通过`listen`方法来`开启服务器`，并且在某一个主机和端口上监听网络请求：
  - 也就是当我们通过 `ip:port`的方式发送到我们`监听的Web服务器上时；`
  - 我们就可以对其进行相关的处理；
- `listen`函数有三个参数：
  - `端口port`: 可以不传, 系统会默认分配端, 后续项目中我们会写入到环境变量中；
  - `主机host`: 通常可以传入localhost、ip地址127.0.0.1、或者ip地址0.0.0.0，默认是0.0.0.0；
  - `localhost`：本质上是一个域名，通常情况下会被解析成127.0.0.1；
  - `127.0.0.1`：回环地址（Loop Back Address），表达的意思其实是我们`主机自己发出去的包，直接被自己接收；`
    - 正常的数据库包经常 `应用层- 传输层- 网络层- 数据链路层- 物理层` ；
    - 而`回环地址，是在网络层直接就被获取到了，是不会经常数据链路层和物理层的；`
    - 比如我们监听 127.0.0.1时，在同一个网段下的主机中，通过ip地址是不能访问的；
  - `0.0.0.0`：
    - 监听IPV4上所有的地址，再根据端口找到不同的应用程序；
    - 比如我们监听 0.0.0.0时，在同一个网段下的主机中，通过ip地址是可以访问的；
- `回调函数`：服务器启动成功时的回调函数；



## request对象

- 在`向服务器发送请求时`，我们会`携带很多信息`，比如：
  - 本次`请求的URL`，服务器需要根据不同的URL进行不同的处理；
  - 本次请求的`请求方式`，比如GET、POST请求传入的参数和处理的方式是不同的；
  - 本次`请求的headers中也会携带一些信息`，比如客户端信息、接受数据的格式、支持的编码格式等；
  - 等等...
- 这些信息，Node会帮助我们封装到一个`request的对象`中，我们可以直接来处理这个request对象：

![image-20231106162356135](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106162356135.png)

```js
const http = require('http');

// 创建一个web服务器
const server = http.createServer((req, res) => {
  // request对象中封装了客户端给我们服务器传递过来的所有信息
  console.log(req.url);
  console.log(req.method);
  console.log(req.headers);

  res.end("Hello Server");
});

// 启动服务器,并且制定端口号和主机
server.listen(8888, '0.0.0.0', () => {
  console.log("服务器启动成功~");
});

```



### URL的处理

- 客户端在发送请求时，会请求不同的数据，那么会传入不同的请求地址：
  - 比如 http://localhost:8000/login；
  - 比如 http://localhost:8000/products;
- 服务器端需要`根据不同的请求地址，作出不同的响应`：

![image-20231106162520628](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106162520628.png)

### URL的解析

- 那么如果用户发送的地址中还携带一些额外的参数呢？
  - http://localhost:8000/login?name=why&password=123;
  - 这个时候，url的值是 `/login?name=why&password=123；`
- 我们如何对它进行解析呢？使用内置模块`url`：

![image-20231106162707446](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106162707446.png)

- 但是 `query` 信息如何可以获取呢？

![image-20231106162721234](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106162721234.png)

```js
const http = require('http');
const url = require('url');
const qs = require('querystring');

// 创建一个web服务器
const server = http.createServer((req, res) => {

  // 最基本的使用方式
  // if (req.url === '/login') {
  //   res.end("欢迎回来~");
  // } else if (req.url === '/users') {
  //   res.end("用户列表~");
  // } else {
  //   res.end("错误请求, 检查~");
  // }

  // /login?username=why&password=123
  const { pathname, query } = url.parse(req.url);
  if (pathname === '/login') {
    console.log(query);//name=why&password=123
    console.log(qs.parse(query));//[Object: null prototype] { name: 'why', password: '123' }
    const { username, password } = qs.parse(query);
    console.log(username, password);//why 123
    res.end("请求结果~");
  }

  // console.log(req.url);
  // res.end("请求结果~");
});

// 启动服务器,并且制定端口号和主机
server.listen(8888, '0.0.0.0', () => {
  console.log("服务器启动成功~");
});

```



### method的处理

- 在`Restful`规范（设计风格）中，我们对于数据的增删改查应该通过不同的请求方式：
  - `GET`：查询数据；
  - `POST`：新建数据；
  - `PATCH`：更新数据；
  - `DELETE`：删除数据；
- 所以，我们可以通过判断不同的请求方式进行不同的处理。
  - 比如创建一个用户：
  - 请求接口为 /users；
  - 请求方式为 POST请求；
  - 携带数据 username和password；

```js
const http = require('http');
const url = require('url');
const qs = require('querystring');

// 创建一个web服务器
const server = http.createServer((req, res) => {

  const { pathname } = url.parse(req.url);
  if (pathname === '/login') {
    if (req.method === 'POST') {
      // 拿到body中的数据
      req.setEncoding('utf-8');
      req.on('data', (data) => {
        const {username, password} = JSON.parse(data);
        console.log(username, password);
      });

      res.end("Hello World");
    }
  }
});

server.listen(8888, '0.0.0.0', () => {
  console.log("服务器启动成功~");
});

```



### HTTP Request Header

- 在request对象的`header`中也包含很多有用的信息，客户端会默认传递过来一些信息：

![image-20231106164729058](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106164729058.png)

- `content-type`是这次`请求携带的数据的类型：`
  - `application/x-www-form-urlencoded`：表示数据被编码成以 '&' 分隔的键- 值对，同时以 '=' 分隔键和值
  - `application/json`：表示是一个json类型；
  - `text/plain`：表示是文本类型；
  - `application/xml`：表示是xml类型；
  - `multipart/form-data`：表示是上传文件；

- `content-length`：文件的大小长度
- `keep-alive`：
  - http是基于TCP协议的，但是通常在进行一次请求和响应结束后会立刻中断；
  - 在http1.0中，如果想要继续保持连接：
    - 浏览器需要在请求头中添加 connection: keep-alive；
    - 服务器需要在响应头中添加 connection:keey-alive；
    - 当客户端再次放请求时，就会使用同一个连接，直接一方中断连接；
  - 在http1.1中，所有连接默认是 connection: keep-alive的；
    - 不同的Web服务器会有不同的保持 keep-alive的时间；
    - Node中默认是5s中；
- `accept-encoding`：告知服务器，客户端支持的文件压缩格式，比如js文件可以使用gzip编码，对应.gz文件；
- `accept`：告知服务器，客户端可接受文件的格式类型；
- `user-agent`：客户端相关的信息；

```js
const http = require('http');

// 创建一个web服务器
const server = http.createServer((req, res) => {
  console.log(req.headers);

  req.on('data', (data) => {
    
  })

  res.end("Hello Server");
});

// 启动服务器,并且制定端口号和主机
server.listen(8888, '0.0.0.0', () => {
  console.log("服务器启动成功~");
});

```

## response对象

### 返回响应结果

- 如果我们希望`给客户端响应的结果数据`，可以通过两种方式：
  - `Write`方法：这种方式是直接写出数据，但是并没有关闭流；
  - `end`方法：这种方式是写出最后的数据，并且写出后会关闭流；

![image-20231106165724500](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106165724500.png)

- 如果我们没有调用 end和close，客户端将会一直等待结果：
  - 所以客户端在发送网络请求时，都会设置超时时间。

```js
const http = require('http');

// 创建一个web服务器
const server = http.createServer((req, res) => {

  // 响应结果
  res.write("响应结果一");
  res.end("Hello World");
});

// 启动服务器,并且制定端口号和主机
server.listen(8888, '0.0.0.0', () => {
  console.log("服务器启动成功~");
});

```



### 返回状态码

- `Http状态码`(Http Status Code)是用来表示Http响应状态的数字代码: 
  - Http状态码非常多，可以根据不同的情况，给客户端返回不同的状态码;
  - MDN响应码解析地址:https://developer.mozilla.org/zh-CN/docs/web/http/status

![image-20230921164028180](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230921164028180.png)

```js
const http = require('http');

// 创建一个web服务器
const server = http.createServer((req, res) => {

  // 设置状态码
  // 方式一: 直接给属性赋值
  // res.statusCode = 400;
  // 方式二: 和Head一起设置
  res.writeHead(503)

  // 响应结果
  res.write("响应结果一");
  res.end("Hello World");
});

// 启动服务器,并且制定端口号和主机
server.listen(8888, '0.0.0.0', () => {
  console.log("服务器启动成功~");
});

```

### 响应头文件

- 返回头部信息，主要有两种方式：
  - `res.setHeader`：一次写入一个头部信息；
  - `res.writeHead`：同时写入header和status；

![image-20231106170041318](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106170041318.png)

- Header设置 `Content-Type`有什么作用呢？
  - 默认客户端接收到的是`字符串`，客户端会按照自己默认的方式进行处理；

![image-20231106170121832](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106170121832.png)

```js
const http = require('http');

// 创建一个web服务器
const server = http.createServer((req, res) => {

  // 设置响应的header
  // 设置方式一:
  // res.setHeader("Content-Type", "text/plain;charset=utf8");
  res.writeHead(200, {
    "Content-Type": "text/html;charset=utf8"
  });

  // 响应结果
  res.end("<h2>Hello Server</h2>");
});

// 启动服务器,并且制定端口号和主机
server.listen(8888, '0.0.0.0', () => {
  console.log("服务器启动成功~");
});

```



## http请求

- `axios`库可以在浏览器中使用，也可以在Node中使用：
  - 在`浏览器`中，axios使用的是封装`xhr`；
  - 在`Node`中，使用的是`http内置模块`；

![01_http发送网络请求(axios在node本质)](https://cdn.jsdelivr.net/gh/OneOneT/images@main/01_http%E5%8F%91%E9%80%81%E7%BD%91%E7%BB%9C%E8%AF%B7%E6%B1%82(axios%E5%9C%A8node%E6%9C%AC%E8%B4%A8).png)

```js
const http = require('http');

// http发送get请求
// http.get('http://localhost:8888', (res) => {
//   res.on('data', (data) => {
//     console.log(data.toString());
//   });

//   res.on('end', () => {
//     console.log("获取到了所有的结果");
//   })
// })

// http发送post请求
const req = http.request({
  method: 'POST',
  hostname: 'localhost',
  port: 8888
}, (res) => {
  res.on('data', (data) => {
    console.log(data.toString());
  });

  res.on('end', () => {
    console.log("获取到了所有的结果");
  })
});

req.end();

```



## 文件上传

### 文件上传 – 错误示范

```js
const http = require('http');
const fs = require('fs');

const server = http.createServer((req, res) => {
  if (req.url === '/upload') {
    if (req.method === 'POST') {
      const fileWriter = fs.createWriteStream('./foo.png', {flags: 'a+'});
      // req.pipe(fileWriter);

      req.on('data', (data) => {
        // console.log(data);
        // fileWriter.write(data);
      });

      req.on('end', () => {
        console.log("文件上传成功~");
        res.end("文件上传成功~");
      })
    }
  }
});

server.listen(8000, () => {
  console.log("文件上传服务器开启成功~");
})

```



### 文件上传 – 正确做法

```js
const http = require('http');
const fs = require('fs');
const qs = require('querystring');

const server = http.createServer((req, res) => {
  if (req.url === '/upload') {
    if (req.method === 'POST') {
      req.setEncoding('binary');

      let body = '';
      const totalBoundary = req.headers['content-type'].split(';')[1];
      const boundary = totalBoundary.split('=')[1];

      req.on('data', (data) => {
        body += data;
      });

      req.on('end', () => {
        console.log(body);
        // 处理body
        // 1.获取image/png的位置
        const payload = qs.parse(body, "\r\n", ": ");
        const type = payload["Content-Type"];

        // 2.开始在image/png的位置进行截取
        const typeIndex = body.indexOf(type);
        const typeLength = type.length;
        let imageData = body.substring(typeIndex + typeLength);

        // 3.将中间的两个空格去掉
        imageData = imageData.replace(/^\s\s*/, '');

        // 4.将最后的boundary去掉
        imageData = imageData.substring(0, imageData.indexOf(`--${boundary}--`));

        fs.writeFile('./foo.png', imageData, 'binary', (err) => {
          res.end("文件上传成功~");
        })
      })
    }
  }
});

server.listen(8000, () => {
  console.log("文件上传服务器开启成功~");
})

```





# express

## 认识Web框架

- 前面我们已经学习了使用`http`内置模块来搭建Web服务器，为什么还要使用框架？
  - 原生http在进行很多处理时，会较为复杂；
  - 有URL判断、Method判断、参数处理、逻辑代码处理等，都需要我们自己来处理和封装；
  - 并且所有的内容都放在一起，会非常的混乱；
- 目前在Node中比较流行的Web服务器框架是express、koa；
  - 我们先来学习express，后面再学习koa，并且对他们进行对比；
- express早于koa出现，并且在Node社区中迅速流行起来：
  - 我们可以基于express快速、方便的开发自己的Web服务器；
  - 并且可以通过一些`实用工具`和`中间件`来扩展自己功能；
- `Express整个框架的核心就是中间件，理解了中间件其他一切都非常简单！`



## Express安装

- express的使用过程有两种方式：
  - 方式一：通过express提供的脚手架，直接创建一个应用的骨架；
  - 方式二：从零搭建自己的express应用结构；
- 方式一：安装express-generator



- 安装脚手架

```sh
npm install -g express-generator
```

- 创建项目

```sh
express express-demo
```

- 安装依赖

```sh
npm install
```

- 启动项目

```sh
node bin/www
```



- 方式二：从零搭建自己的express应用结构；

```sh
npm init -y
```



## Express的基本使用

- 我们来创建第一个express项目：
  - 我们会发现，之后的开发过程中，可以方便的将请求进行分离：
  - 无论是不同的URL，还是get、post等请求方式；
  - 这样的方式非常方便我们已经进行维护、扩展；
  - 当然，这只是初体验，接下来我们来探索更多的用法；
- 请求的路径中如果有一些参数，可以这样表达：
  - /users/:userId；
  - 在`request`对象中药获取可以通过 req.params.userId;
- 返回数据，我们可以方便的使用`json`：
  - res.json(数据)方式；
  - 可以支持其他的方式，可以自行查看文档；
  - https://www.expressjs.com.cn/guide/routing.html

```js
const express = require('express');

// express其实是一个函数: createApplication
// 返回app
const app = express();

// 监听默认路径
app.get('/', (req, res, next) => {
  res.end("Hello Express");
})

app.post('/', (req, res, next) => {
  
})

app.post('/login', (req, res, next) => {
  res.end("Welcome Back~");
})

// 开启监听
app.listen(8000, () => {
  console.log("express初体验服务器启动成功~");
});

```



## 客户端发送请求的方式

- 客户端传递到服务器参数的方法常见的是5种：
  - 方式一：`通过get请求中的URL的params；`
  - 方式二：`通过get请求中的URL的query；`
  - 方式三：`通过post请求中的body的json格式`
  - 方式四：`通过post请求中的body的x-www-form-urlencoded格式`
  - 方式五：`通过post请求中的form-data格式`

![01_客户端给服务器传递参数的方式总结](https://cdn.jsdelivr.net/gh/OneOneT/images@main/01_%E5%AE%A2%E6%88%B7%E7%AB%AF%E7%BB%99%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%BC%A0%E9%80%92%E5%8F%82%E6%95%B0%E7%9A%84%E6%96%B9%E5%BC%8F%E6%80%BB%E7%BB%93.png)

## params/query

- 请求地址：http://localhost:8000/login/abc/why
- 获取参数：

![image-20231107104543407](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107104543407.png)

- 请求地址：http://localhost:8000/login?username=why&password=123
- 获取参数：

![image-20231107104558565](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107104558565.png)

```js
const express = require('express');

const app = express();

app.get('/products/:id/:name', (req, res, next) => {
  console.log(req.params);
  // req.params => 在数据库中查询真实的商品数据
  res.end("商品的详情数据~");
})

app.get('/login', (req, res, next) => {
  console.log(req.query);
  res.end("用户登录成功~");
})

app.listen(8000, () => {
  console.log("普通中间件服务器启动成功~");
});


```



## 响应数据

- `end方法`
  - 类似于http中的response.end方法，用法是一致的
- `json方法`
  - json方法中可以传入很多的类型：object、array、string、boolean、number、null等，它们会被转换成json格式返回；
- `status方法`
  - 用于设置状态码；
  - 注意：这里是一个函数，而不是属性赋值；
- 更多响应的方式：https://www.expressjs.com.cn/4x/api.html#res

```js
const express = require('express');
const router = require('./routers/users');

const app = express();

app.get('/products/:id/:name', (req, res, next) => {
  console.log(req.params);
  // req.params => 在数据库中查询真实的商品数据
  res.end("商品的详情数据~");
})

app.get('/login', (req, res, next) => {
  console.log(req.query);

  // 设置响应吗
  res.status(204);

  // res.type("application/json");
  // res.end(JSON.stringify({name: "why", age: 18}));
  // res.json({name: "why", age: 18})
  // 设置内容
  res.json(["abc", "cba", "abc"]);
});

/**
 * 举个例子:
 *   请求所有的用户信息: get /users
 *   请求所有的某个用户信息: get /users/:id
 *   请求所有的某个用户信息: post /users body {username: passwod:}
 *   请求所有的某个用户信息: delete /users/:id 
 *   请求所有的某个用户信息: patch /users/:id {nickname: }
 */

app.listen(8000, () => {
  console.log("普通中间件服务器启动成功~");
});


```



## 认识中间件

- Express是一个路由和中间件的Web框架，它本身的功能非常少：
  - Express应用程序本质上是`一系列中间件函数的调用；`
- 中间件是什么呢？
  - 中间件的本质是`传递给express的一个回调函数；`
  - 这个回调函数接受三个参数：
    - `请求对象（request对象）；`
    - `响应对象（response对象）；`
    - `next函数（在express中定义的用于执行下一个中间件的函数）；`

- 中间件中可以执行哪些任务呢？
  - 执行任何代码；
  - 更改请求（request）和响应（response）对象；
  - 结束请求-响应周期（返回数据）；
  - 调用栈中的下一个中间件；
- 如果当前中间件功能`没有结束请求-响应周期，则必须调用next()将控制权传递给下一个中间件功能，否则，请求将被挂起。`

![image-20231107102558598](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107102558598.png)

![01_express的use方法实现原理](https://cdn.jsdelivr.net/gh/OneOneT/images@main/01_express%E7%9A%84use%E6%96%B9%E6%B3%95%E5%AE%9E%E7%8E%B0%E5%8E%9F%E7%90%86.png)

## 应用中间件 – 自己编写

- 那么，如何将一个中间件应用到我们的应用程序中呢？
  - express主要提供了两种方式：
    - app/router.use；
    - app/router.methods；
  - 可以是 app，也可以是router，router我们后续再学习:
  - `methods`指的是常用的请求方式，比如： app.get或app.post等；
- 我们先来学习use的用法，因为`methods的方式本质是use的特殊情况；`

### 案例一：最普通的中间件

```js
const express = require('express');

const app = express();

// 编写普通的中间件
// use注册一个中间件(回调函数)
app.use((req, res, next) => {
  console.log("注册了第01个普通的中间件~");
  next();
});

app.use((req, res, next) => {
  console.log("注册了第02个普通的中间件~");
  next();
});

app.use((req, res, next) => {
  console.log("注册了第03个普通的中间件~");
  res.end("Hello Middleware");
});

app.listen(8000, () => {
  console.log("普通中间件服务器启动成功~");
});


```



### 案例二：path匹配中间件

```js
//路径中间件
const express = require('express');

const app = express();

app.use((req, res, next) => {
  console.log("common middleware01");
  next();
})

// 路径匹配的中间件
app.use('/home', (req, res, next) => {
  console.log("home middleware 01");
});

// 中间插入了一个普通的中间件
app.use((req, res, next) => {
  console.log("common middleware02");
  next();
})

app.use('/home', (req, res, next) => {
  console.log("home middleware 02");
});

app.listen(8000, () => {
  console.log("express初体验服务器启动成功~");
});

```



### 案例三：path和method匹配中间件

```js
//路径和方法匹配的中间件

const express = require('express');

const app = express();

// 路径和方法匹配的中间件
app.use((req, res, next) => {
  console.log("common middleware01");
  next();
})

app.get('/home', (req, res, next) => {
  console.log("home path and method middleware01");
});

app.post('/login', (req, res, next) => {
  console.log("login path and method middleware01");
})

app.listen(8000, () => {
  console.log("express初体验服务器启动成功~");
});

```

### 案例四：注册多个中间件

```js
const express = require('express');

const app = express();

app.use((req, res, next) => {
  console.log("common middleware 01");
  next();
});

app.get('/home', (req, res, next) => {
  console.log("home path and method middleware 01");
  next();
})

app.get("/home", (req, res, next) => {
  console.log("home path and method middleware 02");
  next();
}, (req, res, next) => {
  console.log("home path and method middleware 03");
  next();
}, (req, res, next) => {
  console.log("home path and method middleware 04");
  res.end("home page");
});

app.listen(8000, () => {
  console.log("express初体验服务器启动成功~");
});

```



## 应用中间件 – body解析

- 并非所有的中间件都需要我们从零去编写：
  - express有内置一些帮助我们完成对request解析的中间件；
  - registry仓库中也有很多可以辅助我们开发的中间件；
- 在`客户端发送post请求时，会将数据放到body中：`
  - 客户端可以通过`json`的方式传递；
  - 也可以通过`form`表单的方式传递；

![image-20231107103826312](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107103826312.png)

```js
const express = require('express');

const app = express();

// 自己编写的json解析
// app.use((req, res, next) => {
//   if (req.headers["content-type"] === 'application/json') {
//     req.on('data', (data) => {
//       const info = JSON.parse(data.toString());
//       req.body = info;
//     })
  
//     req.on('end', () => {
//       next();
//     })
//   } else {
//     next();
//   }
// })


// 使用express提供给我们的body解析
// body-parser: express3.x 内置express框架
// body-parser: express4.x 被分离出去
// body-parser类似功能: express4.16.x 内置成函数
app.use(express.json());
// extended
// true: 那么对urlencoded进行解析时, 它使用的是第三方库: qs
// false: 那么对urlencoded进行解析时, 它使用的是Node内置模块: querystring
app.use(express.urlencoded({extended: true}));

app.post('/login', (req, res, next) => {
  console.log(req.body);
  res.end("Coderwhy, Welcome Back~");
});

app.post('/products', (req, res, next) => {
  console.log(req.body);
  res.end("Upload Product Info Success~");
});

app.listen(8000, () => {
  console.log("express初体验服务器启动成功~");
});

```

### 编写解析request body中间件

![image-20231107104045068](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107104045068.png)



### 应用中间件 – express提供

- 但是，事实上我们可以使用expres内置的中间件或者使用`body-parser`来完成：

![image-20231107104130006](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107104130006.png)

- 如果我们解析的是 `application/x-www-form-urlencoded：`

![image-20231107104155282](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107104155282.png)



## 应用中间件 – 第三方中间件

### 请求日志记录

- 如果我们希望将请求日志记录下来，那么可以使用express官网开发的第三方库：`morgan`

```js
const fs = require('fs');

const express = require('express');
const morgan = require('morgan');

const app = express();

const writerStream = fs.createWriteStream('./logs/access.log', {
  flags: "a+"
})

app.use(morgan("combined", {stream: writerStream}));

app.get('/home', (req, res, next) => {
  res.end("Hello World");
})

app.listen(8000, () => {
  console.log("express初体验服务器启动成功~");
});

```

### 上传文件

- 如果我们希望借助于multer帮助我们解析一些`form-data`中的普通数据，那么我们可以使用`any`：

![image-20231107110549940](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107110549940.png)

```js
//multer解析
const express = require('express');
const multer = require('multer');

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const upload = multer();

app.use(upload.any());

app.post('/login', (req, res, next) => {
  console.log(req.body);
  res.end("用户登录成功~")
});

app.listen(8000, () => {
  console.log("form-data解析服务器启动成功~")
});

```

- 上传文件，我们可以使用express提供的`multer`来完成：

```js
const path = require('path');

const express = require('express');
const multer = require('multer');

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

//添加后缀名
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, './uploads/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  }
})

const upload = multer({
  // dest: './uploads/'
  storage
});

app.post('/login', upload.any(), (req, res, next) => {
  console.log(req.body);
  res.end("用户登录成功~")
});

app.post('/upload', upload.array('file'), (req, res, next) => {
  console.log(req.files);
  res.end("文件上传成功~");
});

app.listen(8000, () => {
  console.log("form-data解析服务器启动成功~")
});

```



## Express的路由

- 如果我们将所有的代码逻辑都写在app中，那么app会变得越来越复杂：
  - 一方面完整的Web服务器包含非常多的处理逻辑；
  - 另一方面有些处理逻辑其实是一个整体，我们应该将它们放在一起：比如对users相关的处理
    - 获取用户列表；
    - 获取某一个用户信息；
    - 创建一个新的用户；
    - 删除一个用户；
    - 更新一个用户；
- 我们可以使用 `express.Router`来创建一个路由处理程序：
  - 一个Router实例拥有`完整的中间件和路由系统；`
  - 因此，它也被称为 `迷你应用程序（mini-app）`；

```js
/**
 * 举个例子:
 *   请求所有的用户信息: get /users
 *   请求所有的某个用户信息: get /users/:id
 *   请求所有的某个用户信息: post /users body {username: passwod:}
 *   请求所有的某个用户信息: delete /users/:id 
 *   请求所有的某个用户信息: patch /users/:id {nickname: }
 */

const express = require('express');

const router = express.Router();

router.get('/', (req, res, next) => {
  res.json(["why", "kobe", "lilei"]);
});

router.get('/:id', (req, res, next) => {
  res.json(`${req.params.id}用户的信息`);
});

router.post('/', (req, res, next) => {
  res.json("create user success~");
});

module.exports = router;

```

```js
const express = require('express');
const userRouter = require('./routers/users');
const productRouter = require('./routers/products');

const app = express();

app.use("/users", userRouter);
app.use("/products", productRouter);

app.listen(8000, () => {
  console.log("路由服务器启动成功~");
});


```



## 静态资源服务器

- 部署静态资源我们可以选择很多方式：
  - Node也可以作为`静态资源服务器`，并且express给我们提供了方便部署静态资源的方法；

```js
const express = require('express');

const app = express();

app.use(express.static('./build'));

app.listen(8000, () => {
  console.log("路由服务器启动成功~");
});

```



## 错误处理

![02_服务器返回错误信息的两种方案](https://cdn.jsdelivr.net/gh/OneOneT/images@main/02_%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%BF%94%E5%9B%9E%E9%94%99%E8%AF%AF%E4%BF%A1%E6%81%AF%E7%9A%84%E4%B8%A4%E7%A7%8D%E6%96%B9%E6%A1%88.png)

```js
const express = require('express');

const app = express();

const USERNAME_DOES_NOT_EXISTS = "USERNAME_DOES_NOT_EXISTS";
const USERNAME_ALREADY_EXISTS = "USERNAME_ALREADY_EXISTS";

app.post('/login', (req, res, next) => {
  // 加入在数据中查询用户名时, 发现不存在
  const isLogin = false;
  if (isLogin) {
    res.json("user login success~");
  } else {
    // res.type(400);
    // res.json("username does not exists~")
    next(new Error(USERNAME_DOES_NOT_EXISTS));
  }
})

app.post('/register', (req, res, next) => {
  // 加入在数据中查询用户名时, 发现不存在
  const isExists = true;
  if (!isExists) {
    res.json("user register success~");
  } else {
    // res.type(400);
    // res.json("username already exists~")
    next(new Error(USERNAME_ALREADY_EXISTS));
  }
});

app.use((err, req, res, next) => {
  let status = 400;
  let message = "";
  console.log(err.message);

  switch(err.message) {
    case USERNAME_DOES_NOT_EXISTS:
      message = "username does not exists~";
      break;
    case USERNAME_ALREADY_EXISTS:
      message = "USERNAME_ALREADY_EXISTS~"
      break;
    default: 
      message = "NOT FOUND~"
  }

  res.status(status);
  res.json({
    errCode: status,
    errMessage: message
  })
})

app.listen(8000, () => {
  console.log("路由服务器启动成功~");
});

```



# Koa



## 认识Koa

- 前面我们已经学习了express，另外一个非常流行的Node Web服务器框架就是Koa。
- Koa官方的介绍：
  - koa：next generation web framework for node.js；
  - koa：node.js的下一代web框架；
- 事实上，koa是express同一个团队开发的一个新的Web框架：
  - 目前团队的核心开发者TJ的主要精力也在维护Koa，express已经交给团队维护了；
  - Koa旨在为Web应用程序和API提供更小、更丰富和更强大的能力；
  - 相对于express`具有更强的异步处理能力`
  - Koa的核心代码只有1600+行，是一个更加轻量级的框架；
  - 我们可以根据需要安装和使用中间件；
- 事实上学习了express之后，学习koa的过程是很简单的；



## koa洋葱模型

- 两层理解含义：
  - 中间件处理代码的过程；
  - Response返回body执行；

![image-20231107152842685](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107152842685.png)

![image-20231107161059960](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107161059960.png)

- express中同步代码执行也是符合洋葱模型，但在执行异步代码时，因为express底层默认是返回普通next函数，对于异步代码不会等待有结果才执行后面的代码



## Koa初体验

- 我们来体验一下koa的Web服务器，创建一个接口。
  - koa也是通过`注册中间件来完成请求操作的；`
- koa注册的中间件提供了两个参数：
- `ctx`：上下文（Context）对象；
  - koa并没有像express一样，将req和res分开，而是将它们作为ctx的属性；
  - ctx代表一次请求的上下文对象；
  - `ctx.request`：获取请求对象；
  - `ctx.response`：获取响应对象；
- `next`：本质上是一个dispatch，类似于之前的next；
  - 后续我们学习Koa的源码，来看一下它是一个怎么样的函数；

```js
const Koa = require('koa');

const app = new Koa();

app.use((ctx, next) => {
  ctx.response.body = "Hello World";
});

app.listen(8000, () => {
  console.log("koa初体验服务器启动成功~");
});

```



## Koa中间件

- koa通过创建的`app对象`，注册中间件只能通过`use`方法：
  - Koa并没有提供methods的方式来注册中间件；
  - 也没有提供path中间件来匹配路径；
- 但是真实开发中我们如何将路径和method分离呢？
  - 方式一：`根据request自己来判断；`
  - 方式二：`使用第三方路由中间件；`

```js
const Koa = require('koa');

const app = new Koa();

// use注册中间件
app.use((ctx, next) => {
  if (ctx.request.url === '/login') {
    if (ctx.request.method === 'GET') {
      console.log("来到了这里~");
      ctx.response.body = "Login Success~";
    }
  } else {
    ctx.response.body = "other request~";
  }
});

// 没有提供下面的注册方式
// methods方式: app.get()/.post
// path方式: app.use('/home', (ctx, next) => {})
// 连续注册: app.use((ctx, next) => {
// }, (ctx, next) => {
// })

app.listen(8000, () => {
  console.log("koa初体验服务器启动成功~");
});

```



## 路由的使用

- koa官方并没有给我们提供路由的库，我们可以选择第三方库：`koa-router`

```sh
npm install @koa/router
```

- 我们可以先封装一个 user.router.js 的文件：
- 在app中将`router.routes()`注册为中间件：
- 注意：`allowedMethods`用于判断某一个method是否支持：
  - 如果我们请求 get，那么是正常的请求，因为我们有实现get；
  - 如果我们请求 put、delete、patch，那么就自动报错：Method Not Allowed，状态码：405；
  - 如果我们请求 link、copy、lock，那么久自动报错：Not Implemented，状态码：501；

```js
const Koa = require('koa');

const userRouter = require('./router/user');

const app = new Koa();

app.use((ctx, next) => {
  // ctx.response.body = "Hello World";
  next();
});

app.use(userRouter.routes());
app.use(userRouter.allowedMethods());

app.listen(8000, () => {
  console.log("koa路由服务器启动成功~");
});

```



## params/query

- 请求地址：http://localhost:8000/users/123
  - 获取`params`：

![image-20231107151524474](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107151524474.png)

- 请求地址：http://localhost:8000/login?username=why&password=123
  - 获取`query`：

![image-20231107151544341](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107151544341.png)

```js
const Koa = require('koa');

const app = new Koa();
const Router = require('koa-router');

const userRouter = new Router({prefix: '/users'});

userRouter.get('/:id', (ctx, next) => {
  console.log(ctx.request.params);
  console.log(ctx.request.query);
})

// app.use((ctx, next) => {
//   console.log(ctx.request.url);
//   console.log(ctx.request.query);
//   console.log(ctx.request.params);
//   ctx.response.body = "Hello World";
// });

app.use(userRouter.routes());

app.listen(8000, () => {
  console.log("参数处理服务器启动成功~");
});

```



## body解析

### json

- 请求地址：http://localhost:8000/login
- body是json格式：

![image-20231107153327782](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107153327782.png)

- 获取json数据：

  - 安装依赖：

    ```sh
    npm install koa-bodyparser
    ```

- 使用 `koa-bodyparser`的中间件；

![image-20231107153514722](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107153514722.png)



### x-www-form-urlencoded

- 请求地址：http://localhost:8000/login
- body是`x-www-form-urlencoded`格式：

![image-20231107153725307](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107153725307.png)

- 获取json数据：(和json是一致的)

- 安装依赖：

  ```sh
  npm install koa-bodyparser
  ```

- 使用 `koa-bodyparser`的中间件；

![image-20231107153739647](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107153739647.png)



### form-data

- 请求地址：http://localhost:8000/login
  - body是`form-data`格式

![image-20231107153853792](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107153853792.png)

- 解析body中的数据，我们需要使用`multer`

  - 安装依赖：

    ```sh
    npm install koa-multer
    ```

  - 使用 multer中间件；

![image-20231107153909198](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107153909198.png)



### Multer上传文件

![image-20231107154034320](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231107154034320.png)

```js
const Koa = require('koa');
const Router = require('koa-router');
const multer = require('koa-multer');

const app = new Koa();
const uploadRouter = new Router({prefix: '/upload'});

// const storage = multer.diskStorage({
//   destination,
//   filename,
// })

const upload = multer({
  dest: './uploads/'
});

uploadRouter.post('/avatar', upload.single('avatar'), (ctx, next) => {
  console.log(ctx.req.file);
  ctx.response.body = "上传头像成功~";
});

app.use(uploadRouter.routes());

app.listen(8000, () => {
  console.log("koa初体验服务器启动成功~");
});

```



## 数据的响应

- 输出结果：`body`将响应主体设置为以下之一：
  - string ：字符串数据
  - Buffer ：Buffer数据
  - Stream ：流数据
  - Object|| Array：对象或者数组
  - null ：不输出任何内容
  - 如果`response.status`尚未设置，Koa会自动将状态设置为200或204。
- 请求状态：`status`

```js
const Koa = require('koa');

const app = new Koa();

app.use((ctx, next) => {
  // ctx.request.query
  // ctx.query

  // 设置内容
  // ctx.response.body
  // ctx.response.body = "Hello world~"
  // ctx.response.body = {
  //   name: "coderwhy",
  //   age: 18,
  //   avatar_url: "https://abc.png"
  // };
  // 设置状态码
  // ctx.response.status = 400;
  // ctx.response.body = ["abc", "cba", "nba"];

  // ctx.response.body = "Hello World~";
  ctx.status = 404;
  ctx.body = "Hello Koa~";
});

app.listen(8000, () => {
  console.log("koa初体验服务器启动成功~");
});

```



## 静态服务器

- koa并没有内置部署相关的功能，所以我们需要使用第三方库：

```sh
npm install koa-static
```

- 部署的过程类似于express：

```js
const Koa = require('koa');
const staticAssets = require('koa-static');

const app = new Koa();

app.use(staticAssets('./build'));

app.listen(8000, () => {
  console.log("koa初体验服务器启动成功~");
});

```



## 错误处理

```js
const Koa = require('koa');

const app = new Koa();

app.use((ctx, next) => {
  const isLogin = false;
  if (!isLogin) {
    ctx.app.emit('error', new Error("您还没有登录~"), ctx);
  }
});

app.on('error', (err, ctx) => {
  ctx.status = 401;
  ctx.body = err.message;
})

app.listen(8000, () => {
  console.log("koa初体验服务器启动成功~");
});

```



## koa和express对比

- 在学习了两个框架之后，我们应该已经可以发现koa和express的区别：
- 从架构设计上来说：
- express是完整和强大的，其中帮助我们内置了非常多好用的功能；
- koa是简洁和自由的，它只包含最核心的功能，并不会对我们使用其他中间件进行任何的限制。
  - 甚至是在app中连最基本的get、post都没有给我们提供；
  - 我们需要通过自己或者路由来判断请求方式或者其他功能；
- 因为express和koa框架他们的核心其实都是`中间件`：
  - 但是他们的中间件事实上，它们的中间件的执行机制是不同的，特别是针`对某个中间件中包含异步操作时；`
  - 所以，接下来，我们再来研究一下express和koa中间件的执行顺序问题；

### 案例实现

- 我通过一个需求来演示所有的过程：

  - 假如有三个中间件会在一次请求中匹配到，并且按照顺序执行；
  - 我希望最终实现的方案是：
    - 在middleware1中，在req.message中添加一个字符串 aaa；
    - 在middleware2中，在req.message中添加一个 字符串bbb；
    - 在middleware3中，在req.message中添加一个 字符串ccc；
    - 当所有内容添加结束后，在middleware1中，通过res返回最终的结果；

- 实现方案：

  - `Express同步数据的实现；`

  ```js
  //输出：aaabbbccc
  
  const express = require('express');
  
  const app = express();
  
  const middleware1 = (req, res, next) => {
    req.message = "aaa";
    next();
    res.end(req.message);
  }
  
  const middleware2 = (req, res, next) => {
    req.message += "bbb";
    next();
  }
  
  const middleware3 = (req, res, next) => {
    req.message += "ccc";
  }
  
  app.use(middleware1, middleware2, middleware3);
  
  app.listen(8000, () => {
    console.log("服务器启动成功~");
  })
  ```

  

  - `Express异步数据的实现；`

  ```js
  //输出aaabbb
  
  const express = require('express');
  const axios = require('axios');
  
  const app = express();
  
  const middleware1 = async (req, res, next) => {
    req.message = "aaa";
    await next();
    res.end(req.message);
  }
  
  const middleware2 = async (req, res, next) => {
    req.message += "bbb";
    await next();
  }
  
  const middleware3 = async (req, res, next) => {
    const result = await axios.get('http://123.207.32.32:9001/lyric?id=167876');
    req.message += result.data.lrc.lyric;
  }
  
  app.use(middleware1, middleware2, middleware3);
  
  app.listen(8000, () => {
    console.log("服务器启动成功~");
  })
  ```

  

  - `Koa同步数据的实现`；

  ```js
  //同步跟express一样
  
  const Koa = require('koa');
  
  const app = new Koa();
  
  const middleware1 = (ctx, next) => {
    ctx.message = "aaa";
    next();
    ctx.body = ctx.message;
  }
  
  const middleware2 = (ctx, next) => {
    ctx.message += "bbb";
    next();
  }
  
  const middleware3 = (ctx, next) => {
    ctx.message += "ccc";
  }
  
  app.use(middleware1);
  app.use(middleware2);
  app.use(middleware3);
  
  app.listen(8000, () => {
    console.log("服务器启动成功~");
  })
  ```

  

  - `Koa异步数据的实现；`

  ```js
  /*
  	next()前面➕await ==》 koa源码对next函数放回的是一个promise,express中返回一个普通的函数
  	await next()会等待中间件有结果时，才执行下面的代码
  */
  
  const Koa = require('koa');
  const axios = require('axios');
  
  const app = new Koa();
  
  const middleware1 = async (ctx, next) => {
    ctx.message = "aaa";
    await next();
    next();
    ctx.body = ctx.message;
  }
  
  const middleware2 = async (ctx, next) => {
    ctx.message += "bbb";
    await next();
  }
  
  const middleware3 = async (ctx, next) => {
    const result = await axios.get('http://123.207.32.32:9001/lyric?id=167876');
    ctx.message += result.data.lrc.lyric;
  }
  
  app.use(middleware1);
  app.use(middleware2);
  app.use(middleware3);
  
  app.listen(8000, () => {
    console.log("服务器启动成功~");
  })
  ```

  



# Mysql

## 常见的数据库有哪些？

- 通常我们将数据划分成两类：`关系型数据库`和`非关系型数据库；`
- `关系型数据库`：MySQL、Oracle、DB2、SQL Server、Postgre SQL等；
  - 关系型数据库通常我们会创建很多个`二维数据表`；
  - `数据表之间相互关联`起来，形成`一对一`、`一对多`、`多对多`等关系；
  - 之后可以利用`SQL语句`在多张表中查询我们所需的数据；
- `非关系型数据库`：MongoDB、Redis、Memcached、HBse等；
  - 非关系型数据库的英文其实是Not only SQL，也简称为`NoSQL`；
  - 相当而言非关系型数据库比较简单一些，存储数据也会更加自由（甚至我们可以直接将一个复杂的`json对象`直接塞入到数据库中）；
  - NoSQL是基于`Key-Value`的对应关系，并且查询的过程中不需要经过SQL解析；
- 如何在开发中选择他们呢？具体的选择会根据不同的项目进行综合的分析，我这里给一点点建议：
  - 目前在公司进行后端开发（Node、Java、Go等），还是以`关系型数据库为主；`
  - 比较常用的用到非关系型数据库的，在爬取大量的数据进行存储时，会比较常见；



## 认识SQL语句

- 我们希望操作数据库（特别是在程序中），就需要有`和数据库沟通的语言`，这个语言就是`SQL`：
  - SQL是Structured Query Language，称之为结构化查询语言，简称SQL；
  - 使用SQL编写出来的语句，就称之为SQL语句；
  - SQL语句可以用于`对数据库进行操作；`
- 事实上，常见的关系型数据库SQL语句都是比较相似的，所以你学会了MySQL中的SQL语句，之后去操作比如Oracle或者其他关系型数据库，也是非常方便的。
- SQL语句的常用规范：
  - 通常关键字使用大写的，比如`CREATE`、`TABLE`、`SHOW`等等；
  - 一条语句结束后，需要以 `;` 结尾；
  - 如果遇到关键字作为表明或者字段名称，可以使用``包裹;

### SQL语句的分类

- 常见的SQL语句我们可以分成四类：
- `DDL`（Data Definition Language）：数据定义语言；
  - 可以通过DDL语句对数据库或者表进行：创建、删除、修改等操作；
- `DML`（Data Manipulation Language）：数据操作语言；
  - 可以通过DML语句对表进行：添加、删除、修改等操作；
- `DQL`（Data Query Language）：数据查询语言；
  - 可以通过DQL从数据库中查询记录；（重点）
- `DCL`（Data Control Language）：数据控制语言；
  - 对数据库、表格的权限进行相关访问控制操作；



## SQL的数据类型

- 我们知道不同的数据会划分为`不同的数据类型`，在数据库中也是一样：
  - MySQL支持的数据类型有：`数字类型`，`日期`和`时间类型`，`字符串`（字符和字节）类型，`空间类型`和 `JSON数据类型。`

### 数字类型

- 数字类型
- MySQL的数字类型有很多：
- `整数数字类型`：INTEGER，INT，SMALLINT，TINYINT，MEDIUMINT，BIGINT；
- `浮点数字类型`：FLOAT，DOUBLE（FLOAT是4个字节，DOUBLE是8个字节）；
- `精确数字类型`：DECIMAL，NUMERIC（DECIMAL是NUMERIC的实现形式）；

![image-20231110155246421](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231110155246421.png)



### 日期类型

- MySQL的日期类型也很多：
- `YEAR`以YYYY格式显示值
  - 范围 1901到2155，和 0000。
- `DATE`类型用于具有日期部分但没有时间部分的值：
  - DATE以格式YYYY-MM-DD显示值 ；
  - 支持的范围是 '1000-01-01' 到 '9999-12-31'；
- `DATETIME`类型用于包含日期和时间部分的值：
  - DATETIME以格式'YYYY-MM-DD hh:mm:ss'显示值；
  - 支持的范围是1000-01-01 00:00:00到9999-12-31 23:59:59;
- `TIMESTAMP`数据类型被用于同时包含日期和时间部分的值：
  - TIMESTAMP以格式'YYYY-MM-DD hh:mm:ss'显示值；
  - 但是它的范围是UTC的时间范围：'1970-01-01 00:00:01'到'2038-01-19 03:14:07';
- 另外：DATETIME或TIMESTAMP 值可以包括在高达微秒（6位）精度的后小数秒一部分（了解）
  - 比如DATETIME表示的范围可以是'1000-01-01 00:00:00.000000'到'9999-12-31 23:59:59.999999';



### 字符串类型

- MySQL的字符串类型表示方式如下：
- `CHAR`类型在创建表时为固定长度，长度可以是0到255之间的任何值；
  - 在被查询时，会删除后面的空格；
- `VARCHAR`类型的值是可变长度的字符串，长度可以指定为0到65535之间的值；
  - 在被查询时，不会删除后面的空格；
- `BINARY`和`VARBINARY` 类型用于存储二进制字符串，存储的是字节字符串；
  -  https://dev.mysql.com/doc/refman/8.0/en/binary-varbinary.html
- `BLOB`用于存储大的二进制类型；
- `TEXT`用于存储大的字符串类型；



## DDL-数据库的操作

- `查看当前数据库：`

```sql
# 查看所有的数据
SHOW DATABASES;

# 使用某一个数据
USE coderhub;

# 查看当前正在使用的数
SELECT DATABASE();
```

- `创建新的数据库：`

```sql
# 创建数据库语句
CREATE DATABASE bilibili;
CREATE DATABASE IF NOT EXISTS bilibili;
CREATE DATABASE IF NOT EXISTS bilibili
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
```

- `删除数据库：`

```sql
# 删除数据库
DROP DATABASE bilibili;
DROP DATABASE IF EXIT bilibili;
```

- `修改数据库：`

```sql
# 修改数据库的字符集和排序规则
ALTER DATABASE bilibili CHARACTER SET = utf8 COLLATE = utf8_unicode_ci;
```



## DDL-数据表的操作

### 表约束

- `主键：PRIMARY KEY`

  - 一张表中，我们为了区分`每一条记录的唯一性`，必须有一个字段是永远不会重复，并且不会为空的，这个字段我们通常会将它设置为主键：
  - 主键是表中唯一的索引；
  - 并且必须是NOT NULL的，如果没有设置 NOT NULL，那么MySQL也会隐式的设置为NOT NULL；
  - 主键也可以是多列索引，`PRIMARY KEY(key_part , ...) ，我们一般称之为 联合主键 ；`
  - 建议：开发中主键字段应该是和业务无关的，尽量不要使用业务字段来作为主键；

  

- `唯一：UNIQUE`

  - 某些字段在开发中我们希望`是唯一的，不会重复的`，比如手机号码、身份证号码等，这个字段我们可以使用UNIQUE来约束：
  - 使用UNIQUE约束的字段在表中必须是不同的；
  - UNIQUE 索引允许NULL包含的列具有多个值NULL；

  

- `不能为空：NOT NULL`

  - 某些字段我们要求用户`必须插入值，不可以为空，`这个时候我们可以使用 NOT NULL 来约束；

  

- `默认值：DEFAULT`

  - 某些字段我们希望在`没有设置值时给予一个默认值`，这个时候我们可以使用 DEFAULT来完成；

  

- `自动递增：AUTO_INCREMENT`

  - 某些字段我们希望不设置值时可以`进行递增`，比如用户的id，这个时候可以使用AUTO_INCREMENT来完成；

  

- `外键：FOREIGN KEY`

  - 将`两张表联系起来`，我们可以将products中的brand_id关联到brand中的id：
  - 如果是创建表添加外键约束，我们需要在创建表的()最后添加如下语句；

  ```sql
  FOREIGN KEY (brand_id) REFERENCES brand(id)
  ```

  - 如果是表已经创建好，额外添加外键：

  ```sql
  ALTER TABLE `products` ADD `brand_id` INT;
  ALTER TABLE `products` ADD FOREIGN KEY (brand_id) REFERENCES brand(id);
  ```

  - 现在我们可以将products中的brand_id关联到brand中的id的值：

  ```sql
  UPDATE `products` SET `brand_id` = 1 WHERE `brand` = '华为';
  UPDATE `products` SET `brand_id` = 4 WHERE `brand` = 'OPPO';
  UPDATE `products` SET `brand_id` = 3 WHERE `brand` = '苹果';
  UPDATE `products` SET `brand_id` = 2 WHERE `brand` = '小米';
  ```

- `外键存在时更新和删除数据`
- 如果我希望可以更新呢？我们需要修改`on delete`或者`on update`的值；
- 我们可以给更新或者删除时设置几个值：
  - `RESTRICT（默认属性）：`当更新或删除某个记录时，会检查该记录是否有关联的外键记录，有的话会报错的，不允许更新或删除；
  - `NO ACTION：`和RESTRICT是一致的，是在SQL标准中定义的；
  - `CASCADE`：当更新或删除某个记录时，会检查该记录是否有关联的外键记录，有的话：
    - 更新：那么会更新对应的记录；
    - 删除：那么关联的记录会被一起删除掉；
  - `SET NULL`：当更新或删除某个记录时，会检查该记录是否有关联的外键记录，有的话，将对应的值设置为NULL；

```sql
SHOW CREATE TABLE `products`;
#删除之前的外键
ALTER TABLE `products` DROP FOREIGN KEY products_ibfk_1;

ALTER TABLE `products` ADD FOREIGN KEY (brand_id) REFERENCES brand(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;
```



- 查看数据表

```sql
# 查看所有的数据表
SHOW TABLES;

# 查看某一个表结构
DESC user;
```

- 创建数据表

```sql
CREATE TABLE IF NOT EXISTS `users`(
name VARCHAR(20),
age INT,
height DOUBLE
);
```

```sql
# 创建一张表
CREATE TABLE IF NOT EXISTS `users`(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(20) NOT NULL,
age INT DEFAULT 0,
telPhone VARCHAR(20) DEFAULT '' UNIQUE NOT NULL
);
```

- 删除数据表

```sql
# 删除数据库
DROP TABLE users;
DROP TABLE IF EXISTS users;
```

- 修改表

```sql
# 1.修改表名
ALTER TABLE `moments` RENAME TO `moment`;
# 2.添加一个新的列
ALTER TABLE `moment` ADD `publishTime` DATETIME;
ALTER TABLE `moment` ADD `updateTime` DATETIME;
# 3.删除一列数据
ALTER TABLE `moment` DROP `updateTime`;
# 4.修改列的名称
ALTER TABLE `moment` CHANGE `publishTime` `publishDate` DATE;
# 5.修改列的数据类型
ALTER TABLE `moment` MODIFY `id` INT;
```



## DML

- 创建一张新的表

```sql
CREATE TABLE IF NOT EXISTS `products`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`title` VARCHAR(20),
`description` VARCHAR(200),
`price` DOUBLE,
`publishTime` DATETIME
);
```



### 插入数据

```sql
INSERT INTO `products` (`title`, `description`, `price`, `publishTime`)
VALUES ('iPhone', 'iPhone12只要998', 998.88, '2020-10-10');
INSERT INTO `products` (`title`, `description`, `price`, `publishTime`)
VALUES ('huawei', 'iPhoneP40只要888', 888.88, '2020-11-11');
```



### 删除操作

```sql
# 删除数据
# 会删除表中所有的数据
DELETE FROM `products`;
# 会删除符合条件的数据
DELETE FROM `products` WHERE `title` = 'iPhone';
```



### 修改数据

```sql
# 修改数据
# 会修改表中所有的数据
UPDATE `products` SET `title` = 'iPhone12', `price` = 1299.88;
# 会修改符合条件的数据
UPDATE `products` SET `title` = 'iPhone12', `price` = 1299.88 WHERE `title` = 'iPhone';
```

- 如果我们希望修改完数据后，直接可以显示最新的更新时间：

```sql
ALTER TABLE `products` ADD `updateTime` TIMESTAMP
DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
```



## DQL

### 基本查询

- 查询所有的数据并且显示所有的字段：

```sql
SELECT * FROM `products`;
```

- 查询title、brand、price：

```sql
SELECT title, brand, price FROM `products`;
```

- 我们也可以给字段起别名：
  - 别名一般在多张表或者给客户端返回对应的key时会使用到；

```sql
SELECT title as t, brand as b, price as p FROM `products`;
```



### where查询条件

- 在开发中，我们希望`根据条件来筛选我们的数据`，这个时候我们要使用条件查询：
  - 条件查询会使用 WEHRE查询子句；
- WHERE的比较运算符

```sql
# 查询价格小于1000的手机
SELECT * FROM `products` WHERE price < 1000;
# 查询价格大于等于2000的手机
SELECT * FROM `products` WHERE price >= 2000;
# 价格等于3399的手机
SELECT * FROM `products` WHERE price = 3399;
# 价格不等于3399的手机
SELECT * FROM `products` WHERE price != 3399;
# 查询华为品牌的手机
SELECT * FROM `products` WHERE `brand` = '华为';
```

- WHERE的逻辑运算符

```sql
# 查询品牌是华为，并且小于2000元的手机
SELECT * FROM `products` WHERE `brand` = '华为' and `price` < 2000;
SELECT * FROM `products` WHERE `brand` = '华为' && `price` < 2000;
# 查询1000到2000的手机（不包含1000和2000）
SELECT * FROM `products` WHERE price > 1000 and price < 2000;
# OR: 符合一个条件即可
# 查询所有的华为手机或者价格小于1000的手机
SELECT * FROM `products` WHERE brand = '华为' or price < 1000;
# 查询1000到2000的手机（包含1000和2000）
SELECT * FROM `products` WHERE price BETWEEN 1000 and 2000;
# 查看多个结果中的一个
SELECT * FROM `products` WHERE brand in ('华为', '小米');
```

- `模糊查询`使用`LIKE`关键字，结合两个特殊的符号：
  - `%` 表示匹配任意个的任意字符；
  - `_` 表示匹配一个的任意字符；

```sql
# 查询所有以v开头的title
SELECT * FROM `products` WHERE title LIKE 'v%';
# 查询带M的title
SELECT * FROM `products` WHERE title LIKE '%M%';
# 查询带M的title必须是第三个字符
SELECT * FROM `products` WHERE title LIKE '__M%';
```



### 查询结果排序

- 当我们查询到结果的时候，我们希望讲结果按照某种方式进行排序，这个时候使用的是ORDER BY；
- `ORDER BY`有两个常用的值：
  - `ASC`：升序排列；
  - `DESC`：降序排列；

```sql
SELECT * FROM `products` WHERE brand = '华为' or price < 1000 ORDER BY price ASC;
```



### 分页查询

- 当数据库中的数据非常多时，一次性查询到所有的结果进行显示是不太现实的：
  - 在真实开发中，我们都会要求用户传入`offset`、`limit`或者`page`等字段；
  - 它们的目的是让我们可以在数据库中进行分页查询；
  - 它的用法有[LIMIT {[offset,] row_count | row_count OFFSET offset}]

```sql
SELECT * FROM `products` LIMIT 30 OFFSET 0;
SELECT * FROM `products` LIMIT 30 OFFSET 30;
SELECT * FROM `products` LIMIT 30 OFFSET 60;
# 另外一种写法：offset, row_count
SELECT * FROM `products` LIMIT 90, 30;
```



### 聚合函数

- 聚合函数表示对 `值的集合 进行操作的 组（集合）函数。`

```sql
# 华为手机价格的平均值
SELECT AVG(price) FROM `products` WHERE brand = '华为';
# 计算所有手机的平均分
SELECT AVG(score) FROM `products`;
# 手机中最低和最高分数
SELECT MAX(score) FROM `products`;
SELECT MIN(score) FROM `products`;
# 计算总投票人数
SELECT SUM(voteCnt) FROM `products`;
# 计算所有条目的数量
SELECT COUNT(*) FROM `products`;
# 华为手机的个数
SELECT COUNT(*) FROM `products` WHERE brand = '华为';
```



### Group By

- 事实上`聚合函数`相当于默认`将所有的数据分成了一组：`
  - 我们前面使用avg还是max等，都是将所有的结果看成一组来计算的；
  - 那么如果我们希望划分多个组：比如华为、苹果、小米等手机分别的平均价格，应该怎么来做呢？
  - 这个时候我们可以使用 GROUP BY；
- `GROUP BY通常和聚合函数一起使用：`
  - 表示我们`先对数据进行分组，再对每一组数据，进行聚合函数的计算；`
- 我们现在来提一个需求：
  - 根据品牌进行分组；
  - 计算各个品牌中：商品的个数、平均价格；
  - 也包括：最高价格、最低价格、平均评分；

```sql
SELECT brand,
	COUNT(*) as count,
	ROUND(AVG(price),2) as avgPrice,
	MAX(price) as maxPrice,
	MIN(price) as minPrice,
	AVG(score) as avgScore
FROM `products` GROUP BY brand;
```

#### Group By的约束条件

- 如果我们希望给`Group By查询到的结果添加一些约束`，那么我们可以使用：`HAVING`。
- 比如：如果我们还希望筛选出平均价格在4000以下，并且平均分在7以上的品牌：

```sql
ELECT brand,
	COUNT(*) as count,
	ROUND(AVG(price),2) as avgPrice,
	MAX(price) as maxPrice,
	MIN(price) as minPrice,
	AVG(score) as avgScore
FROM `products` GROUP BY brand 
	HAVING avgPrice < 4000 and avgScore > 7;
```



### 多表查询

#### 什么是多表查询？

- 如果我们希望查询到产品的同时，显示对应的品牌相关的信息，因为`数据是存放在两张表中`，所以这个时候就需要进行多表查询。
- 如果我们直接通过查询语句希望在多张表中查询到数据，这个时候是什么效果呢？

```sql
SELECT * FROM `products`, `brand`;
```

![image-20231110162741415](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231110162741415.png)



#### 默认多表查询的结果

- 我们会发现一共有648条数据，这个数据量是如何得到的呢？
  - 第一张表的108条 * 第二张表的6条数据；
  - 也就是说第一张表中每一个条数据，都会和第二张表中的每一条数据结合一次；
  - 这个结果我们称之为 `笛卡尔乘积，`也称之为直积，表示为 `X*Y`；
- 但是事实上很多的数据是没有意义的，比如华为和苹果、小米的品牌结合起来的数据就是没有意义的，我们可不可以进行筛选呢？
  - 使用where来进行筛选；
  - 这个表示查询到笛卡尔乘积后的结果中，符合products.brand_id = brand.id条件的数据过滤出来；

```sql
SELECT * FROM `products`, `brand` WHERE `products`.brand_id = `brand`.id;
```



#### 多表之间的连接

- 事实上我们想要的效果并不是这样的，而且表中的某些特定的数据，这个时候我们可以使用 SQL JOIN 操作：
  - `左连接`
  - `右连接`
  - `内连接`
  - `全连接`

![image-20231110163212171](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231110163212171.png)

#### 左连接

- 如果我们希望获取到的是`左边所有的数据（以左表为主）：`
  - 这个时候就表示无论左边的表是否有对应的brand_id的值对应右边表的id，左边的数据都会被查询出来；
  - 这个也是开发中使用最多的情况，它的完整写法是LEFT [OUTER] JOIN，但是OUTER可以省略的；

![image-20231110164346602](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231110164346602.png)

```sql
SELECT * FROM `products` LEFT JOIN `brand` ON `products`.brand_id = `brand`.id;

SELECT * FROM `products` LEFT JOIN `brand` ON `products`.brand_id = `brand`.id
WHERE brand.id IS NULL;
```



#### 右连接

- 如果我们希望获取到的是`右边所有的数据（以由表为主）：`
  - 这个时候就表示无论左边的表中的brand_id是否有和右边表中的id对应，右边的数据都会被查询出来；
  - 右连接在开发中没有左连接常用，它的完整写法是RIGHT [OUTER] JOIN，但是OUTER可以省略的；

![image-20231110164640362](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231110164640362.png)

```sql
SELECT * FROM `products` RIGHT JOIN `brand` ON `products`.brand_id = `brand`.id;

SELECT * FROM `products` RIGHT JOIN `brand` ON `products`.brand_id = `brand`.id
WHERE products.id IS NULL;
```



#### 内连接

- 事实上内连接是表示`左边的表和右边的表都有对应的数据关联：`

  - 内连接在开发中偶尔也会有一些场景使用，看自己的场景。
  - 内连接有其他的写法：`CROSS JOIN`或者 `JOIN`都可以；

  ```sql
  SELECT * FROM `products` INNER JOIN `brand` ON `products`.brand_id = `brand`.id;
  ```

- 我们会发现它和之前的下面写法是一样的效果：

```sql
SELECT * FROM `products`, `brand` WHERE `products`.brand_id = `brand`.id;
```

- 但是他们代表的含义并不相同：
  - SQL语句一：`内连接`，代表的是在两张表连接时就会约束数据之间的关系，来决定之后查询的结果；
  - SQL语句二：`where条件`，代表的是先计算出笛卡尔乘积，在笛卡尔乘积的数据基础之上进行where条件的帅选；



#### 全连接

- SQL规范中全连接是使用`FULL JOIN`，但是MySQL中并没有对它的支持，我们需要使用 `UNION` 来实现：

![image-20231110165104627](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231110165104627.png)

```sql
(SELECT * FROM `products` LEFT JOIN `brand` ON `products`.brand_id = `brand`.id)
UNION
(SELECT * FROM `products` RIGHT JOIN `brand` ON `products`.brand_id = `brand`.id);

(SELECT * FROM `products` LEFT JOIN `brand` ON `products`.brand_id = `brand`.id WHERE `brand`.id IS NULL)
UNION
(SELECT * FROM `products` RIGHT JOIN `brand` ON `products`.brand_id = `brand`.id WHERE `products`.id IS NULL);
```



### 多对多关系

![多对多关系的表结构](https://cdn.jsdelivr.net/gh/OneOneT/images@main/%E5%A4%9A%E5%AF%B9%E5%A4%9A%E5%85%B3%E7%B3%BB%E7%9A%84%E8%A1%A8%E7%BB%93%E6%9E%84.png)



## 数据格式

### 查询数据的问题

- 查询到的结果通常是一张表，比如查询手机+品牌信息：

```sql
SELECT * FROM products LEFT JOIN brand ON products.brand_id = brand.id;
```

![image-20231110165749229](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231110165749229.png)

### 转成对象

- 但是在真实开发中，实际上红色圈起来的部分应该放入到一个对象中，那么我们可以使用下面的查询方式：
  - 这个时候我们要用 `JSON_OBJECT;`

![02_查询到的结果转化成对象类型](https://cdn.jsdelivr.net/gh/OneOneT/images@main/02_%E6%9F%A5%E8%AF%A2%E5%88%B0%E7%9A%84%E7%BB%93%E6%9E%9C%E8%BD%AC%E5%8C%96%E6%88%90%E5%AF%B9%E8%B1%A1%E7%B1%BB%E5%9E%8B.png)

```sql
SELECT products.id as id, 
			 products.title as title, 
			 products.price as price, 
			 products.score as score,
			JSON_OBJECT('id', brand.id, 'name', brand.name, 'rank', brand.phoneRank, 'website', brand.website) as brand
FROM products 
LEFT JOIN brand 
ON products.brand_id = brand.id;
```

![image-20231110170006382](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231110170006382.png)



### 多对多转成数组

- 在多对多关系中，我们希望查询到的是一个数组：
  - 比如一个学生的多门课程信息，应该是放到一个数组中的；
  - 数组中存放的是课程信息的一个个对象；
  - 这个时候我们要 `JSON_ARRAYAGG`和`JSON_OBJECT`结合来使用；

![03_查询到的结果转化成数组类型](https://cdn.jsdelivr.net/gh/OneOneT/images@main/03_%E6%9F%A5%E8%AF%A2%E5%88%B0%E7%9A%84%E7%BB%93%E6%9E%9C%E8%BD%AC%E5%8C%96%E6%88%90%E6%95%B0%E7%BB%84%E7%B1%BB%E5%9E%8B.png)

```sql
SELECT stu.id, 
			 stu.name, 
			 stu.age,
			 JSON_ARRAYAGG(JSON_OBJECT('id', cs.id, 'name', cs.name)) as courses
FROM students stu
LEFT JOIN students_select_courses ssc ON stu.id = ssc.student_id
LEFT JOIN courses cs ON ssc.course_id = cs.id
GROUP BY stu.id;
```

![image-20231110170122910](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231110170122910.png)



# mysql2库

## 认识mysql2

- 前面我们所有的操作都是在GUI工具中，通过执行SQL语句来获取结果的，那真实开发中肯定是通过代码来完成所有的操作的。
- 那么如何可以`在Node的代码中执行SQL语句来`，这里我们可以借助于两个库：
  - `mysql`：最早的Node连接MySQL的数据库驱动；
  - `mysql2`：在mysql的基础之上，进行了很多的优化、改进；
- 目前相对来说，我更偏向于使用mysql2，mysql2兼容mysql的API，并且提供了一些附加功能
  - `更快/更好的性能；`
  - `Prepared Statement（预编译语句）：`
    - 提高性能：将创建的语句模块发送给MySQL，然后MySQL编译（解析、优化、转换）语句模块，并且存储它但是不执行，之后我们在真正执行时会给?提供实际的参数才会执行；就算多次执行，也只会编译一次，所以性能是更高的；
    - 防止SQL注入：之后传入的值不会像模块引擎那样就编译，那么一些SQL注入的内容不会被执行；or 1 = 1不会被执行；
  - `支持Promise`，所以我们可以使用async和await语法
  - 等等....

## 使用mysql2

- mysql2的使用过程如下：
  - 第一步：`创建连接（通过createConnection），并且获取连接对象；`
  - 第二步：`执行SQL语句即可（通过query）；`

```js
const mysql = require('mysql2')

// 1.创建一个连接(连接上数据库)
const connection = mysql.createConnection({
  host: 'localhost',
  port: 3306,
  database: 'music_db',
  user: 'root',
  password: 'Coderwhy123.'
})


// 2.执行操作语句, 操作数据库
const statement = 'SELECT * FROM `students`;'
// structure query language: DDL/DML/DQL/DCL
connection.query(statement, (err, values, fields) => {
  if (err) {
    console.log('查询失败:', err)
    return
  }

  // 查看结果
  console.log(values)
  // console.log(fields)
})

```





## Prepared Statement

- Prepared Statement（预编译语句）：
  - 提高性能：将创建的语句模块发送给MySQL，然后MySQL编译（解析、优化、转换）语句模块，并且存储它但是不执行，之后我们在真正执行时会给?提供实际的参数才会执行；就算多次执行，也只会编译一次，所以性能是更高的；
  - 防止SQL注入：之后传入的值不会像模块引擎那样就编译，那么一些SQL注入的内容不会被执行；or 1 = 1不会被执行；

![04_mysql执行过程预处理语句的性能优化](https://cdn.jsdelivr.net/gh/OneOneT/images@main/04_mysql%E6%89%A7%E8%A1%8C%E8%BF%87%E7%A8%8B%E9%A2%84%E5%A4%84%E7%90%86%E8%AF%AD%E5%8F%A5%E7%9A%84%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96.png)

![05_mysql执行预处理语句-防止SQL注入](https://cdn.jsdelivr.net/gh/OneOneT/images@main/05_mysql%E6%89%A7%E8%A1%8C%E9%A2%84%E5%A4%84%E7%90%86%E8%AF%AD%E5%8F%A5-%E9%98%B2%E6%AD%A2SQL%E6%B3%A8%E5%85%A5.png)

```sql
const mysql = require('mysql2')

// 1.创建一个连接
const connection = mysql.createConnection({
  host: 'localhost',
  port: 3306,
  database: 'music_db',
  user: 'root',
  password: 'Coderwhy123.'
})

// 2.执行一个SQL语句: 预处理语句
const statement = 'SELECT * FROM `products` WHERE price > ? AND score > ?;'
connection.execute(statement, [1000, 8], (err, values) => {
  console.log(values)
})

// connection.destroy()

```



## Connection Pools

- 前面我们是创建了一个连接（connection），但是如果我们有多个请求的话，该连接很有可能正在被占用，那么我们是否需要每次一个请求都去创建一个新的连接呢？
  - 事实上，mysql2给我们提供了连接池（connection pools）；
  - 连接池可以在`需要的时候自动创建连接，并且创建的连接不会被销毁，会放到连接池中，后续可以继续使用；`
  - 我们可以在创建连接池的时候设置LIMIT，也就是最大创建个数；

```js
const mysql = require('mysql2')

// 1.创建一个连接
const connectionPool = mysql.createPool({
  host: 'localhost',
  port: 3306,
  database: 'music_db',
  user: 'root',
  password: 'Coderwhy123.',
  connectionLimit: 5
})

// 2.执行一个SQL语句: 预处理语句
const statement = 'SELECT * FROM `products` WHERE price > ? AND score > ?;'
connectionPool.execute(statement, [1000, 8], (err, values) => {
  console.log(values)
})


```



## Promise方式

```js
const mysql = require('mysql2')

// 1.创建一个连接
const connectionPool = mysql.createPool({
  host: 'localhost',
  port: 3306,
  database: 'music_db',
  user: 'root',
  password: 'Coderwhy123.',
  connectionLimit: 5
})

// 2.执行一个SQL语句: 预处理语句
const statement = 'SELECT * FROM `products` WHERE price > ? AND score > ?;'

connectionPool.promise().execute(statement, [1000, 9]).then((res) => {
  const [values, fields] = res
  console.log('-------------------values------------------')
  console.log(values)
  console.log('-------------------fields------------------')
  console.log(fields)
}).catch(err => {
  console.log(err)
})

```



# 跨域

## 什么是跨域

- 要想理解跨域，要先理解浏览器的同源策略:
  - `同源策略`是一个重要的安全策略，它用于限制一个`origin`的文档或者它加载的脚本如何能`与另一个源的资源进行交互`。它能帮助阻隔恶意文档，`减少可能被攻击的媒介。`
  - 如果两个 URL 的 `protocol`、`port` (en-US) (如果有指定的话) 和 `host` 都相同的话，则这两个 URL 是`同源`。
  - 这个方案也被称为“`协议/主机/端口元组`”，或者直接是“元组”。
- 事实上跨域的产生和`前端分离`的发展有很大的关系:
  - 早期的服务器端渲染的时候，是没有跨域的问题的;
  - 但是随着前后端的分离，目前`前端开发的代码和服务器开发的API接口往往是分离的`，甚至`部署在不同的服务器上的;`
- 这个时候我们就会发现，访问 `静态资源服务器` 和 `API接口服务器` 很有可能`不是同一个服务器或者不是同一个端口`。 
  - 浏览器发现静态资源和API接口(XHR、Fetch)`请求不是来自同一个地方时(同源策略)`，就产生了`跨域。`
- 所以，在静态资源服务器和API服务器(其他资源类同)是同一台服务器时，是没有跨域问题的。
- 前端我们学习了很多服务器开发的知识，接下来，我们就可以演示一下跨域产生和不产生的项目部署区别了。

![image-20231104105555238](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231104105555238.png)

![image-20231104110137602](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231104110137602.png)

## 跨域的解决方案总结

- 跨域常见的解决方案：
  - 方案一：`静态资源和API服务器部署在同一个服务器中；`
  - 方案二：`CORS， 即是指跨域资源共享；`
  - 方案三：`node代理服务器（webpack中就是它）；`
  - 方案四：`Nginx反向代理；`
- 不常见的方案：
  - `jsonp`：现在很少使用了（曾经流行过一段时间）；
  - `postMessage`：有兴趣了解一下吧；
  - `websocket`：为了解决跨域，所有的接口都变成socket通信？
  - …..



### 跨域解决方案一: 静态资源和API服务器部署在同一个服务器中

![image-20231106090454457](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106090454457.png)



### 跨域解决方案二: CORS

- `跨源资源共享`（CORS， Cross-Origin Resource Sharing跨域资源共享）：
  - 它是一种基于`http header`的机制；
  - 该机制通过`允许服务器标示除了它自己以外的其它源（域、协议和端口），使得浏览器允许这些 origin 访问加载自己的资源。`
- 浏览器将 CORS 请求分成两类：`简单请求`和`非简单请求。`
- 只要同时满足以下两大条件，就属于简单请求（不满足就属于非简单请求）（了解即可）。
- 请求方法是以下是三种方法之一：
  - HEAD
  - GET
  - POST
- HTTP 的头信息不超出以下几种字段：
  - Accept
  - Accept-Language
  - Content-Language
  - Last-Event-ID
  - Content-Type：只限于三个值 application/x-www-form-urlencoded、multipart/form-data、text/plain

![image-20231104112803649](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231104112803649.png)

![image-20231106090946073](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106090946073.png)

```js
const Koa = require('koa')
const KoaRouter = require('@koa/router')
const static = require('koa-static')

const app = new Koa()

app.use(static('./client'))

// 中间件
// app.use(async (ctx, next) => {
//   // 1.允许简单请求开启CORS
//   ctx.set("Access-Control-Allow-Origin", "*")
//   // 2.非简单请求开启下面的设置
//   ctx.set("Access-Control-Allow-Headers", "Accept, AcceptEncoding, Connection, Host, Origin")
//   ctx.set("Access-Control-Allow-Credentials", true) // cookie
//   ctx.set("Access-Control-Allow-Methods", "PUT, POST, GET, DELETE, PATCH, OPTIONS")
//   // 3.发起的是一个options请求
//   if (ctx.method === 'OPTIONS') {
//     ctx.status = 204
//   } else {
//     await next()
//   }
// })

const userRouter = new KoaRouter({ prefix: '/users' })
userRouter.get('/list', (ctx, next) => {
  ctx.body = [
    { id: 111, name: "why", age: 18 },
    { id: 112, name: "kobe", age: 18 },
    { id: 113, name: "james", age: 25 },
    { id: 114, name: "curry", age: 30 },
  ]
})
app.use(userRouter.routes())
app.use(userRouter.allowedMethods())

app.listen(8000, () => {
  console.log('koa服务器启动成功~')
})

```



### 跨域解决方案三: Node代理服务器

![image-20231104114031737](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231104114031737.png)

![image-20231106091606002](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106091606002.png)

```shell
npm i http-proxy-middleware
```

```js
// node服务器代理
// webpack => webpack-dev-server
const express = require('express')
const { createProxyMiddleware } = require('http-proxy-middleware')

const app = express()

app.use(express.static('./client'))

app.use('/api', createProxyMiddleware({
  target: "http://localhost:8000",
  pathRewrite: {
    '^/api': ''
  }
}))

app.listen(9000, () => {
  console.log('express proxy服务器开启成功')
})

```

#### webpack解决跨域

- 在开发阶段， `webpack-dev-server` 会启动一个本地开发服务器，所以我们的应用在开发阶段是独立运行在 `localhost`的一个端口上，而后端服务又是运行在另外一个地址上
- 所以在开发阶段中，由于`浏览器同源策略`的原因，当本地访问后端就会出现跨域请求的问题
- 通过设置`webpack proxy`实现代理请求后，相当于`浏览器与服务端中添加一个代理者`
- 当本地发送请求的时候，代理服务器响应该请求，并将请求转发到目标服务器，目标服务器响应数据后再将数据返回给代理服务器，最终再由代理服务器将数据响应给本地

![image-20231106095226372](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106095226372.png)

- 在代理服务器传递数据给本地浏览器的过程中，两者同源，并不存在跨域行为，这时候浏览器就能正常接收数据
- 注意：`服务器与服务器之间请求数据并不会存在跨域行为，跨域行为是浏览器安全策略限制`





### 跨域解决方案四 – Nginx反向代理

- Nginx反向代理
- 下载Nginx地址：https://nginx.org/en/download.html

![image-20231104115217987](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231104115217987.png)

![image-20231106091829720](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231106091829720.png)



# cookie/token

## 为什么需要登录凭证呢？

- web开发中，我们使用最多的协议是http，但是`http是一个无状态的协议。`
  - 无状态的协议？什么叫做无状态协议呢？
- 举个例子：
  - 我们登录了一个网站 www.coderhub.com;
  - 登录的时候我们需要输入用户名和密码：比如用户名coderwhy，密码：Coderwhy666.;
  - 登录成功之后，我们要`以coderwhy的身份去访问其他的数据和资源，还是通过http请求去访问。`
    - coderhub的服务器会问：你谁呀？
    - coderwhy说：我是coderwhy呀，刚刚登录过呀；
    - coderhub：怎么证明你刚刚登录过呀？
    - coderwhy说：这。。。，http没有告诉你吗？
    - coderhub：`http的每次请求对我来说都是一个单独的请求，和之前请求过什么没有关系。`
- 看到了吧？这就是http的无状态，也就是服务器不知道你上一步做了什么，我们必须得有一个办法可以证明我们登录过。

## cookie

### 认识cookie

- Cookie（复数形态Cookies），又称为“小甜饼”。类型为“`小型文本文件`”，`某些网站为了辨别用户身份而存储在用户本地终端（Client Side）上的数据。`
  - 浏览器会在特定的情况下携带上`cookie`来发送请求，我们可以`通过cookie来获取一些信息；`
- Cookie总是保存在`客户端中`，按在客户端中的存储位置，Cookie可以分为`内存Cookie`和`硬盘Cookie`。
  - `内存Cookie`由浏览器维护，保存在内存中，浏览器关闭时Cookie就会消失，其存在时间是短暂的；
  - `硬盘Cookie`保存在硬盘中，有一个过期时间，用户手动清理或者过期时间到时，才会被清理；
- 如果判断一个cookie是内存cookie还是硬盘cookie呢？
  - 没有设置过期时间，默认情况下cookie是内存cookie，在关闭浏览器时会自动删除；
  - 有设置过期时间，并且过期时间不为0或者负数的cookie，是硬盘cookie，需要手动或者到期时，才会删除；

### cookie常见的属性

- cookie的生命周期：
- 默认情况下的cookie是`内存cookie`，也称之为`会话cookie`，也就是在浏览器关闭时会自动被删除；
- 我们可以通过设置`expires` 或者`max-age` 来设置过期的时间；
  - `expires`：设置的是Date.toUTCString()，设置格式是;expires=date-in-GMTString-format；
  - `max-age`：设置过期的秒钟，;max-age=max-age-in-seconds (例如一年为60 * 60 * 24 * 365)；
- cookie的作用域：（允许cookie发送给哪些URL）
- `Domain`：指定哪些主机可以接受cookie
  - 如果不指定，那么默认是 origin，不包括子域名。
  - 如果指定Domain，则包含子域名。例如，如果设置 Domain=mozilla.org，则 Cookie 也包含在子域名中（如developer.mozilla.org）。
- `Path`：指定主机下哪些路径可以接受cookie
  - 例如，设置 Path=/docs，则以下地址都会匹配：
    - /docs
    - /docs/Web/
    - /docs/Web/HTTP





### 客户端设置cookie

- js直接设置和获取cookie：

![image-20231110101539630](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231110101539630.png)

- 这个cookie会在会话关闭时被删除掉；

![image-20231110101549093](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231110101549093.png)

- 设置cookie，同时设置过期时间（默认单位是秒钟）

![image-20231110101556835](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231110101556835.png)

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  <h2>客户端的网站</h2>

  <button>设置cookie</button>

  <script>
    const btnEl = document.querySelector('button')
    btnEl.onclick = function() {
      // 在浏览器中通过js设置cookie(在开发中很少使用)
      // 没有设置max-age时, 是一个内存cookie, 浏览器关闭时会消失
      // 设置max-age时, 是一个硬盘cookie, 只能等到过期时间到达的时候, 才会销毁
      document.cookie = "name=why;max-age=30;"
      document.cookie = "age=18;max-age=60;"
    }
  </script>
</body>
</html>
```



### 服务器设置cookie

```js
const Koa = require('koa')
const KoaRouter = require('@koa/router')

const app = new Koa()

const userRouter = new KoaRouter({ prefix: '/users' })

/**
 * 1.服务器设置cookie
 * 2.客户端(浏览器)保存cookie
 * 3.在同一个作用域下访问服务器, 自动携带cookie
 * 4.服务器验证客户端携带的cookie
 */
userRouter.get('/login', (ctx, next) => {
  // 在服务器中为登录的客户端, 设置一个cookie
  ctx.cookies.set('slogan', 'ikun', {
    maxAge: 60 * 1000 * 5
  })

  ctx.body = '登录成功~'
})

userRouter.get('/list', (ctx, next) => {
  // 验证用户的登录凭证: 携带口号 ikun
  const value = ctx.cookies.get('slogan')
  console.log(value)
  if (value === 'ikun') {
    ctx.body = `user list data~`
  } else {
    ctx.body = `没有权限访问用户列表, 请先登录~`
  }
})

app.use(userRouter.routes())
app.use(userRouter.allowedMethods())

app.listen(8000, () => {
  console.log('服务器启动成功~')
})

```



### Session是基于cookie实现机制

```js
const Koa = require('koa')
const KoaRouter = require('@koa/router')
const koaSession = require('koa-session')

const app = new Koa()

const userRouter = new KoaRouter({ prefix: '/users' })

const session = koaSession({
  key: 'sessionid',
  signed: true,
  maxAge: 60 * 1000 * 5,
  // httpOnly: true
}, app)
// 加盐操作
app.keys = ['aaa', 'bbb', 'why', 'kobe']

app.use(session)

userRouter.get('/login', (ctx, next) => {
  // 在服务器中为登录的客户端, 设置一个cookie
  ctx.session.slogan = 'ikun'

  ctx.body = '登录成功~'
})

userRouter.get('/list', (ctx, next) => {
  // 验证用户的登录凭证: 携带口号 ikun
  const value = ctx.session.slogan
  console.log(value)
  if (value === 'ikun') {
    ctx.body = `user list data~`
  } else {
    ctx.body = `没有权限访问用户列表, 请先登录~`
  }
})

app.use(userRouter.routes())
app.use(userRouter.allowedMethods())

app.listen(8000, () => {
  console.log('服务器启动成功~')
})

```



## token

### 认识token

- cookie和session的方式有很多的缺点：
  - `Cookie会被附加在每个HTTP请求中`，所以无形中增加了流量（事实上某些请求是不需要的）；
  - Cookie是`明文传递`的，所以存在安全性的问题；
  - Cookie的`大小限制`是4KB，对于复杂的需求来说是不够的；
  - 对于`浏览器外的其他客户端`（比如iOS、Android），`必须手动的设置cookie和session`；
  - 对于`分布式系统和服务器集群`中`如何可以保证其他系统也可以正确的解析session？`
- 所以，在目前的前后端分离的开发过程中，使用token来进行身份验证的是最多的情况：
  - token可以翻译为令牌；
  - 也就是在`验证了用户账号和密码正确的情况，给用户颁发一个令牌；`
  - 这个令牌作为后续用户`访问一些接口或者资源的凭证；`
  - 我们可以根据这个`凭证来判断用户是否有权限来访问；`
- 所以token的使用应该分成两个重要的步骤：
  - `生成token`：登录的时候，颁发token；
  - `验证token`：访问某些资源或者接口时，验证token；



### JWT实现Token机制

- JWT生成的Token由三部分组成：
- `header`
  - `alg`：采用的加密算法，默认是 HMAC SHA256（`HS256`），`采用同一个密钥进行加密和解密`；
  - `typ`：JWT，固定值，通常都写成JWT即可；
  - 会通过base64Url算法进行编码；
- `payload`
  - 携带的数据，比如我们可以将用户的id和name放到payload中；
  - 默认也会携带`iat`（issued at），令牌的`签发时间`；
  - 我们也可以设置`过期时间`：`exp`（expiration time）；
  - 会通过base64Url算法进行编码
- `signature`
  - 设置一个`secretKey`，通过将`前两个的结果合并后进行HMACSHA256的算法`；
  - HMACSHA256(base64Url(header)+.+base64Url(payload), secretKey);
  - 但是如果secretKey暴露是一件非常危险的事情，因为之后就可以模拟颁发token，也可以解密token；

![image-20231110104929790](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231110104929790.png)



### Token的使用

- 在真实开发中，我们可以直接使用一个库来完成： `jsonwebtoken`；

![image-20231110105125438](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20231110105125438.png)

```js
const Koa = require('koa')
const KoaRouter = require('@koa/router')
const jwt = require('jsonwebtoken')

const app = new Koa()

const userRouter = new KoaRouter({ prefix: '/users' })

const secretkey = 'aaabbbccxxxx'

userRouter.get('/login', (ctx, next) => {
  // 1.颁发token
  const payload = { id: 111, name: 'why' }
  const token = jwt.sign(payload, secretkey, {
    expiresIn: 60
  })

  ctx.body = {
    code: 0,
    token,
    message: '登录成功, 可以进行其他的操作'
  }
})

userRouter.get('/list', (ctx, next) => {
  // 1.获取客户端携带过来的token
  const authorization = ctx.headers.authorization
  const token = authorization.replace('Bearer ', '')
  console.log(token)

  // 2.验证token
  try {
    const result = jwt.verify(token, secretkey)
    
    ctx.body = {
      code: 0,
      data: [
        { id: 111, name: 'why' },
        { id: 111, name: 'why' },
        { id: 111, name: 'why' },
      ]
    }
  } catch (error) {
    ctx.body = {
      code: -1010,
      message: 'token过期或者无效的token~'
    }
  }
})

app.use(userRouter.routes())
app.use(userRouter.allowedMethods())

app.listen(8000, () => {
  console.log('服务器启动成功~')
})

```



### 非对称加密

- 前面我们说过，`HS256`加密算法一单密钥暴露就是非常危险的事情：
  - 比如在分布式系统中，每一个子系统都需要获取到密钥；
  - 那么拿到这个密钥后这个子系统既可以发布另外，也可以验证令牌；
  - 但是对于一些资源服务器来说，它们只需要有验证令牌的能力就可以了；
- 这个时候我们可以使用非对称加密，`RS256`：
  - `私钥（private key）`：用于发布令牌；
  - `公钥（public key）`：用于验证令牌；
- 我们可以使用`openssl`来生成一对私钥和公钥：
  - Mac直接使用terminal终端即可；
  - Windows默认的cmd终端是不能直接使用的，建议直接使用git bash终端；

```sh
openssl
> genrsa -out private.key 2048
> rsa -in private.key -pubout -out public.key
```



### 使用公钥和私钥签发和验证签名

```js
const fs = require('fs')
const Koa = require('koa')
const KoaRouter = require('@koa/router')
const jwt = require('jsonwebtoken')

const app = new Koa()

const userRouter = new KoaRouter({ prefix: '/users' })

const privateKey = fs.readFileSync('./keys/private.key')
const publicKey = fs.readFileSync('./keys/public.key')

userRouter.get('/login', (ctx, next) => {
  // 1.颁发token
  const payload = { id: 111, name: 'why' }
  const token = jwt.sign(payload, privateKey, {
    expiresIn: 60,
    algorithm: 'RS256'
  })

  ctx.body = {
    code: 0,
    token,
    message: '登录成功, 可以进行其他的操作'
  }
})

userRouter.get('/list', (ctx, next) => {
  // 1.获取客户端携带过来的token
  const authorization = ctx.headers.authorization
  const token = authorization.replace('Bearer ', '')
  console.log(token)

  // 2.验证token
  try {
    const result = jwt.verify(token, publicKey, {
      algorithms: ['RS256']
    })
    
    ctx.body = {
      code: 0,
      data: [
        { id: 111, name: 'why' },
        { id: 111, name: 'why' },
        { id: 111, name: 'why' },
      ]
    }
  } catch (error) {
    console.log(error)
    ctx.body = {
      code: -1010,
      message: 'token过期或者无效的token~'
    }
  }
})

app.use(userRouter.routes())
app.use(userRouter.allowedMethods())

app.listen(8000, () => {
  console.log('服务器启动成功~')
})

```

