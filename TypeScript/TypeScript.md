#  TypeScript

## 认识TypeScript

- 虽然我们已经知道`TypeScript`是干什么的，也知道它解决了什么样的问题，但是我们还是需要全面的来认识一下TypeScript到底是什么?
- 我们来看一下TypeScript在GitHub和官方上对自己的定义:
  - GitHub说法:TypeScript is a superset of JavaScript that compiles to clean JavaScript output.
  - TypeScript官网:TypeScript is a typed superset of JavaScript that compiles to plain JavaScript.
  - 翻译一下:`TypeScript`是拥有`类型的JavaScript超集`，它可以编译成普通、干净、完整的JavaScript代码。
- 怎么理解上面的话呢?
  - 我们可以将`TypeScript理解成加强版的JavaScript`。
  - `JavaScript所拥有的特性，TypeScript全部都是支持的，并且它紧随ECMAScript的标准，所以ES6、ES7、ES8等新语法标准，它都是支持的;`
  - TypeScript在实现新特性的同时，总是保持和ES标准的同步甚至是领先;
  - 并且在语言层面上`，不仅仅增加了类型约束，而且包括一些语法的扩展`，比如枚举类型(Enum)、元组类型(Tuple)等;
  - 并且`TypeScript最终会被编译成JavaScript代码`，所以你并不需要担心它的兼容性问题，在编译时也可以不借助于Babel这样的工具;
- 所以，我们可以把TypeScript理解成更加强大的JavaScript，不仅让JavaScript更加安全，而且给它带来了诸多好用的好用特性;

## TypeScript编译环境

- 在前面我们提到过，`TypeScript最终会被编译成JavaScript来运行`，所以我们需要搭建对应的环境:
- 我们需要在电脑上安装TypeScript，这样就可以通过TypeScript的Compiler将其编译成JavaScript;
- 所以，我们需要先可以先进行全局的安装: # 
  - 安装命令

```shell
npm install typescript -g
```

- 查看版本

```shell
tsc --version
```

## TypeScript运行环境

- 如果我们每次为了查看TypeScript代码的运行效果，都通过经过两个步骤的话就太繁琐了: 
  - 第一步:通过`tsc`编译TypeScript到JavaScript代码;
  - 第二步:在浏览器或者`Node`环境下运行JavaScript代码;

- 是否可以简化这样的步骤呢?
  - 比如编写了TypeScript之后可以直接运行在浏览器上?
  - 比如编写了TypeScript之后，直接通过node的命令来执行?
- 上面我提到的两种方式，可以通过两个解决方案来完成:
  - 方式一:通过`webpack`，配置本地的TypeScript编译环境和开启一个本地服务，可以直接运行在浏览器上; 
  - 方式二:通过`ts-node`库，为TypeScript的运行提供执行环境;

> ### 方式一:webpack配置

- 方式一在之前的TypeScript文章中我已经有写过，如果需要可以自行查看对应的文章;
- https://mp.weixin.qq.com/s/wnL1l-ERjTDykWM76l4Ajw;

> ### 方式二:安装ts-node

```shell
npm install ts-node -g
```

- 另外ts-node需要依赖 `tslib` 和 `@types/node` 两个包: 

```shell
npm install tslib @types/node -g
```

- 现在，我们可以直接通过 ts-node 来运行**TypeScript的代码:** 

```shell
ts-node math.tss
```



# TypeScript基本用法(一)

## 变量的声明

- 在`TypeScript`中定义`变量`需要指定 `标识符` 的类型。
- 所以完整的声明格式如下: 
  - 声明了类型后TypeScript就会进行类型检测，声明的类型可以称之为`类型注解(Type Annotation)`;
  - var/let/const 标识符: 数据类型 = 赋值;
- 比如我们声明一个message，完整的写法如下:
  - 注意:这里的`string是小写的，和String是有区别的`
  - `string是TypeScript中定义的字符串类型，String是ECMAScript中定义的一个类`
- 如果我们给message赋值其他类型的值，那么就会报错:

```ts
// string: TypeScript给我们定义标识符时, 提供的字符串类型
// String: JavaScript中字符串的包装类
let message: string = "Hello World"
message = "Hello TypeScript"
// message = true

console.log(message)

export {}

```

> ts编译成js文件

```js

"use strict";
// exports.__esModule = true;
// string: TypeScript给我们定义标识符时, 提供的字符串类型
// String: JavaScript中字符串的包装类
var message = "Hello World";
message = "Hello TypeScript";
// message = true
console.log(message);

```



## 声明变量的关键字

- 在TypeScript定义变量(标识符)和ES6之后一致，可以使用`var`、`let`、`const`来定义。
- 当然，在`tslint中并不推荐使用var来声明变量:`
- 可见，在TypeScript中并不建议再使用var关键字了，主要原因和ES6升级后let和var的区别是一样的，`var是没有块级作用域 的`，会引起很多的问题，这里不再展开探讨。

```ts
// 定义标识符
let name: string = "why"
const age: number = 18
const height: number = 1.88

name = "kobe"
// name = 123

export {}

```

## 变量的类型推导(推断)

- 在开发中，有时候为了方便起见我们并`不会在声明每一个变量时都写上对应的数据类型`，我们更希望可以通过TypeScript本身的 特性帮助我们推断出对应的变量类型:

![image-20230913104002101](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230913104002101.png)

- 这是因为在一个变量第一次赋值时，`会根据后面的赋值内容的类型，来推断出变量的类型:`
  - 上面的message就是因为后面赋值的是一个string类型，所以message虽然没有明确的说明，但是依然是一个string类型;

```ts
// 声明一个标识符时, 如果有直接进行赋值, 会根据赋值的类型推导出标识符的类型注解
// 这个过程称之为类型推导
// let进行类型推导, 推导出来的通用类型
// const进行类型推导, 推导出来的字面量类型(后续专门讲解)
let name = "why"
let age = 18
const height = 1.88

// name = 123

export {}
```

## JavaScript类型 – number类型 

- 数字类型是我们开发中经常使用的类型，TypeScript和JavaScript一样，不区分整数类型(int)和浮点型(double)，统一为 number类型。

- 学习过ES6应该知道，ES6新增了二进制和八进制的表示方法，而TypeScript也是支持二进制、八进制、十六进制的表示:

```ts
const x:number = 123;
const y:number = 3.14;
const z:number = 0xffff;
```



## JavaScript类型 – boolean类型

```ts
const x:boolean = true;
const y:boolean = false;
```



## JavaScript类型 – string类型

```ts
const x:string = 'hello';
const y:string = `${x} world`;
```



## JavaScript类型 – Array类型 

- `数组类型`的定义也非常简单，有两种方式:

  - `Array<string>`事实上是一种泛型的写法，我们会在后续中学习它的用法;

- ****

  如果添加其他类型到数组中，那么会报错:

```ts
// 明确的指定<数组>的类型注解: 两种写法
// 1. string[]: 数组类型, 并且数组中存放的字符串类型
// 2. Array<string>: 数组类型, 并且数组中存放的是字符串类型

// 注意事项: 在真实的开发中, 数组一般存放相同的类型, 不要存放不同的类型
let names: string[] = ["abc", "cba", "nba"]
names.push("aaa")
// names.push(123)

let nums: Array<number> = [123, 321, 111]

export {}

```

## JavaScript类型 – Object类型 

- `object`对象类型可以用于描述一个对象:
- 但是从myinfo中我们不能获取数据，也不能设置数据:

```ts
let info = {
  name: "why",
  age: 18,
  height: 1.88
}

console.log(info.name)
console.log(info.age)

export {}

```

## function函数

### 函数的参数类型

- `函数`是JavaScript非常重要的组成部分，TypeScript允许我们`指定函数的参数和返回值的类型。`

> `参数`的类型注解

- 声明函数时，可以在每个参数后添加类型注解，以声明函数接受的参数类型:

```ts
// 在定义一个TypeScript中的函数时, 都要明确的指定参数的类型
function sum(num1: number, num2: number) {
  return num1 + num2
}

const res = sum(123, 321)
// sum("abc", "cba")
// sum({}, {})

export {}

```

### 函数的返回值类型

- 我们也可以添加`返回值的类型注解`，这个注解出现在`函数列表的后面:`
- 和变量的类型注解一样，我们通常情况下不需要返回类型注解，因为TypeScript会根据 `return` 返回值推断函数的返回类型:
  - 某些第三方库处于方便理解，会明确指定返回类型，看个人喜好;

```ts
// 在定义一个TypeScript中的函数时
// 返回值类型可以明确的指定, 也可以自动进行类型推导
function sum(num1: number, num2: number): number {
  return num1 + num2
}

const res = sum(123, 321)


export {}

```



### 匿名函数参数

- 匿名函数与函数声明会有一些不同:
  - 当一个函数出现在TypeScript可以确定该函数会被如何调用的地方时; 
  - 该函数的参数会自动指定类型;
- 我们并没有指定item的类型，但是item是一个string类型:
  - 这是因为TypeScript会根据forEach函数的类型以及数组的类型推断出item的类型; 
  - 这个过程称之为`上下文类型(contextual typing)`，因为函数执行的上下文可以帮助确定参数和返回值的类型;

```ts
const names: string[] = ["abc", "cba", "nba"]

// 匿名函数是否需要添加类型注解呢? 最好不要添加类型注解
names.forEach(function(item, index, arr) {
  console.log(item, index, arr)
})

export {}

```

### 对象类型

- 如果我们希望限定一个`函数接受的参数是一个对象`，这个时候要如何限定呢?
  - 我们可以使用`对象类型`;
- 在这里我们使用了一个对象来作为类型:
  - 在对象我们可以添加属性，并且告知TypeScript该属性需要是什么类型;
  - 属性之间可以使用 `,` 或者 `;` 来分割，最后一个分隔符是可选的;
  - 每个属性的类型部分也是可选的，如果不指定，那么就是any类型;

```ts
// 1.对象类型的简单回顾
// const info: {
//   name: string
//   age: number
// } = {
//   name: "why",
//   age: 18
// }

// 2.对象类型和函数类型结合使用
type PointType = {
  x: number
  y: number
  z?: number
}
function printCoordinate(point: PointType) {
  console.log("x坐标:", point.x)
  console.log("y坐标:", point.y)
}

// printCoordinate(123)
printCoordinate({ x: 20, y: 30 })

export {}

```

### 可选类型

- `对象类型`也可以指定哪些属性是`可选`的，可以在属性的后面添加一个`?`:

```ts
type PointType = {
  x: number
  y: number
  z?: number
}
function printCoordinate(point: PointType) {
  console.log("x坐标:", point.x)
  console.log("y坐标:", point.y)
}
```



## TypeScript类型-any类型

- 在某些情况下，我们确实`无法确定一个变量的类型`，并且可能它会发生一些变化，这个时候我们可以使用`any`类型(类似于Dart 语言中的dynamic类型)。
- `any`类型有点像一种讨巧的TypeScript手段:
  - 我们可以对any类型的变量进行任何的操作，包括获取不存在的属性、方法; 
  - 我们给一个any类型的变量赋值任何的值，比如数字、字符串的值;
- 如果对于某些情况的处理过于`繁琐不希望添加规定的类型注解，或者在引入一些第三方库时，缺失了类型注解`，这个时候我们可 以使用**any:**
- 包括在Vue源码中，也会使用到any来进行某些类型的适配;

```ts
// any类型就表示不限制标识符的任意类型, 并且可以在该标识符上面进行任意的操作(在TypeScript中回到JavaScript中)
let id: any = "aaaa"

id = "bbbb"
id = 123
console.log(id.length)

id = { name: "why", level: 99 }


// 定义数组
const infos: any[] = ["abc", 123, {}, []]
```



## TypeScript类型-unknown类型 

- `unknown`是TypeScript中比较特殊的一种类型，它用于描述`类型不确定的变量`。
- 和any类型有点类似，但是`unknown类型的值上做任何事情都是不合法的`; 

```ts
let foo: unknown = "aaa"
foo = 123

// unknown类型默认情况下在上面进行任意的操作都是非法的
// 要求必须进行类型的校验(缩小), 才能根据缩小之后的类型, 进行对应的操作
if (typeof foo === "string") { // 类型缩小
  console.log(foo.length, foo.split(" "))
}


export {}
```



## TypeScript类型-void类型

- `void`通常用来指定一个`函数是没有返回值的`，那么它的`返回值就是void类型:`
- 这个函数我们没有写任何类型，那么它默认返回值的类型就是void的，我们也可以显示的来指定返回值是void:
- 这里还有一个注意事项:
  - 我们可以将`undefined`赋值给void类型，也就是函数可以返回`undefined`
  - 当基于`上下文的类型推导(Contextual Typing)`推导出返回类型为 void 的时候，并不会强制函数一定不能返回内容。

```ts
// 1.在TS中如果一个函数没有任何的返回值, 那么返回值的类型就是void类型
// 2.如果返回值是void类型, 那么我们也可以返回undefined(TS编译器允许这样做而已)
function sum(num1: number, num2: number): void {
  console.log(num1 + num2)

  // return 123 错误的做法
}


// 应用场景: 用来指定函数类型的返回值是void
type LyricInfoType = { time: number, text: string }
// parseLyric函数的数据类型: (lyric: string) => LyricInfoType[]
function parseLyric(lyric: string): LyricInfoType[] {
  const lyricInfos: LyricInfoType[] = []
  // 解析
  return lyricInfos
}

// parseLyric => 函数/对象
type FooType = () => void
const foo: FooType = () => {}


// 举个例子:(涉及函数的类型问题, 后续还会详细讲解)
// 1.定义要求传入的函数的类型
type ExecFnType = (...args: any[]) => void

// 2.定义一个函数, 并且接收的参数也是一个函数, 而且这个函数的类型必须是ExecFnType
function delayExecFn(fn: ExecFnType) {
  setTimeout(() => {
    fn("why", 18)
  }, 1000);
}

// 3.执行上面函数, 并且传入一个匿名函数
delayExecFn((name, age) => {
  console.log(name, age)
})

export {}
```

```ts
const names = ["abc", "cba", "nba"]

// 了解即可: 基于上下文类型推导的函数中的返回值如果是void类型, 并且不强制要求不能返回任何的东西
names.forEach((item: string, index: number, arr: string[]) => {
  console.log(item)
  return 123
})

```



## TypeScript类型-never类型

- `never` 表示`永远不会发生值的类型`，比如一个函数:
  - 如果一个函数中是一个死循环或者抛出一个异常，那么这个函数会返回东西吗?
  - 不会，那么写void类型或者其他类型作为返回值类型都不合适，我们就可以使用never类型;
- never有什么样的应用场景呢?这里我们举一个例子，但是它用到了`联合类型`，后面我们会讲到:

```ts
// 一. 实际开发中只有进行类型推导时, 可能会自动推导出来是never类型, 但是很少使用它
// 1.一个函数是死循环
// function foo(): never {
//   // while(true) {
//   //   console.log("-----")
//   // }
//   throw new Error("1233")
// }
// foo()

// 2.解析歌词的工具
function parseLyric() {
  return []
}


// 二. 封装框架/工具库的时候可以使用一下never
// 其他时候在扩展工具的时候, 对于一些没有处理的case, 可以直接报错
function handleMessage(message: string | number | boolean) {
  switch (typeof message) {
    case "string":
      console.log(message.length)
      break
    case "number":
      console.log(message)
      break
    case "boolean":
      console.log(Number(message))
      break
    default:
      const check: never = message
  }
}

handleMessage("aaaa")
handleMessage(1234)

// 另外同事调用这个函数
handleMessage(true)

export {}
```





## TypeScript类型-tuple类型 

- `tuple`是`元组类型`，很多语言中也有这种数据类型，比如Python、Swift等。

> 那么tuple和数组有什么区别呢?

- 首先，`数组中通常建议存放相同类型的元素`，`不同类型的元素是不推荐放在数组中。(可以放在对象或者元组中)` 
- 其次，`元组中每个元素都有自己特性的类型，根据索引值获取到的值可以确定对应的类型;`

> tuple应用场景

- tuple通常可以作为返回的值，在使用的时候会非常的方便;

```ts
// 保存我的个人信息: why 18 1.88
// 1.使用数组类型
// 不合适: 数组中最好存放相同的数据类型, 获取值之后不能明确的知道对应的数据类型
const info1: any[] = ["why", 18, 1.88]
const value = info1[2]
console.log()


// 2.使用对象类型(最多)
const info2 = {
  name: "why",
  age: 18,
  height: 1.88
}

// 3.使用元组类型
// 元组数据结构中可以存放不同的数据类型, 取出来的item也是有明确的类型
const info3: [string, number, number] = ["why", 18, 1.88]
const value2 = info3[2]


// 在函数中使用元组类型是最多的(函数的返回值)
function useState(initialState: number): [number, (newValue: number) => void] {
  let stateValue = initialState
  function setValue(newValue: number) {
    stateValue = newValue
  }

  return [stateValue, setValue]
}

const [count, setCount] = useState(10)
console.log(count)
setCount(100)

export {}

```



# TypeScript基本用法(二)

## 联合类型--|

- TypeScript的类型系统允许我们使用多种运算符，从现有类型中构建新类型。
- 我们来使用第一种组合类型的方法:`联合类型(Union Type)`
  - 联合类型是由`两个或者多个其他类型组成的类型`;
  - 表示`可以是这些类型中的任何一个值`; 
  - 联合类型中的每一个类型被称之为`联合成员(union's members);`

> 类型缩小

- 传入给一个联合类型的值是非常简单的:只要保证是联合类型中的某一个类型的值即可
  - 但是我们拿到这个值之后，我们应该如何使用它呢?因为`它可能是任何一种类型。`
  - 比如我们拿到的值可能是string或者number，我们就不能对其调用string上的一些方法;
- 那么我们怎么处理这样的问题呢?
  - 我们需要使用`缩小(narrow)联合`(后续我们还会专门讲解缩小相关的功能); 
  - TypeScript可以`根据我们缩小的代码结构，推断出更加具体的类型;`

```ts
// 1.联合类型的基本使用
// let foo: number | string = "abc"
// foo = 123

// // 使用的时候要特别的小心
// if (typeof foo === "string") {
//   console.log(foo.length)
// }


// 2.举个栗子: 打印id
function printID(id: number | string) {
  console.log("您的ID:", id)

  // 类型缩小
  if (typeof id === "string") {
    console.log(id.length)
  } else {
    console.log(id)
  }
}

printID("abc")
printID(123)

```

## 类型别名--type

- 在前面，我们通过在类型注解中编写 `对象类型` 和 `联合类型`，但是当我们想要多次在其他地方使用时，就要编写多次。 
- 比如我们可以给对象类型起一个别名:

```ts
// 类型别名: type
type MyNumber = number
const age: MyNumber = 18

// 给ID的类型起一个别名
type IDType = number | string

function printID(id: IDType) {
  console.log(id)
}


// 打印坐标
type PointType = { x: number, y: number, z?: number }
function printCoordinate(point: PointType) {
  console.log(point.x, point.y, point.z)
}

```

## 接口的声明--interface

- 在前面我们通过`type`可以用来声明一个对象类型:
- 对象的另外一种声明方式就是通过`接口`来声明:

```ts
const name = "why"

console.log("why")
console.log(name)

type PointType = {
  x: number
  y: number
  z?: number
}

// 接口: interface
// 声明的方式
interface PointType2 {
  x: number
  y: number
  z?: number
}

function printCoordinate(point: PointType2) {
  
}


export {}


```



## interface和type区别

- 我们会发现`interface`和`type`都可以用来定义对象类型，那么在开发中定义对象类型时，到底选择哪一个呢?
  - 如果是定义`非对象类型，通常推荐使用type`，比如Direction、Alignment、一些Function;
- 如果是定义`对象类型`，那么他们是有区别的: 
  - `interface` 可以`重复`的对某个接口来定义属性和方法; 
  - 而`type`定义的是别名，别名是不能重复的;
- 所以，interface可以为现有的接口提供更多的扩展。
  - 接口还有很多其他的用法，我们会在后续详细学习

```ts
// 1.区别一: type类型使用范围更广, 接口类型只能用来声明对象
type MyNumber = number
type IDType = number | string


// 2.区别二: 在声明对象时, interface可以多次声明
// 2.1. type不允许两个相同名称的别名同时存在
// type PointType1 = {
//   x: number
//   y: number
// }

// type PointType1 = {
//   z?: number
// }


// 2.2. interface可以多次声明同一个接口名称
interface PointType2 {
  x: number
  y: number
}

interface PointType2 {
  z: number
}

const point: PointType2 = {
  x: 100,
  y: 200,
  z: 300
}


// 3.interface支持继承的
interface IPerson {
  name: string
  age: number
}

interface IKun extends IPerson {
  kouhao: string
}

const ikun1: IKun = {
  kouhao: "你干嘛, 哎呦",
  name: "kobe",
  age: 30
}

// 4.interface可以被类实现(TS面向对象时候再讲)
// class Person implements IPerson {

// }


// 总结: 如果是非对象类型的定义使用type, 如果是对象类型的声明那么使用interface


export {}


```



## 交叉类型--&

- 前面我们学习了`联合类型`:
  - `联合类型表示多个类型中一个即可`
- 还有另外一种类型合并，就是`交叉类型(Intersection Types)`: 
  - `交叉类似表示需要满足多个类型的条件`;
  - 交叉类型使用 `&` 符号;
- 我们来看下面的交叉类型:
  - 表达的含义是number和string要同时满足;
  - 但是有同时满足是一个number又是一个string的值吗?其实是没有的，所以MyType其实是一个never类型;

> 使用场景:

- 在开发中，我们进行交叉时，通常是对`对象类型`进行交叉的:

```ts
// 回顾: 联合类型
type ID = number | string
const id1: ID = "abc"
const id2: ID = 123

// 交叉类型: 两种(多种)类型要同时满足
type NewType = number & string // 没有意义

interface IKun {
  name: string
  age: number
}

interface ICoder {
  name: string
  coding: () => void
}

type InfoType = IKun & ICoder

const info: InfoType = {
  name: "why",
  age: 18,
  coding: function() {
    console.log("coding")
  }
}

```

## 类型断言--as

- 有时候`TypeScript无法获取具体的类型信息`，这个我们需要使用`类型断言(Type Assertions)`。
  - 比如我们通过 document.getElementById，TypeScript只知道该函数会返回 HTMLElement ，但并不知道它具体的类型:
- `TypeScript只允许类型断言转换为 更具体 或者 不太具体 的类型版本`，此规则可防止不可能的强制转换:

```ts
// 获取DOM元素 <img class="img"/>
// const imgEl = document.querySelector(".img")
// if (imgEl !== null) { // 类型缩小
//   imgEl.src = "xxx"
//   imgEl.alt = "yyy"
// }

// 使用类型断言
const imgEl = document.querySelector(".img") as HTMLImageElement
imgEl.src = "xxx"
imgEl.alt = "yyy"


// 类型断言的规则: 断言只能断言成更加具体的类型, 或者 不太具体(any/unknown) 类型
const age: number = 18
// 错误的做法
// const age2 = age as string

// TS类型检测来说是正确的, 但是这个代码本身不太正确
// const age3 = age as any
// const age4 = age3 as string
// console.log(age4.split(" "))


export {}

```

## 非空类型断言--!

- 我们`确定传入的参数是有值的`，这个时候我们可以使用`非空类型断言`: 
  - 非空断言使用的是 `!` ，`表示可以确定某个标识符是有值的，跳过ts在编译阶段对它的检测;`

```ts
// 定义接口
interface IPerson {
  name: string
  age: number
  friend?: {
    name: string
  }
}

const info: IPerson = {
  name: "why",
  age: 18
}

// 访问属性: 可选链: ?.
console.log(info.friend?.name)

// 属性赋值:
// 解决方案一: 类型缩小
if (info.friend) {
  info.friend.name = "kobe"
}

// 解决方案二: 非空类型断言(有点危险, 只有确保friend一定有值的情况, 才能使用)
info.friend!.name = "james"

export {}

```

## 字面量类型

- 除了前面我们所讲过的类型之外，也可以使用`字面量类型(literal types):`
- 那么这样做有什么意义呢?
  - 默认情况下这么做是没有太大的意义的，但是我们可以将`多个类型联合在一起;`

```ts
// 1.字面量类型的基本上
const name: "why" = "why"
let age: 18 = 18

// 2.将多个字面量类型联合起来 |
type Direction = "left" | "right" | "up" | "down"
const d1: Direction = "left"

// 栗子: 封装请求方法
type MethodType = "get" | "post"
function request(url: string, method: MethodType) {
}

request("http://codercba.com/api/aaa", "post")

// TS细节
//我们的对象在进行字面量推理的时候，info其实是一个 {url: string, method: string}，所以我们没办法将一个 string 赋值给一个 字面量 类型。

// const info = {
//   url: "xxxx",
//   method: "post"
// }
// 下面的做法是错误: info.method获取的是string类型
// request(info.url, info.method)

// 解决方案一: info.method进行类型断言
// request(info.url, info.method as "post")

// 解决方案二: 直接让info对象类型是一个字面量类型
// const info2: { url: string, method: "post" } = {
//   url: "xxxx",
//   method: "post"
// }
const info2 = {
  url: "xxxx",
  method: "post"
} as const
// xxx 本身就是一个string
request(info2.url, info2.method)

export {}


```

## 类型缩小

- 什么是类型缩小呢?
  - 类型缩小的英文是 `Type Narrowing`(也有人翻译成类型收窄);
  - 我们可以通过类似于 `typeof padding === "number"` 的判断语句，来改变TypeScript的执行路径; 
  - 在给定的执行路径中，我们可以`缩小比声明时更小的类型`，这个过程称之为 `缩小( Narrowing )`; 
  - 而我们编写的 `typeof padding === "number` 可以称之为 `类型保护(type guards);`
- 常见的类型保护有如下几种: 
  - `typeof`
  - `平等缩小`(比如===、!==) 
  - `instanceof`
  - `in`
  - 等等...



### typeof

- 在 TypeScript 中，检查返回的值`typeof`是一种类型保护: 
  - 因为 TypeScript 对如何typeof操作不同的值进行编码。

```ts
// 1.typeof: 使用的最多
function printID(id: number | string) {
  if (typeof id === "string") {
    console.log(id.length, id.split(" "))
  } else {
    console.log(id)
  }
}
```

### 平等缩小

- 我们可以使用`Switch`或者相等的一些运算符来表达相等性(比如===, !==, ==, and != ):

```ts
// 2.===/!==: 方向的类型判断
type Direction = "left" | "right" | "up" | "down"
function switchDirection(direction: Direction) {
  if (direction === "left") {
    console.log("左:", "角色向左移动")
  } else if (direction === "right") {
    console.log("右:", "角色向右移动")
  } else if (direction === "up") {
    console.log("上:", "角色向上移动")
  } else if (direction === "down") {
    console.log("下:", "角色向下移动")
  }
}
```

### instanceof

- JavaScript 有一个运算符来`检查一个值是否是另一个值的“实例”:`

```ts
// 3. instanceof: 传入一个日期, 打印日期
function printDate(date: string | Date) {
  if (date instanceof Date) {
    console.log(date.getTime())
  } else {
    console.log(date)
  }

  // if (typeof date === "string") {
  //   console.log(date)
  // } else {
  //   console.log(date.getTime())
  // }
}
```

### in操作符

- Javascript 有一个运算符，用于`确定对象是否具有带名称的属性`:in运算符 
  - 如果`指定的属性在指定的对象或其原型链中`，则in 运算符返回true;

```ts
// 4.in: 判断是否有某一个属性
interface ISwim {
  swim: () => void
}

interface IRun {
  run: () => void
}

function move(animal: ISwim | IRun) {
  if ("swim" in animal) {
    animal.swim()
  } else if ("run" in animal) {
    animal.run()
  }
}

const fish: ISwim = {
  swim: function() {}
}

const dog: IRun = {
  run: function() {}
}

move(fish)
move(dog)

```



# TypeScript函数类型

## 什么时候函数类型

- 在JavaScript开发中，`函数`是重要的组成部分，并且函数可以作为`一等公民`(可以作为参数，也可以作为返回值进行传递)。
- 那么在使用函数的过程中，函数是否也可以有自己的类型呢?
- 我们可以编写`函数类型的表达式(Function Type Expressions)`，来表示函数类型;

```ts
function foo(arg: number): number {
  return 123
}

// foo本身也是一个标识符, 也应该有自己的类型
const bar: any = (arg: number): number => {
  return 123
}

function delayExecFn(fn) {

}
```

```ts
// 方案一: 函数类型表达式 function type expression
// 格式: (参数列表) => 返回值
type BarType = (num1: number) => number
const bar: BarType = (arg: number): number => {
  return 123
}

export {}


```

## 函数类型参数的格式

```ts
// TypeScript对于传入的函数类型的多余的参数会被忽略掉(the extra arguments are simply ignored.)
type CalcType = (num1: number, num2: number) => number
function calc(calcFn: CalcType) {
  calcFn(10, 20)
}

calc(function(num) {
  return 123
})

// forEach栗子:
const names = ["abc", "cba", "nba"]
names.forEach(function(item) {
  console.log(item.length)
})

// TS对于很多类型的检测报不报错, 取决于它的内部规则
// TS版本在不断更新: 在进行合理的类型检测的情况, 让ts同时更好用(好用和类型检测之间找到一个平衡)
// 举一个栗子:
interface IPerson {
  name: string
  age: number
}

// typescript github issue, 成员
const p = {
  name: "why",
  age: 18,
  height: 1.88,
  address: "广州市"
}

const info: IPerson = p

export {}


```



## 调用签名(Call Signatures)

- 在 JavaScript 中，`函数除了可以被调用，自己也是可以有属性值的。`
  - 然而前面讲到的函数类型表达式并`不能支持声明属性`; 
  - 如果我们想描述一个`带有属性的函数`，我们可以在一个对象类型中写一个`调用签名(call signature)`;
- 注意这个语法跟函数类型表达式稍有不同，在参数列表和返回的类型之间用的是 `:` 而不是 =>。

```ts
// 1.函数类型表达式
type BarType = (num1: number) => number

// 2.函数的调用签名(从对象的角度来看待这个函数, 也可以有其他属性)
interface IBar {
  name: string
  age: number
  // 函数可以调用: 函数调用签名
  (num1: number): number
}

const bar: IBar = (num1: number): number => {
  return 123
}

bar.name = "aaa"
bar.age = 18
bar(123)


// 开发中如何选择:
// 1.如果只是描述函数类型本身(函数可以被调用), 使用函数类型表达式(Function Type Expressions)
// 2.如果在描述函数作为对象可以被调用, 同时也有其他属性时, 使用函数调用签名(Call Signatures)


export {}



```

## 构造签名 (Construct Signatures)

- JavaScript 函数也可以使用 `new` 操作符调用，当被调用的时候，TypeScript 会认为这是一个`构造函数(constructors)`，因为 他们会产生一个`新对象`。
  - 你可以写一个`构造签名( Construct Signatures )`，方法是在调用签名前面加一个 `new` 关键词;

```ts
class Person {
}

interface ICTORPerson {
  new (): Person
}

function factory(fn: ICTORPerson) {
  const f = new fn()
  return f
}

factory(Person)

```



## 参数的可选类型 

- 我们可以指定`某个参数`是`可选`的:
- 另外`可选类型需要在必传参数的后面:`

```ts
// y就是一个可选参数
// 可选参数类型是什么? number | undefined 联合类型
function foo(x: number, y?: number) {
  if (y !== undefined) {
    console.log(y + 10)
  }
}

foo(10)
foo(10, 20)

export {}


```

## 默认参数

- 从ES6开始，JavaScript是支持`默认参数`的，TypeScript也是支持默认参数的:

```ts
// 函数的参数可以有默认值
// 1.有默认值的情况下, 参数的类型注解可以省略
// 2.有默认值的参数, 是可以接收一个undefined的值
function foo(x: number, y = 100) {
  console.log(y + 10)
}

foo(10)
foo(10, undefined)
foo(10, 55)

export {}


```

## 剩余参数

- 从ES6开始，JavaScript也支持`剩余参数`，剩余参数语法允许我们`将一个不定数量的参数放到一个数组中`。

```ts
function foo(...args: (string | number)[]) {

}

foo(123, 321)
foo("abc", 111, "cba")
```



## 函数的重载(了解)

- 那么这个代码应该如何去编写呢?
  - 在TypeScript中，我们可以去编写`不同的重载签名(overload signatures)`来表示函数可以以不同的方式进行调用; 
  - `一般是编写两个或者以上的重载签名，再去编写一个通用的函数`以及实现;

```ts
// 需求: 只能将两个数字/两个字符串进行相加
// 案例分析: any实现
// function add(arg1, arg2) {
//   return arg1 + arg2
// }

// add(10, 20)
// add("abc", "cba")
// add({aaa: "aaa"}, 123)


// 1.实现两个函数
// function add1(num1: number, num2: number) {
//   return num1 + num2
// }

// function add2(str1: string, str2: string) {
//   return str1 + str2
// }

// add1(10, 20)
// add2("abc", "cba")


// 2.错误的做法: 联合类型是不可以
// function add(arg1: number|string, arg2: number|string) {
//   return arg1 + arg2
// }


// 3.TypeScript中函数的重载写法
// 3.1.先编写重载签名
function add(arg1: number, arg2: number): number
function add(arg1: string, arg2: string): string

// 3.2.编写通用的函数实现
function add(arg1: any, arg2: any): any {
  return arg1 + arg2
}

add(10, 20)
add("aaa", "bbb")
// 通用函数不能被调用
// add({name: "why"}, "aaa")
// add("aaa", 111)

export {}

```



## 联合类型和重载的选择

- 我们现在有一个需求:定义一个函数，可以传入字符串或者数组，获取它们的长度。
- 这里有两种实现方案:
  - 方案一:使用`联合类型`来实现; 
  - 方案二:实现`函数重载`来实现;
- 在开发中我们选择使用哪一种呢?
  - 在可能的情况下，尽量选择使用`联合类型`来实现;

```ts
// 1.普通的实现
// function getLength(arg) {
//   return arg.length
// }

// 2.函数的重载
// function getLength(arg: string): number
// function getLength(arg: any[]): number
// function getLength(arg) {
//   return arg.length
// }


// 3.联合类型实现(可以使用联合类型实现的情况, 尽量使用联合类型)
// function getLength(arg: string | any[]) {
//   return arg.length
// }

// 4.对象类型实现
function getLength(arg: { length: number }) {
  return arg.length
}


getLength("aaaaa")
getLength(["abc", "cba", "nba"])
getLength({ name: "why", length: 100 })


```



## 可推导的this类型

- `this`是JavaScript中一个比较难以理解和把握的知识点:
  - 公众号也有一篇文章专门讲解this:
    - https://mp.weixin.qq.com/s/hYm0JgBI25grNG_2sCRlTA; 
- 当然在目前的Vue3和React开发中你不一定会使用到this:
  - Vue3的Composition API中很少见到this，React的Hooks开发中也很少见到this了;
- 默认情况下是可以正常运行的，也就是TypeScript在编译时，认为我们的this是可以正确去使用的:
  - 这是因为在没有指定this的情况，`this默认情况下是any类型的;`

```ts
// 在没有对TS进行特殊配置的情况下, this是any类型

// 1.对象中的函数中的this
const obj = {
  name: "why",
  studying: function() {
    // 默认情况下, this是any类型
    console.log(this.name.length, "studying")
  }
}

obj.studying()
// obj.studying.call({})


// 2.普通的函数
function foo() {
  console.log(this)
}

export {}

```

## this的编译选项

- VSCode在检测我们的TypeScript代码时，默认情况下运行`不确定的this按照any类型去使用。`
  - 但是我们可以创建一个`tsconfig.json`文件，开启`noImplicitThis`，告知VSCodethis必须明确执行(不能是隐式的);

![image-20230914194050709](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230914194050709.png)

- 在设置了`noImplicitThis`为true时， TypeScript会根据`上下文推导this`，但是`在不能正确推导时，就会报错，需要我们明确 的指定this。`

![image-20230914194427118](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230914194427118.png)



## 指定this的类型

- 在开启`noImplicitThis`的情况下，我们`必须指定this的类型。`
- 如何指定呢?函数的第一个参数类型:
  - 函数的第一个参数我们可以根据该函数之后被调用的情况，用于声明this的类型(`名词必须叫this`); 
  - 在后续调用函数传入参数时，从第二个参数开始传递的，this参数会在编译后被抹除;

```ts
// 在设置配置选项(编译选项compilerOptions, noImplicitThis设置为true, 不允许模糊的this存在)

// 1.对象中的函数中的this
const obj = {
  name: "why",
  studying: function(this: {}) {
    // 默认情况下, this是any类型
    console.log(this, "studying")
  }
}

// obj.studying()
obj.studying.call({})


// 2.普通的函数
function foo(this: { name: string }, info: {name: string}) {
  console.log(this, info)
}

foo.call({ name: "why" }, { name: "kobe" })

export {}

```



## this相关的内置工具

- Typescript 提供了一些`工具类型`来辅助进行常见的类型转换，这些类型`全局`可用。

- `ThisParameterType`:

  - 用于提取一个函数类型Type的this (opens new window)参数类型; 
  - 如果这个函数类型没有this参数返回unknown;

- `OmitThisParameter`:

  - 用于移除一个函数类型Type的this参数类型, 并且返回当前的函数类型

- `ThisType`:

  - 这个类型不返回一个转换过的类型，它被用作标记一个上下文的this类型。(官方文档)

    

```ts
function foo(this: { name: string }, info: {name: string}) {
  console.log(this, info)
}

type FooType = typeof foo

// 1.ThisParameterType: 获取FooType类型中this的类型
type FooThisType = ThisParameterType<FooType>


// 2.OmitOmitThisParameter: 删除this参数类型, 剩余的函数类型
type PureFooType = OmitThisParameter<FooType>


// 3.ThisType: 用于绑定一个上下文的this
interface IState {
  name: string
  age: number
}

interface IStore {
  state: IState
  eating: () => void
  running: () => void
}

const store: IStore & ThisType<IState> = {
  state: {
    name: "why",
    age: 18
  },
  eating: function() {
    console.log(this.name)
  },
  running: function() {
    console.log(this.name)
  }
}

store.eating.call(store.state)


export {}

```



# TypeScript面向对象

## 认识类的使用

- 在早期的JavaScript开发中(`ES5`)我们需要通过`函数`和`原型链`来实现`类和继承`，从ES6开始，引入了`class`关键字，可以更加方 便的`定义和使用类`。
- TypeScript作为JavaScript的超集，也是支持使用`class`关键字的，并且还可以`对类的属性和方法等进行静态类型检测。`
- 实际上在JavaScript的开发过程中，我们更加习惯于`函数式编程`:
  - 比如React开发中，目前更多使用的函数组件以及结合Hook的开发模式; 
  - 比如在Vue3开发中，目前也更加推崇使用 Composition API;
- 但是在封装某些业务的时候，类具有更强大封装性，所以我们也需要掌握它们。
- 类的定义我们通常会使用`class关键字`:
  - 在面向对象的世界里，`任何事物都可以使用类的结构来描述;` 
  - 类中包含特有的`属性和方法`;

## 类的定义

- 我们来定义一个**Person类:**
  - 使用`class`关键字来定义一个类;
- 我们可以声明类的`属性`:在类的内部声明类的属性以及对应的类型
  - 如果类型没有声明，那么它们默认是any的;
  - 我们也可以给属性设置初始化值;
  - 在默认的`strictPropertyInitialization(ts严格模式)`模式下面我们的属性是必须 `初始化`的，如果没有初始化，那么编译时就会报错;
    - 如果我们在strictPropertyInitialization模式下确实不希望给属 性初始化，可以使用 name!: string语法;
- 类可以有自己的构造函数`constructor`，当我们通过`new关键字创建一个实例时，构造函数会被调用;`
  - 构造函数不需要返回任何值，默认返回当前创建出来的实例; 
- 类中可以有自己的函数，`定义的函数称之为方法;`

```ts
class Person {
  // 成员属性: 声明成员属性
  name: string
  age: number

  constructor(name: string, age: number) {
    this.name = name
    this.age = age
  }

  eating() {
    console.log(this.name + " eating")
  }

  running() {
    console.log(this.name + " running")
  }
}

// 实例对象: instance
const p1 = new Person("why", 18)
const p2 = new Person("kobe", 30)

console.log(p1.name, p2.age)

export {}


```



## 类的继承

- 面向对象的其中一大特性就是`继承`，继承不仅仅可以减少我们的代码量，也是`多态的使用前提`。
- 我们使用`extends`关键字来实现继承，子类中使用`super`来访问父类。
- 我们来看一下Student类继承自Person:
  - Student类可以有自己的属性和方法，并且会继承Person的属性和方法;
  - 在构造函数中，我们可以通过`super`来调用父类的构造方法，对父类中的属性进行初始化;

```ts
// public
// private
// protected

class Person {
  protected name: string
  private age: number

  constructor(name: string, age: number) {
    this.name = name
    this.age = age
  }

  // 方法变成私有方法: 只有在类内部才能访问
  private eating() {
    console.log("吃东西", this.age, this.name)
  }
}

const p = new Person("why", 18)
// console.log(p.name, p.age)
// p.name = "kobe"
// p.eating()

// 子类中是否可以访问
class Student extends Person {
  constructor(name: string, age: number) {
    super(name, age)
  }

  studying() {
    console.log("在学习", this.name)
  }
}

const stu = new Student("why", 18)

```

## 类的成员修饰符

- 在TypeScript中，类的属性和方法支持三种`修饰符`: public、private、protected 
  - `public` 修饰的是在任何地方可见、公有的属性或方法，默认编写的属性就是public的; 
  - `private` 修饰的是仅在同一类中可见、私有的属性或方法;
  - `protected` 修饰的是仅在类自身及子类中可见、受保护的属性或方法;
- public是默认的修饰符，也是可以直接访问的，我们这里来演示一下protected和private。

```js
// public
// private(只能在本类中访问，子类，外部类访问不了)
// protected

class Person {
  protected name: string
  private age: number

  constructor(name: string, age: number) {
    this.name = name
    this.age = age
  }

  // 方法变成私有方法: 只有在类内部才能访问
  private eating() {
    console.log("吃东西", this.age, this.name)
  }
}

const p = new Person("why", 18)
// console.log(p.name, p.age)
// p.name = "kobe"
// p.eating()

// 子类中是否可以访问
class Student extends Person {
  constructor(name: string, age: number) {
    super(name, age)
  }

  studying() {
    console.log("在学习", this.name)
  }
}

const stu = new Student("why", 18)

```

## 只读属性-readonly

- 如果有一个属性我们`不希望外界可以任意的修改`，只希望确定值后直接使用，那么可以使用`readonly`:

```ts
class Person {
  readonly name: string
  age: number

  constructor(name: string, age: number) {
    this.name = name
    this.age = age
  }
}

// 类和实例之间的关系(重要)
const p = new Person("why", 18)
console.log(p.name, p.age)

// p.name = "kobe" 只读属性不能进行写入操作
p.age = 20

export {}

```

`readonly`还可以与其他三个`可访问性修饰符`，一起使用。

```ts
class A {
  constructor(
    public readonly x:number,
    protected readonly y:number,
    private readonly z:number
  ) {}
}
```

## getters/setters

- 在前面一些`私有属性`我们是`不能直接访问`的，或者某些属性我们想要监听它的`获取(getter)`和`设置(setter)`的过程，这个时候我们 可以使用`存取器`。

```ts
class Person {
  // 私有属性: 属性前面会使用_
  private _name: string
  private _age: number

  constructor(name: string, age: number) {
    this._name = name
    this._age = age
  }

  running() {
    console.log("running:", this._name)
  }

  // setter/getter: 对属性的访问进行拦截操作
  set name(newValue: string) {
    this._name = newValue
  }

  get name() {
    return this._name
  }


  set age(newValue: number) {
    if (newValue >= 0 && newValue < 200) {
      this._age = newValue
    }
  }

  get age() {
    return this._age
  }
}

const p = new Person("why", 100)
p.name = "kobe"
console.log(p.name)

p.age = -10
console.log(p.age)


export {}

```

## 参数属性(实例属性的简写形式)

- TypeScript 提供了特殊的语法，可以把一个`构造函数参数转成一个同名同值的类属性。`
- 这些就被称为`参数属性(parameter properties)`;
- 你可以通过在`构造函数参数`前添加一个可见性修饰符 public private protected 或者 readonly 来创建参数属性，最后这些类 属性字段也会得到这些修饰符;

```ts

class Point {
  x:number;
  y:number;

  constructor(x:number, y:number) {
    this.x = x;
    this.y = y;
  }
}
```

- 上面实例中，属性`x`和`y`的值是通过构造方法的参数传入的。
- 这样的写法等于对`同一个属性要声明两次类型`，一次在类的头部，另一次在构造方法的参数里面。这有些累赘，TypeScript 就提供了一种`简写形式`。

```ts
//简写
class A {
  constructor(
    public a: number,
    protected b: number,
    private c: number,
    readonly d: number
  ) {}
}

// 编译结果
class A {
    a;
    b;
    c;
    d;
    constructor(a, b, c, d) {
      this.a = a;
      this.b = b;
      this.c = c;
      this.d = d;
    }
}
```

## 抽象类abstract

- 我们知道，`继承是多态使用的前提。`
  - 所以在定义很多`通用的调用接口`时**,** 我们通常会让调用者传入`父类`，通过`多态`来实现更加灵活的调用方式。
  - 但是，`父类本身可能并不需要对某些方法进行具体的实现，所以父类中定义的方法,`，我们可以定义为`抽象方法。`
- 什么是 抽象方法? 在TypeScript中没有具体实现的方法(没有方法体)，就是抽象方法。
  - 抽象方法，必须存在于`抽象类`中;
  - 抽象类是使用`abstract`声明的类;
- 抽象类有如下的特点:
  - `抽象类是不能被实例`的话(也就是不能通过new创建) 
  - `抽象方法必须被子类实现`，否则该类必须是一个抽象类;

```ts
abstract class Shape {
  // getArea方法只有声明没有实现体
  // 实现让子类自己实现
  // 可以将getArea方法定义为抽象方法: 在方法的前面加abstract
  // 抽象方法必须出现在抽象类中, 类前面也需要加abstract
  abstract getArea()
}


class Rectangle extends Shape {
  constructor(public width: number, public height: number) {
    super()
  }

  getArea() {
    return this.width * this.height
  }
}

class Circle extends Shape {
  constructor(public radius: number) {
    super()
  }

  getArea() {
    return this.radius ** 2 * Math.PI
  }
}

class Triangle extends Shape {
  getArea() {
    return 100
  }
}


// 通用的函数
function calcArea(shape: Shape) {
  return shape.getArea()
}

calcArea(new Rectangle(10, 20))
calcArea(new Circle(5))
calcArea(new Triangle())

// 在Java中会报错: 不允许
calcArea({ getArea: function() {} })

// 抽象类不能被实例化
// calcArea(new Shape())
// calcArea(100)
// calcArea("abc")

```



## 类的类型

- 类本身也是可以作为一种`数据类型`的:

```ts
class Person {}

/**
 * 类的作用:
 *  1.可以创建类对应的实例对象
 *  2.类本身可以作为这个实例的类型
 *  3.类也可以当中有一个构造签名的函数
 */

const name: string = "aaa"
const p: Person = new Person()
function printPerson(p: Person) {}

function factory(ctor: new () => void) {}
factory(Person)

export {}

```



## 对象类型的属性修饰符

- 对象类型中的`每个属性`可以说明它的类型、属性是否可选、属性是否只读等信息。
- `可选属性`(Optional Properties)
  - 我们可以在属性名后面加一个 `?` 标记表示这个属性是`可选`的;
- `只读属性`(Readonly Properties)
  - 在 TypeScript 中，属性可以被标记为 `readonly`，这不会改变任何运行时的行为; 
  - 但在类型检查的时候，一个标记为 readonly的属性是不能被写入的。

```ts
// 定义对象类型
type IPerson = {
  // 属性?: 可选的属性
  name?: string
  // readonly: 只读的属性
  readonly age: number
}

interface IKun {
  name?: string
  readonly slogan: string
}

const p: IPerson = {
  name: "why",
  age: 18
}

// p.age = 30


```

## 索引签名!!

- 什么是`索引签名`呢?
  - 有的时候，你不能提前知道一个类型里的所有属性的名字，但是你知道这些值的特征;
  - 这种情况，你就可以用一个`索引签名` (index signature) `来描述可能的值的类型;`
- 一个索引签名的属性类型必须是 `string` 或者是 `number`**。**
  - 虽然 TypeScript 可以同时支持 string 和 number 类型，但`数字索引的返回类型一定要是字符索引返回类型的子类型;`(了 解)

```ts
interface ICollection {
  // 索引签名
  [index: string]: number

  length: number
}

const names: number[] = [111, 222, 333]
console.log(names[0])
console.log(names[1])
console.log(names[2])


function iteratorCollection(collection: ICollection) {
  console.log(collection[0])
  console.log(collection[1])
}

// iteratorCollection(names)
// const tuple: [string, string] = ["why", "18"]
// iteratorCollection(tuple)

iteratorCollection({ name: 111, age: 18, length: 10 })

export {}

```

> 索引签名-索引类型问题(忽略)

```ts
interface IIndexType {
  [bbb: string]: any
}

const nums: IIndexType = ["abc", "cba", "nba"]
// 通过数字类型访问索引时, 最终都是转化成string类型访问
const num1 = nums[0]
console.log(num1)

const info: IIndexType = { name: "why", age: 18 }
const name = info["name"]
console.log(name)

export {}

```

### 索引签名-基本使用

```ts
// interface IPerson {
//   name: string
//   age: number
//   height: number
// }

// const p: IPerson = {
//   name: "why",
//   age: 18,
//   height: 1.88
// }

// console.log(p.address)

// 1.索引签名的理解
// interface InfoType {
//   // 索引签名: 可以通过字符串索引, 去获取到一个值, 也是字符串
//   [key: string]: string
// }
// function getInfo(): InfoType {
//   const abc: any = "hahah"
//   return abc
// }


// const info = getInfo()
// const name = info["name"]
// console.log(name, info.age, info.address)


// 2.索引签名的案例
interface ICollection {
  [index: number]: string
  length: number
}

function printCollection(collection: ICollection) {
  for (let i = 0; i < collection.length; i++) {
    const item = collection[i]
    console.log(item.length)
  }
}

const array = ["abc", "cba", "nba"]
const tuple: [string, string] = ["why", "广州"]
printCollection(array)
printCollection(tuple)

export {}


```

### 索引签名-类型问题

```ts
interface IIndexType {
  // 返回值类型的目的是告知通过索引去获取到的值是什么类型
  // [index: number]: string
  // [index: string]: any
  [index: string]: string
}

// 索引签名: [index: number]: string
// const names: IIndexType = ["abc", "cba", "nba"]

// 索引签名: [index: string]: any: 没有报错
// 1.索引要求必须是字符串类型 names[0] => names["0"]
// const names: IIndexType = ["abc", "cba", "nba"]

// 索引签名: [index: string]: string: 会报错
// 严格字面量赋值检测: ["abc", "cba", "nba"] => Array实例 => names[0] names.forEach
// const names: IIndexType = ["abc", "cba", "nba"]
// names["forEach"] => function
// names["map/filter"] => function

export {}


```



### 索引签名-两个签名

```ts
interface IIndexType {
  // 两个索引类型的写法
  [index: number]: string
  [key: string]: any

  // 要求一:下面的写法不允许: 数字类型索引的类型, 必须是字符串类型索引的类型的 子类型
  // 结论: 数字类型必须是比如字符串类型更加确定的类型(需要是字符串类型的子类型)
  // 原因: 所有的数字类型都是会转成字符串类型去对象中获取内容
  // 数字0: number|string, 当我们是一个数字的时候, 既要满足通过number去拿到的内容, 不会和string拿到的结果矛盾
  // 数字"0": string

  // 数字0: string
  // 数字"0": number|string
  // [index: number]: number|string
  // [key: string]: string

  // 要求二: 如果索引签名中有定义其他属性, 其他属性返回的类型, 必须符合string类型返回的属性
  // [index: number]: string
  // [key: string]: number|string

  // aaa: string
  // bbb: boolean 错误的类型
}

const names: IIndexType = ["abc", "cba", "nba"]
const item1 = names[0]
const forEachFn = names["forEach"]

names["aaa"]

export {}


```



## 接口继承

- 接口和类一样是可以进行继承的，也是使用`extends`关键字: 
  - 并且我们会发现，`接口是支持多继承`的(类不支持多继承)

```ts
interface IPerson {
  name: string
  age: number
}

// 可以从其他的接口中继承过来属性
// 1.减少了相同代码的重复编写
// 2.如果使用第三库, 给我们定义了一些属性
//  > 自定义一个接口, 同时你希望自定义接口拥有第三方某一个类型中所有的属性
//  > 可以使用继承来完成
interface IKun extends IPerson {
  slogan: string
}

const ikun: IKun = {
  name: "why",
  age: 18,
  slogan: "你干嘛, 哎呦"
}

export {}

```

## 接口的实现

- 接口定义后，也是可以被`类`实现的:
  - 如果被一个类实现，那么在之后需要传入接口的地方，都可以将这个类传入; 
  - 这就是`面向接口`开发;

```ts
interface IKun {
  name: string
  age: number
  slogan: string

  playBasketball: () => void
}

interface IRun {
  running: () => void
}


const ikun: IKun = {
  name: "why",
  age: 18,
  slogan: "你干嘛!",
  playBasketball: function() {}
}

// 作用: 接口被类实现
class Person implements IKun, IRun {
  name: string
  age: number
  slogan: string

  playBasketball() {
    
  }

  running() {

  }
}

const ikun2 = new Person()
const ikun3 = new Person()
const ikun4 = new Person()
console.log(ikun2.name, ikun2.age, ikun2.slogan)
ikun2.playBasketball()
ikun2.running()

```





## TS中类型检测-鸭子类型

```ts
// TypeScript对于类型检测的时候使用的鸭子类型
// 鸭子类型: 如果一只鸟, 走起来像鸭子, 游起来像鸭子, 看起来像鸭子, 那么你可以认为它就是一只鸭子
// 鸭子类型, 只关心属性和行为, 不关心你具体是不是对应的类型

class Person {
  constructor(public name: string, public age: number) {}

  running() {}
}

class Dog {
  constructor(public name: string, public age: number) {}
  running() {}
}

function printPerson(p: Person) {
  console.log(p.name, p.age)
}

printPerson(new Person("why", 18))
// printPerson("abc")
printPerson({name: "kobe", age: 30, running: function() {}})
printPerson(new Dog("旺财", 3))

const person: Person = new Dog("果汁", 5)


export {}

```

## TS严格字面量赋值检测

```ts
interface IPerson {
  name: string
  age: number
}


// 1.奇怪的现象一: 
// 定义info, 类型是IPerson类型
const obj = {
  name: "why",
  age: 18,

  // 多了一个height属性
  height: 1.88
}
const info: IPerson = obj


// 2.奇怪的现象二:
function printPerson(person: IPerson) {

}
const kobe = { name: "kobe", age: 30, height: 1.98 }
printPerson(kobe)


// 解释现象
// 第一次创建的对象字面量, 称之为fresh(新鲜的)
// 对于新鲜的字面量, 会进行严格的类型检测. 必须完全满足类型的要求(不能有多余的属性)
const obj2 = {
  name: "why",
  age: 18,

  height: 1.88
}

const p: IPerson = obj2

export {}

```



# TypeScript枚举类型

- 枚举类型是为数不多的TypeScript特性有的特性之一:
  - 枚举其实就是`将一组可能出现的值，一个个列举出来`，定义在一个类型中，这个类型就是枚举类型; 
  - 枚举允许开发者定义一组命名常量，常量可以是数字、字符串类型;
  - `Enum 成员值都是只读的，不能重新赋值`

```ts
// 定义枚举类型
enum Direction {
  LEFT,
  RIGHT
}

const d1: Direction = Direction.LEFT

function turnDirection(direction: Direction) {
  switch(direction) {
    case Direction.LEFT:
      console.log("角色向左移动一个格子")
      break
    case Direction.RIGHT:
      console.log("角色向右移动一个格子")
      break
  }
}

// 监听键盘的点击
turnDirection(Direction.LEFT)

export {}

```

## 枚举类型的值

- 枚举类型默认是有值的，比如上面的枚举，默认值是这样的:
- 当然，我们也可以给枚举其他值:
  - 这个时候会从100进行递增;
- 我们也可以给他们赋值其他的类型:

```ts
enum Color {
  Red,
  Green,
  Blue
}

// 等同于
enum Color {
  Red = 0,
  Green = 1,
  Blue = 2
}
```



```ts
// 定义枚举类型
// enum Direction {
//   LEFT = 0,
//   RIGHT = 1
// }

// enum Direction {
//   LEFT = 100,
//   RIGHT
// }

enum Direction {
  LEFT = "LEFT",
  RIGHT = "RIGHT"
}

//计算式
enum Operation {
  Read = 1 << 0,
  Write = 1 << 1,
  foo = 1 << 2
}

const d1: Direction = Direction.LEFT

export {}

```



# TypeScript泛型编程

## 认识泛型

- 软件工程的主要目的是构建不仅仅明确和一致的API，还要让你的代码具有很强的可重用性:
  - 比如我们可以通过函数来封装一些API，通过`传入不同的函数参数`，让函数帮助我们完成不同的操作; 
  - 但是对于`参数的类型是否也可以参数化`呢?
- 什么是`类型的参数化`?
  - 我们来提一个需求:`封装一个函数，传入一个参数，并且返回这个参数;`
- 如果我们是TypeScript的思维方式，要考虑这个`参数和返回值的类型需要一致:`

```ts
function getFirst(arr:number): number {
  return arr;
}
```

- 上面的代码虽然实现了，但是不适用于其他类型，比如string、boolean、Person等类型:

```ts
function f(arr:any[]):any {
  return arr[0];
}
```



## 泛型实现类型的参数化

- 虽然`any`是可以的，但是定义为`any`的时候，我们其实已经丢失了类型信息:
  - 比如我们传入的是一个number，那么我们希望返回的可不是any类型，而是number类型;
  - 所以，我们需要在函数中可以捕获到参数的类型是number，并且同时使用它来作为返回值的类型;
- 我们需要在这里使用一种特性的变量 - `类型变量(type variable)`，`它作用于类型，而不是值:`
- 这里我们可以使用两种方式来调用它:
  - 方式一:通过 `<类型>` 的方式将类型传递给函数;
  - 方式二:通过`类型推导(type argument inference)`，自动推到出我们传入变量的类型:
    - 在这里会推导出它们是 `字面量类型`的，因为`字面量类型对于我们的函数也是适用的`

```ts
// 1.理解形参和实例参数化, 但是参数的类型是固定的
// function foo(name: string, age: number) {

// }
// foo("why", 19)
// foo("kobe", 30)


// 2.定义函数: 将传入的内容返回
// number/string/{name: string}
function bar<Type>(arg: Type): Type {
  return arg
}

// 2.1. 完整的写法
const res1 = bar<number>(123)
const res2 = bar<string>("abc")
const res3 = bar<{name: string}>({ name: "why" })

// 2.2. 省略的写法
const res4 = bar("aaaaaaaaa")
const res5 = bar(11111111)

// let message = "Hello World"

```

## 泛型的基本补充

- 当然我们也可以传入多个类型:
- 平时在开发中我们可能会看到一些常用的名称: 
  - `T`:Type的缩写，类型
  - `K、V`:key和value的缩写，键值对
  - `E`:Element的缩写，元素
  - `O`:Object的缩写，对象

```ts
function foo<T, E>(arg1: T, arg2: E) {

}

foo(10, 20)
foo(10, "abc")
foo<string, { name: string }>("abc", { name: "why" })

export {}

```



## 泛型接口

- 在定义`接口`的时候我们也可以使用泛型:

```ts
//接口定义
interface IKun<Type = string> {
  name: Type
  age: number
  slogan: Type
}

const kunkun: IKun<string> = {
  name: "why",
  age: 18,
  slogan: "哈哈哈"
}

const ikun2: IKun<number> = {
  name: 123,
  age: 20,
  slogan: 666
}

const ikun3: IKun = {
  name: "kobe",
  age: 30,
  slogan: "坤坤加油!"
}


export {}

```

## 泛型类

```ts
class Point<Type = number> {
  x: Type
  y: Type
  constructor(x: Type, y: Type) {
    this.x = x
    this.y = y
  }
}

const p1 = new Point(10, 20)
console.log(p1.x)
const p2 = new Point("123", "321")
console.log(p2.x)

export {}

```



## 泛型约束!!

- 有时候我们希望传入的`类型有某些共性`，但是这些共性可能不是在同一种类型中:
  - 比如string和array都是有length的，或者某些对象也是会有length属性的;
  - 那么只要是拥有length的属性都可以作为我们的参数类型，那么应该如何操作呢?
- 这里表示是`传入的类型必须有这个属性`，也可以有其他属性，但是必须至少有这个成员。

```ts
interface ILength {
  length: number
}

// 1.getLength没有必要用泛型
function getLength(arg: ILength) {
  return arg.length
}

const length1 = getLength("aaaa")
const length2 = getLength(["aaa", "bbb", "ccc"])
const length3 = getLength({ length: 100 })


// 2.获取传入的内容, 这个内容必须有length属性
// Type相当于是一个变量, 用于记录本次调用的类型, 所以在整个函数的执行周期中, 一直保留着参数的类型
function getInfo<Type extends ILength>(args: Type): Type {
  return args
}

const info1 = getInfo("aaaa")
const info2 = getInfo(["aaa", "bbb", "ccc"])
const info3 = getInfo({ length: 100 })

// getInfo(12345)
// getInfo({})

export {}


```

- 在泛型约束中使用`类型参数(Using Type Parameters in Generic Constraints)`
  - 你可以声明一个类型参数，这个类型参数被其他类型参数约束;
- 举个栗子:我们希望获取一个对象给定属性名的值
  - 我们需要确保我们不会获取 obj 上不存在的属性; 
  - 所以我们在两个类型之间建立一个约束;

```ts
// 传入的key类型, obj当中key的其中之一
interface IKun {
  name: string
  age: number
}

type IKunKeys = keyof IKun // "name"|"age"

function getObjectProperty<O, K extends keyof O>(obj: O, key: K){
  return obj[key]
}

const info = {
  name: "why",
  age: 18,
  height: 1.88
}

const name = getObjectProperty(info, "name")

export {}

```



## 映射类型!!

- 有的时候，`一个类型需要基于另外一个类型`，但是你又`不想拷贝一份`，这个时候可以考虑使用`映射类型`。 
  - 大部分内置的工具都是通过映射类型来实现的;
  - 大多数类型体操的题目也是通过映射类型完成的;
- `映射类型建立在索引签名的语法上`:
  - 映射类型，就是使用了 `PropertyKeys` 联合类型的泛型;
  - 其中 `PropertyKeys` 多是通过 `keyof` 创建，然后`循环遍历键名创建一个类型;`

```ts
// TypeScript提供了映射类型: 函数
// 映射类型不能使用interface定义
// Type = IPerson
// keyof = "name" | "age"
type MapPerson<Type> = {
  // 索引类型以此进行使用
  [aaa in keyof Type]: Type[aaa]

  // name: string
  // age: number
}


interface IPerson {
  name: string
  age: number
}

// 拷贝一份IPerson
// interface NewPerson {
//   name: string
//   age: number
// }
type NewPerson = MapPerson<IPerson>


export {}


```

### 映射修饰符

- 在使用`映射类型`时，有两个额外的修饰符可能会用到: 
  - 一个是 `readonly`，用于设置属性只读;
  - 一个是 `?` ，用于设置属性可选;
- 你可以通过前缀 - 或者 + 删除或者添加这些修饰符，如果没有写前缀，相当于使用了 + 前缀。

```ts
type MapPerson<Type> = {
  readonly [Property in keyof Type]?: Type[Property]
}

interface IPerson {
  name: string
  age: number
  height: number
  address: string
}

type IPersonOptional = MapPerson<IPerson>

const p: IPersonOptional = {

}

export {}


```



```ts
type MapPerson<Type> = {
  -readonly [Property in keyof Type]-?: Type[Property]
}

interface IPerson {
  name: string
  age?: number
  readonly height: number
  address?: string
}

// 
type IPersonRequired = MapPerson<IPerson>

const p: IPersonRequired = {
  name: "why",
  age: 18,
  height: 1.88,
  address: "广州市"
}


export {}


```

# TypeScript扩展

## TypeScript模块化

- JavaScript 有一个s很长的处理模块化代码的历史，TypeScript 从 2012 年开始跟进，现在已经实现支持了很多格式。但是随着 时间流逝，社区和 JavaScript 规范已经使用为名为 `ES Module`的格式，这也就是我们所知的 `import/export` 语法。
  - ES 模块在 2015 年被添加到 JavaScript 规范中，到 2020 年，大部分的 web 浏览器和 JavaScript 运行环境都已经广泛支持。 
  - 所以在TypeScript中最主要使用的模块化方案就是`ES Module`;

![image-20230915192409470](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230915192409470.png)

## 非模块(Non-modules)

- TypeScript 认为什么是一个模块。

  - JavaScript 规范声明任何`没有 export 的 JavaScript 文件都应该被认为是一个脚本，而非一个模块。`
  - 在一个脚本文件中，`变量和类型会被声明在共享的全局作用域，`将多个输入文件合并成一个输出文件，或者在 HTML使用多 个 <script> 标签加载这些文件。

- 如果你有一个文件，现在`没有任何 import 或者 export`，但是`你希望它被作为模块处理，添加这行代码:`

  ```ts
  export {}
  ```

- 这会`把文件改成一个没有导出任何内容的模块`，这个语法可以生效，无论你的模块目标是什么。

## 内置类型导入

- TypeScript 4.5 也允许单独的导入，你需要使用 `type` 前缀 ，表明被导入的是一个类型:

![image-20230915193023348](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230915193023348.png)

- 这些可以让一个非 TypeScript 编译器比如 Babel、swc 或者 esbuild 知道什么样的导入可以被安全移除。





## 命名空间namespace(了解)

- TypeScript 有它自己的模块格式，名为 `namespaces` ，它在 ES 模块标准之前出现。
  - 命名空间在TypeScript早期时，称之为`内部模块`，目的是将一个模块内部再进行作用域的划分，防止一些命名冲突的问题;
  - 虽然命名空间没有被废弃，但是由于 ES 模块已经拥有了命名空间的大部分特性，因此更推荐使用 ES 模块，这样才能与 JavaScript 的(发展)方向保持一致。

```ts

// export function formatPrice() {

// }

// export function formatDate() {
  
// }

//命名空间
export namespace price {
  export function format(price: string) {
    return "¥" + price
  }

  export const name = "price"
}

export namespace date {
  export function format(dateString) {
    return "2022-10-10"
  }

  const name = "date"
}


// export {}

```

```ts
import { price, date } from "./utils/format";


// 使用命名空间中的内容
price.format("1111")
date.format("22222")


```

## 类型的查找

- typescript文件:`.d.ts`文件
  - 我们之前编写的typescript文件都是 `.ts` 文件，这些文件最终会输出 `.js` 文件，也是我们通常编写代码的地方;
  - 还有另外一种文件 `.d.ts` 文件，它是用来做类型的声明(declare)，称之为`类型声明(Type Declaration)`或者`类型定义(Type Definition)`文件。
  - 它仅仅用来做类型检测，告知typescript我们有哪些类型;
- 那么typescript会在哪里查找我们的类型声明呢? 
  - `内置类型声明`;
  - `外部定义类型声明`;
  - `自己定义类型声明`;

### 内置类型声明

- `内置类型声明`是typescript自带的、帮助我们内置了JavaScript运行时的一些标准化API的声明文件; 
  - 包括比如Function、String、Math、Date等内置类型;
  - 也包括运行环境中的DOM API，比如Window、Document等;
- TypeScript 使用模式命名这些声明文件lib.[something].d.ts。

![image-20230915194737674](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230915194737674.png)

- 内置类型声明通常在我们`安装typescript的环境中会带有的`;
  - https://github.com/microsoft/TypeScript/tree/main/lib



### 外部定义类型声明--第三方库

- `外部类型声明`通常是我们使用一些库(比如第三方库)时，需要的一些类型声明。 

- 这些库通常有两种类型声明方式:

  - 方式一:在自己库中进行类型声明(`编写.d.ts文件`)，比如axios

  - 方式二:通过`社区的一个公有库DefinitelyTyped存放类型声明文件`

  - 该库的GitHub地址:https://github.com/DefinitelyTyped/DefinitelyTyped/

  - 该库查找声明安装方式的地址:https://www.typescriptlang.org/dt/search?search= 

  - 比如我们安装`react`的类型声明:

    - ```shell
      npm i @types/react --save-dev
      ```



### 自己定义类型声明

- 什么情况下需要自己来定义声明文件呢?
  - 情况一:我们使用的第三方库是一个纯的JavaScript库，没有对应的声明文件;比如lodash 
  - 情况二:我们给自己的代码中声明一些类型，方便在其他地方直接进行使用;

```ts
// 给自己的代码添加类型声明文件
// 平时使用的代码中用到的类型, 直接在当前位置进行定义或者在业务文件夹某一个位置编写一个类型文件即可
type IDType = number | string
interface IKun {
  name: string
  age: number
  slogan: string
}
```



## declare

### declare 声明模块

- 我们也可以`声明模块`，比如lodash模块默认不能使用的情况，可以自己来声明这个模块:

  

- 声明模块的语法: `declare module '模块名' {}`。 

  - 在`声明模块的内部`，我们可以通过 `export` 导出对应库的类、函数等;

```ts
declare module "lodash" {
  export function join(...args: any[]): any
}

// 为自己的 变量/函数/类 定义类型声明
declare const whyName: string
declare const whyAge: number
declare const whyHeight: number

declare function foo(bar: string): string

declare class Person {
  constructor(public name: string, public age: number)
}
```

![image-20230915201929640](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230915201929640.png)

![image-20230915202140205](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230915202140205.png)

### declare声明文件

- 在某些情况下，我们也可以`声明文件`:
  - 比如在`开发vue的过程中，默认是不识别我们的.vue文件的，那么我们就需要对其进行文件的声明;` 
  - 比如在开发中我们使用了 jpg 这类图片文件，默认typescript也是不支持的，也需要对其进行声明;

```ts
// 作为一个第三方库为其他开发者提供类型声明文件 .d.ts => axios.d.ts


// 声明文件模块
declare module "*.png"
declare module "*.jpg"
declare module "*.jpeg"
declare module "*.svg"

declare module "*.vue"

```

### declare 命名空间 

- 比如我们在index.html中直接引入了jQuery:
  - CDN地址: https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js 
- 我们可以进行命名空间的声明:
- 在main.ts中就可以使用了:

```ts
// 声明成模块(不合适)
// 声明命名空间
declare namespace $ {
  export function ajax(settings: any): any
}
```

![image-20230915201650673](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230915201650673.png)



## tsconfig.json

### 认识tsconfig.json文件

- 什么是`tsconfig.json`文件呢?(官方的解释)

  - 当目录中出现了 `tsconfig.json` 文件，则说明该目录是 `TypeScript` 项目的根目录; 

  - `tsconfig.json` 文件指定了`编译项目所需的根目录下的文件以及编译选项。`

  - 官方的解释有点“官方”，直接看我的解释。

  - tsconfig.json文件有两个作用:

    - 作用一(主要的作用):让`TypeScript Compiler`在`编译`的时候，知道`如何去编译TypeScript代码`和`进行类型检测;`
      - 比如是否允许不明确的this选项，是否允许隐式的any类型;
      - 将TypeScript代码编译成什么版本的JavaScript代码;
    - 作用二:让`编辑器`(比如VSCode)可以`按照正确的方式识别TypeScript代码;`
      - 对于哪些语法进行提示、类型错误检测等等;

  - `JavaScript` 项目可以使用 `jsconfig.json` 文件，它的作用与 `tsconfig.json` 基本相同，只是默认启用了一些 JavaScript 相关的

    编译选项。



### tsconfig.json配置

- tsconfig.json在编译时如何被使用呢?
  - 在调用 `tsc` 命令并且`没有其它输入文件参数`时，编译器将由`当前目录开始向父级目录寻找包含 tsconfig 文件的目录。`
  - 调用 `tsc 命令并且没有其他输入文件参数`，可以使用 `--project` (或者只是 -p)的命令行选项来`指定包含了 tsconfig.json 的 目录;`
  - 当命令行中`指定了输入文件参数`， tsconfig.json 文件会被忽略;
- `webpack`中使用`ts-loader`进行打包时，也会自动读取tsconfig文件，根据配置编译TypeScript代码。
- tsconfig.json文件包括哪些选项呢?
  - tsconfig.json本身包括的选项非常非常多，我们不需要每一个都记住;
  - 可以查看文档对于每个选项的解释:https://www.typescriptlang.org/tsconfig
  - 当我们开发项目的时候，选择TypeScript模板时，tsconfig文件默认都会帮助我们配置好的;



### tsconfig.json顶层选项

![image-20230920093657431](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230920093657431.png)

![image-20230920093722211](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230920093722211.png)



### tsconfig.json文件

- `tsconfig.json`是用于配置`TypeScript`编译时的配置选项:
  - https://www.typescriptlang.org/tsconfig 
- 我们这里讲解几个比较常见的:

![image-20230920094354296](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230920094354296.png)

![image-20230920095414367](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230920095414367.png)





# TypeScript类型体操
