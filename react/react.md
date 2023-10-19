#  React是什么

- 官方对它的解释：用于构建用户界面的 `JavaScript` 库；


## React的特点

> ### 声明式编程
>

- `声明式编程`是目前整个大前端开发的模式：Vue、React、Flutter、SwiftUI；
- 它允许我们`只需要维护自己的状态，当状态改变时，React可以根据最新的状态去渲染我们的UI界面`；

> ### 组件化开发
>

-  组件化开发页面目前前端的流行趋势，我们会将复杂的界面拆分成一个个小的组件；

> ### 多平台适配
>

![image-20230902004216280](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230902004216280.png)

## React开发依赖

> ### 开发React必须依赖三个库：
>

-  `react`：包含react所必须的核心代码 
- `react-dom`：react渲染在不同平台所需要的核心代码 
- `babel`：将jsx转换成React代码的工具

> ### 为什么要进行拆分呢？原因就是`react-native`
>

- react包中包含了`react web`和`react-native`所共同拥有的核心代码。 

- react-dom针对`web和native`所完成的事情不同： 

  - `web端`：react-dom会将`jsx`最终渲染成`真实的DOM`，显示在浏览器中 


  - `native端`：react-dom会将jsx最终渲染成`原生的控件`（比如Android中的Button，iOS中的UIButton）。

```html
  <script crossorigin src="https://unpkg.com/react@16/umd/react.development.js"></script>

  <script crossorigin src="https://unpkg.com/react-dom@16/umd/react-dom.development.js"></script>

  <script src="https://unpkg.com/babel-standalone@6/babel.min.js"></script>
```

## Babel**和React的关系**

> babel是什么呢?

- Babel ，又名 Babel.js。
- 是目前前端使用非常广泛的`编译器、转移器`。
- 比如当下很多浏览器并不支持ES6的语法，但是确实ES6的语法非常的简洁和方便，我们开发时希望使用它。
- 那么编写源码时我们就可以使用ES6来编写，之后通过`Babel`工具，`将ES6转成大多数浏览器都支持的ES5的语法。`

> React和Babel的关系:

- 默认情况下`开发React其实可以不使用babel`。
-  但是前提是我们自己使用 `React.createElement` 来编写源代码，它编写的代码非常的繁琐和可读性差。 
- 那么我们就可以直接编写`jsx(JavaScript XML)`的语法，并且让`babel`帮助我们转换成`React.createElement。`

## Hello World(初体验)

- 第一步:在界面上通过**React显示一个Hello World**
  - 注意:这里我们编写React的script代码中，必须添加 `type="text/babel"`，作用是可以让`babel解析jsx的语法`
- `ReactDOM.createRoot`**函数:用于创建一个`React根`，之后渲染的内容会包含在这个根中** 
  - 参数:将渲染的内容，挂载到哪一个HTML元素上
    - 这里我们已经提定义一个 id 为 app 的 div 
  - `root.render函数`:
    - 参数:要渲染的根组件
- 我们可以通过**{}语法来引入外部的变量或者表达式**

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hello React</title>
</head>
<body>

  <div id="root"></div>
  <div id="app"></div>
  
  <!-- 添加依赖 -->
  <!-- 依赖三个包 -->
  <!-- CDN引入 -->
  <script crossorigin src="https://unpkg.com/react@18/umd/react.development.js"></script>
  <script crossorigin src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script> 
  <!-- babel -->
  <script src="https://unpkg.com/babel-standalone@6/babel.min.js"></script>

  <!-- 下载引入 -->

  <!-- npm下载引入(脚手架) -->

  <script type="text/babel">
    // 编写React代码(jsx语法)
    // jsx语法 -> 普通的JavaScript代码 -> babel

    // 渲染Hello World
    // React18之前: ReactDOM.render
    // ReactDOM.render(<h2>Hello World</h2>, document.querySelector("#root"))

    // React18之后:
    const root = ReactDOM.createRoot(document.querySelector("#root"))
    root.render(<h2>Hello World</h2>)

    // const app = ReactDOM.createRoot(document.querySelector("#app"))
    // app.render(<h2>你好啊, 李银河</h2>)

  </script>

</body>
</html>
```



# React组件化开发(一)

## react组件化开发（类组件）

- 整个逻辑其实可以看做一个整体，那么我们就可以将其封装成一个组件:
  - 我们说过`root.render` 参数是一个`HTML元素或者一个组件`; 
  - 所以我们可以先将之前的业务逻辑封装到一个组件中，然后传入到 `ReactDOM.render` 函数中的第一个参数;
- 在**React中，如何封装一个组件呢?**这里我们暂时使用`类的方式封装组件`:
  - 1.定义一个类(`类名大写，组件的名称是必须大写的，小写会被认为是HTML元素`)，`继承自React.Component` 
  - 2.实现当前组件的`render函数`
    - render当中返回的jsx内容，就是之后React会帮助我们渲染的内容

```js
  <script type="text/babel">
    // 1.定义App根组件
    class App extends React.Component {
      constructor() {
        super()
        this.state = {
          message: "Hello World"
        }
      }

      render() {
        const { message } = this.state

        return (
          <div>
            <h2>{message}</h2>
          </div>
        )
      }
    }

    // 2.创建root并且渲染App组件
    const root = ReactDOM.createRoot(document.querySelector("#root"))
    root.render(<App/>)
  </script>
```

## 组件化-数据依赖

- 在组件中的数据，我们可以分成两类： 

  1. `参与界面更新的数据`：当数据变量时，需要更新组件渲染的内容； 
  2. `不参与界面更新的数据`：当数据变量时，不需要更新将组建渲染的内容；
- 参与界面更新的数据我们也可以称之为是**`参与数据流`**，这个数据是`定义在当前对象的**state**中`
  - 我们可以通过在**`构造函数**中 this.state = {定义的数据}` **
  - **当我们的`数据发生变化`时，我们可以调用 **`this.setState 来更新数据`**，并且通知React进行update操作； 
    - 在进行update操作时，就会**`重新调用render函数`**，并且使用最新的数据，来渲染界面

```js
 class App extends React.Component {
      constructor() {
        super()
        this.state = {
          message: "Hello World"
        }
      }

      render() {
        const { message } = this.state

        return (
          <div>
            <h2>{message}</h2>
          </div>
        )
      }
    }
```

## 组件化-事件绑定

- React 事件的`命名`采用`小驼峰式(camelCase)`，而不是纯小写;
- 我们需要`通过{}传入一个事件处理函数`，这个函数会在事件发生时被执行;

### this的绑定问题

- 在事件执行后，我们`可能需要获取当前类的对象中相关的属性`，这个时候需要用到`this`
  - 如果我们这里直接打印this，也会发现它是一个`undefined`
- 为什么是undefined呢?
  * 原因是btnClick函数并不是我们主动调用的，而且当button发生改变时，React内部调用了btnClick函数; 
  * `而它内部调用时，并不知道要如何绑定正确的this;`
- 如何解决this的问题呢?
  - `方案一`:bind给btnClick显示绑定this 
  - `方案二`:使用 ES6 class fields 语法
  - `方案三`:事件监听时传入箭头函数(个人推荐)

```js
    // const obj = {
    //   name: "obj",
    //   foo: function() {
    //     console.log("foo:", this)
    //   }
    // }

    // // obj.foo()

    // const config = {
    //   onClick: obj.foo.bind(obj)
    // }

    // const click = config.onClick
    // click()

    /*
      this的四种绑定规则:
        1.默认绑定 独立执行 foo()
        2.隐式绑定 被一个对象执行 obj.foo() -> obj
        3.显式绑定: call/apply/bind foo.call("aaa") -> String("aaa")
        4.new绑定: new Foo() -> 创建一个新对象, 并且赋值给this
    */

    // 1.定义App根组件
    class App extends React.Component {
      // class fields
      name = "App"

      constructor() {
        super()
        this.state = {
          message: "Hello World",
          counter: 100
        }

        this.btn1Click = this.btn1Click.bind(this)
      }

      btn1Click() {
        console.log("btn1Click", this);
        this.setState({ counter: this.state.counter + 1 })
      }

      btn2Click = () => {
        console.log("btn2Click", this)
        this.setState({ counter: 1000 })
      }

      btn3Click() {
        console.log("btn3Click", this);
        this.setState({ counter: 9999 })
      }

      render() {
        const { message } = this.state

        return (
          <div>
            {/* 1.this绑定方式一: bind绑定 */}
            <button onClick={this.btn1Click}>按钮1</button>

            
            {/* 2.this绑定方式二: ES6 class fields */}
            <button onClick={this.btn2Click}>按钮2</button>


            {/* 3.this绑定方式三: 直接传入一个箭头函数(重要) */}
            <button onClick={() => console.log("btn3Click")}>按钮3</button>

            <button onClick={() => this.btn3Click()}>按钮3</button>


            <h2>当前计数: {this.state.counter}</h2>
          </div>
        )
      }
    }


```



> ##  事件绑定中的this
>

- `默认情况下是undefined`

  - 因为在正常的DOM操作中，监听点击，监听函数中的`this`其实是**`节点对象`**（比如说是button对象）； 


  - 这次因为React并`不是直接渲染成真实的DOM`，我们所编写的button只是一个语法糖，它的`本质React的Element对象；` 


  - 那么在这里发生监听的时候，react在执行函数时并**`没有绑定this`**，默认情况下就是一个`undefined`；

- 我们在绑定的函数中，可能想要使用当前对象，比如执行 this.setState 函数，就必须拿到`当前对象的this`

  - 我们就需要在传入函数时，`给这个函数直接绑定this`

  - 类似于下面的写法:

    ```html
    <button onClick={this.changeText.bind(this)}>改变文本</button>
    ```


![事件this内部的绑定规则](https://cdn.jsdelivr.net/gh/OneOneT/images@main/%E4%BA%8B%E4%BB%B6this%E5%86%85%E9%83%A8%E7%9A%84%E7%BB%91%E5%AE%9A%E8%A7%84%E5%88%99.jpg)

```js
    class App extends React.Component  {
      // 组件数据
      constructor() {
        //调用父类的构造函数
        super()

        //参与数据流
        this.state = {
          message: "Hello Word"
        }

         //绑定this
        this.handleBtn = this.handleBtn.bind(this)
      }
      
       handleBtn() {
        this.setState({
          message: "Hello React"
        })
      }

      // render当中返回的jsx内容
      render() {
        const {message} = this.state
        return (
          <div>
            <h2>{message}</h2>
            {/*
              onClick={this.handleBtn}只是引用this.handleBtn 并没调用
              当函数点击时回调函数, 而函数内部的调用是默认调用this=>window,但jsx内部开启了严格模式,这是的this指向undefined
           */}
            <button onClick={this.handleBtn}>更改</button>
          </div>
      
        )
      }

    

    }
```



### 事件参数传递

- 在执行事件函数时，有可能我们需要获取一些参数信息:比如**`event对象、其他参数`**
- 情况一:`获取event对象`
  - 很多时候我们需要拿到`event对象`来做一些事情(比如阻止默认行为)
  - 那么默认情况下，`event对象有被直接传入`，函数就可以获取到event对象;
- 情况二:`获取更多参数`
  - 有更多参数时，我们最好的方式就是`传入一个箭头函数，主动执行的事件函数，并且传入相关的其他参数;`

```js
    // function foo(name, age, height) {}
    // const bar = foo.bind("aaa", "kobe", 30)
    // bar("event")

    // 1.定义App根组件
    class App extends React.Component {
      constructor() {
        super()
        this.state = {
          message: "Hello World"
        }
      }

      btnClick(event, name, age) {
        console.log("btnClick:", event, this)
        console.log("name, age:", name, age)
      }

      render() {
        const { message } = this.state

        return (
          <div>
            {/* 1.event参数的传递 */}
            <button onClick={this.btnClick.bind(this)}>按钮1</button>
            <button onClick={(event) => this.btnClick(event)}>按钮2</button>

            
            {/* 2.额外的参数传递 */}
            <button onClick={this.btnClick.bind(this, "kobe", 30)}>按钮3(不推荐)</button>

            <button onClick={(event) => this.btnClick(event, "why", 18)}>按钮4</button>
          </div>
        )
      }
    }

```



### 补充

```js
"use strict";

//严格模式下 => 默认绑定this指向underfind 
function bar() {
  console.log('严格模式下bar:', this);
}

//默认调用this指向(window)
bar()//undefined

```

```js
    function foo() {
      console.log('foo:', this);
    }

    //默认调用this指向(window)
    foo()//winddow

    class Student {

      running() {
        console.log("running:", this);
      }
    }

    const stu = new Student()
    //隐试绑定
    stu.running()//Student {}

    const friend = stu.running
    //默认调用(window)
    //ES6 的class内部默认为严格模式
    // 默认绑定 => window => 严格模式下 => undefined
    
    friend()//undefined
```



## React**条件渲染**

- 某些情况下，界面的内容会`根据不同的情况显示不同的内容`，或者`决定是否渲染某部分内容`: 
  - 在`vue`中，我们会通过`指令`来控制:比如v-if、v-show;
  - 在`React`中，所有的`条件判断都和普通的JavaScript代码一致`;
- 常见的条件渲染的方式有哪些呢? 
  - 方式一:`条件判断语句`
    - 适合逻辑较多的情况 
  - 方式二:`三元运算符`
    - 适合逻辑比较简单 
  - 方式三:`与运算符 &&`
    - 适合如果条件成立，渲染某一个组件;如果条件不成立，什么内容也不渲染;
  - `v-show的效果`
    - 主要是控制`display`属性是否为`none`

```js
    // 1.定义App根组件
    class App extends React.Component {
      constructor() {
        super()
        this.state = {
          message: "Hello World",

          isReady: false,

          friend: undefined
        }
      }

      render() {
        const { isReady, friend } = this.state

        // 1.条件判断方式一: 使用if进行条件判断
        let showElement = null
        if (isReady) {
          showElement = <h2>准备开始比赛吧</h2>
        } else {
          showElement = <h1>请提前做好准备!</h1>
        }

        return (
          <div>
            {/* 1.方式一: 根据条件给变量赋值不同的内容 */}
            <div>{showElement}</div>

            {/* 2.方式二: 三元运算符 */}
            <div>{ isReady ? <button>开始战斗!</button>: <h3>赶紧准备</h3> }</div>

            {/* 3.方式三: &&逻辑与运算 */}
            {/* 场景: 当某一个值, 有可能为undefined时, 使用&&进行条件判断 */}
            <div>{ friend && <div>{friend.name + " " + friend.desc}</div> }</div>
              
          </div>
        )
      }
    }
```



## React**列表渲染**

- 真实开发中我们会从服务器请求到大量的数据，数据会以列表的形式存储: 
  - 比如歌曲、歌手、排行榜列表的数据;
  - 比如商品、购物车、评论列表的数据;
  - 比如好友消息、动态、联系人列表的数据;
- 在**React中并没有像Vue模块语法中的v-for指令，而且需要我们通过JavaScript代码的方式组织数据，转成JSX:** 
  - 很多从Vue转型到React的同学非常不习惯，认为Vue的方式更加的简洁明了;
  - 但是React中的JSX正是因为和JavaScript无缝的衔接，让它可以更加的灵活;
  - 另外我经常会提到React是真正可以提高我们编写代码能力的一种方式;
- 如何展示列表呢?
  - 在React中，展示列表最多的方式就是使用`数组的map高阶函数`;
- 很多时候我们在展示一个数组中的数据之前，需要先对它进行一些处理: 
  - 比如`过滤`掉一些内容:`filter函数`
  - 比如`截取数组中的一部分内容`:`slice函数`(slice不会改变原数组,splice会修改原数组)

```js
    // 1.定义App根组件
    class App extends React.Component {
      constructor() {
        super()
        this.state = {
          students: [
            { id: 111, name: "why", score: 199 },
            { id: 112, name: "kobe", score: 98 },
            { id: 113, name: "james", score: 199 },
            { id: 114, name: "curry", score: 188 },
          ]
        }
      }

      render() {
        const { students } = this.state

        // 分数大于100的学生进行展示
        const filterStudents = students.filter(item => {
          return item.score > 100
        })

        // 分数大于100, 只展示两个人的信息
        // slice(start, end): [start, end)
        const sliceStudents = filterStudents.slice(0, 2)

        return (
          <div>
            <h2>学生列表数据</h2>
            <div className="list">
              {
                students.filter(item => item.score > 100).slice(0, 2).map(item => {
                  return (
                    <div className="item" key={item.id}>
                      <h2>学号: {item.id}</h2>
                      <h3>姓名: {item.name}</h3>
                      <h1>分数: {item.score}</h1>
                    </div>
                  )
                })
              }
            </div>
          </div>
        )
      }
    }

```

# React组件化开发(二)

## React-组件分类

- 组件化思想的应用:
  - 有了组件化的思想，我们在之后的开发中就要充分的利用它。
  - 尽可能的将页面拆分成一个个小的、可复用的组件。
  - 这样让我们的代码更加方便组织和管理，并且扩展性也更强。
- React**的组件相对于Vue更加的灵活和多样，按照不同的方式可以分成很多类组件:
  - `根据组件的定义方式`，可以分为:<u>函数组件</u>(Functional Component )和<u>类组件</u>(Class Component);
  - `根据组件内部是否有状态需要维护`，可以分成:<u>无状态组件</u>(Stateless Component )和<u>有状态组件</u>(Stateful Component); 
  - `根据组件的不同职责`，可以分成:<u>展示型组件</u>(Pressentational Component)和<u>容器型组件</u>(Container Component);
- 这些概念有很多重叠，但是他们最主要是关注数据逻辑和**UI展示的分离:** 
  - `函数组件`、`无状态组件`、`展示型组件`主要关注UI的展示;
  - `类组件`、`有状态组件`、`容器型组件`主要关注数据逻辑;
- 当然还有很多组件的其他概念:比如`异步组件`、`高阶组件`等。



### React-类组件

- `类组件`的定义有如下要求:
  - `组件的名称是大写字符开头`(无论类组件还是函数组件) 
  - 类组件需要`继承`自 `React.Component`
    - 类组件`必须实现render函数`
- 在ES6之前，可以通过create-react-class 模块来定义类组件，但是目前官网建议我们使用**ES6的class类定义。**
- 使用class定义一个组件:
  - constructor是可选的，我们通常在constructor中初始化一些数据; 
  - `this.state`中维护的就是我们`组件内部的数据`;
  - `render()` 方法是 class 组件中`唯一必须实现的方法`;

#### render函数的返回值

- 当 `render` 被调用时，它会检查 `this.props` 和 `this.state` 的变化并返回以下类型之一:

- React 元素:
  - 通常通过 JSX 创建。
  - 例如，<div /> 会被 React 渲染为 DOM 节点，<MyComponent /> 会被 React 渲染为自定义组件;
  - 无论是 <div /> 还是 <MyComponent /> 均为 React 元素。
- 数组或 fragments:使得 render 方法可以返回多个元素。 
- Portals:可以渲染子节点到不同的 DOM 子树中。
- 字符串或数值类型:它们在 DOM 中会被渲染为文本节点
- 布尔类型或 null:什么都不渲染。

```js
import React from "react";


// 1.类组件
class App extends React.Component {
  constructor() {
    super()

    this.state = {
      message: "App Component"
    }
  }

  render() {
    // const { message } = this.state
    // 1.react元素: 通过jsx编写的代码就会被编译成React.createElement, 所以返回的就是一个React元素
    // return <h2>{message}</h2>

    // 2.组件或者fragments(后续学习)
    // return ["abc", "cba", "nba"]
    // return [
    //   <h1>h1元素</h1>,
    //   <h2>h2元素</h2>,
    //   <div>哈哈哈</div>
    // ]

    // 3.字符串/数字类型
    // return "Hello World"

    return true
  }
}

export default App;

```



### React-函数组件

- 函数组件是使用`function`来进行定义的函数，只是`这个函数会返回和类组件中render函数返回一样的内容`。
- 函数组件有自己的特点(当然，后面我们会讲**hooks，就不一样了):** 
  - 没有生命周期，也会被更新并挂载，但是没有生命周期函数;
  - this关键字不能指向组件实例(因为没有组件实例);
  - 没有内部状态(state);

```js
// 函数式组件
function App(props) {
  // 返回值: 和类组件中render函数返回的是一致
  return <h1>App Functional Component</h1>
}

export default App
```



## React-生命周期

### 认识生命周期

- 很多的事物都有从`创建`到`销毁`的整个过程，这个`过程称之为是生命周期`;
- React**组件也有自己的生命周期，了解组件的生命周期可以让我们`在最合适的地方完成自己想要的功能`;**
- 生命周期和生命周期函数的关系:
- 生命周期**是一个抽象的概念，在生命周期的整个过程，分成了很多个阶段;** 
  - 比如`装载阶段(Mount)`，组件第一次在DOM树中被渲染的过程;
  - 比如`更新过程(Update)`，组件状态发生变化，重新更新渲染的过程;
  - 比如`卸载过程(Unmount)`，组件从DOM树中被移除的过程;
- React**内部为了告诉我们当前处于哪些阶段，会对我们组件内部实现的某些函数进行回调，这些函数就是生命周期函数:** 
  - 比如实现`componentDidMount`函数:`组件已经挂载到DOM上时`，就会回调;
  - 比如实现`componentDidUpdate`函数:`组件已经发生了更新时`，就会回调;
  - 比如实现`componentWillUnmount`函数:`组件即将被移除时`，就会回调;
  - 我们可以在这些回调函数中编写自己的逻辑代码，来完成自己的需求功能;
- 我们谈React生命周期时，主要谈的类的生命周期，因为函数式组件是没有生命周期函数的;(后面我们可以通过hooks来模拟一些生命 周期的回调)

### 生命周期解析

![image-20230902150016964](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230902150016964.png)

![image-20230902150905764](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230902150905764.png)

### **生命周期函数**

> Constructor

- 如果不初始化 state 或不进行方法绑定，则不需要为 React 组件实现构造函数。
- constructor中通常只做两件事情:
  - 通过给 this.state 赋值对象来初始化内部的state; 
  - 为事件绑定实例(this);

> componentDidMount

- componentDidMount() 会在组件挂载后(插入 DOM 树中)立即调用。
- componentDidMount中通常进行哪里操作呢?
  - 依赖于DOM的操作可以在这里进行;
  - 在此处发送网络请求就最好的地方;(官方建议)
  - 可以在此处添加一些订阅(会在componentWillUnmount取消订阅);

> componentDidUpdate

- componentDidUpdate() 会在更新后会被立即调用，`首次渲染不会执行此方法。`
  - 当组件更新后，可以在此处对 DOM 进行操作;
  - 如果你对更新前后的 props 进行了比较，也可以选择在此处s进行网络请求;(例如，当 props 未发生变化时，则不会执行网 络请求)。

>  componentWillUnmount

- componentWillUnmount() 会在组件卸载及销毁之前直接调用。
  - 在此方法中执行必要的清理操作;
  - 例如，清除 timer，取消网络请求或清除在 componentDidMount() 中创建的订阅等;

### 不常用生命周期函数

- 除了上面介绍的生命周期函数之外，还有一些不常用 的生命周期函数:
  - `getDerivedStateFromProps`:state 的值在任何 时候都依赖于 props时使用;该方法返回一个对象 来更新state;
  - `getSnapshotBeforeUpdate`:在React更新DOM 之前回调的一个函数，可以获取DOM更新前的一 些信息(比如说滚动位置);
  - [shouldComponentUpdate](#shouldComponentUpdate):该生命周期函数很 常用，但是我们等待讲性能优化时再来详细讲解;
- 另外，**React中还提供了一些过期的生命周期函数，这 些函数已经不推荐使用。**
- 更详细的生命周期相关的内容，可以参考官网:
  -  https://zh-hans.reactjs.org/docs/react-component.html

![image-20230902151005876](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230902151005876.png)

```js
import React from "react"

class HelloWorld extends React.Component {
  // 1.构造方法: constructor
  constructor() {
    console.log("HelloWorld constructor")
    super()

    this.state = {
      message: "Hello World"
    }
  }

  changeText() {
    this.setState({ message: "你好啊, 李银河" })
  }

  // 2.执行render函数
  render() {
    console.log("HelloWorld render")
    const { message } = this.state

    return (
      <div>
        <h2>{message}</h2>
        <p>{message}是程序员的第一个代码!</p>
        <button onClick={e => this.changeText()}>修改文本</button>
      </div>
    )
  }

  // 3.组件被渲染到DOM: 被挂载到DOM
  componentDidMount() {
    console.log("HelloWorld componentDidMount")
  }

  // 4.组件的DOM被更新完成： DOM发生更新
  componentDidUpdate(prevProps, prevState, snapshot) {
    console.log("HelloWorld componentDidUpdate:", prevProps, prevState, snapshot)
  }

  // 5.组件从DOM中卸载掉： 从DOM移除掉
  componentWillUnmount() {
    console.log("HelloWorld componentWillUnmount")
  }


  // 不常用的生命周期补充
  shouldComponentUpdate() {
    return true
  }

  getSnapshotBeforeUpdate() {
    console.log("getSnapshotBeforeUpdate")
    return {
      scrollPosition: 1000
    }
  }
}

export default HelloWorld

```



## React-组件通信

### 认识组件的嵌套

- 组件之间存在嵌套关系:
  - 在之前的案例中，我们只是创建了一个组件App;
  - 如果我们一个应用程序将所有的逻辑都放在一个组件中，那么这个组件就会变成非常的臃肿和难以维护; 
  - 所以组件化的核心思想应该是对组件进行拆分，拆分成一个个小的组件;
  - 再将这些组件组合嵌套在一起，最终形成我们的应用程序;
- 上面的嵌套逻辑如下，它们存在如下关系:
  - App组件是Header、Main、Footer组件的父组件; 
  - Main组件是Banner、ProductList组件的父组件;



### 认识组件间的通信

-  开发过程中，我们会经常遇到需要`组件之间相互进行通信`:
  - 比如App可能使用了多个Header，每个地方的Header展示的内容不同，那么我们就需要使用者传递给Header一些数据，让其进行展示;
  - 又比如我们在Main中一次性请求了Banner数据和ProductList数据，那么就需要传递给他们来进行展示; 
  - 也可能是子组件中发生了事件，需要由父组件来完成某些操作，那就需要子组件向父组件传递事件;

- 总之，在一个**React项目中，组件之间的通信是非常重要的环节;**
- 父组件在展示子组件，可能会传递一些数据给子组件: 
  - 父组件通过 `属性=值`的形式来`传递给子组件数据`; 
  - 子组件通过 `props` 参数`获取父组件传递过来的数据`;



### **父组件传递子组件** **-** **类组件和函数组件**

```js
//父组件

import React, { Component } from 'react'
import axios from "axios"

import MainBanner from './MainBanner'
import MainProductList from './MainProductList'

export class Main extends Component {
  constructor() {
    super()

    this.state = {
      banners: [],
      productList: []
    }
  }

  componentDidMount() {
    axios.get("http://123.207.32.32:8000/home/multidata").then(res => {
      const banners = res.data.data.banner.list
      const recommend = res.data.data.recommend.list
      this.setState({
        banners,
        productList: recommend
      })
    })
  }

  render() {
    const { banners, productList } = this.state

    return (
      <div className='main'>
        <div>Main</div>
      //传递给子组件
        <MainBanner banners={banners} title="轮播图"/>
        <MainBanner/>
        <MainProductList productList={productList}/>
      </div>
    )
  }
}

export default Main
```

```js
//子组件
import React, { Component } from 'react'
import PropTypes from "prop-types"

export class MainBanner extends Component {
  // static defaultProps = {
  //   banners: [],
  //   title: "默认标题"
  // }

  constructor(props) {
    super(props)

    this.state = {}
  }

  render() {
    // console.log(this.props)
    const { title, banners } = this.props

    return (
      <div className='banner'>
        <h2>封装一个轮播图: {title}</h2>
        <ul>
          {
            banners.map(item => {
              return <li key={item.acm}>{item.title}</li>
            })
          }
        </ul>
      </div>
    )
  }
}

// MainBanner传入的props类型进行验证
MainBanner.propTypes = {
  banners: PropTypes.array,
  title: PropTypes.string
}

// MainBanner传入的props的默认值
MainBanner.defaultProps = {
  banners: [],
  title: "默认标题"
}

export default MainBanner
```

#### 参数propTypes

- 对于传递给子组件的数据，有时候我们可能希望`进行验证`，特别是对于大型项目来说:
  - 当然，如果你项目中默认继承了`Flow`或者`TypeScript`，那么直接就可以进行`类型验证`; 
  - 但是，即使我们没有使用Flow或者TypeScript，也可以通过 `prop-types` 库来进行参数验证;
- 从 React v15.5 开始，`React.PropTypes` 已移入另一个包中:`prop-types` 库
- 更多的验证方式，可以参考官网:
  - https://zh-hans.reactjs.org/docs/typechecking-with-proptypes.html 
  - 比如验证数组，并且数组中包含哪些元素;
  - 比如验证对象，并且对象中包含哪些key以及value是什么类型;
  - 比如某个原生是必须的，使用 requiredFunc: PropTypes.func.isRequired
- 如果没有传递，我们希望有`默认值`呢? 
  - 我们使用`defaultProps`就可以了



### **子组件传递父组件**

- 某些情况，我们也需要`子组件向父组件传递消息`:
- 在`vue`中是通过`自定义事件`来完成的;
- 在`React`中同样是通过`props`传递消息，只是让`父组件给子组件传递一个回调函数`，在`子组件中调用这个函数即可;`

```js
//父组件

import React, { Component } from 'react'
import AddCounter from './AddCounter'
import SubCounter from './SubCounter'

export class App extends Component {
  constructor() {
    super()

    this.state = {
      counter: 100
    }
  }

  changeCounter(count) {
    this.setState({ counter: this.state.counter + count })
  }

  render() {
    const { counter } = this.state

    return (
      <div>
        <h2>当前计数: {counter}</h2>
        <AddCounter addClick={(count) => this.changeCounter(count)}/>
        <SubCounter subClick={(count) => this.changeCounter(count)}/>
      </div>
    )
  }
}

export default App
```

```js
//子组件

import React, { Component } from 'react'
// import PropTypes from "prop-types"

export class AddCounter extends Component {
  addCount(count) {
    this.props.addClick(count)
  }

  render() {

    return (
      <div>
        <button onClick={e => this.addCount(1)}>+1</button>
        <button onClick={e => this.addCount(5)}>+5</button>
        <button onClick={e => this.addCount(10)}>+10</button>
      </div>
    )
  }
}

// AddCounter.propTypes = {
//   addClick: PropTypes.func
// }

export default AddCounter
```

### React**中的插槽(slot)**

- 在开发中，我们`抽取了一个组件`，但是为了让这个组件具备更强的`通用性`，我们不能将组件中的内容限制为固定的**div、span等等 这些元素。**
- 我们应该让使用者可以决定某一块区域到底存放什么内容。
- 这种需求在**`Vue`当中有一个固定的做法是通过slot来完成的，React呢?**
- React**对于这种需要插槽的情况非常灵活，有两种方案可以实现:**
  - `组件的children子元素`;
  - `props属性传递React元素`;

```js
import React, { Component } from 'react'
import NavBar from './nav-bar'
import NavBarTwo from './nav-bar-two'

export class App extends Component {
  render() {
    const btn = <button>按钮2</button>

    return (
      <div>
        {/* 1.使用children实现插槽 */}
        <NavBar>
          <button>按钮</button>
          <h2>哈哈哈</h2>
          <i>斜体文本</i>
        </NavBar>

        {/* 2.使用props实现插槽 */}
        <NavBarTwo 
          leftSlot={btn}
          centerSlot={<h2>呵呵呵</h2>}
          rightSlot={<i>斜体2</i>}
        />
      </div>
    )
  }
}

export default App
```

#### children实现插槽

- 每个组件都可以获取到`props.children`:它包含组件的开始标签和结束标签之间的内容。

```js
import React, { Component } from 'react'
// import PropTypes from "prop-types"
import "./style.css"

export class NavBar extends Component {
  render() {
    const { children } = this.props
    console.log(children)

    return (
      <div className='nav-bar'>
        <div className="left">{children[0]}</div>
        <div className="center">{children[1]}</div>
        <div className="right">{children[2]}</div>
      </div>
    )
  }
}

// NavBar.propTypes = {
//   children: PropTypes.array
// }

export default NavBar
```

#### props实现插槽

- 通过**`children`实现的方案虽然可行，但是有一个`弊端`:`通过索引值获取传入的元素很容易出错，不能精准的获取传入的原生`;**
- 另外一个种方案就是使用 `props` 实现:
  - 通过`具体的属性名`，可以让我们在传入和获取时更加的精准;

```js
import React, { Component } from 'react'

export class NavBarTwo extends Component {
  render() {
    const { leftSlot, centerSlot, rightSlot } = this.props

    return (
      <div className='nav-bar'>
        <div className="left">{leftSlot}</div>
        <div className="center">{centerSlot}</div>
        <div className="right">{rightSlot}</div>
      </div>
    )
  }
}

export default NavBarTwo
```

#### 作用域插槽

```js
import React, { Component } from 'react'
import TabControl from './TabControl'

export class App extends Component {
  constructor() {
    super()

    this.state = {
      titles: ["流行", "新款", "精选"],
      tabIndex: 0
    }
  }

  tabClick(tabIndex) {
    this.setState({ tabIndex })
  }

  getTabItem(item) {
    if (item === "流行") {
      return <span>{item}</span>
    } else if (item === "新款") {
      return <button>{item}</button>
    } else {
      return <i>{item}</i>
    }
  }

  render() {
    const { titles, tabIndex } = this.state

    return (
      <div className='app'>
        <TabControl 
          titles={titles} 
          tabClick={i => this.tabClick(i)}
          // itemType={item => <button>{item}</button>}
          itemType={item => this.getTabItem(item)}
        />
        <h1>{titles[tabIndex]}</h1>
      </div>
    )
  }
}

export default App
```

```js
import React, { Component } from 'react'
import "./style.css"

export class TabControl extends Component {
  constructor() {
    super()

    this.state = {
      currentIndex: 0
    }
  }

  itemClick(index) {
    // 1.自己保存最新的index
    this.setState({ currentIndex: index })

    // 2.让父组件执行对应的函数
    this.props.tabClick(index)
  }

  render() {
    const { titles, itemType } = this.props
    const { currentIndex } = this.state

    return (
      <div className='tab-control'>
        {
          titles.map((item, index) => {
            return (
              <div 
                className={`item ${index === currentIndex?'active':''}`} 
                key={item}
                onClick={e => this.itemClick(index)}
              >
                {/* <span className='text'>{item}</span> */}
                {itemType(item)}
              </div>
            )
          })
        }
      </div>
    )
  }
}

export default TabControl
```



### 非父子组件通信

#### Context应用场景

- `非父子组件通信`
  - 在开发中，比较常见的数据传递方式是通过`props属性自上而下(由父到子)进行传递`。
  - 但是对于有一些场景:比如一些数据需要在多个组件中进行共享(地区偏好、UI主题、用户登录状态、用户信息等)。
  - 如果我们在顶层的App中定义这些信息，之后一层层传递下去，那么对于一些中间层不需要数据的组件来说，是一种冗余的 操作。
- 我们实现一个一层层传递的案例:
  - 我这边顺便补充一个小的知识点:Spread Attributes
- 但是，如果层级更多的话，一层层传递是非常麻烦，并且代码是非常冗余的:
  - React提供了一个API:`Context`;
  - Context 提供了一种`在组件之间共享此类值的方式`，而`不必显式地通过组件树的逐层传递 props`;
  - Context 设计目的是为了`共享那些对于一个组件树而言是“全局”的数据`，例如当前认证的用户、主题或首选语言;

```js
import React from "react"

// 1.创建一个Context
const ThemeContext = React.createContext({ color: "blue", size: 10 })

export default ThemeContext

```

```js
//app组件
import React, { Component } from 'react'
import Home from './Home'

import ThemeContext from "./context/theme-context"
import UserContext from './context/user-context'
import Profile from './Profile'

export class App extends Component {
  constructor() {
    super()

    this.state = {
      info: { name: "kobe", age: 30 }
    }
  }

  render() {
    const { info } = this.state

    return (
      <div>
        <h2>App</h2>
        {/* 1.给Home传递数据 */}
        {/* <Home name="why" age={18}/>
        <Home name={info.name} age={info.age}/>
        <Home {...info}/> */}

        {/* 2.普通的Home */}
        {/* 第二步操作: 通过ThemeContext中Provider中value属性为后代提供数据 */}
        <UserContext.Provider value={{nickname: "kobe", age: 30}}>
          <ThemeContext.Provider value={{color: "red", size: "30"}}>
            <Home {...info}/>
          </ThemeContext.Provider>
        </UserContext.Provider>
        <Profile/>
      </div>
    )
  }
}

export default App
```

```js
import React, { Component } from "react";
import ThemeContext from "./context/theme-context";
import UserContext from "./context/user-context";

export class HomeInfo extends Component {
  render() {
    // 4.第四步操作: 获取数据, 并且使用数据
    console.log(this.context);

    return (
      <div>
        <h2>HomeInfo: {this.context.color}</h2>
        <UserContext.Consumer>
          {(value) => {
            return <h2>Info User: {value.nickname}</h2>;
          }}
        </UserContext.Consumer>
      </div>
    );
  }
}

// 3.第三步操作: 设置组件的contextType为某一个Context
HomeInfo.contextType = ThemeContext;

export default HomeInfo;

```



#### Context相关API

> React.createContext

- 创建一个需要共享的`Context对象`:
- 如果一个`组件订阅了Context`，那么这个组件会从离自身最近的那个匹配的 Provider 中读取到当前的context值; 
- defaultValue是组件在顶层查找过程中没有找到对应的Provider，那么就使用默认值

![image-20230903013033913](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230903013033913.png)

> Context.Provider

- 每个 `Context` 对象都会返回一个 `Provider React` 组件，它允许消费组件`订阅 context 的变化`: 
- `Provider` 接收一个 `value 属性，传递给消费组件;`
- 一个 Provider 可以和多个消费组件有对应关系;
- 多个 Provider 也可以嵌套使用，里层的会覆盖外层的数据;
- `当 Provider 的 value 值发生变化时，它内部的所有消费组件都会重新渲染;`

![image-20230903013211589](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230903013211589.png)

> Class.contextType

- 挂载在 `class` 上的 `contextType` 属性会被重赋值为一个由 React.createContext() 创建的 Context 对象: 
- 这能让你使用 `this.context 来消费最近 Context 上的那个值;` 
- 你可以在任何生命周期中访问到它，包括 render 函数中;

![image-20230903013314689](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230903013314689.png)

> Context.Consumer

- 这里，React 组件也可以订阅到 `context` 变更。这能让你在 `函数式组件` 中完成订阅 context。 
- 这里需要 函数作为子元素(function as child)这种做法;
- 这个函数接收当前的 context 值，返回一个 React 节点;

![image-20230903013452709](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230903013452709.png)

> 什么时候使用Context.Consumer

- 当使用value的组件是一个函数式组件时; 
- 当组件中需要使用多个Context时;

# React组件化开发(三)

## setState

### 为什么使用setState

- 开发中我们并不能直接通过修改state的值来让界面发生更新:
  - 因为我们修改了state之后，希望React根据最新的State来重新渲染界面，但是这种方式的修改React并不知道数据发生了变化;
  - React并没有实现类似于`Vue2`中的`Object.defineProperty`或者`Vue3`中的`Proxy`的方式来监听数据的变化; 
  - 我们必须通过`setState`来告知React数据已经发生了变化;
- 疑惑:在组件中并没有实现**setState的方法，为什么可以调用呢?** 
  - 原因很简单，setState方法是从Component中继承过来的。

![image-20230903014641201](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230903014641201.png)

### setState异步更新

> setState的更新是`异步`的?

- 最终打印结果是Hello World;
- 可见`setState`是`异步`的操作，我们并`不能在执行完setState之后立马拿到最新的state的结果`

![image-20230903021056363](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230903021056363.png)

> 为什么setState设计为异步呢?

- setState设计为异步其实之前在GitHub上也有很多的讨论;
- React核心成员(Redux的作者)Dan Abramov也有对应的回复;
- https://github.com/facebook/react/issues/11527#issuecomment-360199710;

> 简单的总结:

- setState设计为异步，可以`显著的提升性能`;
  - 如果<u>每次调用 setState都进行一次更新，那么意味着render函数会被频繁调用，界面重新渲染，这样效率是很低的;</u> 
  - 最好的办法应该是<u>获取到多个更新，之后进行批量更新;</u>

- `如果同步更新了state，但是还没有执行render函数，那么state和props不能保持同步;` 
  - state和props不能保持一致性，会在开发中产生很多的问题;

### 如何获取异步的结果 

- 如何可以`获取到更新后的值`呢?
  - 方式一:`setState的回调`
    - setState接受两个参数:第二个参数是一个`回调函数`，`这个回调函数会在更新后会执行`; 
    - 格式如下:setState(partialState, callback)
  - ◼ 当然，我们也可以在`生命周期函数`:

```JS
import React, { Component } from 'react'

export class App extends Component {
  constructor(props) {
    super(props)

    this.state = {
      message: "Hello World",
      counter: 0
    }
  }

  changeText() {
    // 1.setState更多用法
    // 1.基本使用
    // this.setState({
    //   message: "你好啊, 李银河"
    // })

    // 2.setState可以传入一个回调函数
    // 好处一: 可以在回调函数中编写新的state的逻辑
    // 好处二: 当前的回调函数会将之前的state和props传递进来
    // this.setState((state, props) => {
    //   // 1.编写一些对新的state处理逻辑
    //   // 2.可以获取之前的state和props值
    //   console.log(this.state.message, this.props)

    //   return {
    //     message: "你好啊, 李银河"
    //   }
    // })

    // 3.setState在React的事件处理中是一个异步调用
    // 如果希望在数据更新之后(数据合并), 获取到对应的结果执行一些逻辑代码
    // 那么可以在setState中传入第二个参数: callback
    this.setState({ message: "你好啊, 李银河" }, () => {
      console.log("++++++:", this.state.message)
    })
    
    console.log("------:", this.state.message)
  }

  increment() {

  }

  render() {
    const { message, counter } = this.state

    return (
      <div>
        <h2>message: {message}</h2>
        <button onClick={e => this.changeText()}>修改文本</button>
        <h2>当前计数: {counter}</h2>
        <button onClick={e => this.increment()}>counter+1</button>
      </div>
    )
  }
}

export default App
```



### setState**一定是异步吗?(React18之前)**

> 验证一:`在setTimeout中的更新`:

![image-20230903021348573](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230903021348573.png)



> 验证二:`原生DOM事件`:

![image-20230903021414035](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230903021414035.png)



- 其实分成两种情况:
  - `在组件生命周期或React合成事件中，setState是异步;` 
  - `在setTimeout或者原生dom事件中，setState是同步;`



### setState**默认是异步的(React18之后)** 

- 在React18之后，默认所有的操作都被放到了批处理中(异步处理)
- 如果希望代码可以同步会拿到，则需要执行特殊的**`flushSync操作`:**

```js
import React, { Component } from 'react'
import { flushSync } from 'react-dom'

function Hello(props) {
  return <h2>{props.message}</h2>
}

export class App extends Component {
  constructor(props) {
    super(props)

    this.state = {
      message: "Hello World",
      counter: 0
    }
  }

  componentDidMount() {
    // 1.网络请求一: banners

    // 2.网络请求二: recommends

    // 3.网络请求三: productlist
  }

  changeText() {
    setTimeout(() => {
      // 在react18之前, setTimeout中setState操作, 是同步操作
      // 在react18之后, setTimeout中setState异步操作(批处理)
      flushSync(() => {
        this.setState({ message: "你好啊, 李银河" })
      })
      console.log(this.state.message)
    }, 0);
  }

  increment() {
  }

  render() {
    const { message, counter } = this.state
    console.log("render被执行")

    return (
      <div>
        <h2>message: {message}</h2>
        <button onClick={e => this.changeText()}>修改文本</button>
        <h2>当前计数: {counter}</h2>
        <button onClick={e => this.increment()}>counter+1</button>

        <Hello message={message}/>
      </div>
    )
  }
}

export default App
```

## React性能优化

### React更新机制

- React渲染流程

![image-20230902003530793](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230902003530793.png)

- React更新流程

![image-20230905150655186](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905150655186.png)

### React的更新流程

- React在`props`或`state`发生改变时，会调用R`eact的render方法`，会创建一颗不同的树。

- React需要`基于这两颗不同的树之间的差别`来判断如何有效的更新UI：

  -  如果一棵树参考另外一棵树进行完全比较更新，那么即使是最先进的算法，该算法的复杂程度为 O(n³)，其中 n 是树中元素的数量； 

  -  如果在 React 中使用了该算法，那么展示 1000 个元素所需要执行的计算量将在十亿的量级范围； 

  -  这个开销太过昂贵了，React的更新性能会变得非常低效；

- 于是，React对这个算法进行了优化，将其优化成了O(n)，如何优化的呢？

  - 同层节点之间相互比较，不会垮节点比较； (同层发生改变, 但子元素不变还是会重新生成新的DOM树)

  - 不同类型的节点，产生不同的树结构； 

  - 开发中，可以通过key来指定哪些节点在不同的渲染下保持稳定；


### key优化

- 我们在前面`遍历列`表时，总是会提示一个警告，让我们加入一个`key属性`: 
- 方式一:在最后位置插入数据
  - 这种情况，有无key意义并不大 
- 方式二:在前面插入数据
  - 这种做法，在没有key的情况下，所有的li都需要进行修改;
- 当子元素(这里的li)拥有 key 时，React 使用 key 来匹配原有树上的子元素以及最新树上的子元素: 
  - 在下面这种场景下，key为111和222的元素仅仅进行位移，不需要进行任何的修改;
  - 将key为333的元素插入到最前面的位置即可;
- key的注意事项:
  - `key应该是唯一的`;
  - `key不要使用随机数`(随机数在下一次render时，会重新生成一个数字); 
  - `使用index作为key，对性能是没有优化的;`

### render函数被调用

- 我们使用之前的一个嵌套案例:
  - 在App中，我们增加了一个计数器的代码;
  - 当点击+1时，会重新调用App的render函数;
  - 而当App的render函数被调用时，所有的子组件的render函 数都会被重新调用;
- 那么，我们可以思考一下，在以后的开发中，`我们只要是修改了 App中的数据，所有的组件都需要重新render，进行diff算法，性能必然是很低的:`
  - 事实上，很多的组件<u>没有必须要重新render</u>;
  - 它们调用`render应该有一个前提`，就是`依赖的数据(state、props)发生改变时，再调用自己的render方法`
- 如何来控制render方法是否被调用呢?
  - 通过`shouldComponentUpdate`方法即可;

### shouldComponentUpdate

- React**给我们提供了一个`生命周期`方法** `shouldComponentUpdate`(很多时候，我们简称为`SCU`)，这个方法接受参数，并且需要有 返回值:
- 该方法有两个参数:
  - 参数一:`nextProps` 修改之后，最新的props属性 
  - 参数二:`nextState` 修改之后，最新的state属性
- 该方法返回值是一个boolean类型:
  - 返回值为`true`，那么就`需要调用render方法`;
  - 返回值为`false`，那么久`不需要调用render方法`;
  - `默认返回的是true，也就是只要state发生改变，就会调用render方法;`
- 比如我们在App中增加一个message属性:
  * jsx中并没有依赖这个message，那么它的改变不应该引起重新渲染;
  * 但是因为render监听到state的改变，就会重新render，所以最后render方法还是被重新调用了;

```js
//App
import React, { PureComponent } from 'react'
import Home from './Home'
import Recommend from './Recommend'
import Profile from './Profile'


export class App extends PureComponent {
  constructor() {
    super()

    this.state = {
      message: "Hello World",
      counter: 0
    }
  }

  // shouldComponentUpdate(nextProps, newState) {
  //   // App进行性能优化的点
  //   if (this.state.message !== newState.message || this.state.counter !== newState.counter) {
  //     return true
  //   }
  //   return false
  // }

  changeText() {
    this.setState({ message: "你好啊,李银河!" })
    // this.setState({ message: "Hello World" })
  }

  increment() {
    this.setState({ counter: this.state.counter + 1 })
  }

  render() {
    console.log("App render")
    const { message, counter } = this.state

    return (
      <div>
        <h2>App-{message}-{counter}</h2>
        <button onClick={e => this.changeText()}>修改文本</button>
        <button onClick={e => this.increment()}>counter+1</button>
        <Home message={message}/>
        <Recommend counter={counter}/>
        <Profile message={message}/>
      </div>
    )
  }
}

export default App

```

```js
//home
import React, { PureComponent } from 'react'

export class Home extends PureComponent {
  constructor(props) {
    super(props)

    this.state = {
      friends: []
    }
  }

  // shouldComponentUpdate(newProps, nextState) {
  //   // 自己对比state是否发生改变: this.state和nextState
  //   if (this.props.message !== newProps.message) {
  //     return true
  //   }
  //   return false
  // }

  render() {
    console.log("Home render")
    return (
      <div>
        <h2>Home Page: {this.props.message}</h2>
      </div>
    )
  }
}

export default Home
```

### 类组件-PureComponent

- 如果所有的类，我们都需要手动来实现 shouldComponentUpdate**，那么会给我们开发者增加非常多的工作量。** 
  - 我们来设想一下shouldComponentUpdate中的各种判断的目的是什么?
  - props或者state中的数据是否发生了改变，来决定shouldComponentUpdate返回true或者false;
- 事实上**React已经考虑到了这一点，所以React已经默认帮我们实现好了，如何实现呢?** 
  - `将class继承自PureComponent`。

![image-20230905153609647](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905153609647.png)

### 函数组件-高阶组件memo

- 目前我们是针对`类组件可以使用PureComponent`，那么函数式组件呢?
  - 事实上函数式组件我们在props没有改变时，也是不希望其重新渲染其DOM树结构的

- 我们需要使用一个`高阶组件memo`:
  - 我们将之前的Header、Banner、ProductList都通过memo函数进行一层包裹;
  - Footer没有使用memo函数进行包裹;
  - 最终的效果是，当counter发生改变时，Header、Banner、ProductList的函数不会重新执行; 
  - 而Footer的函数会被重新执行;

## 不可变数据的力量

```js
import React, { PureComponent } from 'react'

export class App extends PureComponent {
  constructor() {
    super()

    this.state = {
      books: [
        { name: "你不知道JS", price: 99, count: 1 },
        { name: "JS高级程序设计", price: 88, count: 1 },
        { name: "React高级设计", price: 78, count: 2 },
        { name: "Vue高级设计", price: 95, count: 3 },
      ],
      friend: {
        name: "kobe"
      },
      message: "Hello World"
    }
  }

  // shouldComponentUpdate(nextProps, nextState) {
  //   shallowEqual(nextProps, this.props)
  //   shallowEqual(nextState, this.state)
  // }

  addNewBook() {
    const newBook = { name: "Angular高级设计", price: 88, count: 1 }

    // 1.直接修改原有的state, 重新设置一遍
    // 在PureComponent是不能引入重新渲染(re-render)
    this.state.books.push(newBook)
    this.setState({ books: this.state.books })

    // 2.赋值一份books, 在新的books中修改, 设置新的books
    const books = [...this.state.books]
    books.push(newBook)

    this.setState({ books: books })
  }

  addBookCount(index) {
    // this.state.books[index].count++
    const books = [...this.state.books]
    books[index].count++
    this.setState({ books: books })
  }

  render() {
    const { books } = this.state

    return (
      <div>
        <h2>数据列表</h2>
        <ul>
          {
            books.map((item, index) => {
              return (
                <li key={index}>
                  <span>name:{item.name}-price:{item.price}-count:{item.count}</span>
                  <button onClick={e => this.addBookCount(index)}>+1</button>
                </li>
              )
            })
          }
        </ul>
        <button onClick={e => this.addNewBook()}>添加新书籍</button>
      </div>
    )
  }
}

export default App
```



## ref

- 在**React的开发模式中，通常情况下不需要、也不建议直接操作DOM原生，但是某些特殊的情况，确实需要`获取Dom进行某些操作:`** 
  - 管理焦点，文本选择或媒体播放;
  - 触发强制动画;
  - 集成第三方 DOM 库;
  - 我们可以通过refs获取DOM;
- 如何创建**refs来获取对应的DOM呢?目前有三种方式:**
- 方式一:`传入字符串`
  - 使用时通过 `this.refs.`传入的字符串格式获取对应的元素;
- 方式二:`传入一个对象`
  - 对象是通过 `React.createRef()` 方式创建出来的;
  - 使用时获取到创建的对象其中有一个current属性就是对应的元素;
- 方式三:`传入一个函数`
  - 该函数会在DOM被挂载时进行回调，这个函数会传入一个 元素对象，我们可以自己保存; 
  - 使用时，直接拿到之前保存的元素对象即可;

```js
import React, { PureComponent, createRef } from 'react'

export class App extends PureComponent {
  constructor() {
    super()

    this.state = {

    }

    this.titleRef = createRef()
    this.titleEl = null
  }

  getNativeDOM() {
    // 1.方式一: 在React元素上绑定一个ref字符串
    // console.log(this.refs.why)

    // 2.方式二: 提前创建好ref对象, createRef(), 将创建出来的对象绑定到元素
    // console.log(this.titleRef.current)

    // 3.方式三: 传入一个回调函数, 在对应的元素被渲染之后, 回调函数被执行, 并且将元素传入
    console.log(this.titleEl)
  }

  render() {
    return (
      <div>
        <h2 ref="why">Hello World</h2>
        <h2 ref={this.titleRef}>你好啊,李银河</h2>
        <h2 ref={el => this.titleEl = el}>你好啊, 师姐</h2>
        <button onClick={e => this.getNativeDOM()}>获取DOM</button>
      </div>
    )
  }
}

export default App
```

### ref类型

- ref 的值根据`节点的类型而有所不同`:
  - 当 ref 属性用于 `HTML 元素时`，构造函数中使用 React.createRef() 创建的 ref 接收`底层 DOM 元素作为其 current 属性;` 
  - 当 ref 属性用于`自定义 class 组件时`，ref 对象接收`组件的挂载实例`作为其 current 属性;
  - `你不能在函数组件上使用 ref 属性，因为他们没有实例;`
- 这里我们演示一下ref引用一个class组件对象:

```js
import React, { PureComponent, createRef } from 'react'


class HelloWorld extends PureComponent {
  test() {
    console.log("test------")
  }

  render() {
    return <h1>Hello World</h1>
  }
}

export class App extends PureComponent {
  constructor() {
    super()

    this.hwRef = createRef()
  }

  getComponent() {
    console.log(this.hwRef.current)
    this.hwRef.current.test()
  }

  render() {
    return (
      <div>
        <HelloWorld ref={this.hwRef}/>
        <button onClick={e => this.getComponent()}>获取组件实例</button>
      </div>
    )
  }
}

export default App
```

### forwardRef

- `函数式组件是没有实例`的，所以无法通过ref获取他们的实例:
  * 但是某些时候，我们可能想要获取函数式组件中的某个DOM元素; 
  * 这个时候我们可以通过 [React.forwardRef](#ref的转发) ，后面我们也会学习 hooks 中如何使用ref;

```js
import React, { PureComponent, createRef, forwardRef } from 'react'


const HelloWorld = forwardRef(function(props, ref) {
  return (
    <div>
      <h1 ref={ref}>Hello World</h1>
      <p>哈哈哈</p>
    </div>
  )
})


export class App extends PureComponent {
  constructor() {
    super()

    this.hwRef = createRef()
  }

  getComponent() {
    console.log(this.hwRef.current)
  }

  render() {
    return (
      <div>
        <HelloWorld ref={this.hwRef}/>
        <button onClick={e => this.getComponent()}>获取组件实例</button>
      </div>
    )
  }
}

export default App
```

## 认识受控组件

- 在**React中，HTML表单的处理方式和普通的DOM元素不太一样:表单元素通常会保存在一些内部的state。**
- 比如下面的HTML表单元素:
  * 这个处理方式是DOM默认处理HTML表单的行为，在`用户点击提交时会提交到某个服务器`中，并且`刷新页面`; 
  * `在React中，并没有禁止这个行为，它依然是有效的;`
  * 但是通常情况下会使用`JavaScript函数来方便的处理表单提交`，同时`还可以访问用户填写的表单数据`;
  * 实现这种效果的标准方式是使用“`受控组件`”;

```js
import React, { PureComponent } from 'react'

export class App extends PureComponent {
  constructor() {
    super()

    this.state = {
      username: "coderwhy"
    }
  }

  inputChange(event) {
    console.log("inputChange:", event.target.value)
    this.setState({ username: event.target.value })
  }

  render() {
    const { username } = this.state

    return (
      <div>
        {/* 受控组件 */}
        <input type="checkbox" value={username} onChange={e => this.inputChange(e)}/>

        {/* 非受控组件 */}
        <input type="text" />
        <h2>username: {username}</h2>
      </div>
    )
  }
}

export default App
```

### **受控组件基本演练**

- 在 HTML 中，表单元素(如**<input>、** <textarea> 和 <select>**)之类的表单元素`通常自己维护state`**，并`根据用户输入进行更新`。
- 而在 React 中，`可变状态`(mutable state)通常`保存在组件的state 属性中，并且只能通过使用setState()来更新。`
  - 我们将两者结合起来，使`React的state成为“唯一数据源”`;
  - 渲染表单的 `React 组件还控制着用户输入过程中表单发生的操作;`
  - `被 React 以这种方式控制取值的表单输入元素`就叫做“`受控组件`”;
- 由于在表单元素上设置了 `value` 属性，因此显示的值将始终为 this.state.value**，这使得** React 的 state 成为唯一数据源。 
- 由于 handleUsernameChange 在每次按键时都会执行并更新 React 的 state**，因此显示的值将随着用户输入而更新。**
- `textarea标签`
  - texteare标签和input比较相似: 
- `select标签`
  - select标签的使用也非常简单，只是它不需要通过selected属性来控制哪一个被选中，它可以匹配state的value来选中。
- 处理多个输入
  - 多处理方式可以像单处理方式那样进行操作，但是需要多个监听方法: 
  - 这里我们可以使用ES6的一个语法:计算属性名(Computed property names)

### 非受控组件

- React**推荐大多数情况下使用 受控组件 来处理表单数据:** 
  - 一个`受控组件`中，`表单数据是由 React 组件来管理的`; 
  - 另一种替代方案是使用`非受控组件`，这时`表单数据将交由 DOM 节点来处理`;
- 如果要使用非受控组件中的数据，那么我们需要使用 `ref` 来从`DOM节点中获取表单数据`。 
  - 我们来进行一个简单的演练:
  - 使用ref来获取input元素;
- 在非受控组件中通常使用**`defaultValue来设置默认值;`**
- 同样，**<input type="checkbox">** 和 <input type="radio"> 支持 defaultChecked**，<select>** 和 <textarea> 支 持 defaultValue**。**

```js
import React, { createRef, PureComponent } from 'react'

export class App extends PureComponent {

  constructor() {
    super()

    this.state = {
      username: "",
      password: "",
      isAgree: false,
      hobbies: [
        { value: "sing", text: "唱", isChecked: false },
        { value: "dance", text: "跳", isChecked: false },
        { value: "rap", text: "rap", isChecked: false }
      ],
      fruit: ["orange"],
      intro: "哈哈哈"
    }

    this.introRef = createRef()
  }

  componentDidMount() {
    // this.introRef.current.addEventListener
  }

  handleSubmitClick(event) {
    // 1.阻止默认的行为
    event.preventDefault()

    // 2.获取到所有的表单数据, 对数据进行组件
    console.log("获取所有的输入内容")
    console.log(this.state.username, this.state.password)
    const hobbies = this.state.hobbies.filter(item => item.isChecked).map(item => item.value)
    console.log("获取爱好: ", hobbies)
    console.log("获取结果:", this.introRef.current.value)

    // 3.以网络请求的方式, 将数据传递给服务器(ajax/fetch/axios)
  }

  handleInputChange(event) {
    this.setState({
      [event.target.name]: event.target.value
    })
  }

  handleAgreeChange(event) {
    this.setState({ isAgree: event.target.checked })
  }

  handleHobbiesChange(event, index) {
    const hobbies = [...this.state.hobbies]
    hobbies[index].isChecked = event.target.checked
    this.setState({ hobbies })
  }

  handleFruitChange(event) {
    const options = Array.from(event.target.selectedOptions)
    const values = options.map(item => item.value)
    this.setState({ fruit: values })

    // 额外补充: Array.from(可迭代对象)
    // Array.from(arguments)
    const values2 = Array.from(event.target.selectedOptions, item => item.value)
    console.log(values2)
  }

  render() {
    const { username, password, isAgree, hobbies, fruit, intro } = this.state

    return (
      <div>
        <form onSubmit={e => this.handleSubmitClick(e)}>
          {/* 1.用户名和密码 */}
          <div>
            <label htmlFor="username">
              用户: 
              <input 
                id='username' 
                type="text" 
                name='username' 
                value={username} 
                onChange={e => this.handleInputChange(e)}
              />
            </label>
            <label htmlFor="password">
              密码: 
              <input 
                id='password' 
                type="password" 
                name='password' 
                value={password} 
                onChange={e => this.handleInputChange(e)}
              />
            </label>
          </div>

          {/* 2.checkbox单选 */}
          <label htmlFor="agree">
            <input 
              id='agree' 
              type="checkbox" 
              checked={isAgree} 
              onChange={e => this.handleAgreeChange(e)}
            />
            同意协议
          </label>

          {/* 3.checkbox多选 */}
          <div>
            您的爱好:
            {
              hobbies.map((item, index) => {
                return (
                  <label htmlFor={item.value} key={item.value}>
                    <input 
                      type="checkbox"
                      id={item.value} 
                      checked={item.isChecked}
                      onChange={e => this.handleHobbiesChange(e, index)}
                    />
                    <span>{item.text}</span>
                  </label>
                )
              })
            }
          </div>

          {/* 4.select */}
          <select value={fruit} onChange={e => this.handleFruitChange(e)} multiple>
            <option value="apple">苹果</option>
            <option value="orange">橘子</option>
            <option value="banana">香蕉</option>
          </select>

          {/* 5.非受控组件 */}
          <input type="text" defaultValue={intro} ref={this.introRef} />

          <div>
            <button type='submit'>注册</button>
          </div>
        </form>
      </div>
    )
  }
}

export default App
```



## 高阶组件

### 认识高阶函数

> 什么是高阶组件呢?

- 相信很多同学都知道(听说过?)，也用过 高阶函数
- 它们非常相似，所以我们可以先来回顾一下什么是 `高阶函数`。

> 高阶函数的维基百科定义:至少满足以下条件之一: 

1. `接受一个或多个函数作为输入`;
2. `输出一个函数`;



JavaScript中比较常见的`filter`、`map`、`reduce`都是高阶函数。

> 那么说明是高阶组件呢?

- 高阶组件的英文是 Higher-Order Components，简称为 `HOC`;
- 官方的定义:`高阶组件是参数为组件，返回值为新组件的函数;`

> 如下的解析:

- 首先，`高阶组件 本身不是一个组件，而是一个函数;`
- 其次，`这个函数的参数是一个组件，返回值也是一个组件;`

```js
import React, { PureComponent } from 'react'

// 定义一个高阶组件
function hoc(Cpn) {
  // 1.定义类组件
  class NewCpn extends PureComponent {
    render() {
      return <Cpn name="why"/>
    }
  }
  return NewCpn

  // 定义函数组件
  // function NewCpn2(props) {

  // }
  // return NewCpn2
}

class HelloWorld extends PureComponent {
  render() {
    return <h1>Hello World</h1>
  }
}

const HelloWorldHOC = hoc(HelloWorld)

export class App extends PureComponent {
  render() {
    return (
      <div>
        <HelloWorldHOC/>
      </div>
    )
  }
}

export default App
```

### 高阶组件的定义 

- 高阶组件的调用过程类似于这样:

![image-20230905164044439](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905164044439.png)

- 高阶函数的编写过程类似于这样:

  ![image-20230905164107971](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905164107971.png)

- 组件的名称问题:

  - 在ES6中，类表达式中类名是可以省略的;
  - 组件的名称都可以通过`displayName`来修改;

- 高阶组件并不是**React API的一部分，它是基于React的 组合特性而形成的设计模式;**

- 高阶组件在一些React第三方库中非常常见:

  - 比如redux中的`connect`;(后续会讲到)
  - 比如react-router中的`withRouter`;(后续会讲到)

### 应用一：props**的增强** 

> 不修改原有代码的情况下，添加新的**props**

```js
import { PureComponent } from 'react'

// 定义组件: 给一些需要特殊数据的组件, 注入props
function enhancedUserInfo(OriginComponent) {
  class NewComponent extends PureComponent {
    constructor(props) {
      super(props)

      this.state = {
        userInfo: {
          name: "coderwhy",
          level: 99
        }
      }
    }

    render() {
      return <OriginComponent {...this.props} {...this.state.userInfo}/>
    }
  }

  return NewComponent
}

export default enhancedUserInfo

```

```js
import React, { PureComponent } from 'react'
import enhancedUserInfo from './hoc/enhanced_props'
import About from './pages/About'


const Home = enhancedUserInfo(function(props) {
  return <h1>Home: {props.name}-{props.level}-{props.banners}</h1>
})

const Profile = enhancedUserInfo(function(props) {
  return <h1>Profile: {props.name}-{props.level}</h1>
})

const HelloFriend = enhancedUserInfo(function(props) {
  return <h1>HelloFriend: {props.name}-{props.level}</h1>
})

export class App extends PureComponent {
  render() {
    return (
      <div>
        <Home banners={["轮播1", "轮播2"]}/>
        <Profile/>
        <HelloFriend/>

        <About/>
      </div>
    )
  }
}

export default App
```

> 利用高阶组件来共享**Context**

```js
import React, { PureComponent } from 'react'
import ThemeContext from './context/theme_context'
import Product from './pages/Product'

export class App extends PureComponent {
  render() {
    return (
      <div>
        <ThemeContext.Provider value={{color: "red", size: 30}}>
          <Product/>
        </ThemeContext.Provider>
      </div>
    )
  }
}

export default App
```

### 应用二：渲染判断鉴权

- 在开发中，我们可能遇到这样的场景:
  - 某些页面是必须用户登录成功才能进行进入;
  - 如果用户没有登录成功，那么直接跳转到登录页面;
- 这个时候，我们就可以使用高阶组件来完成鉴权操作:

```js
function loginAuth(OriginComponent) {
  return props => {
    // 从localStorage中获取token
    const token = localStorage.getItem("token")

    if (token) {
      return <OriginComponent {...props}/>
    } else {
      return <h2>请先登录, 再进行跳转到对应的页面中</h2>
    }
  }
}

export default loginAuth
```

### 应用三: 生命周期劫持

-  我们也可以利用高阶函数来劫持生命周期，在生命周期中完成自己的逻辑:

```js
import { PureComponent } from "react";

function logRenderTime(OriginComponent) {
  return class extends PureComponent {
    UNSAFE_componentWillMount() {
      this.beginTime = new Date().getTime()
    }
  
    componentDidMount() {
      this.endTime = new Date().getTime()
      const interval = this.endTime - this.beginTime
      console.log(`当前${OriginComponent.name}页面花费了${interval}ms渲染完成!`)
    }

    render() {
      return <OriginComponent {...this.props}/>
    }
  }
}

export default logRenderTime

```

### 高阶函数的意义

- 我们会发现利用高阶组件可以针对某些**React代码进行更加优雅的处理。**
- 其实早期的**React有提供组件之间的一种复用方式是`mixin`，`目前已经不再建议使用`:
  **
  - Mixin 可能会相互依赖，相互耦合，不利于代码维护;
  - 不同的Mixin中的方法可能会相互冲突;
  - Mixin非常多时，组件处理起来会比较麻烦，甚至还要为其做相关处理，这样会给代码造成滚雪球式的复杂性;
- 当然，`HOC`也有自己的一些缺陷:
  - HOC需要在`原组件上进行包裹或者嵌套`，`如果大量使用HOC，将会产生非常多的嵌套，这让调试变得非常困难`; 
  - HOC可以`劫持props，在不遵守约定的情况下也可能造成冲突;`
- Hooks**的出现，是开创性的，它解决了很多React之前的存在的问题** 
  - 比如this指向问题、比如hoc的嵌套复杂度问题等等;



## ref的转发

- 在前面我们学习**ref时讲过，`ref不能应用于函数式组件`:**
  - 因为`函数式组件没有实例`，所以不能获取到对应的组件对象
- 但是，在开发中我们可能想要获取函数式组件中某个元素的**DOM，这个时候我们应该如何操作呢?** 
  - 方式一:直接传入ref属性(**错误的做法**)
  - 方式二:通过`forwardRef`高阶函数;

```js
const MyInput = forwardRef(function MyInput(props, ref) {
  return (
    <label>
      {props.label}
      <input ref={ref} />
    </label>
  );
});
```

## Portals

- 某些情况下，我们希望`渲染的内容独立于父组件`，甚至是`独立于当前挂载到的DOM元素中`(默认都是挂载到id为root的DOM元素上的)。
- `Portal` 提供了一种`将子节点渲染到存在于父组件以外的 DOM 节点的优秀的方案`: 
  - 第一个参数(child)是任何可渲染的 React 子元素，例如一个元素，字符串或 fragment; 
  - 第二个参数(container)是一个 DOM 元素;
- 通常来讲，当你从组件的 render 方法返回一个元素时，该元素将被挂载到 DOM 节点中离其最近的父节点: 
- 然而，有时候将子元素插入到 DOM 节点中的不同位置也是有好处的:

```js
import React, { PureComponent } from 'react'
import { createPortal } from "react-dom"
import Modal from './Modal'

export class App extends PureComponent {
  render() {
    return (
      <div className='app'>
        <h1>App H1</h1>
        {
          createPortal(<h2>App H2</h2>, document.querySelector("#why"))
        }

        {/* 2.Modal组件 */}
        <Modal>
          <h2>我是标题</h2>
          <p>我是内容, 哈哈哈</p>
        </Modal>
      </div>
    )
  }
}

export default App
```

```js
import React, { PureComponent } from 'react'
import { createPortal } from "react-dom"

export class Modal extends PureComponent {
  render() {
    return createPortal(this.props.children, document.querySelector("#modal"))
  }
}

export default Modal
```



## fragment

- 在之前的开发中，我们总是在一个组件中`返回内容时包裹一个div元素:`
- 我们又希望可以不渲染这样一个div应该如何操作呢?
  - 使用`Fragment`
  - Fragment 允许你将子列表分组，而无需向 DOM 添加额外节点;
- React还提供了`Fragment的短语法`:
  - 它看起来像空标签 `<> </>;`
  - 但是，如果我们`需要在Fragment中添加key，那么就不能使用短语法`



## StrictMode

- `StrictMode` 是一个用来突出显示`应用程序中潜在问题的工具`: 
  - 与 Fragment 一样，StrictMode 不会渲染任何可见的 UI;
  - 它为其后代元素触发额外的检查和警告;
  - 严格模式检查`仅在开发模式下运行`;它们不会影响生产构建;
- 可以为应用程序的任何`部分启用严格模式`:
  - 不会对 Header 和 Footer 组件运行严格模式检查;
  - 但是，ComponentOne 和 ComponentTwo 以及它们的所有后代元素都将进行检查;



### 严格模式检查的是什么?

> 但是检测，到底检测什么呢? 

1. 识别不安全的生命周期:
2. 使用过时的 ref API

3. 检查意外的副作用
   - 这个组件的constructor会被调用两次;
   - `这是严格模式下故意进行的操作，让你来查看在这里写的一些逻辑代码被调用多次时，是否会产生一些副作用;`
   - `在生产环境中，是不会被调用两次的;`

4. 使用废弃的findDOMNode方法
   - 在之前的React API中，可以通过findDOMNode来获取DOM，不过已经不推荐使用了，可以自行学习演练一下

5. 检测过时的context API
   - 早期的Context是通过static属性声明Context对象属性，通过getChildContext返回Context对象等方式来使用Context的; 
   - 目前这种方式已经不推荐使用，大家可以自行学习了解一下它的用法;









# JSX

## jsx是什么

- JSX是一种`JavaScript的语法扩展(eXtension)`，也在很多地方称之为JavaScript XML，因为看起就是一段XML语法; 
- 它用于`描述我们的UI界面`，并且其完成`可以和JavaScript融合在一起使用`;
- 它`不同于Vue中的模块语法`，你`不需要专门学习模块语法中的一些指令`(比如v-for、v-if、v-else、v-bind)

### 为什么React选择了JSX

- React**认为`渲染逻辑本质上与其他UI逻辑存在内在耦合`** 
  - 比如`UI需要绑定事件`(button、a原生等等);
  - 比如`UI中需要展示数据状态`;
  - 比如在`某些状态发生改变时，又需要改变UI`;
- 他们之间是`密不可分`，所以React`没有将标记分离到不同的文件中`，而是将`它们组合到了一起`，这个地方就是`组件(Component)`; 
  - 当然，后面我们还是会继续学习更多组件相关的东西;
- 在这里，我们只需要知道，JSX其实是嵌入到JavaScript中的一种结构语法;

> JSX的书写规范:

- JSX的`顶层只能有一个根元素`，所以我们很多时候会在`外层包裹一个div元素`(或者使用后面我们学习的`Fragment`);
- 为了`方便阅读`，我们通常在jsx的外层包裹一个`小括号()`，这样可以方便阅读，并且jsx可以进行换行书写;
- JSX中的标签可以是`单标签`，也可以是`双标签`;
  - 注意:如果是单标签，必须以/>结尾;

## JSX**的使用** 

> jsx中的`注释`



> JSX嵌入`变量`作为子元素

- 情况一:当变量是`Number`、`String`、`Array`类型时，可以`直接显示`
- 情况二:当变量是`null`、`undefined`、`Boolean`类型时，`内容为空`;
  - 如果希望可以显示null、undefined、Boolean，那么`需要转成字符串`;
  - 转换的方式有很多，比如`toString`方法、和`空字符串`拼接，`String(变量)`等方式; 
- 情况三:`Object对象类型不能作为子元素`(not valid as a React child)

> JSX嵌入表达式

- `运算表达式` 
- `三元运算符` 
- `执行一个函数`

> jsx绑定属性

- 如元素都会有`title`属性
- 比如img元素会有`src`属性
- 比如a元素会有`href`属性
- 比如元素可能需要绑定`class` 
- 比如原生使用`内联样式style`

```js
    // 1.定义App根组件
    class App extends React.Component {
      constructor() {
        super()
        this.state = {
          counter: 100,
          message: "Hello World",
          names: ["abc", "cba", "nba"],

          aaa: undefined,
          bbb: null,
          ccc: true,

          friend: { name: "kobe" },

          firstName: "kobe",
          lastName: "bryant",

          age: 20,

          movies: ["流浪地球", "星际穿越", "独行月球"]
        }
      }

      render() {
        // 1.插入标识符
        const { message, names, counter } = this.state
        const { aaa, bbb, ccc } = this.state
        const { friend } = this.state

        // 2.对内容进行运算后显示(插入表示)
        const { firstName, lastName } = this.state
        const fullName = firstName + " " + lastName
        const { age } = this.state
        const ageText = age >= 18 ? "成年人": "未成年人"
        const liEls = this.state.movies.map(movie => <li>{movie}</li>)

        // 3.返回jsx的内容
        return (
          <div>
            {/* 1.Number/String/Array直接显示出来 */}
            <h2>{counter}</h2>
            <h2>{message}</h2>
            <h2>{names}</h2>

            {/* 2.undefined/null/Boolean */}
            <h2>{String(aaa)}</h2>
            <h2>{bbb + ""}</h2>
            <h2>{ccc.toString()}</h2>

            {/* 3.Object类型不能作为子元素进行显示*/}
            <h2>{friend.name}</h2>
            <h2>{Object.keys(friend)[0]}</h2>

            {/* 4.可以插入对应的表达式*/}
            <h2>{10 + 20}</h2>
            <h2>{firstName + " " + lastName}</h2>
            <h2>{fullName}</h2>

            {/* 5.可以插入三元运算符*/}
            <h2>{ageText}</h2>
            <h2>{age >= 18 ? "成年人": "未成年人"}</h2>

            {/* 6.可以调用方法获取结果*/}
            <ul>{liEls}</ul>
            <ul>{this.state.movies.map(movie => <li>{movie}</li>)}</ul>
            <ul>{this.getMovieEls()}</ul>
          </div>
        )
      }

      getMovieEls() {
        const liEls = this.state.movies.map(movie => <li>{movie}</li>)
        return liEls
      }
    }
```

```js
    // 1.定义App根组件
    class App extends React.Component {
      constructor() {
        super()
        this.state = {
          title: "哈哈哈",
          imgURL: "https://ts1.cn.mm.bing.net/th/id/R-C.95bc299c3f1f0e69b9eb1d0772b14a98?rik=W5QLhXiERW4nLQ&riu=http%3a%2f%2f20178405.s21i.faiusr.com%2f2%2fABUIABACGAAgoeLO-wUo4I3o2gEw8Qs4uAg.jpg&ehk=N7Bxe9nqM08w4evC2kK6yyC%2bxIWTjdd6HgXsQYPbMj0%3d&risl=&pid=ImgRaw&r=0",
          href: "https://www.baidu.com",

          isActive: true,
          objStyle: {color: "red", fontSize: "30px"}
        }
      }

      render() {
        const { title, imgURL, href, isActive, objStyle } = this.state

        // 需求: isActive: true -> active
        // 1.class绑定的写法一: 字符串的拼接
        const className = `abc cba ${isActive ? 'active': ''}`
        // 2.class绑定的写法二: 将所有的class放到数组中
        const classList = ["abc", "cba"]
        if (isActive) classList.push("active")
        // 3.class绑定的写法三: 第三方库classnames -> npm install classnames

        return (
          <div>
            { /* 1.基本属性绑定 */ }
            <h2 title={title}>我是h2元素</h2>
            {/*<img src={imgURL} alt=""/>*/}
            <a href={href}>百度一下</a>

            
            { /* 2.绑定class属性: 最好使用className */ }
            <h2 className={className}>哈哈哈哈</h2>
            <h2 className={classList.join(" ")}>哈哈哈哈</h2>

            
            { /* 3.绑定style属性: 绑定对象类型 */ }
            <h2 style={{color: "red", fontSize: "30px"}}>呵呵呵呵</h2>
            <h2 style={objStyle}>呵呵呵呵</h2>
          </div>
        )
      }
    }


```





## JSX的本质

- 实际上，`jsx` 仅仅只是 `React.createElement(component, props, ...children) 函数的语法糖。`
  - 所有的`jsx`最终都会被`转换`成`React.createElement的函数调用`。

- `createElement`需要传递三个参数:
  - 参数一:`type`
    - 当前ReactElement的类型;
    - 如果是标签元素，那么就使用字符串表示 “div”;
    - 如果是组件元素，那么就直接使用组件的名称;

  - 参数二:`config`
    - 所有jsx中的属性都在config中以对象的属性和值的形式存储;
    - 比如传入className作为元素的class;

  - 参数三:`children`
    - 存放在标签中的内容，以children数组的方式进行存储;
    - 当然，如果是多个元素呢?React内部有对它们进行处理，处理的源码在下方


```js
 class App extends React.Component {
      constructor() {
        super()
        this.state = {
          message: "Hello World"
        }
      }

      render() {
        const { message } = this.state

        return (
          <div>
            <div className="header">Header</div>
            <div className="Content">
              <div>{message}</div>
              <ul>
                <li>列表数据1</li>
                <li>列表数据2</li>
                <li>列表数据3</li>
                <li>列表数据4</li>
                <li>列表数据5</li>
              </ul>
            </div>
            <div className="footer">Footer</div>
          </div>
        )
      }
    }

```



```js
//转化后

    // 1.定义App根组件
    class App extends React.Component {
      constructor() {
        super()
        this.state = {
          message: "Hello World"
        }
      }

      render() {
        const { message } = this.state

        const element = React.createElement(
          "div",
          null,
  /*#__PURE__*/ React.createElement(
            "div",
            {
              className: "header"
            },
            "Header"
          ),
  /*#__PURE__*/ React.createElement(
            "div",
            {
              className: "Content"
            },
    /*#__PURE__*/ React.createElement("div", null, "Banner"),
    /*#__PURE__*/ React.createElement(
              "ul",
              null,
      /*#__PURE__*/ React.createElement(
                "li",
                null,
                "\u5217\u8868\u6570\u636E1"
              ),
      /*#__PURE__*/ React.createElement(
                "li",
                null,
                "\u5217\u8868\u6570\u636E2"
              ),
      /*#__PURE__*/ React.createElement(
                "li",
                null,
                "\u5217\u8868\u6570\u636E3"
              ),
      /*#__PURE__*/ React.createElement(
                "li",
                null,
                "\u5217\u8868\u6570\u636E4"
              ),
      /*#__PURE__*/ React.createElement("li", null, "\u5217\u8868\u6570\u636E5")
            )
          ),
  /*#__PURE__*/ React.createElement(
            "div",
            {
              className: "footer"
            },
            "Footer"
          )
        );
        
        console.log(element)

        return element
      }
    }

```

![虚拟DOM_JS对象树](https://cdn.jsdelivr.net/gh/OneOneT/images@main/%E8%99%9A%E6%8B%9FDOM_JS%E5%AF%B9%E8%B1%A1%E6%A0%91.jpg)

## 虚拟DOM

- 我们通过 `React.createElement` 最终创建出来一个 `ReactElement对象`：


> ReactElement对象是什么作用呢？React为什么要创建它呢？

- 原因是React利用`ReactElement对象`组成了一个`JavaScript的对象树`；
- `JavaScript的对象树就是虚拟DOM`（Virtual DOM）；



> 如何查看ReactElement的树结构呢?

* 我们可以将之前的j`sx返回结果进行打印`;  
* 注意下面代码中我打jsx的打印;

![image-20230902003349156](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230902003349156.png)

- 而`ReactElement`最终形成的树结构就是`Virtual DOM`;

![JSX的转化_01](https://cdn.jsdelivr.net/gh/OneOneT/images@main/JSX%E7%9A%84%E8%BD%AC%E5%8C%96_01.jpg)



## jsx–虚拟DOM–真实DOM

![image-20230902003530793](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230902003530793.png)

## 声明式编程

- `虚拟DOM`帮助我们从`命令式编程转到了声明式编程`的模式
- `React官方的说法`:Virtual DOM 是一种编程理念。
  - 在这个理念中，UI以一种理想化或者说虚拟化的方式保存在内存中，并且它是一个相对简单的JavaScript对象 
  - 我们可以通过`ReactDOM.rende`r让 `虚拟DOM` 和 `真实DOM`同步起来，这个过程中叫做`协调`(Reconciliation);
- 这种编程的方式赋予了React声明式的API:
  - 你只需要告诉React希望让UI是什么状态;
  - React来确保DOM和这些状态是匹配的;
  - 你不需要直接进行DOM操作，就可以从手动更改DOM、属性操作、事件处理中解放出来;



# React编写css

## React中的CSS

- 事实上，**css一直是React的痛点，也是被很多开发者吐槽、诟病的一个点。**
- 在这一点上，Vue做的要好于React:
  - Vue通过在.vue文件中编写 <style><style> 标签来编写自己的样式; 
  - 通过是否添加 `scoped` 属性来决定编写的样式是全局有效还是局部有效; 
  - 通过 `lang` 属性来设置你喜欢的 less、sass等预处理器;
  - 通过`内联样式`风格的方式来根据最新状态设置和改变css;
  - 等等...
- Vue**在CSS上虽然不能称之为完美，但是已经足够简洁、自然、方便了，至少统一的样式风格不会出现多个开发人员、多个项目 采用不一样的样式风格。**
- 相比而言，React官方并没有给出在React中统一的样式风格:
  - 由此，从普通的css，到css modules，再到css in js，有几十种不同的解决方案，上百个不同的库; 
  - 大家一致在寻找最好的或者说最适合自己的CSS方案，但是到目前为止也没有统一的方案;

## 内联样式

- `内联样式`是官方推荐的一种css样式的写法:
  - style 接受一个采用`小驼峰命名`属性的 JavaScript 对象，而不是 CSS 字符串; 
  - 并且可以引用state中的状态来设置相关的样式;
- 内联样式的`优点`:
  - `内联样式, 样式之间不会有冲突` 
  - `可以动态获取当前state中的状态`
- 内联样式的`缺点`:
  - 写法上都需要使用驼峰标识
  - 某些样式没有提示
  - 大量的样式, 代码混乱
  - 某些样式无法编写(比如伪类/伪元素)
- 所以官方依然是希望内联合适和普通的**css来结合编写;**

## 普通的css

- 普通的**css我们通常会编写到一个单独的文件，之后再进行引入。**
- 这样的编写方式和普通的网页开发中编写方式是一致的:
  - 如果我们按照普通的网页标准去编写，那么也不会有太大的问题;
  - 但是组件化开发中我们总是希望组件是一个`独立的模块`，即便是样式也只是在自己内部生效，不会相互影响; 
  - 但是`普通的css都属于全局的css，样式之间会相互影响;`
- 这种编写方式最大的问题是`样式之间会相互层叠掉`;

## css modules

- `css modules`**并不是React特有的解决方案，而是所有使用了类似于`webpack配置的环境`下都可以使用的。**
- 如果在其他项目中使用它，那么我们需要自己来进行配置，比如配置`webpack.config.js`中的`modules: true`等。
- React的脚手架已经内置了css modules的配置:
  * .css/.less/.scss 等样式文件都需要修改成 .module.css/.module.less/.module.scss 等; 
  * 之后就可以引用并且进行使用了;
- css modules**确实解决了局部作用域的问题，也是很多人喜欢在React中使用的一种方案。**
- 但是这种方案也有自己的`缺陷`:
  - 引用的类名，不能使用连接符(.home-title)，在JavaScript中是不识别的; 
  - 所有的className都必须使用{style.className} 的形式来编写;
  - 不方便动态来修改某些样式，依然需要使用内联样式的方式;
- 如果你觉得上面的缺陷还算**OK，那么你在开发中完全可以选择使用css modules来编写，并且也是在React中很受欢迎的一种方式。**

## 认识**CSS in JS**

- 官方文档也有提到过`CSS in JS`这种方案:
  - “CSS-in-JS” 是指一种模式，其中 `CSS 由 JavaScript 生成`而不是在外部文件中定义;
  - 此功能并不是 React 的一部分，而是由第三方库提供;
  - React 对样式如何定义并没有明确态度;
- 在传统的前端开发中，我们通常会将结构(HTML)、样式(CSS)、逻辑(JavaScript)进行分离。
  - 但是在前面的学习中，我们就提到过，React的思想中认为`逻辑本身和UI是无法分离`的，所以才会有了`JSX`的语法。
  - 样式呢?样式也是属于UI的一部分;
  - 事实上CSS-in-JS的模式就是`一种将样式(CSS)也写入到JavaScript中的方式，并且可以方便的使用JavaScript的状态;` 
  - 所以React有被人称之为 `All in JS`;
- 当然，这种开发的方式也受到了很多的批评:
  - Stop using CSS in JavaScript for web development
  - https://hackernoon.com/stop-using-css-in-javascript-for-web-development-fa32fb873dcc

## styled-components

- 批评声音虽然有，但是在我们看来很多优秀的**CSS-in-JS的库依然非常强大、方便:**
  - CSS-in-JS通过JavaScript来为CSS赋予一些能力，包括类似于CSS预处理器一样的样式嵌套、函数定义、逻辑复用、动态修 改状态等等;
  - 虽然CSS预处理器也具备某些能力，但是获取动态状态依然是一个不好处理的点;
  - 所以，目前可以说CSS-in-JS是React编写CSS最为受欢迎的一种解决方案;
- 目前比较流行的**CSS-in-JS的库有哪些呢?** 
  - `styled-components`
  - `emotion`
  - `glamorous`
- 目前可以说**styled-components依然是社区最流行的CSS-in-JS库，所以我们以styled-components的讲解为主;** 
- 安装**styled-components:**

```shell
npm install styled-component
```

### ES6**标签模板字符串**

- ES6**中增加了模板字符串的语法，这个对于很多人来说都会使用。**
- 但是模板字符串还有另外一种用法:`标签模板字符串`(**Tagged Template Literals)**。
- 我们一起来看一个普通的JavaScript的函数:
  - 正常情况下，我们都是通过 `函数名()` 方式来进行调用的，其实函数还有另外一种调用方式:
- 如果我们在调用的时候`插入其他的变量`:
  - 模板字符串被拆分了;
  - 第一个元素是数组，是被模块字符串拆分的字符串组合; 
  - 后面的元素是一个个模块字符串传入的内容;
- 在**styled component中，就是通过这种方式来解析模块字符串，最终生成我们想要 的样式的**



### styled**的基本使用**

- styled-components**的`本质是通过函数的调用，最终 创建出一个组件:`**

  - 这个组件会被自动添加上一个不重复的class;
  - styled-components会给该class添加相关的样式;

- 另外，它支持类似于**CSS预处理器一样的样式嵌套:**

  - 支持`直接子代选择器或后代选择器`，并且直接编写

    样式;

  - 可以通过 `&` 符号`获取当前元素`;

  - `直接伪类选择器、伪元素`等;

```js
import styled from "styled-components"
import {
  primaryColor,
  largeSize
} from "./style/variables"

// 1.基本使用
export const AppWrapper = styled.div`
  .footer {
    border: 1px solid orange;
  }
`

// const obj = {
//   name: (props) => props.name || "why"
// }


// 2.子元素单独抽取到一个样式组件
// 3.可以接受外部传入的props
// 4.可以通过attrs给标签模板字符串中提供的属性
// 5.从一个单独的文件中引入变量
export const SectionWrapper = styled.div.attrs(props => ({
  tColor: props.color || "blue"
}))`
  border: 1px solid red;

  .title {
    font-size: ${props => props.size}px;
    color: ${props => props.tColor};

    &:hover {
      background-color: purple;
    }
  }

  .content {
    font-size: ${largeSize}px;
    color: ${primaryColor};
  }
`

```

```js
import React, { PureComponent } from 'react'
import Home from './home'
import { AppWrapper, SectionWrapper } from "./style"

export class App extends PureComponent {

  constructor() {
    super()

    this.state = {
      size: 30,
      color: "yellow"
    }
  }

  render() {
    const { size } = this.state

    return (
      <AppWrapper>
        <SectionWrapper size={size}>
          <h2 className='title'>我是标题</h2>
          <p className='content'>我是内容, 哈哈哈</p>
          <button onClick={e => this.setState({color: "skyblue"})}>修改颜色</button>
        </SectionWrapper>

        <Home/>

        <div className='footer'>
          <p>免责声明</p>
          <p>版权声明</p>
        </div>
      </AppWrapper>
    )
  }
}

export default App
```



### props**、attrs属性** 

- props**可以传递**

- props可以被传递给styled组件
  * 获取props需要通过`${}传入一个插值函数`，props会作为该函数的参数; 
  * 这种方式可以有效的解决动态样式的问题;
- 添加**attrs属性**



### style高级特性

- 支持样式的继承

- styled设置主题

```js
import styled from "styled-components";

const HYButton = styled.button`
  border: 1px solid red;
  border-radius: 5px;
`

export const HYButtonWrapper = styled(HYButton)`
  background-color: #0f0;
  color: #fff;
`

export const HomeWrapper = styled.div`
  .top {
    .banner {
      color: red;
    }
  }

  .bottom {
    .header {
      color: ${props => props.theme.color};
      font-size: ${props => props.theme.size};
    }

    .product-list {
      .item {
        color: blue;
      }
    }
  }
`

```



## classnames

- React在JSX给了我们开发者足够多的灵活性，你可以像编写JavaScript代码一样，通过一些逻辑来决定是否添加某些class

- 借助于一个第三方的库:`classnames`

```shell
npm install classnames
```

* 很明显，这是一个用于动态添加classnames的一个库

```js
import React, { PureComponent } from 'react'
import classNames from 'classnames'

export class App extends PureComponent {
  constructor() {
    super()

    this.state = {
      isbbb: true,
      isccc: true
    }
  }

  render() {
    const { isbbb, isccc } = this.state

    const classList = ["aaa"]
    if (isbbb) classList.push("bbb")
    if (isccc) classList.push("ccc")
    const classname = classList.join(" ")

    return (
      <div>
        <h2 className={`aaa ${isbbb ? 'bbb': ''} ${isccc ? 'ccc': ''}`}>哈哈哈</h2>
        <h2 className={classname}>呵呵呵</h2>

        <h2 className={classNames("aaa", { bbb:isbbb, ccc:isccc })}>嘿嘿嘿</h2>
        <h2 className={classNames(["aaa", { bbb: isbbb, ccc: isccc }])}>嘻嘻嘻</h2>
      </div>
    )
  }
}

export default App
```



# React-Redux(一)

> # redux

## JavaScript纯函数

- 函数式编程中有一个非常重要的概念叫`纯函数`，JavaScript符合函数式编程的范式，所以也有纯函数的概念;
  - 在react**开发中纯函数是被多次提及**的;
  - 比如react**中`组件就被要求像是一个纯函数`(为什么是像，因为还有class组件)，`redux中有一个reducer的概念`**，也是要求 必须是一个纯函数;
  - 所以掌握纯函数对于理解很多框架的设计是非常有帮助的;
- 纯函数的维基百科定义:
  - 在程序设计中，若一个函数符合以下条件，那么这个函数被称为纯函数:
  - 此`函数在相同的输入值时，需产生相同的输出。`
  - 函数的输出和输入值以外的其他隐藏信息或状态无关，也和由I/O设备产生的外部输出无关。
  - 该函数不能有语义上可观察的函数`副作用`，诸如“触发事件”，使输出设备输出，或更改输出值以外物件的内容等。
- 当然上面的定义会过于的晦涩，所以我简单总结一下: 
  - `确定的输入，一定会产生确定的输出`;
  - `函数在执行过程中，不能产生副作用;`

### 副作用概念的理解

- 那么这里又有一个概念，叫做`副作用`，什么又是副作用呢?
  - 副作用(side effect)其实本身是医学的一个概念，比如我们经常说吃什么药本来是为了治病，可能会产生一些其他的副作用;
  - 在计算机科学中，也引用了副作用的概念，表示在`执行一个函数`时，除了`返回函数值`之外，还对`调用函数产生了附加的影响`， 比如`修改了全局变量，修改参数或者改变外部的存储;`
- 纯函数在执行的过程中就是不能产生这样的副作用: 
  - 副作用往往是产生`bug的 '温床'`

### 纯函数的案例

- 我们来看一个对数组操作的两个函数:
  - `slice`:slice截取数组时不会对原数组进行任何操作,而是生成一个新的数组; 
  - `splice`:splice截取数组, 会返回一个新的数组, 也会对原数组进行修改;
- slice**就是一个纯函数，不会修改数组本身，而splice函数不是一个纯函数;**



### 纯函数的作用和优势

- 为什么纯函数在函数式编程中非常重要呢?
  - 因为你可以安心的编写和安心的使用;
  - 你在写的时候保证了函数的纯度，只是`单纯实现自己的业务逻辑`即可，`不需要关心传入的内容是如何获得的或者依赖其他的 外部变量是否已经发生了修改;`
  - 你在用的时候，你确定`你的输入内容不会被任意篡改`，并且`自己确定的输入，一定会有确定的输出`;
- React中就要求我们`无论是函数还是class声明一个组件，这个组件都必须像纯函数一样，保护它们的props不被修改:`
- 学习redux中，reducer也被要求是一个纯函数。

## 为什么需要redux

- JavaScript**开发的应用程序，已经变得越来越复杂了:**
  - JavaScript需要`管理的状态`越来越多，越来越复杂;
  - 这些状态包括服务器返回的数据、缓存数据、用户操作产生的数据等等，也包括一些UI的状态，比如某些元素是否被选中，是否显示 加载动效，当前分页;
- 管理不断变化的state是非常困难的:
  - `状态之间相互会存在依赖`，一个状态的变化会引起另一个状态的变化，`View页面也有可能会引起状态的变化`;
  - 当应用程序复杂时，state在什么时候，因为什么原因而发生了变化，发生了怎么样的变化，会变得非常难以控制和追踪;
- `React是在视图层帮助我们解决了DOM的渲染过程`，但是State依然是留给我们自己来管理:
  - 无论是组件定义自己的state，还是组件之间的通信通过props进行传递;也包括通过Context进行数据之间的共享;
  - React主要负责帮助我们管理视图，state如何维护最终还是我们自己来决定;
- `Redux`就是一个帮助我们`管理State的容器`:`Redux是JavaScript的状态容器，提供了可预测的状态管理;`
- Redux除了和React一起使用之外，它也可以和其他界面库一起来使用(比如Vue)，并且它非常小(包括依赖在内，只有2kb)

## Redux的三大原则

> 单一数据源

- 整个应用程序的`state`被存储在一颗object tree中，并且这个object tree只存储在一个 `store` 中: 
- Redux`并没有强制让我们不能创建多个Store`，但是那样做并`不利于数据的维护`;
- `单一的数据源可以让整个应用程序的state变得方便维护、追踪、修改;`

> State是只读的

- `唯一修改State的方法一定是触发action`，不要试图在其他地方通过任何的方式来修改State:
- 这样就确保了View或网络请求都不能直接修改state，它们`只能通过action来描述自己想要如何修改state`; 
- 这样可以保证所有的修改都被集中化处理，并且按照严格的顺序来执行，所以不需要担心race condition(竟态)的问题;

> 使用纯函数来执行修改

- 通过reducer将 `旧state`和 `actions联系在一起`，并且`返回一个新的State`: 
- 随着应用程序的复杂度增加，我们可以将`reducer拆分成多个小的reducers，分别操作不同state tree的一部分;`
- 但是`所有的reducer都应该是纯函数，不能产生任何的副作用`;





## Redux的核心理念-Store 

- Redux**的核心理念非常简单。**
- 比如我们有一个朋友列表需要管理:
  - 如果我们`没有定义统一的规范来操作这段数据`，那么`整个数据的变化就是无法跟踪的;` 
  - 比如页面的某处通过products.push的方式增加了一条数据; 
  - S比如另一个页面通过products[0].age = 25修改了一条数据;
- 整个应用程序错综复杂，当出现**bug时，很难跟踪到底哪里发生的变化;**

![image-20230905195614178](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905195614178.png)

## Redux的核心理念-action

- Redux`要求我们通过action来更新数据`:
  - 所有数据的变化，必须通过`派发(dispatch)action来更新;`
  - action是一个普通的JavaScript对象，`用来描述这次更新的type和content;`
- 比如下面就是几个更新friends的action:
  - 强制使用action的好处是可以`清晰的知道数据到底发生了什么样的变化，所有的数据变化都是可跟追、可预测的;`
  - 当然，目前我们的`action是固定的对象`;
  - 真实应用中，我们会`通过函数来定义，返回一个action;`

![image-20230905200422274](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905200422274.png)



## Redux的核心理念-reducer

- 但是如何将`state`和`action`联系在一起呢?答案就是`reducer`
  - reducer是一个`纯函数`;
  - reducer做的事情就是将传入的`state`和`action`结合起来生成一个`新的state`;

![image-20230905200513629](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905200513629.png)

## Redux结构划分

- 如果我们将所有的逻辑代码写到一起，那么当redux变得复杂时代码就难以维护。
  - 接下来，我会对`代码进行拆分`，将`store`、`reducer`、`action`、`constants(常量)`拆分成一个个文件。 
  - 创建`store/index.js`文件:
  - 创建`store/reducer.js`文件:
  - 创建`store/actionCreators.js`文件:
  - 创建`store/constants.js`文件:

![image-20230905202240769](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905202240769.png)

## Redux的使用过程

1. 创建一个`对象`，作为我们要`保存的状态`:
2. 创建`Store`来`存储这个state`
   - 创建`store`时必须`创建reducer`;
   - 我们可以通过 `store.getState` 来获取`当前的state`;

3. 通过`action`来`修改state`
   - 通过`dispatch`来`派发action`;
   - 通常`action`中都会有`type`属性，也可以携带其他的数据;

4. 修改`reducer`中的处理代码
   - 这里一定要记住，`reducer是一个纯函数，不需要直接修改state;` 
   - 后面我会讲到直接修改state带来的问题;

5. 可以在`派发action之前，监听store的变化:` 

```js
const { createStore } = require("redux")

// 初始化的数据
const initialState = {
  name: "why",
  counter: 100
}

//reducer是一个纯函数，不需要直接修改state；
// 定义reducer函数: 纯函数
// 两个参数: 
// 参数一: store中目前保存的state
// 参数二: 本次需要更新的action(dispatch传入的action)
// 返回值: 它的返回值会作为store之后存储的state
function reducer(state = initialState, action) {
  switch(action.type) {
    case "change_name":
      return { ...state, name: action.name }
    case "add_number":
      return { ...state, counter: state.counter + action.num }
    default:
      return state
  }
}

// 创建的store
const store = createStore(reducer)

module.exports = store
```

```js
//action

//定义常量
const { ADD_NUMBER, CHANGE_NAME } = require("./constants")

//action中都会有type属性，也可以携带其他的数据；
const changeNameAction = (name) => ({
  type: CHANGE_NAME,
  name
})

const addNumberAction = (num) => ({
  type: ADD_NUMBER,
  num
})


module.exports = {
  changeNameAction,
  addNumberAction
}

```



```js
//页面使用store

/**
 * redux代码优化:
 *  1.将派发的action生成过程放到一个actionCreators函数中
 *  2.将定义的所有actionCreators的函数, 放到一个独立的文件中: actionCreators.js
 *  3.actionCreators和reducer函数中使用字符串常量是一致的, 所以将常量抽取到一个独立constants的文件中
 *  4.将reducer和默认值(initialState)放到一个独立的reducer.js文件中, 而不是在index.js
 */

const store = require("./store")
const { addNumberAction, changeNameAction } = require("./store/actionCreators")

const unsubscribe = store.subscribe(() => {
  console.log("订阅数据的变化:", store.getState())
})

// actionCreators: 帮助我们创建action
// const changeNameAction = (name) => ({
//   type: "change_name",
//   name
// })


// 修改store中的数据: 必须action
//派发actions
store.dispatch(changeNameAction("kobe"))
store.dispatch(changeNameAction("lilei"))
store.dispatch(changeNameAction("james"))

// 修改counter
// const addNumberAction = (num) => ({
//   type: "add_number",
//   num
// })

store.dispatch(addNumberAction(10))
store.dispatch(addNumberAction(20))
store.dispatch(addNumberAction(30))
store.dispatch(addNumberAction(100))


```

## Redux使用流程

* 我们已经知道了**redux的基本使用过程，那么我们就更加清晰来认识一下redux在实际开发中的流程:**

![image-20230907192126012](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230907192126012.png)









# React-Redux(二)

> # react-redux

## redux融入react代码

- 核心代码主要是两个:
  - 在 `componentDidMount` 中定义数据的变化，`当数据发生变化时重新设置 counter;` 
  - 在`发生点击事件`时，`调用store的dispatch来派发对应的action;`

```js
//redux模式
import React, { PureComponent } from 'react'
import store from "../store"
import { addNumberAction } from '../store/actionCreators'

export class Home extends PureComponent {
  constructor() {
    super()

    this.state = {
      //从store获取数据
      counter: store.getState().counter,

      message: "Hello World",
      friends: [
        {id: 111, name: "why"},
        {id: 112, name: "kobe"},
        {id: 113, name: "james"},
      ]
    }
  }

  //生命周期函数
  componentDidMount() {
    //订阅store
    store.subscribe(() => {
      const state = store.getState()
      this.setState({ counter: state.counter })
    })
  }

  addNumber(num) {
    //派发actions
    store.dispatch(addNumberAction(num))
  }

  render() {
    const { counter } = this.state

    return (
      <div>
        <h2>Home Counter: {counter}</h2>
        <div>
          <button onClick={e => this.addNumber(1)}>+1</button>
          <button onClick={e => this.addNumber(5)}>+5</button>
          <button onClick={e => this.addNumber(8)}>+8</button>
        </div>
      </div>
    )
  }
}

export default Home

```



## react-redux库

- 开始之前需要强调一下，`redux和react没有直接的关系`，你完全可以在React, Angular, Ember, jQuery, or vanilla JavaScript中使用Redux。

- 尽管这样说，redux依然是和React库结合的更好，因为他们是`通过state函数来描述界面的状态`，Redux可以发射状态的更新， 让他们作出相应。

- 虽然我们之前已经实现了connect、Provider这些帮助我们完成连接redux、react的辅助工具，但是实际上redux官方帮助我 们提供了 `react-redux` 的库，可以直接在项目中使用，并且实现的逻辑会更加的严谨和高效。

- 安装react-redux:

  ```shell
  yarn add react-redux
  ```

  ```js
  import { createStore, compose, combineReducers } from "redux"
  import { log, thunk, applyMiddleware } from "./middleware"
  // import thunk from "redux-thunk"
  
  import counterReducer from "./counter"
  import homeReducer from "./home"
  import userReducer from "./user"
  
  // 正常情况下 store.dispatch(object)
  // 想要派发函数 store.dispatch(function)
  
  // 将两个reducer合并在一起
  const reducer = combineReducers({
    counter: counterReducer,
    home: homeReducer,
    user: userReducer
  })
  
  // combineReducers实现原理(了解)
  // function reducer(state = {}, action) {
  //   // 返回一个对象, store的state
  //   return {
  //     counter: counterReducer(state.counter, action),
  //     home: homeReducer(state.home, action),
  //     user: userReducer(state.user, action)
  //   }
  // }
  
  // redux-devtools
  const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__({trace: true}) || compose;
  const store = createStore(reducer)
  
  //中间件使用
  applyMiddleware(store, log, thunk)
  
  export default store
  
  ```

![image-20230905203636536](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905203636536.png)

![image-20230905203920327](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905203920327.png)

```js
import React, { PureComponent } from 'react'
import { connect } from "react-redux"
// import store from "../store"
import { addNumberAction, subNumberAction } from '../store/counter'

export class About extends PureComponent {

  calcNumber(num, isAdd) {
    if (isAdd) {
      this.props.addNumber(num)
    } else {
      this.props.subNumber(num)
    }
  }

  render() {
    const { counter, banners, recommends, userInfo } = this.props

    return (
      <div>
        <div className='user'>
          <h2>nickname: {userInfo.nickname}</h2>
        </div>
        <h2>About Page: {counter}</h2>
        <div>
          <button onClick={e => this.calcNumber(6, true)}>+6</button>
          <button onClick={e => this.calcNumber(88, true)}>+88</button>
          <button onClick={e => this.calcNumber(6, false)}>-6</button>
          <button onClick={e => this.calcNumber(88, false)}>-88</button>
        </div>
        <div className='banner'>
          <h2>轮播图数据:</h2>
          <ul>
            {
              banners.map((item, index) => {
                return <li key={index}>{item.title}</li>
              })
            }
          </ul>
        </div>
        <div className='recommend'>
          <h2>推荐数据:</h2>
          <ul>
            {
              recommends.map((item, index) => {
                return <li key={index}>{item.title}</li>
              })
            }
          </ul>
        </div>
      </div>
    )
  }
}

// connect()返回值是一个高阶组件
// function mapStateToProps(state) {
//   return {
//     counter: state.counter
//   }
// }

// function fn2(dispatch) {
//   return {
//     addNumber(num) {
//       dispatch(addNumberAction(num))
//     },
//     subNumber(num) { 
//       dispatch(subNumberAction(num))
//     }
//   }
// }

const mapStateToProps = (state) => ({
  counter: state.counter.counter,
  banners: state.home.banners,
  recommends: state.home.recommends,
  userInfo: state.user.userInfo
})

const mapDispatchToProps = (dispatch) => ({
  addNumber(num) {
    dispatch(addNumberAction(num))
  },
  subNumber(num) {
    dispatch(subNumberAction(num))
  }
})

export default connect(mapStateToProps, mapDispatchToProps)(About)

```

### Provider

React Redux 包含一个<Provider />组件，`它使 Redux 存储可供应用程序的其余部分使用：`

```js
import React from 'react'
import ReactDOM from 'react-dom/client'

import { Provider } from 'react-redux'
import store from './store'

import App from './App'

// As of React 18
const root = ReactDOM.createRoot(document.getElementById('root'))
root.render(
  <Provider store={store}>
    <App />
  </Provider>
)
```

### Connect(class写法)

- 该`connect()`函数将 `React 组件连接到 Redux 存储`。
- 它向其`连接的组件提供它需要从存储中获取的数据片段(mapStateToProps)`，以及`可用于将操作分派到存储的函数(mapDispatchToProps)`。
- 它不会修改传递给它的组件类；相反，它返回一个`新的连接组件类`，`该类包装您传入的组件`。

```js
function connect(mapStateToProps?, mapDispatchToProps?, mergeProps?, options?)
```

![image-20230905210057032](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905210057032.png)

#### mapStateToProps

- 作为传递给的第一个参数`connect`
- ``mapStateToProps`用于从存储中选择连接组件所需的数据部分。它经常被简称为`mapState`。

- 每次存储状态发生变化时都会调用它。
- 它接收整个存储状态，并且应该返回该组件所需的数据对象。

#### mapDispatchToProps

- 作为传递给的第二个参数`connect`
- `mapDispatchToProps`用于将操作分派到存储。
- `dispatch`是 Redux 存储的一个函数。您调用`store.dispatch`以调度操作。这是触发状态更改的唯一方法。
- 使用 React Redux，您的组件永远不会直接访问存储 `connect`为您服务。
- React Redux 为您提供了两种让组件分派操作的方法：
  - 默认情况下，连接的组件`props.dispatch`本身接收并可以调度操作。
  - `connect`可以接受一个名为 的参数`mapDispatchToProps`，它允许您创建在调用时分派的函数，并将这些函数作为 props 传递给您的组件。
- 这些`mapDispatchToProps`函数通常简称为`mapDispatch`，但实际使用的变量名称可以是您想要的任何名称。

![image-20230905211725860](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905211725860.png)

## combineReducers（react函数）

- 目前我们`合并`的方式是通过每次调用reducer函数自己来返回一个新的对象。
- 事实上，redux给我们提供了一个`combineReducers`函数可以方便的让我们对多个reducer进行合并:

![image-20230905204651491](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905204651491.png)

> 那么combineReducers是如何实现的呢?

- 事实上，它也是将我们`传入的reducers合并到一个对象中`，最终`返回一个combination的函数`(相当于我们之前的reducer函数了);
- 在执行`combination`函数的过程中，它会通过`判断前后返回的数据是否相同来决定返回之前的state还是新的state`; 
- `新的state会触发订阅者发生对应的刷新，而旧的state可以有效的组织订阅者发生刷新;`

## 异步操作

### 组件中异步操作

- 在之前简单的案例中，redux中保存的`counter`是一个`本地定义的数据`
  - 我们可以直接通过`同步`的操作来`dispatch action，state就会被立即更新。`
  - 但是真实开发中，redux中保存的很多数据`可能来自服务器，我们需要进行异步的请求，再将数据保存到redux中。`
- 在之前学习网络请求的时候我们讲过，网络请求可以在`class组件的componentDidMount中发送`，所以我们可以有这样的结构:
- 我现在完成如下案例操作:
  - 在Home组件中请求banners和recommends的数据; 
  - 在Profile组件中展示banners和recommends的数据;

### redux中异步操作

- 上面的代码有一个`缺陷`:
  - 我们必须将`网络请求的异步代码放到组件的生命周期`中来完成;
  - 事实上，`网络请求到的数据也属于我们状态管理的一部分`，更好的一种方式应该是`将其也交给redux来管理`;
- 但是在redux中如何可以进行异步的操作呢?
  - 答案就是使用`中间件(Middleware)`;
  - 学习过Express或Koa框架的童鞋对中间件的概念一定不陌生;
  - 在这类框架中，`Middleware`可以帮助我们在`请求和响应之间嵌入一些操作的代码`，比如cookie解析、日志记录、文件压缩等操作;

### 理解中间件

- redux也引入了`中间件(Middleware)`的概念:
  - 这个中间件的目的是在`dispatch的action`和`最终达到的reducer之间`，`扩展一些自己的代码`; 
  - 比如日志记录、调用异步接口、添加代码调试功能等等;
- 我们现在要做的事情就是发送异步的网络请求，所以我们可以添加对应的中间件: 
  - 这里官网推荐的、包括演示的网络请求的中间件是使用 `redux-thunk`;

> redux-thunk**是如何做到让我们可以发送异步的请求呢?**

- 我们知道，默认情况下的`dispatch(action)，action需要是一个JavaScript的对象(type 和 content)`;
- redux-thunk可以让`dispatch(action函数)，action可以是一个函数;`
- 该函数会被调用，并且会传给`这个函数一个dispatch函数和getState函数;`
  - `dispatch`函数用于我们之后再次派发action;
  - `getState`函数考虑到我们之后的一些操作需要依赖原来的状态，用于让我们可以获取之前的一些状态;

![image-20230905214651981](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905214651981.png)

### 如何使用redux-thunk 

1. 安装redux-thunk

```shell
yarn add redux-thunk
```

2. 在创建store时传入应用了`middleware`的`enhance`函数 
   - 通过`applyMiddleware`来`结合多个Middleware`, `返回一个enhancer;` 
   - 将`enhancer`作为第二个参数传入到`createStore`中;

![image-20230905214823175](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905214823175.png)

2. 定义返回一个函数的action:
   - 注意:这里不是返回一个对象了，而是一个`函数`; 
   - 该`函数在dispatch之后会被执行`;

```js
export const fetchHomeMultidataAction = () => {
  // 如果是一个普通的action, 那么我们这里需要返回action对象
  // 问题: 对象中是不能直接拿到从服务器请求的异步数据的
  // return {}

  return function(dispatch, getState) {
    // 异步操作: 网络请求
    // console.log("foo function execution-----", getState().counter)
    axios.get("http://123.207.32.32:8000/home/multidata").then(res => {
      const banners = res.data.data.banner.list
      const recommends = res.data.data.recommend.list

      // dispatch({ type: actionTypes.CHANGE_BANNERS, banners })
      // dispatch({ type: actionTypes.CHANGE_RECOMMENDS, recommends })
      dispatch(changeBannersAction(banners))
      dispatch(changeRecommendsAction(recommends))
    })
  }

  // 如果返回的是一个函数, 那么redux是不支持的
  // return foo
}
```



## redux-devtools

- 我们之前讲过，redux可以方便的让我们对`状态进行跟踪和调试`，那么如何做到呢?
  - sredux官网为我们提供了`redux-devtools`的工具;
  - 利用这个工具，我们可以知道每次状态是如何被修改的，修改前后的状态变化等等;
- 安装该工具需要两步:
  - 第一步:在对应的浏览器中安装相关的插件(比如Chrome浏览器扩展商店中搜索Redux DevTools即可); 
  - 第二步:在redux中继承devtools的中间件(默认是关闭状态);

```js
import { createStore, applyMiddleware, compose } from "redux"
import thunk from "redux-thunk"
import reducer from "./reducer"

// redux-devtools
const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__({trace: true}) || compose;
const store = createStore(reducer, composeEnhancers(applyMiddleware(thunk)))

export default store
```



## Reducer结构划分

- 我们可以对`reducer`进行拆分:
  * 我们先抽取一个对counter处理的reducer; 
  * 再抽取一个对home处理的reducer;
    * 将它们`合并起来`;

> Reducer文件拆分

- 目前我们已经将`不同的状态`处理`拆分到不同的reducer中`，我们来思考:
  - 虽然已经放到不同的函数了，但是这些函数的处理依然是在同一个文件中，代码非常的混乱; 
  - 另外关于reducer中用到的constant、action等我们也依然是在同一个文件中;

![image-20230905212442032](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230905212442032.png)

```js
//index
import { createStore, compose, combineReducers } from "redux"
import { log, thunk, applyMiddleware } from "./middleware"
// import thunk from "redux-thunk"

import counterReducer from "./counter"
import homeReducer from "./home"
import userReducer from "./user"

// 正常情况下 store.dispatch(object)
// 想要派发函数 store.dispatch(function)

// 将两个reducer合并在一起
const reducer = combineReducers({
  counter: counterReducer,
  home: homeReducer,
  user: userReducer
})

// combineReducers实现原理(了解)
// function reducer(state = {}, action) {
//   // 返回一个对象, store的state
//   return {
//     counter: counterReducer(state.counter, action),
//     home: homeReducer(state.home, action),
//     user: userReducer(state.user, action)
//   }
// }

// redux-devtools
const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__({trace: true}) || compose;
const store = createStore(reducer)

applyMiddleware(store, log, thunk)

export default store

```









# React-Redux(三)

## 认识Redux Toolkit

- `Redux Toolkit` 是官方推荐的`编写 Redux 逻辑`的方法。

  - 在前面我们学习Redux的时候应该已经发现，`redux的编写逻辑过于的繁琐和麻烦。`
  - 并且代码通常分拆在多个文件中(虽然也可以放到一个文件管理，但是代码量过多，不利于管理); 
  - Redux Toolkit包旨在成为编写Redux逻辑的标准方式，从而解决上面提到的问题;
  - 在很多地方为了称呼方便，也将之称为“`RTK`”;

- 安装Redux Toolkit:

  ```shell
  npm install @reduxjs/toolkit react-redux
  ```

- Redux Toolkit**的核心`API`主要是如下几个:**

  - `configureStore`:包装createStore以提供简化的配置选项和良好的默认值。它可以自动组合你的 slice reducer，添加你提供的任何 Redux 中间件，redux-thunk`默认`包含，并启用 Redux DevTools Extension。
  - `createSlice`:接受reducer函数的对象、切片名称和初始状态值，并自动生成切片reducer，并带有相应的actions。
  - `createAsyncThunk`: 接受一个动作类型字符串和一个返回承诺的函数，并生成一个pending/fulfilled/rejected基于该承诺分 派动作类型的 thunk

## 重构redux代码

- 我们先对counter的reducer进行重构: 通过`createSlice`创建一个`slice`。

> `createSlice`主要包含如下几个参数:

- `name`:用户标记slice的名词
  - 在之后的redux-devtool中会显示对应的名词;
- `initialState`:初始化值
  - 第一次初始化时的值;
- `reducers`:相当于之前的reducer函数
  - 对象类型，并且可以添加很多的函数;
  - 函数类似于redux原来reducer中的一个case语句;
  - 函数的参数:
    - 参数一:state
    - 参数二:调用这个action时，传递的action参数;
- `createSlice`**返回值是一个对象，包含所有的actions;**

![image-20230906145003313](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906145003313.png)



## store的创建

- `configureStore`用于创建store对象，常见参数如下:
- `reducer`，将slice中的reducer可以组成一个对象传入此处;
- `middleware`:可以使用参数，传入其他的中间件(自行了解); 
- `devTools`:是否配置devTools工具，默认为true;

![image-20230906150013119](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906150013119.png)

### extraReducer的另外一种写法

- `extraReducer`**还可以传入一个函数，函数接受一个`builder`参数。** 
  - 我们可以向builder中添加`case`来监听异步操作的结果:

![image-20230906151310202](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906151310202.png)



## Redux Toolkit的异步操作

- 在之前的开发中，我们通过`redux-thunk中间件让dispatch中可以进行异步操作。`
- Redux Toolkit`默认`已经给我们继承了Thunk相关的功能:`createAsyncThunk`
- 当**createAsyncThunk创建出来的action被dispatch时，会存在三种状态:** 
  - `pending`:action被发出，但是还没有最终的结果;
  - `fulfilled`:获取到最终的结果(有返回值的结果);
  - `rejected`:执行过程中有错误或者抛出了异常;
- 我们可以在**createSlice的entraReducer中监听这些结果:** 

```js
import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'
import axios from 'axios'

export const fetchHomeMultidataAction = createAsyncThunk(
  "fetch/homemultidata", 
  async (extraInfo, { dispatch, getState }) => {
    // console.log(extraInfo, dispatch, getState)
    // 1.发送网络请求, 获取数据
    const res = await axios.get("http://123.207.32.32:8000/home/multidata")

    // 2.取出数据, 并且在此处直接dispatch操作(可以不做)
    const banners = res.data.data.banner.list
    const recommends = res.data.data.recommend.list
    dispatch(changeBanners(banners))
    dispatch(changeRecommends(recommends))

    // 3.返回结果, 那么action状态会变成fulfilled状态
    return res.data
})

const homeSlice = createSlice({
  name: "home",
  initialState: {
    banners: [],
    recommends: []
  },
  reducers: {
    changeBanners(state, { payload }) {
      state.banners = payload
    },
    changeRecommends(state, { payload }) {
      state.recommends = payload
    }
  },
  // extraReducers: {
  //   [fetchHomeMultidataAction.pending](state, action) {
  //     console.log("fetchHomeMultidataAction pending")
  //   },
  //   [fetchHomeMultidataAction.fulfilled](state, { payload }) {
  //     state.banners = payload.data.banner.list
  //     state.recommends = payload.data.recommend.list
  //   },
  //   [fetchHomeMultidataAction.rejected](state, action) {
  //     console.log("fetchHomeMultidataAction rejected")
  //   }
  // }
  extraReducers: (builder) => {
    // builder.addCase(fetchHomeMultidataAction.pending, (state, action) => {
    //   console.log("fetchHomeMultidataAction pending")
    // }).addCase(fetchHomeMultidataAction.fulfilled, (state, { payload }) => {
    //   state.banners = payload.data.banner.list
    //   state.recommends = payload.data.recommend.list
    // })
  }
})

export const { changeBanners, changeRecommends } = homeSlice.actions
export default homeSlice.reducer

```

## Redux Toolkit的数据不可变性(了解)

- 在React开发中，我们总是会强调`数据的不可变性`:
  - 无论是类组件中的state，还是redux中管理的state;
  - 事实上在整个JavaScript编码过程中，`数据的不可变性都是非常重要的`;
- 所以在前面我们经常会进行`浅拷贝`来完成某些操作，但是浅拷贝事实上也是存在问题的: 
  - 比如过大的对象，进行浅拷贝也会造成性能的浪费;
  - 比如浅拷贝后的对象，在深层改变时，依然会对之前的对象产生影响;
- 事实上Redux Toolkit`底层使用了immerjs`的一个库来`保证数据的不可变性。`
- 在我们公众号的一片文章中也有专门讲解`immutable-js库`的底层原理和使用方法:
  - https://mp.weixin.qq.com/s/hfeCDCcodBCGS5GpedxCGg
- 为了节约内存，又出现了一个新的算法:`Persistent Data Structure(持久化数据结构或一致性数据结构);`
  - 用一种数据结构来保存数据;
  - 当`数据被修改`时，会`返回一个对象`，但是`新的对象会尽可能的利用之前的数据结构而不会 对内存造成浪费`;

## 自定义connect函数

```js
import { createContext } from "react";

export const StoreContext = createContext()
```

```js
// connect的参数:
// 参数一: 函数
// 参数二: 函数
// 返回值: 函数 => 高阶组件

import { PureComponent } from "react";
import { StoreContext } from "./StoreContext";
// import store from "../store"

export function connect(mapStateToProps, mapDispatchToProps, store) {
  // 高阶组件: 函数
  return function(WrapperComponent) {
    class NewComponent extends PureComponent {
      constructor(props, context) {
        super(props)
        
        this.state = mapStateToProps(context.getState())
      }

      componentDidMount() {
        //监听state数据的变化
        this.unsubscribe = this.context.subscribe(() => {
          // this.forceUpdate()
          this.setState(mapStateToProps(this.context.getState()))
        })
      }

      componentWillUnmount() {
        //取消订阅
        this.unsubscribe()
      }

      render() {
        const stateObj = mapStateToProps(this.context.getState())
        const dispatchObj = mapDispatchToProps(this.context.dispatch)
        return <WrapperComponent {...this.props} {...stateObj} {...dispatchObj}/>
      }
    }

    NewComponent.contextType = StoreContext

    return NewComponent
  }
}

```

### context处理store

- 但是上面的`connect函数有一个很大的缺陷`:`依赖导入的store`
  - 如果我们将其封装成一个独立的库，需要依赖用于创建的 store，我们应该如何去获取呢?
  - 难道让用户来修改我们的源码吗?不太现实;
- 正确的做法是我们提供一个`Provider`，`Provider来自于我们创 建的Context，让用户将store传入到value中即可;`

![image-20230906154514360](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906154514360.png)



## [Redux-hooks模式](#redux-hooks模式)











# React-Router(一)

## 前端路由

- 路由其实是`网络工程`中的一个术语:
  - 在架构一个网络时，非常重要的两个设备就是`路由器`和`交换机`。
  - 当然，目前在我们生活中`路由器`也是越来越被大家所熟知，因为我们生活中都会用到`路由器`:
  - 事实上，`路由器主要维护的是一个映射表`;
  - `映射表`会决定数据的流向;
- 路由的概念在`软件工程`中出现，最早是在后端路由中实现的，原因是web的发展主要经历了这样一些阶段: 
  - 后端路由阶段;
  - 前后端分离阶段;
  - 单页面富应用(SPA);

## 后端路由

- 早期的网站开发整个HTML页面是由`服务器`来渲染的.
- `服务器`直接`生产渲染好对应的HTML页面`, 返回给客户端进行展示.
- 但是, 一个网站, 这么多页面服务器如何处理呢?
  - 一个页面有自己对应的网址, 也就是`URL`;
  - URL会发送到服务器, 服务器会通过`正则`对该`URL进行匹配`, 并且最后交给一个`Controller`进行处理; 
  - Controller进行各种处理, `最终生成HTML或者数据, 返回给前端.`
- 上面的这种操作, 就是`后端路由`:
  - 当我们页面中需要`请求不同的路径内容时`, 交给服务器来进行处理, `服务器渲染好整个页面, 并且将页面返回给客户端.` 
  - 这种情况下渲染好的页面, `不需要单独加载任何的js和css, 可以直接交给浏览器展示,` 这样也有利于`SEO`的优化.
- 后端路由的缺点:
  - 一种情况是整个页面的模块由后端人员来编写和维护的;
  - 另一种情况是前端开发人员如果要开发页面, 需要通过PHP和Java等语言来编写页面代码;
  - 而且通常情况下HTML代码和数据以及对应的逻辑会混在一起, 编写和维护都是非常糟糕的事情;

## 前后端分离

> `前端渲染`的理解:

- 每次请求涉及到的`静态资源都会从静态资源服务器获取`，这些资源包括`HTML+CSS+JS`，然后在`前端对这些请求回来的资源进行渲染;`
- 需要注意的是，`客户端的每一次请求，都会从静态资源服务器请求文件;`
- 同时可以看到，和之前的后端路由不同，这时后端只是负责提供API了;

> `前后端分离阶段`:

- 随着`Ajax`的出现, 有了前后端分离的开发模式;
- `后端只提供API来返回数据，前端通过Ajax获取数据，并且可以通过JavaScript将数据渲染到页面中`; 
- 这样做最大的优点就是前后端责任的清晰，后端专注于数据上，前端专注于交互和可视化上;
- 并且当移动端(iOS/Android)出现后，后端不需要进行任何处理，依然使用之前的一套API即可;
- 目前比较少的网站采用这种模式开发;

> `单页面富应用阶段`:

- 其实`SPA`最主要的特点就是在`前后端分离的基础上加了一层前端路由`. 
- 也就是`前端`来`维护一套路由规则.`
- 前端路由的核心是什么呢?`改变URL，但是页面不进行整体的刷新。`

## SPA的缺陷和服务器端渲染(ssr)的优势

![ ](https://cdn.jsdelivr.net/gh/OneOneT/images@main/SPA%E7%9A%84%E7%BC%BA%E9%99%B7%E5%92%8C%E6%9C%8D%E5%8A%A1%E5%99%A8%E7%AB%AF%E6%B8%B2%E6%9F%93%E7%9A%84%E4%BC%98%E5%8A%BF.png)



## URL的hash

- 前端路由是如何做到URL和内容进行映射呢?监听URL的改变。
- URL的hash
  - `URL的hash也就是锚点(#)`, `本质上是改变window.location的href属性;` 
  - 我们可以通过直接赋值location.hash来改变href, 但是页面不发生刷新;
- `hash的优势就是兼容性更好，在老版IE中都可以运行，但是缺陷是有一个#，显得不像一个真实的路径。`







## HTML5的History

- `history接口是HTML5新增的,` 它有六种模式改变`URL而不刷新页面:` 
  - `replaceState`:替换原来的路径;
  - `pushState`:使用新的路径;
  - `popState`:路径的回退;
  - `go`:向前或向后改变路径; 
  - `forward`:向前改变路径; 
  - `back`:向后改变路径;













# React-Router(二)

## 认识React-router

- 目前前端流行的三大框架**,** 都有自己的路由实现**:** 
  - Angular的AngRouter
  - React的ReactRouter
  - Vue的vue-router
- React Router**在最近两年版本更新的较快，并且在最新的React Router6.x版本中发生了较大的变化。** 
  - 目前React Router6.x已经非常稳定，我们可以放心的使用;
- 安装React Router:
  - 安装时，我们选择`react-router-dom`;
  - `react-router会包含一些react-native的内容，web开发并不需要;`

```shell
    npm install react-router-dom
```



## Router的基本使用 

- react-router最主要的API是给我们提供的一些组件:
- `BrowserRouter`或`HashRouter`
  - Router中包含了对路径改变的监听，并且会将相应的路径传递给子组件;
  - `BrowserRouter`使用`history`模式;
  - `HashRouter`使用`hash`模式;

![image-20230906163922653](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906163922653.png)



## 组件路由映射配置

- `Routes`:包裹所有的Route，在其中匹配一个路由
  - Router5.x使用的是Switch组件
- `Route`:Route用于路径的匹配;
  - `path`属性:用于设置匹配到的路径;
  - `element`属性:设置匹配到路径后，渲染的组件;
    - Router5.x使用的是component属性
  - `exact`:精准匹配，只有精准匹配到完全一致的路径，才会渲染对应的组件;
    - Router6.x不再支持该属性

![image-20230906164409936](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906164409936.png)

## 路由的嵌套

- 在开发中，路由之间是存在`嵌套关系`的。
- 这里我们假设Home页面中有两个页面内容:
  - 推荐列表和排行榜列表;
  - 点击不同的链接可以跳转到不同的地方，显示不同的内容;
- `<Outlet>`组件用于在`父路由元素中作为子路由的占位元素。`

![image-20230906171206591](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906171206591.png)

![image-20230906171127551](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906171127551.png)

## 组件导航

### Link的使用

- `Link`和`NavLink`:
  - 通常路径的跳转是使用`Link组件`，最终会被`渲染成a元素`;
  - `NavLink`是在<u>Link基础之上增加了一些样式属性</u>(后续学习); 
  - `to`属性:Link中最重要的属性，用于设置`跳转到的路径;`

![image-20230906164622051](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906164622051.png)



### NavLink的使用 

- 需求:<u>路径选中时，对应的a元素变为红色</u>
- 这个时候，我们要使用`NavLink`组件来替代Link组件:
  - `style`:传入函数，函数接受一个对象，包含`isActive`属性
  - `className`:传入函数，函数接受一个对象，包含`isActive`属性
- 默认的activeClassName: 
  - 事实上在`默认匹配成功时`，`NavLink就会添加上一个动态的active class;` 
  - 所以我们也可以直接编写样式
- 当然，如果你担心这个class在其他地方被使用了，出现样式的层叠，也可以自定义class

```js
 <NavLink to="/home" style={({isActive}) => ({color: isActive ? "red": ""})}>首页</NavLink>

 <NavLink to="/about" style={({isActive}) => ({color:  isActive ? "red": ""})}>关于</NavLink> 

 <NavLink to="/home" className={({isActive}) => isActive?"link-active":""}>首页</NavLink>

<NavLink to="/about" className={({isActive}) => isActive?"link-active":""}>关于</NavLink> 

```

### Navigate导航

- `Navigate`用于`路由的重定向`，当这个组件出现时，就会执行跳转到对应的`to`路径中:
- 我们这里使用这个的一个案例:
  - 用户跳转到Profile界面;
  - 但是在Profile界面有一个isLogin用于记录用户是否登录:
    - true:那么显示用户的名称;
    - false:直接重定向到登录界面;
- 我们也可以在匹配到`/`的时候，直接`跳转到/home页面`

```js
import React, { PureComponent } from 'react'
import { Navigate } from 'react-router-dom'

export class Login extends PureComponent {
  constructor(props) {
    super(props)

    this.state = {
      isLogin: false
    }
  }
  
  login() {
    this.setState({ isLogin: true })
  }

  render() {
    const { isLogin } = this.state

    return (
      <div>
        <h1>Login Page</h1>
        {!isLogin ? <button onClick={e => this.login()}>登录</button>: <Navigate to="/home"/>}
      </div>
    )
  }
}

export default Login
```

> 路由重定向

![image-20230906175457695](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906175457695.png)

![image-20230906175831200](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906175831200.png)





## 编程导航

- 目前我们实现的跳转主要是通过`Link或者NavLink(组件导航)`进行跳转的，实际上我们也可以通过`JavaScript`代码进行跳转。 
  - 我们知道Navigate组件是可以进行路由的跳转的，但是依然是`组件`的方式。
  - 如果我们希望通过JavaScript代码逻辑进行跳转(比如点击了一个button)，那么就需要获取到`navigate对象。`
- 在Router6.x版本之后，代码类的API都迁移到了`hooks`的写法:
  - 如果我们希望进行代码跳转，需要通过`useNavigate`的Hook获取到`navigate对象`进行操作; 

- 那么如果是一个函数式组件，我们可以直接调用，但是如果是一个`类组件`呢?

### 函数式组件-useNavigate

![image-20230906173512421](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906173512421.png)



### 类组件(封装withRouter高阶组件)

```js
//类组件编程式导航（封住withRouter高阶组件）

import { useState } from "react"
import { useLocation, useNavigate, useParams, useSearchParams } from "react-router-dom"

// 高阶组件: 函数
function withRouter(WrapperComponent) {
  return function(props) {
    // 1.导航
    const navigate = useNavigate()

    // 2.动态路由的参数: /detail/:id
    const params = useParams()

    // 3.查询字符串的参数: /user?name=why&age=18
    const location = useLocation()
    const [searchParams] = useSearchParams()
    const query = Object.fromEntries(searchParams)

    const router = { navigate, params, location, query }

    return <WrapperComponent {...props} router={router}/>
  }
}

export default withRouter

```



```js
import React, { PureComponent } from 'react'
import { withRouter } from "../hoc"

export class HomeSongMenu extends PureComponent {
  constructor(props) {
    super(props)

    this.state = {
      songMenus: [
        { id: 111, name: "华语流行" },
        { id: 112, name: "古典音乐" },
        { id: 113, name: "民谣歌曲" },
      ]
    }
  }

  NavigateToDetail(id) {
    const { navigate } = this.props.router
    navigate("/detail/" + id)
  }

  render() {
    const { songMenus } = this.state

    return (
      <div>
        <h1>Home Song Menu</h1>
        <ul>
          {
            songMenus.map(item => {
              return <li key={item.id} onClick={e => this.NavigateToDetail(item.id)}>{item.name}</li>
            })
          }
        </ul>
      </div>
    )
  }
}

export default withRouter(HomeSongMenu)

```



### 路由参数

- 传递参数有二种方式: 
  - `动态路由`的方式; 
  - `search`传递参数;
- `动态路由`的概念指的是路由中的`路径并不会固定`:
  - 比如/detail的path对应一个组件Detail;
  - 如果我们将path在Route匹配时写成/detail/:id，那么 /detail/abc、/detail/123都可以匹配到该Route，并且进行显示; 
  - 这个匹配规则，我们就称之为`动态路由`;
  - 通常情况下，使用`动态路由可以为路由传递参数`。

![image-20230906173833499](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906173833499.png)



![image-20230906173943068](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906173943068.png)

- `search(查询字符串)`传递参数

![image-20230906173705486](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906173705486.png)

![image-20230906174008567](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906174008567.png)

## Not Found页面配置

- 如果用户随意输入一个地址，该`地址无法匹配`，那么在路由匹配的位置将什么内容都不显示。
- 很多时候，我们希望在这种情况下，让用户看到一个`Not Found`的页面。
- 这个过程非常简单:
  - 开发一个`Not Found页面`;
  - 配置对应的Route，并且设置`path为*`即可;

![image-20230906171302620](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906171302620.png)

![image-20230906171243547](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906171243547.png)

## 路由的配置文件

- 目前我们所有的路由定义都是直接使用R`oute组件`，并且添加属性来完成的。
- 但是这样的方式会让路由变得非常混乱，我们希望将所有的路由配置放到一个地方进行`集中管理:` 
  - 在早期的时候，Router并且没有提供相关的API，我们需要借助于`react-router-config`完成; 
  - 在Router6.x中，为我们提供了`useRoutes` API可以完成相关的配置;
- 如果我们对某些组件进行了`异步加载(懒加载laze)`，那么需要使用`Suspense`进行包裹:

![image-20230906170907445](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230906170907445.png)

```js
import Home from '../pages/Home'
import HomeRecommend from "../pages/HomeRecommend"
import HomeRanking from "../pages/HomeRanking"
import HomeSongMenu from '../pages/HomeSongMenu'
// import About from "../pages/About"
// import Login from "../pages/Login"
import Category from "../pages/Category"
import Order from "../pages/Order"
import NotFound from '../pages/NotFound'
import Detail from '../pages/Detail'
import User from '../pages/User'
import { Navigate } from 'react-router-dom'
import React from 'react'

//路由懒加载
const About = React.lazy(() => import("../pages/About"))
const Login = React.lazy(() => import("../pages/Login"))

const routes = [
  {
    path: "/",
    element: <Navigate to="/home"/>
  },
  {
    path: "/home",
    element: <Home/>,
    children: [
      {
        path: "/home",
        element: <Navigate to="/home/recommend"/>
      },
      {
        path: "/home/recommend",
        element: <HomeRecommend/>
      },
      {
        path: "/home/ranking",
        element: <HomeRanking/>
      },
      {
        path: "/home/songmenu",
        element: <HomeSongMenu/>
      }
    ]
  },
  {
    path: "/about",
    element: <About/>
  },
  {
    path: "/login",
    element: <Login/>
  },
  {
    path: "/category",
    element: <Category/>
  },
  {
    path: "/order",
    element: <Order/>
  },
  {
    path: "/detail/:id",
    element: <Detail/>
  },
  {
    path: "/user",
    element: <User/>
  },
  {
    path: "*",
    element: <NotFound/>
  }
]


export default routes

```





# React-Hooks(一)

## 为什么使用Hooks

- Hook 是 React 16.8 的新增特性，它可以让我们在`不编写class的情况下使用state以及其他的React特性(比如生命周期)`。
- 我们先来思考一下`class组件相对于函数式组件`有什么优势?比较常见的是下面的优势:
- `class组件可以定义自己的state`，用来保存组件自己`内部的状态`;
  - 函数式组件不可以，因为<u>函数每次调用都会产生新的临时变量;</u>
- `class组件有自己的生命周期`，我们可以在对应的生命周期中完成自己的逻辑;
  - 比如在`componentDidMount`中发送网络请求，并且该生命周期函数只会执行一次;
  - 函数式组件在学习hooks之前，如果在函数中发送网络请求，意味着`每次重新渲染都会重新发送一次网络请求;`
- class组件可以`在状态改变时只会重新执行render函数`以及`我们希望重新调用的生命周期函数componentDidUpdate等`; 
  - 函数式组件在重新渲染时，整个函数都会被执行，似乎没有什么地方可以只让它们调用一次;

## Class**组件存在的问题**

> 复杂组件变得难以理解:

- 我们在最初编写一个class组件时，往往逻辑比较简单，并不会非常复杂。但是随着业务的增多，我们的class组件会变得越来越复杂;
- 比如`componentDidMount`中，可能就会包含大量的逻辑代码:包括网络请求、一些事件的监听(还需要在 `componentWillUnmount`中移除);
- 而对于这样的class实际上非常难以拆分:因为它们的逻辑往往混在一起，强行拆分反而会造成过度设计，增加代码的复杂度;

> 难以理解的class:

- 很多人发现学习ES6的`class`是学习React的一个障碍。
- 比如在class中，我们必须搞清楚`this`的指向到底是谁，所以需要花很多的精力去学习this;
- 虽然我认为前端开发人员必须掌握this，但是依然处理起来非常麻烦;

> 组件复用状态很难:

- 在前面为了一些状态的`复用`我们需要通过`高阶组件`;
- 像我们之前学习的redux中connect或者react-router中的withRouter，这些高阶组件设计的目的就是`为了状态的复用;`
- 或者类似于Provider、Consumer来共享一些状态，但是多次使用Consumer时，我们的代码就会存在`很多嵌套`;
- 这些代码让我们不管是编写和设计上来说，都变得非常困难;

## Hook的出现

- Hook的出现，可以解决上面提到的这些问题;
- 简单总结一下`hooks`:
  - 它可以让我们在`不编写class的情况下使用state以及其他的React特性`;
  - 但是我们可以由此延伸出非常多的用法，来让我们前面所提到的问题得到解决;
- Hook的使用场景:
  - Hook的出现基本可以代替我们之前所有使用class组件的地方;
  - 但是如果是一个旧的项目，你并不需要直接将所有的代码重构为Hooks，因为它`完全向下兼容`，你可以渐进式的来使用它; 
  - `Hook只能在函数组件中使用，不能在类组件，或者函数组件之外的地方使用;`
- 在我们继续之前，请记住 Hook 是:
  - 完全可选的:你无需重写任何已有代码就可以在一些组件中尝试 Hook。但是如果你不想，你不必现在就去学习或使用 Hook。
  - 100% 向后兼容的:Hook 不包含任何破坏性改动。
  - 现在可用:Hook 已发布于 v16.8.0。

# React-Hooks(二)

## useState

### useState解析

- `useState`来自react，需要从react中导入，它是一个`hook`;
  - `参数`:<u>初始化值</u>，如果不设置为<u>undefined</u>; 
  - `返回值:`<u>数组</u>，包含两个元素;
    - 元素一:`当前状态的值`(第一调用为初始化值)--state;
    - 元素二:`设置状态值的函数`--setstate;

> 案例:

- 点击button按钮后，会完成两件事情:
  - 调用`setCount`，设置一个新的值;
  - <u>组件重新渲染，并且根据新的值返回DOM结构</u>;



- `Hook 就是 JavaScript 函数`，这个函数可以帮助你 钩入(hook into) React State以及生命周期等特性;

> 但是使用它们会有两个额外的规则:

- 只能在`函数最外层调用 Hook。``不要在循环、条件判断或者子函数中调用。` 
- `只能在 React 的函数组件中调用 Hook。不要在其他 JavaScript 函数中调用。`



### 认识useState

- `useState`会帮助我们定义一个`state变量`，useState 是一种新方法，它与 `class` 里面的 `this.state` 提供的功能`完全相同`。
- 一般来说，在`函数退出后变量就会”消失”`，而 `state 中的变量会被 React 保留。`
- useState接受唯一一个参数，在`第一次组件被调用时使用来作为初始化值`。(如果没有传递参数，那么初始化值为`undefined`)。
- useState的`返回值`是一个`数组`，我们可以通过`数组的解构`，来完成赋值会非常方便。
  - https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment

> FAQ:为什么叫 `useState` 而不叫 `createState`?

- “create” 可能不是很准确，因为 state 只在组件首次渲染的时候被创建。 
- 在下一次重新渲染时，useState 返回给我们当前的 state。
- 如果每次都创建新的变量，它就不是 “state”了。
- 这也是 Hook 的名字总是以 use 开头的一个原因。
- 当然，我们也可以在`一个组件中定义多个变量和复杂变量(数组、对象)`

```js
import React, { memo, useState } from 'react'

const App = memo(() => {
  const [message, setMessage] = useState("Hello World")
  // const [count, setCount] = useState(100)
  // const [banners, setBanners] = useState([])

  function changeMessage() {
    setMessage("你好啊, 李银河!")
  }

  return (
    <div>
      <h2>App: {message}</h2>
      <button onClick={changeMessage}>修改文本</button>
    </div>
  )
})

export default App
```

## useEffect

### 认识Effect Hook

- 目前我们已经通过hook在函数式组件中定义state，那么类似于`生命周期`这些呢?
  - `Effect Hook` 可以让你来完成一些`类似于`class中`生命周期的功能`; 
  - 事实上，类似于网络请求、手动更新DOM、一些事件的监听，都是React更新DOM的一些`副作用(Side Effects)`; 
  - 所以对于完成这些功能的Hook被称之为 Effect Hook;
- 假如我们现在有一个需求:`页面的title`总是显示counter的数字，分别使用`class`组件和`Hook`实现: 

```js
//class组件
import React, { PureComponent } from 'react'

export class App extends PureComponent {
  constructor() {
    super()

    this.state = {
      counter: 100
    }
  }

  componentDidMount() {
    document.title = this.state.counter
  }

  componentDidUpdate() {
    console.log('-------')
    document.title = this.state.counter;
  }

  componentWillUnmount() {
    
  }

  render() {
    const { counter } = this.state

    return (
      <div>
        <h2>计数: {counter}</h2>
        <button onClick={e => this.setState({ counter: counter+1 })}>+1</button>
      </div>
    )
  }
}

export default App

```

### useEffect的解析:

- 通过useEffect的Hook，可以告诉React需要在`渲染后执行某些操作;`
- useEffect要求我们传入一个`回调函数`，在React`执行完更新DOM操作之后，就会回调这个函数;` 
- 默认情况下`，无论是第一次渲染之后，还是每次更新之后，都会执行这个 回调函数;`

```js
//hooks
import React, { memo } from 'react'
import { useState, useEffect } from 'react'

const App = memo(() => {
  const [count, setCount] = useState(200)

  useEffect(() => {
    // 当前传入的回调函数会在组件被渲染完成后, 自动执行
    // 网络请求/DOM操作(修改标题)/事件监听
    document.title = count
  })

  return (
    <div>
      <h2>当前计数: {count}</h2>
      <button onClick={e => setCount(count+1)}>+1</button>
    </div>
  )
})

export default App

```



### 需要清除Effect

- 在class组件的编写过程中，某些`副作用`的代码，我们需要在`componentWillUnmount`中进行`清除`: 
  - 比如我们之前的事件总线或Redux中手动调用subscribe;
  - 都需要在`componentWillUnmount`有对应的`取消订阅`;
  - Effect Hook通过什么方式来模拟componentWillUnmount呢?
- useEffect传入的`回调函数A`本身可以有一个`返回值`，这个返回值是另外一个`回调函数B`:

```js
type EffectCallback = () => (void | (() => void | undefined));
```

> 为什么要在 effect 中返回一个函数?

- 这是 effect `可选的清除机制`。每个 effect 都可以返回一个`清除函数`; 
- 如此可以将`添加和移除订阅的逻辑放在一起`;
- 它们都`属于 effect 的一部分`;

> React 何时清除 effect?

- React 会在`组件更新和卸载的时候执行清除操作;`
- 正如之前学到的，`effect 在每次渲染的时候都会执行;`

```js
import React, { memo, useEffect } from 'react'
import { useState } from 'react'

const App = memo(() => {
  const [count, setCount] = useState(0)

  // 负责告知react, 在执行完当前组件渲染之后要执行的副作用代码
  useEffect(() => {
    // 1.监听事件
    // const unubscribe = store.subscribe(() => {
    // })
    // function foo() {
    // }
    // eventBus.on("why", foo)
    console.log("监听redux中数据变化, 监听eventBus中的why事件")

    // 返回值: 回调函数 => 组件被重新渲染或者组件卸载的时候执行
    return () => {
      console.log("取消监听redux中数据变化, 取消监听eventBus中的why事件")
    }
  })

  return (
    <div>
      <button onClick={e => setCount(count+1)}>+1({count})</button>
    </div>
  )
})

export default App
```



### 使用多个Effect

- 使用Hook的其中一个目的就是`解决class中生命周期经常将很多的逻辑放在一起的问题:`

- 比如网络请求、事件监听、手动修改DOM，这些往往都会放在componentDidMount中; 

- 使用**Effect Hook，我们可以将它们分离到不同的useEffect中:**

  - 代码不再给出

  

- Hook 允许我们按照代码的用途分离它们，而不是像生命周期函数那样: 

  - React 将按照 effect `声明的顺序依次调用组件中的每一个 effect;`

```js
import React, { memo, useEffect } from 'react'
import { useState } from 'react'

const App = memo(() => {
  const [count, setCount] = useState(0)

  // 负责告知react, 在执行完当前组件渲染之后要执行的副作用代码
  useEffect(() => {
    // 1.修改document的title(1行)
    console.log("修改title")
  })

  // 一个函数式组件中, 可以存在多个useEffect
  useEffect(() => {
    // 2.对redux中数据变化监听(10行)
    console.log("监听redux中的数据")
    return () => {
      // 取消redux中数据的监听
    }
  })

  useEffect(() => {
    // 3.监听eventBus中的why事件(15行)
    console.log("监听eventBus的why事件")
    return () => {
      // 取消eventBus中的why事件监听
    }
  })

  return (
    <div>
      <button onClick={e => setCount(count+1)}>+1({count})</button>
    </div>
  )
})

export default App
```



### Effect性能优化

- 默认情况下，`useEffect的回调函数会在每次渲染时都重新执行`，但是这会导致两个问题:
  - 某些代码我们只是`希望执行一次即可`，类似于componentDidMount和componentWillUnmount中完成的事情;(比如网 络请求、订阅和取消订阅);
  - 另外，多次执行也会导致一定的性能问题;
- 我们如何决定useEffect在什么时候应该执行和什么时候不应该执行呢?
  - useEffect实际上有两个参数:
  - `参数一`:<u>执行的回调函数</u>;
  - `参数二`:<u>该useEffect在哪些state发生变化时，才重新执行;(`受谁的影响`)</u>

> 案例练习:

- 受count影响的Effect;

- 但是，如果一个函数我们`不希望依赖任何的内容时`，也可以传入一个`空的数组 []`:
  - 那么这里的两个回调函数分别对应的就是`componentDidMount`和`componentWillUnmount`生命周期函数了;

```js
import React, { memo, useEffect } from 'react'
import { useState } from 'react'

const App = memo(() => {
  const [count, setCount] = useState(0)
  const [message, setMessage] = useState("Hello World")

  useEffect(() => {
    console.log("修改title:", count)
  }, [count])

  useEffect(() => {
    console.log("监听redux中的数据")
    return () => {}
  }, [])

  useEffect(() => {
    console.log("监听eventBus的why事件")
    return () => {}
  }, [])

  useEffect(() => {
    console.log("发送网络请求, 从服务器获取数据")

    return () => {
      console.log("会在组件被卸载时, 才会执行一次")
    }
  }, [])

  return (
    <div>
      <button onClick={e => setCount(count+1)}>+1({count})</button>
      <button onClick={e => setMessage("你好啊")}>修改message({message})</button>
    </div>
  )
})

export default App
```

## useContext

- 在之前的开发中，我们要在组件中使用`共享`的Context有两种方式:
  - `类组件`可以通过 `类名.contextType = MyContext`方式，在类中获取context;
  - 多个Context或者在函数式组件中通过 `MyContext.Consumer` 方式共享context;
- 但是多个Context共享时的方式会存在大量的`嵌套`:
  - Context Hook允许我们通过Hook来直接获取某个Context的值;

> 注意事项:

- 当组件上层`最近`的 `<MyContext.Provider>` 更新时，该 Hook 会`触发重新渲染`，并使用最新传递给 MyContext provider 的 context value 值。

```js
//index.js 
root.render(
   <UserContext.Provider value={{name: "why", level: 99}}>
     <ThemeContext.Provider value={{color: "red", size: 30}}>
       //根组件
       <App />
     </ThemeContext.Provider>
   </UserContext.Provider>
 );

```



```js
import { createContext } from "react";

const UserContext = createContext()
const ThemeContext = createContext()


export {
  UserContext,
  ThemeContext
}
```

```js
import React, { memo, useContext } from 'react'
import { UserContext, ThemeContext } from "./context"

const App = memo(() => {
  // 使用Context
  const user = useContext(UserContext)
  const theme = useContext(ThemeContext)

  return (
    <div>
      <h2>User: {user.name}-{user.level}</h2>
      <h2 style={{color: theme.color, fontSize: theme.size}}>Theme</h2>
    </div>
  )
})

export default App
```

## useReducer(了解)

- 很多人看到`useReducer`的第一反应应该是redux的某个替代品，其实并不是。
- useReducer仅仅是`useState`的一种`替代方案`: 
  - 在某些场景下，如果`state的处理逻辑比较复杂`，我们可以通过`useReducer`来对其进行`拆分`; 
  - 或者这次修改的`state需要依赖之前的state时`，也可以使用;

- `数据是不会共享的`，它们只是使用了相同的`counterReducer`的函数而已。
- 所以，`useReducer只是useState的一种替代品`，并不能替代Redux。

```js
import React, { memo, useReducer } from 'react'
// import { useState } from 'react'

function reducer(state, action) {
  switch(action.type) {
    case "increment":
      return { ...state, counter: state.counter + 1 }
    case "decrement":
      return { ...state, counter: state.counter - 1 }
    case "add_number":
      return { ...state, counter: state.counter + action.num }
    case "sub_number":
      return { ...state, counter: state.counter - action.num }
    default:
      return state
  }
}

// useReducer+Context => redux

const App = memo(() => {
  // const [count, setCount] = useState(0)
  const [state, dispatch] = useReducer(reducer, { counter: 0, friends: [], user: {} })

  // const [counter, setCounter] = useState()
  // const [friends, setFriends] = useState()
  // const [user, setUser] = useState()

  return (
    <div>
      {/* <h2>当前计数: {count}</h2>
      <button onClick={e => setCount(count+1)}>+1</button>
      <button onClick={e => setCount(count-1)}>-1</button>
      <button onClick={e => setCount(count+5)}>+5</button>
      <button onClick={e => setCount(count-5)}>-5</button>
      <button onClick={e => setCount(count+100)}>+100</button> */}

      <h2>当前计数: {state.counter}</h2>
      <button onClick={e => dispatch({type: "increment"})}>+1</button>
      <button onClick={e => dispatch({type: "decrement"})}>-1</button>
      <button onClick={e => dispatch({type: "add_number", num: 5})}>+5</button>
      <button onClick={e => dispatch({type: "sub_number", num: 5})}>-5</button>
      <button onClick={e => dispatch({type: "add_number", num: 100})}>+100</button>
    </div>
  )
})

export default App
```

## useRef

- `useRef`返回一个ref对象，返回的ref对象再组件的整个生命周期保持不变。

> 最常用的ref是两种用法:

- 用法一:`引入DOM`(或者组件，但是需要是class组件)元素;
- 用法二:`保存一个数据`，这个对象在整个`生命周期`中可以保存不变;

> 案例:

- 案例一:引用DOM

```js
import React, { memo, useRef } from 'react'

const App = memo(() => {
  const titleRef = useRef()
  const inputRef = useRef()
  
  function showTitleDom() {
    console.log(titleRef.current)
    inputRef.current.focus()
  }

  return (
    <div>
      <h2 ref={titleRef}>Hello World</h2>
      <input type="text" ref={inputRef} />
      <button onClick={showTitleDom}>查看title的dom</button>
    </div>
  )
})

export default App
```



- 案例二:使用ref保存上一次的某一个值（[useCallback](#useCallback)）

```js
import React, { memo, useRef } from 'react'
import { useCallback } from 'react'
import { useState } from 'react'

let obj = null

const App = memo(() => {
  const [count, setCount] = useState(0)
  const nameRef = useRef()
  console.log(obj === nameRef)
  obj = nameRef

  // 通过useRef解决闭包陷阱
  const countRef = useRef()
  countRef.current = count

  const increment = useCallback(() => {
    setCount(countRef.current + 1)
  }, [])

  return (
    <div>
      <h2>Hello World: {count}</h2>
      <button onClick={e => setCount(count+1)}>+1</button>
      <button onClick={increment}>+1</button>
    </div>
  )
})

export default App

```

## redux-hooks模式

- 在之前的redux开发中，为了让`组件和redux结合起来`，我们使用了`react-redux`中的`connect函数`: 
  - 但是这种方式必须使用`高阶函数`结合返回的`高阶组件`;
  - 并且必须编写:`mapStateToProps`和 `mapDispatchToProps`映射的函数;
- 在Redux7.1开始，提供了Hook的方式，我们再也不需要编写connect以及对应的映射函数了
- `useSelector`的作用是将`state`<u>映射到组件</u>中:
  - 参数一:将state`映射到需要的数据中`;
  - 参数二:可以进行比较来决定是否组件重新渲染;(`shallowEqual`)
    - 默认情况下，`回调函数监听整个state数据`，但state中的数据发生改变时，会`重新进行渲染.`
    - `shallowEqual`,对`当前数据`和`上一次返回的数据`进行比较

> 补充：
>
>  `memo`函数是监听`props`改变，但props的数据发生改变时，才会进行重新渲染

- `useSelector`默认会比较我们返回的`两个对象是否相等`;
  - 如何比较呢? const refEquality = (a, b) => a === b;
  - 也就是我们必须`返回两个完全相等的对象`才可以不引起重新渲染;
- `useDispatch`非常简单，就是直接获取dispatch函数，之后在组件中直接使用即可; 
- 我们还可以通过`useStore`来获取当前的store对象;

```js
//class(connect函数模式)

React, { memo } from 'react'
import { connect } from "react-redux"
import { addNumberAction, subNumberAction } from './store/modules/counter'

const App = memo((props) => {
  const { count, addNumber, subNumber } = props

  function addNumberHandle(num, isAdd = true) {
    if (isAdd) {
      addNumber(num)
    } else {
      subNumber(num)
    }
  }

  return (
    <div>
      <h2>当前计数: {count}</h2>
      <button onClick={e => addNumberHandle(1)}>+1</button>
      <button onClick={e => addNumberHandle(6)}>+6</button>
      <button onClick={e => addNumberHandle(6, false)}>-6</button>
    </div>
  )
})

const mapStateToProps = (state) => ({
  count: state.counter.count
})

const mapDispatchToProps = (dispatch) => ({
  addNumber(num) {
    dispatch(addNumberAction(num))
  },
  subNumber(num) {
    dispatch(subNumberAction(num))
  }
})

export default connect(mapStateToProps, mapDispatchToProps)(App)

```



```js
//hooks模式
import React, { memo } from 'react'
import { useSelector, useDispatch } from "react-redux"
import { addNumberAction, subNumberAction } from './store/modules/counter'

const App = memo((props) => {
  // 1.使用useSelector将redux中store的数据映射到组件内
  const { count } = useSelector((state) => ({
    count: state.counter.count
  }))

  // 2.使用dispatch直接派发action
  const dispatch = useDispatch()
  function addNumberHandle(num, isAdd = true) {
    if (isAdd) {
      dispatch(addNumberAction(num))
    } else {
      dispatch(subNumberAction(num))
    }
  }

  return (
    <div>
      <h2>当前计数: {count}</h2>
      <button onClick={e => addNumberHandle(1)}>+1</button>
      <button onClick={e => addNumberHandle(6)}>+6</button>
      <button onClick={e => addNumberHandle(6, false)}>-6</button>
    </div>
  )
})

export default App

```

```js
//hooks模式
import React, { memo } from 'react'
import { useSelector, useDispatch, shallowEqual } from "react-redux"
import { addNumberAction, changeMessageAction, subNumberAction } from './store/modules/counter'


// memo高阶组件包裹起来的组件有对应的特点: 只有props发生改变时, 才会重新渲染
const Home = memo((props) => {
  const { message } = useSelector((state) => ({
    message: state.counter.message
  }), shallowEqual)

  const dispatch = useDispatch()
  function changeMessageHandle() {
    dispatch(changeMessageAction("你好啊, 师姐!"))
  }

  console.log("Home render")

  return (
    <div>
      <h2>Home: {message}</h2>
      <button onClick={e => changeMessageHandle()}>修改message</button>
    </div>
  )
})


const App = memo((props) => {
  // 1.使用useSelector将redux中store的数据映射到组件内
  const { count } = useSelector((state) => ({
    count: state.counter.count
  }), shallowEqual)

  // 2.使用dispatch直接派发action
  const dispatch = useDispatch()
  function addNumberHandle(num, isAdd = true) {
    if (isAdd) {
      dispatch(addNumberAction(num))
    } else {
      dispatch(subNumberAction(num))
    }
  }

  console.log("App render")

  return (
    <div>
      <h2>当前计数: {count}</h2>
      <button onClick={e => addNumberHandle(1)}>+1</button>
      <button onClick={e => addNumberHandle(6)}>+6</button>
      <button onClick={e => addNumberHandle(6, false)}>-6</button>

      <Home/>
    </div>
  )
})

export default App

```

# React-Hooks(三)

## 性能优化

### useCallback

- `useCallback`实际的目的是为了进行`性能的优化`。
- 如何进行性能的优化呢?
  - useCallback会`放回一个函数`数的 `memoized`(记忆的) 值; 
  - 在`依赖不变`的情况下，`多次定义的时候，返回的值是相同的;`

```js
  // 普通的函数(每一渲染都会重新定义一次(不是调用))
  // function addCount(num) {
  //   console.log("addCount函数创建");
  //   setCount(count + num);
  // }


  //useCallback函数本身也是转入一个函数作为参数,在渲染时也会重新定义(跟普通函数定义一样,起不到性能优化 )
  const addCount = useCallback((num) => {
    console.log("addCount函数创建");
    setCount(count + num);
  });
```



> 案例:

- 案例一:使用useCallback和不使用useCallback定义一个函数是否会带来性能的优化;
- 案例二:使用useCallback和不使用useCallback定义一个函数传递给子组件是否会带来性能的优化;





> 使用场景：

- 将`回调函数传递给子组件`时：如果一个回调函数会作为 props 传递给子组件，那么使用 `useCallback` 可以确保子组件只在必要时才会重新渲染。(搭配memo/pureCompoments使用)
- 通常使用`useCallback`的目的是`不希望子组件进行多次渲染，并不是为了函数进行缓存;`



-  useCallback返回一个有记忆的函数（根传入的回调函数一样）,当调用increment函数时，里面seCount(count + 1)函数时会刷新页面，这时App函数重新执行，重新调用increment函数时，但`没有指定依赖值`，重新调用increment函数时，setCount(count)的count还`定义这第一次count的值`（0）

![image-20230907201733489](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230907201733489.png)

```js
import React, { memo, useState, useCallback, useRef } from 'react'

// useCallback性能优化的点:
// 1.当需要将一个函数传递给子组件时, 最好使用useCallback进行优化, 将优化之后的函数, 传递给子组件

// props中的属性发生改变时, 组件本身就会被重新渲染
const HYHome = memo(function(props) {
  const { increment } = props
  console.log("HYHome被渲染")
  return (
    <div>
      <button onClick={increment}>increment+1</button>

      {/* 100个子组件 */}
    </div>
  )
})

const App = memo(function() {
  const [count, setCount] = useState(0)
  const [message, setMessage] = useState("hello")

  // 闭包陷阱: useCallback ==> 
 
  
  // const increment = useCallback(function foo() {
  //   console.log("increment")
  //   setCount(count+1)
  // }, [count])

  // 进一步的优化: 当count发生改变时, 也使用同一个函数(了解)
  // 做法一: 将count依赖移除掉, 缺点: 闭包陷阱
  // 做法二: useRef, 在组件多次渲染时, 返回的是同一个值
  const countRef = useRef()
  countRef.current = count
  
  const increment = useCallback(function foo() {
    console.log("increment")
    setCount(countRef.current + 1)
  }, [])

  // 普通的函数(组件重新渲染时会重新定义新的函数，而新的函数又会重新传入到另一个组件的props，组件props接收到新的值就会重新渲染)
  // const increment = () => {
  //   setCount(count+1)
  // }

  return (
    <div>
      <h2>计数: {count}</h2>
      <button onClick={increment}>+1</button>

      <HYHome increment={increment}/>

      <h2>message:{message}</h2>
      <button onClick={e => setMessage(Math.random())}>修改message</button>
    </div>
  )
})


//闭包
// function foo(name) {
//   function bar() {
//     console.log(name)
//   }
//   return bar
// }

// const bar1 = foo("why")
// bar1() // why
// bar1() // why

// const bar2 = foo("kobe")
// bar2() // kobe

// bar1() // why

export default App
```

```js
//  useCallback会返回同一个函数(memoized)


/*
	当父组件传递函数给子组件,父组件重新渲染时会重新定义函数,这时子组件的props属性也会跟着变化,这就造成子组件也被重新渲染
	useCallback的作用将函数返回有记忆(memoized)的函数,当依赖值发生改变时,返回新的函数
*/

const [count, setCount] = useState(100);

//不依赖其他值
//设置[], 同一个函数说明对count + num时,都是取到 函数定义 时取到的count = 100 
const addCount = useCallback((num) => {
    console.log("addCount函数创建");
    setCount(count + num);
  }, []);


//设置[count], 会根据count值的变化放回新的函数 ==>(性能优化跟普通的函数没什么区别)
const addCount = useCallback((num) => {
    console.log("addCount函数创建");
    setCount(count + num);
  }, [count]);


// function foo(name) {
//   function bar() {
//     console.log(name)
//   }
//   return bar
// }

// const bar1 = foo("why")
// bar1() // why
// bar1() // why

// const bar2 = foo("kobe")
// bar2() // kobe

// bar1() // why
```

```js
  // 进一步的优化: 当count发生改变时, 也使用同一个函数(了解)
  // 做法一: 将count依赖移除掉, 缺点: 闭包陷阱
  // 做法二: useRef, 在组件多次渲染时, 返回的是同一个值

  const countRef = useRef();//countRef无论在渲染多少次都是同一个对象
  countRef.current = count;//只有countRef里面的current会在渲染时被赋予新的值

// []不依赖谁 ==> 始终返回同一个函数(foo)(这就说明子组件的props没有改变,也不会重新渲染)
//foo函数又指向countRef对象(无论怎么渲染都是同一个对象),并取countRef对象里的current的值
  const addCount = useCallback((num) => {
    console.log("addCount函数创建");
    setCount(countRef.current + num);
  }, []);

```



### useMemo

- `useMemo`实际的目的也是为了进行`性能的优化。`

> 如何进行性能的优化呢?

- useMemo`返回`的也是一个 `memoized(记忆的) 值`;

- 在`依赖不变的情况下，多次定义的时候，返回的值是相同`的;

  

> 案例:

- 案例一:进行大量的计算操作，是否有必须要每次渲染时都重新计算;
- 案例二:对子组件传递相同内容的`对象`时，使用useMemo进行性能的优化



> useCallback和useMemo的区别

- `useCallback`返回的是一个`函数`
- `useMemo`放回的是一个`值`

```js
//两种相同的写法  
const increment = useCallback(fn, [])
const increment2 = useMemo(() => fn, [])
```



```js
import React, { memo, useCallback } from 'react'
import { useMemo, useState } from 'react'


const HelloWorld = memo(function(props) {
  console.log("HelloWorld被渲染~")
  return <h2>Hello World</h2>
})


function calcNumTotal(num) {
  // console.log("calcNumTotal的计算过程被调用~")
  let total = 0
  for (let i = 1; i <= num; i++) {
    total += i
  }
  return total
}

const App = memo(() => {
  const [count, setCount] = useState(0)

  // const result = calcNumTotal(50)

  // 1.不依赖任何的值, 进行计算
  const result = useMemo(() => {
    return calcNumTotal(50)
  }, [])

  // 2.依赖count
  // const result = useMemo(() => {
  //   return calcNumTotal(count*2)
  // }, [count])

  // 3.useMemo和useCallback的对比
  function fn() {}
  // const increment = useCallback(fn, [])
  // const increment2 = useMemo(() => fn, [])


  // 4.使用useMemo对子组件渲染进行优化
  // const info = { name: "why", age: 18 }
  const info = useMemo(() => ({name: "why", age: 18}), [])

  return (
    <div>
      <h2>计算结果: {result}</h2>
      <h2>计数器: {count}</h2>
      <button onClick={e => setCount(count+1)}>+1</button>

      <HelloWorld result={result} info={info} />
    </div>
  )
})

export default App
```




## useImperativeHandle(了解)

- 回顾一下`ref`和`forwardRef`结合使用:
  - 通过`forwardRef`可以将`ref转发到子组件`;
  - 子组件拿到父组件中创建的ref，绑定到自己的某一个元素中;
- `forwardRef`的做法本身没有什么问题，但是我们是将`子组件的DOM直接暴露给了父组件`:
  - 直接暴露给父组件带来的问题是某些情况的不可控;
  - 父组件可以拿到DOM后进行任意的操作;
  - 但是，事实上在上面的案例中，我们只是希望父组件可以操作的focus，其他并不希望它随意操作;
- 通过`useImperativeHandle`可以`只暴露固定的操作`:
  - 通过useImperativeHandle的Hook，将传入的ref和useImperativeHandle第二个参数返回的对象绑定到了一起; 
  - 所以在父组件中，使用 inputRef.current时，实际上使用的是返回的对象;
  - 比如我调用了 focus函数，甚至可以调用 printHello函数;

```js
import React, { memo, useRef, forwardRef, useImperativeHandle } from 'react'

const HelloWorld = memo(forwardRef((props, ref) => {

  const inputRef = useRef()

  // 子组件对父组件传入的ref进行处理
  useImperativeHandle(ref, () => {
    return {
      focus() {
        console.log("focus")
        inputRef.current.focus()
      },
      setValue(value) {
        inputRef.current.value = value
      }
    }
  })

  return <input type="text" ref={inputRef}/>
}))


const App = memo(() => {
  const titleRef = useRef()
  const inputRef = useRef()

  function handleDOM() {
    // console.log(inputRef.current)
    inputRef.current.focus()
    // inputRef.current.value = ""
    inputRef.current.setValue("哈哈哈")
  }

  return (
    <div>
      <h2 ref={titleRef}>哈哈哈</h2>
      <HelloWorld ref={inputRef}/>
      <button onClick={handleDOM}>DOM操作</button>
    </div>
  )
})

export default App

```





## useLayoutEffect(了解)

- `useLayoutEffect`看起来和`useEffect`非常的相似，事实上他们也`只有一点区别`而已: 
  - `useEffect`会在渲染的内容更新到DOM上`后`执行，`不会阻塞DOM的更新;`
  - `useLayoutEffect`会在渲染的内容更新到DOM上`之前`执行，`会阻塞DOM的更新`;
- 如果我们希望在`某些操作发生之后再更新DOM`，那么应该将这个操作放到useLayoutEffect。 
- 案例: useEffect和useLayoutEffect的对比



- 官方更推荐使用`useEffect而不是useLayoutEffect。`

```js
import React, { memo, useEffect, useLayoutEffect, useState } from 'react'

const App = memo(() => {
  const [count, setCount] = useState(0)
  
  useLayoutEffect(() => {
    console.log("useLayoutEffect")
  })

  useEffect(() => {
    console.log("useEffect")
  })

  console.log("App render")

  return (
    <div>
      <h2>count: {count}</h2>
      <button onClick={e => setCount(count + 1)}>+1</button>
    </div>
  )
})

export default App

```

- 执行顺序

![image-20230907213632466](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230907213632466.png)



## useld(服务器端)

> [ssr](#ssr)

- 官方的解释:`useId` 是一个用于生成`横跨服务端和客户端`的稳定的`唯一 ID` 的同时避免 `hydration` 不匹配的 hook。
- 这里有一个词叫`hydration`，要想理解这个词，我们需要理解一些[服务器端渲染(SSR)](#SSR)的概念。

> useId的作用

* 我们再来看一遍:`useId` 是一个用于生成`横跨服务端和客户端的稳定的唯一 ID 的同时避免 hydration 不匹配的 hook。`

> 结论:

- `useId`是用于r`eact的同构`应用开发的，前端的SPA页面并不需要使用它;
- useId可以`保证`应用程序在`客户端和服务器端生成唯一的ID`，这样可以有效的避免通过一些手段生成的id不一致，造成 hydration mismatch;

```js
import React, { memo, useId, useState } from 'react'

const App = memo(() => {
  const [count, setCount] = useState(0)

  const id = useId()
  console.log(id)

  return (
    <div>
      <button onClick={e => setCount(count+1)}>count+1:{count}</button>

      <label htmlFor={id}>
        用户名:<input id={id} type="text" />
      </label>
    </div>
  )
})

export default App

```



## useTransition

- `useTransition` 是一个让你在不阻塞 UI 的情况下来更新状态的 React Hook。

- 官方解释:返回一个`状态值`表示`过渡任务的等待状态`，以及一个`启动该过渡任务的函数。`
  - 事实上官方的说法，还是让人云里雾里，不知所云。
- `useTransition`到底是干嘛的呢?它其实在告诉react对于`某部分任务的更新优先级较低，可以稍后进行更新。`

```js
import React, { memo, useState, useTransition } from 'react'
import namesArray from './namesArray'

const App = memo(() => {
  const [showNames, setShowNames] = useState(namesArray)
  const [ pending, startTransition ] = useTransition()

  function valueChangeHandle(event) {
    startTransition(() => {
      const keyword = event.target.value
      const filterShowNames = namesArray.filter(item => item.includes(keyword))
      setShowNames(filterShowNames)
    })
  }

  return (
    <div>
      <input type="text" onInput={valueChangeHandle}/>
      <h2>用户名列表: {pending && <span>data loading</span>} </h2>
      <ul>
        {
          showNames.map((item, index) => {
            return <li key={index}>{item}</li>
          })
        }
      </ul>
    </div>
  )
})

export default App

```



## useDeferredValue

- 官方解释:`useDeferredValue` 接受一个值，并`返回该值的新副本，该副本将推迟到更紧急地更新之后。`
- 在明白了`useTransition`之后，我们就会发现`useDeferredValue的作用是一样的效果，可以让我们的更新延迟。`

```js
import React, { memo, useState, useDeferredValue } from 'react'
import namesArray from './namesArray'

const App = memo(() => {
  const [showNames, setShowNames] = useState(namesArray)
  const deferedShowNames = useDeferredValue(showNames)

  function valueChangeHandle(event) {
    const keyword = event.target.value
    const filterShowNames = namesArray.filter(item => item.includes(keyword))
    setShowNames(filterShowNames)
  }

  return (
    <div>
      <input type="text" onInput={valueChangeHandle}/>
      <h2>用户名列表: </h2>
      <ul>
        {
          deferedShowNames.map((item, index) => {
            return <li key={index}>{item}</li>
          })
        }
      </ul>
    </div>
  )
})

export default App

```





## 自定义Hooks

- 自定义Hook本质上只是一种`函数代码逻辑的抽取`，严格意义上来说，它本身并`不算React的特性`。

> 案例

- 需求:所有的组件在创建和销毁时都进行打印 
  - 组件被创建:打印 组件被创建了; 
  - 组件被销毁:打印 组件被销毁了;

```js
import React, { memo, useEffect, useState } from 'react'

function useLogLife(cName) {
  useEffect(() => {
    console.log(cName + "组件被创建")
    return () => {
      console.log(cName + "组件被销毁")
    }
  }, [cName])
}

const Home = memo(() => {
  useLogLife("home")

  return <h1>Home Page</h1>
})

const About = memo(() => {
  useLogLife("about")

  return <h1>About Page</h1>
})

const App = memo(() => {
  const [isShow, setIsShow] = useState(true)

  useLogLife("app")

  return (
    <div>
      <h1>App Root Component</h1>
      <button onClick={e => setIsShow(!isShow)}>切换</button>
      { isShow && <Home/> }
      { isShow && <About/> }
    </div>
  )
})

export default App

```

- 需求:Context的共享([useContext](#useContext))

![image-20230909095805434](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230909095805434.png)

```js
import { useContext } from "react"
import { UserContext, TokenContext } from "../context"

function useUserToken() {
  const user = useContext(UserContext)
  const token = useContext(TokenContext)

  return [user, token]
}

export default useUserToken

```



- 需求:获取滚动位置

```js
import { useState, useEffect } from "react"

function useScrollPosition() {
  const [ scrollX, setScrollX ] = useState(0)
  const [ scrollY, setScrollY ] = useState(0)

  useEffect(() => {
    function handleScroll() {
      // console.log(window.scrollX, window.scrollY)
      setScrollX(window.scrollX)
      setScrollY(window.scrollY)
    }

    window.addEventListener("scroll", handleScroll)
    return () => {
      window.removeEventListener("scroll", handleScroll)
    }
  }, [])

  return [scrollX, scrollY]
}

export default useScrollPosition

```

-  需求:localStorage数据存储

```js
import { useEffect } from "react"
import { useState } from "react"

function useLocalStorage(key) {
  // 1.从localStorage中获取数据, 并且数据数据创建组件的state
  const [data, setData] = useState(() => {
    const item = localStorage.getItem(key)
    if (!item) return ""
    return JSON.parse(item)
  })

  // 2.监听data改变, 一旦发生改变就存储data最新值
  useEffect(() => {
    localStorage.setItem(key, JSON.stringify(data))
  }, [data])

  // 3.将data/setData的操作返回给组件, 让组件可以使用和修改值
  return [data, setData]
}


export default useLocalStorage

```



# SSR

- `SSR(Server Side Rendering，服务端渲染)`，指的是页 面在服务器端已经生成了完成的HTML页面结构，不需要浏 览器解析;
- 对应的是`CSR(Client Side Rendering，客户端渲染)，` 我们开发的SPA页面通常依赖的就是客户端渲染;
- 早期的服务端渲染包括PHP、JSP、ASP等方式，但是在目前前 后端分离的开发模式下，前端开发人员不太可能再去学习PHP、 JSP等技术来开发网页;
- 不过我们可以借助于`Node`来帮助我们执行`JavaScript`代码，`提前完成页面的渲染`;



## SSR同构应用

> 什么是同构?

- 一套代码既可以在`服务端`运行又可以在`客户端`运行，这就是同构应用。

- `同构是一种SSR的形态，是现代SSR的一种表现形式。`
  - 当用户发出请求时，先在服务器通过SSR渲染出首页的内容。
  - 但是对应的代码同样可以在客户端被执行。
  - 执行的目的包括事件绑定等以及其他页面切换时也可以在客户端被渲染;

![image-20230909110433246](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230909110433246.png)

![image-20230909110831151](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230909110831151.png)

## Hydration

-  ◼ 什么是`Hydration`?这里我引入vite-plugin-ssr插件的`官方解释`。
- 在进行 SSR 时，我们的页面会呈现为 HTML。
  - 但仅 `HTML 不足以使页面具有交互性`。例如，浏览器端 JavaScript 为零的页面不能是交互式的(没有 JavaScript 事件处理程序来响应用户操作，例如单击按钮)。
  - 为了使我们的`页面具有交互性`，除了在 Node.js 中将页面呈现为 HTML 之外，我们的 UI 框架(Vue/React/...)`还在浏览器中加载和呈现页面`。(它创建页面的内部表示，然后将内部表示映射到我们在 Node.js 中呈现的 HTML 的 DOM 元素。) 
- 这个过程称为**`hydration`。**



## SPA-SSR

![SPA的缺陷和服务器端渲染的优势](https://cdn.jsdelivr.net/gh/OneOneT/images@main/SPA%E7%9A%84%E7%BC%BA%E9%99%B7%E5%92%8C%E6%9C%8D%E5%8A%A1%E5%99%A8%E7%AB%AF%E6%B8%B2%E6%9F%93%E7%9A%84%E4%BC%98%E5%8A%BF.png)













# React脚手架

## 创建React项目

```shell
npx create-react-app my-app
```



## 目录结构分析

![image-20230902004847281](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230902004847281.png)

## PWA

- 整个目录结构都非常好理解，只是有一个PWA相关的概念:
  * PWA全称Progressive Web App，即`渐进式WEB应用`;
  * 一个 PWA 应用首先是`一个网页`, 可以`通过 Web 技术编写出一个网页应用`;
  * 随后添加上 `App Manifest` 和 `Service Worker` 来实现 PWA 的`安装和离线`等功能; 
  * 这种Web存在的形式，我们也称之为是 `Web App`;
- PWA解决了哪些问题呢?
  - 可以`添加至主屏幕`，点击主屏幕图标可以实现启动动画以及隐藏地址栏; 
  - 实现`离线缓存功能`，即使用户手机没有网络，依然可以使用一些离线功能; 
  - 实现了`消息推送`;
  - 等等一系列类似于Native App相关的功能;
- 更多PWA相关的知识，可以自行去学习更多;
  * https://developer.mozilla.org/zh-CN/docs/Web/Progressive_web_apps



## 脚手架中的**webpack** 

- sReact**脚手架默认是基于`Webpack`来开发的;**
- 但是，很奇怪:我们并`没有`在目录结构中看到任何**`webpack相关的内容`?** 
  - 原因是React脚手架`将webpack相关的配置隐藏起来了`(其实从Vue CLI3开始，也是进行了隐藏);
- 如果我们希望看到**webpack的配置信息，应该怎么来做呢?** 
  - 我们可以执行一个`package.json`文件中的一个脚本:`"eject": "react-scripts eject"` 
  -  这个操作是`不可逆`的，所以在执行过程中会给与我们提示;

```shell
yarn eject
```

![image-20230902005717614](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230902005717614.png)

### React脚手架修改webpack方案

![react脚手架修改webpack两种方案](https://cdn.jsdelivr.net/gh/OneOneT/images@main/react%E8%84%9A%E6%89%8B%E6%9E%B6%E4%BF%AE%E6%94%B9webpack%E4%B8%A4%E7%A7%8D%E6%96%B9%E6%A1%88.png)





















