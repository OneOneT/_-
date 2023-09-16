# Taro的特点

- `多端支持`
  - Taro 3 可以支持转换到 H5、ReactNative 以及任意小程序平台(重心是小程序端)。 
  - 目前官方支持转换的平台如下:
    - H5、ReactNative、微信小程序、京东小程序、百度小程序、支付宝小程序、字节跳动小程序 
    - QQ 小程序、钉钉小程序、企业微信小程序、支付宝小程序等
- `多框架支持`
  - 在 Taro 3 中可以使用完整的 React / Vue / Nervjs / Preact 开发体验
  - 

# Taro安装及使用

- Taro 项目基于 node，请确保已具备较新的 node 环境(>=12.0.0)

- Taro CLI工具安装

  - 首先，你需要使用 npm 或者 yarn 全局安装 `@tarojs/cli`，或者直接使用 npx(如下图所示): 

  - ```shell
    npm i –g @tarojs/cli
    ```

- 查看 Taro CLI 工具版本 

  - ```shell
    npm info @tarojs/cli
    ```

## 项目初始化

- 使用命令创建模板项目：

```bash
$ taro init myApp
```

- npm 5.2+ 也可在不全局安装的情况下使用 npx 创建模板项目：

```bash
$ npx @tarojs/cli init myApp
```

- 注意事项:
  - 开发支付宝小程序时，Webpack4 暂不支持使用 React18。 
  - 受小程序环境限制，诸如新 SSR Suspense 等特性将不能在小程序中使用。
  - RN 暂不支持 React v18，需要等待 RN 官方输出支持方案。 
  - 为了顺利地用Taro来开发App，我们强烈地建议您，先对 React Native 开发进行学习。

## 编译运行

- Taro 编译分为 dev 和 build 模式:
  - `dev` 模式(增加 --watch 参数) 将会监听文件修改。
  - `build` 模式(去掉 --watch 参数) 将不会监听文件修改，并会对代码进行压缩打包。
- `dev` 命令 启动 Taro 项目的开发环境 
  - pnpm run dev:h5 启动H5端 
  - pnpm run dev:weapp 启动小程序端
- `build` 命令可以把 Taro 代码编译成不同端的代码，然后在对应的开发工具中查看效果，比如: 
  - H5直接在浏览器中可以查看效果
  - 微信小程序需在《微信开发者工具》打开根目录下的dist查看效果
  - RN应用需参考《React Native端开发流程》
  - 等等

# Taro目录结构

```shell
├── dist                        编译结果目录
|
├── config                      项目编译配置目录
|   ├── index.js                默认配置
|   ├── dev.js                  开发环境配置
|   └── prod.js                 生产环境配置
|
├── src                         源码目录
|   ├── pages                   页面文件目录
|   |   └── index               index 页面目录
|   |       ├── index.js        index 页面逻辑
|   |       ├── index.css       index 页面样式
|   |       └── index.config.js index 页面配置
|   |
|   ├── app.js                  项目入口文件
|   ├── app.css                 项目总通用样式
|   └── app.config.js           项目入口配置
|
├── project.config.json         微信小程序项目配置 project.config.json
├── project.tt.json             抖音小程序项目配置 project.tt.json
├── project.swan.json           百度小程序项目配置 project.swan.json
├── project.qq.json             QQ 小程序项目配置 project.qq.json
|
├── babel.config.js             Babel 配置
├── tsconfig.json               TypeScript 配置
├── .eslintrc                   ESLint 配置
|
└── package.json
```





# Taro+React开发规范

- 为了实现`多端兼容`，综合考虑编译速度、运行性能等因素，Taro可以约定了如下开发规范: 
  - 页面文件遵循 `React组件 (JSX)` 规范。 
  - 组件标签靠近小程序规范(但遵从大驼峰，并需导包)，详见Taro 组件规范
  - 接口能力(JS API)靠近微信小程序规范，但需将`前缀 wx 替换为 Taro(需导包)`，详见Taro接口规范 
  - 数据绑定及事件处理同 React 规范，同时补充了App及页面的生命周期
  - 为兼容多端运行，建议使用`flex`布局进行开发，推荐使用 `px` 单位(750设计稿)。 
  - 在 React 中使用`Taro内置组件`前，必须从 `@tarojs/components` 进行引入。 
  - 文档直接查看Taro的官网文档: https://docs.taro.zone/docs



# Taro--配置(一)

## 新建Page页面

- 快速创建新页面
  - 1.命令行创建:`Taro create --name [页面名称]`
  - 能够在当前项目的`pages目录`下快速生成新的页面文件，并填充基础代码，是一个提高开发效率的利器。 

```shell
Taro create --name home
```

- 2.手动创建页面
  - 在目录根目录下的`pages目录`下新建即可。
- 注意事项:新建的页面，都需在 `app.config.json` 中的 `pages` 列表上配置。

![image-20230910221208853](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230910221208853.png)

- 删除页面，需做两件工作
  - 删除页面对应的文件
  - 删除`app.config.json`中对应的配置



## webpack编译配置(config)

- 编译配置存放于项目根目录下的 `config` 目录中，包含三个文件: 
  - `index.js` 是`通用`配置
  - `dev.js` 是项目`开发时`的配置
  - `prod.js` 是项目`生产时`的配置
- 常用的配置
  - projectName : 项目名称
  - date : 项目创建时间
  - designWidth: 设计稿尺寸
  - sourceRoot :项目源码目录
  - outputRoot: 项目产出目录
  - `defineConstants`: 定义全局的变量(DefinePlugin)
  - `alias`: 配置路径别名
  - h5.webpackChain: webpack配置
  - sh5.devServer :开发者服务配置
- 更多的配置:https://docs.taro.zone/docs/config



## 全局配置(app.config.js)

- `app.config.js` 用来对小程序进行`全局配置`，配置项`遵循微信小程序`规范，`类似微信小程序的app.json`，并对所有平台进行统一
- 更多的配置:
  - https://docs.taro.zone/docs/next/app-config 

![image-20230910205430262](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230910205430262.png)

![image-20230910205444361](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230910205444361.png)

### 配置Tabbar

- 在`app.config.js`中配置`Tabbar`
  - `icon`路劲支持`绝对路径`和`相对路径`

```ts
  tabBar: {
    color: "#999",
    selectedColor: "#ff464e",
    list: [
      {
        text: "首页",
        pagePath: "pages/home/index",
        iconPath: "assets/images/tabbar/home.png",
        selectedIconPath: "assets/images/tabbar/home_active.png",
      },
      {
        text: "分类",
        pagePath: "pages/category/index",
        iconPath: "assets/images/tabbar/category.png",
        selectedIconPath: "assets/images/tabbar/category_active.png",
      },
      {
        text: "购物车",
        pagePath: "pages/cart/index",
        iconPath: "assets/images/tabbar/cart.png",
        selectedIconPath: "assets/images/tabbar/cart_active.png",
      },
      {
        text: "我的",
        pagePath: "pages/profile/index",
        iconPath: "assets/images/tabbar/profile.png",
        selectedIconPath: "assets/images/tabbar/profile_active.png",
      },
    ],
  },
```





## 页面配置(.config.js)

- 每一个小程序`页面`都可以使用 `.config.js` 文件来对本页面的窗口表现进行配置。
- 页面中配置项在当前页面会`覆盖全局配置` app.config.json 的 window 中相同的配置项。 
- 文件需要 `export` 一个默认对象，配置项遵循`微信小程序`规范，并且对所有平台进行统一。
- 更多页面配置:
  - https://docs.taro.zone/docs/next/page-config

![image-20230910205754235](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230910205754235.png)

## 项目配置(**project.x.json)**

- 为了适配`不同的小程序`， Taro支持各个小程序平台添加各自项目`配置文件`。 
- 默认 `project.config.json` 配置只能用于`微信小程序。`
- `project.config.json` 常用配置 
  - libVersion 小程序基础库版本 
  - projectname 小程序项目名字 
  - appid 小程序项目的appid
  - setting 小程序项目编译配置
- 各类小程序平台均有自己的项目配置文件，例如: 
  - 微信小程序，project.config.json
  - 百度小程序，project.swan.json
  - 字节跳动小程序，project.tt.json
  - 支付宝小程序，project.alipay.json
  - 等等

![image-20230910210023929](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230910210023929.png)



## 入口组件(app.js)

- 每一个 Taro 应用都需要一个`入口组件(如React 组件)`用来注册应用。入口文件默认是 `src 目录下的 app.js。`
- 在入口`app.js`组件中我们可以: 
  - 定义应用的`生命周期`
    - onLaunch -> useEffect:在小程序环境中对应 app 的 onLaunch。
    - componentDidShow -> useDidShow:在小程序环境中对应 app 的 onShow 。 
    - componentDidHide -> useDidHide:在小程序环境中对应 app 的 onHide 。
  - `定义全局数据`
    - taroGlobalData
  - 定义应用的`全局状态`:Redux ( Vuex、Pinia)

```ts
import React, { useEffect } from 'react'

// Taro 额外添加的 hooks 要从 '@tarojs/taro' 中引入
import { useDidShow, useDidHide } from '@tarojs/taro'

// 假设我们要使用 Redux
import { Provider } from 'react-redux'
import configStore from './store'

// 全局样式
import './app.css'

const store = configStore()

function App(props) {
  // 可以使用所有的 React Hooks
  useEffect(() => {})

  // 对应 onShow
  useDidShow(() => {})

  // 对应 onHide
  useDidHide(() => {})

  return (
    // 在入口组件不会渲染任何内容，但我们可以在这里做类似于状态管理的事情
    <Provider store={store}>
      {/* props.children 是将要被渲染的页面 */}
      {props.children}
    </Provider>
  )
}

export default App
```



# Taro--配置(二)

## 常用内置组件

- `View`:视图容器。用于包裹各种元素内容(Taro3.3以后支持使用 HTML 标签 进行开发)。
- `Text`:文本组件。用于包裹文本内容。
- `Button`: 按钮组件，多端主题色一样。
- `Image`:图片。H5默认为图片宽高，weapp为默认组件宽高，支持 JPG、PNG、SVG、WEBP、GIF 等格式以及云文件ID。
  - 支持import导入 和 URL网络图片
- `ScrollView`:可滚动视图区域，用于区域滚动。
  - 使用`竖向滚动`时，需要给 <scroll-view> 一个`固定高度`，通过 css 设置 height 
  - 使用`横向滚动`时，需要给<scroll-view>添加white-space: nowrap;样式，子元素设置为行内块级元素。 
  - 小程序中，请勿在 scroll-view 中使用 map、video 等原生组件，也不要使用 canvas、textarea 原生组件。
- `Swiper`:滑块视图容器，一般作为banner轮播图，默认宽100%，高150px。

```ts
export default class CpnsTaro extends Component {
  render() {
    return (
      <View>
        <View>
          <Text>我是一个Text</Text>
        </View>
        <Button type="primary">我是一个Button</Button>

        {/* 图片 */}
        <Image className="image" src={EmptyCartImg}></Image>
        <Image className="image" src={HomeImg}></Image>
        <Image
          className="image"
          src="https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png"
        ></Image>

        {/* ScrollView */}
        <ScrollView scrollY className="v-scroll">
          <View className="v-item">item1</View>
          <View className="v-item">item1</View>
          <View className="v-item">item1</View>
          <View className="v-item">item1</View>
          <View className="v-item">item1</View>
          <View className="v-item">item8</View>
          <View className="v-item">item9</View>
          <View className="v-item">item10</View>
        </ScrollView>

        <ScrollView scrollX className="h-scroll">
          <View className="h-item">item1</View>
          <View className="h-item">item1</View>
          <View className="h-item">item1</View>
          <View className="h-item">item1</View>
          <View className="h-item">item1</View>
          <View className="h-item">item8</View>
          <View className="h-item">item9</View>
          <View className="h-item">item10</View>
        </ScrollView>

        {/* 轮播图组件 */}
        <Swiper className="banner" indicatorDots indicatorActiveColor="#ff464e">
          <SwiperItem>
            <Image className="banner-img" src={BannerImg01}></Image>
          </SwiperItem>
          <SwiperItem>
            <Image className="banner-img" src={BannerImg02}></Image>
          </SwiperItem>
          <SwiperItem>
            <Image className="banner-img" src={BannerImg03}></Image>
          </SwiperItem>
        </Swiper>
      </View>
    );
  }
}
```



## 设计稿及尺寸单位(px)

- `Taro 默认以 750px 作为换算尺寸标准`，如设计稿不是 750px 为标准需修改`designWidth`
  - 比如:设计稿是 640px，则需修改 `config/index.js` 中 `designWidth` 为 640
- 在Taro中单位`建议使用 px、 百分比 %`，Taro 默认会对所有单位进行转换。
  - 在 Taro中写尺寸按照 `1:1` 关系来写，即设计稿量长度 100px，那么尺寸就写 100px，
    - 当转成微信小程序时尺寸为 100rpx，当转成 H5 时尺寸以 rem 为单位。
  - 如你希望部分 px 单位不被转换成 rpx 或 rem ，最简单做法就是在 px 单位中增加一个`大写字母`。

> ### JS 中`行内样式`的转换

- 在编译时，Taro 会帮你对样式做尺寸转换操作
- 但是如果是在 JS 中书写了行内样式，那么编译时就无法做替换了
- 针对这种情况，Taro 提供了 API `Taro.pxTransform` 来做运行时的尺寸转换。

> ### CSS 编译时忽略 

- 忽略单个属性
  - 当前忽略单个属性的最简单的方法，就是 `px 单位使用大写字母。` 
- 忽略样式文件
  - 对于`头部包含注释 /postcss-pxtransform disable/ 的文件`，插件不予转换处理。

- 更多配置:
  - https://taro-docs.jd.com/docs/size#css-%E7%BC%96%E8%AF%91%E6%97%B6%E5%BF%BD%E7%95%A5%E8%BF%87%E6%BB%A4

```css
//no-transform-unit.css

/*postcss-pxtransform disable*/
.no-transform-unit {
  // 下面就算是小写的单位，都不会进行转换
  border: 6px solid red;
  padding: 10px;
}
```

```tsx
import { Component } from "react";
import { View, Text } from "@tarojs/components";
import Taro from "@tarojs/taro";
// 全局样式
import "./index.scss";
import "./no-transform-unit.scss";
// 局部样式
import styles from "./index.module.scss";

// console.log(styles);
export default class StyleTaro extends Component {
  render() {
    const lineStyle = {
      // fontSize: 30, // 30px是不会被转换
      fontSize: Taro.pxTransform(30), // 30px是会被转换, 15px -> 30rpx
      color: "green",
    };
    return (
      <View>
        <View className="style-taro">单位px转换为rpx和rem</View>
        <View className="no-transform-unit">不转换单位</View>
        <View style={lineStyle}>行内样式，px的转换</View>
        <View style={{ fontSize: Taro.pxTransform(30) }}>
          行内样式，px的转换
        </View>
        <View className={styles["local-style"]}>
          编写局部样式
          <View className={styles["name"]}>name</View>
        </View>
        <View className="title">局部样式中编写的全局样式</View>
        <View className={styles["bg-img"]}></View>
        <Text className="text iconfont icon-shouye"></Text>
        <Text className="text iconfont icon-touxiang-kong"></Text>
      </View>
    );
  }
}

```





## 全局和局部样式

- `全局样式`
  - Taro页面和普通组件导入的样式默认都是`全局样式` 
  - 那在Taro中应该如何编写局部的样式呢?使用`CSS Modules`功能

- `局部样式`
  - 在`config/index.js`配置文件中启用 `CSS Modules` 的功能 
  - 编写的样式文件需要加上 `.module` 关键字。
    - 比如: index.module.scss 文件
  - 然后在组件中导入该样式文件，即可以按照模块的方式使用了。
- CSS Modules 中也支持编写全局样式

![image-20230910220336254](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230910220336254.png)

![image-20230910220847934](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230910220847934.png)

```scss
.local-style {
  color: purple;
  border: 4px solid purple;
  .name {
    color: red;
  }
  &:hover {
    color: blue;
  }
}

.bg-img {
  height: 400px;
  border: 1px solid red;
  // 相对路径(h5  weapp)  17k
  background-image: url(../../assets/images/empty_cart.png);
  // 绝对路径（h5）
  // background-image: url(~@/assets/images/empty_cart.png);

  background-repeat: no-repeat;
  background-size: contain;
}

// 全局样式
:global(.title) {
  color: orange;
}

```



## 背景图片

- Taro 支持使用`在 css 里设置背景图片`，使用方式与普通 web 项目大体相同，但需要注意以下几点: 
  - 支持 base64 格式图片，支持网络路径图片。
- 使用`本地`背景图片需注意:
  - `小程序不支持在 css 中使用本地文件`，包括本地的背景图和字体文件。需以 `base64` 方式方可使用。
  - 为了方便开发，Taro 提供了直接在样式文件中引用本地资源的方式，其`原理是通过 PostCSS 的 postcss-url 插件将样式中本 地资源引用转换成 Base64 格式`，从而能正常加载。
  - 不建议使用`太大的背景图`，大图需挪到服务器上，从网络地址引用。 
  - 本地背景图片的引用支持:`相对路径`和`绝对路径`。
- Taro 默认会对 `1kb` 大小以下的资源进行转换，如果需要修改配置，可以在 `config/index.js` 中进行修改，配置位于 [`weapp.module.postcss`](https://taro-docs.jd.com/docs/config-detail#weappmodulepostcss)。

![image-20230910222034731](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230910222034731.png)

## 字体图标

- Taro 支持使用字体图标，使用方式与普通 web 项目相同: 
  - 第一步:先生成字体图标文件
  - 第二步:app.scss 引入字体图标
  - 第三步:组件中使用自定义字体

![image-20230910222236334](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230910222236334.png)

![image-20230910222306942](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230910222306942.png)



# Taro--配置(三)

## 页面路由

- Taro 有两种页面路由跳转方式:使用`Navigator组件`跳转、调用`API`跳转。
  - 组件:`Navigator`
  - 常用API:`navigate` 、`redirectTo`、`switchTab`、`navigateBack`
  - 更多配置：https://taro-docs.jd.com/docs/apis/route/navigateTo

![image-20230911145930095](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230911145930095.png)

```tsx
import { View, Text, Navigator, Button } from "@tarojs/components";
import Taro, { useLoad } from "@tarojs/taro";
import "./index.less";

export default function Index() {
  useLoad(() => {
    console.log("Page loaded.");
  });

  const handleHome = () => {
    Taro.navigateTo({
      url: "/pages/home/index",
    });
  };

  return (
    <View className="'index'">
      <Text>Hello world!</Text>
      {/* api */}
      <Button onClick={handleHome}>home</Button>

      {/* 组件 */}
      <Navigator url="/pages/home/index">home</Navigator>
    </View>
  );
}

```

## 页面通讯

- 在Taro中，常见页面通讯方式:
  - 方式一: `url查询字符串` 和 `只支持小程序端的EventChannel` 
  - 方式二:`全局事件总线`: Taro.eventCenter
  - 方式三:`全局数据`:taroGloabalData 
  - 方式四:`本地数据存储`: Taro.setStorageSync(key, data) 等
  - 方式五:`Redux状态管理库`

> 方式一:`url查询字符串`

- 传递参数:?name=liujun&id=100 
- 获取参数:
  - onLoad 、 useLoad 生命周期获取路由参数
  - `Taro.getCurrentInstance().router.params` 获取路由参数。
  - `useRouter`等同于 Class Component 的 getCurrentInstance().router

![image-20230911151022823](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230911151022823.png)



![image-20230911151142254](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230911151142254.png)

![image-20230911210049044](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230911210049044.png)



> ### 页面传递参数（正向）

```ts
import { View, Text, Navigator, Button } from "@tarojs/components";
import Taro, { useLoad } from "@tarojs/taro";
import "./index.less";

export default function Index() {
  useLoad(() => {
    console.log("Page loaded.");
  });

  const handleAbout2 = () => {
    Taro.navigateTo({
      url: "/pages/about/index?id='2'",
      success(res) {
        if (process.env.TARO_ENV === "weapp") {
          // 注意：这中方式只支持微信小程序端
          // 通过eventChannel向被打开页面传送数据
          res.eventChannel.emit("acceptDataFromHomePage", {
            data: "我是从home页面传递到detail01的数据",
          });
        }
      },
    });
  };



  return (
    <View className="'index'">

      <View>3.页面传递参数（正向）</View>
      <Button onClick={handleAbout3}>about</Button>
    </View>
  );
}

```

```tsx
import { View, Text } from "@tarojs/components";
import Taro, { useDidShow, useLoad, getCurrentInstance } from "@tarojs/taro";

import "./index.less";

export default function About() {
  const currentInstance = getCurrentInstance();
  // console.log(currentInstance.router?.params);

  const router = Taro.useRouter();

  // 页面生命周期
  useLoad((options) => {
    // 方式一：拿到页面传递过来的url参数
    console.log("Page loaded.", options);

    // 下面的代码只兼容微信小程序
    if (process.env.TARO_ENV === "weapp") {
      const eventChannel = currentInstance.page?.getOpenerEventChannel();
      eventChannel.on("acceptDataFromHomePage", function (data) {
        console.log(data);
      });
    }
  });

  useDidShow(() => {
    // 方式二: 拿到页面传递过来的url参数
    console.log(router.params);
  });

  return (
    <View className="about">
      <Text>Hello world!</Text>
    </View>
  );
}

```

> ### 页面传递参数（逆向）

```tsx
import { View, Text, Navigator, Button } from "@tarojs/components";
import Taro, { useLoad } from "@tarojs/taro";
import "./index.less";

export default function Index() {

  const handleMusic = () => {
    Taro.navigateTo({
      url: "/pages/music/index?id='1'",
      events: {
        // 为指定事件添加一个监听器，获取被打开页面传送到当前页面的数据
        acceptDataFromOpenedPage: function (data) {
          console.log("about-event", data);
        },
      },
    });
  };

  return (
    <View className="'index'">
      <View>4.页面传递参数（逆向）</View>
      <Button onClick={handleMusic}>music 逆向</Button>
    </View>
  );
}

```

```tsx
import { View, Text, Button } from "@tarojs/components";
import Taro, { useLoad, useRouter } from "@tarojs/taro";
import { getCurrentInstance } from "@tarojs/runtime";
import "./index.less";

export default function Music() {
  const instance = getCurrentInstance();

  const router = useRouter();
  const { id } = router.params;

  useLoad(() => {
    console.log("Page loaded.");
  });

  const handleBack = () => {
    Taro.navigateBack({
      delta: 1,
    });

    if (process.env.TARO_ENV === "weapp") {
      console.log("微信");

      const eventChannel = instance.page?.getOpenerEventChannel();
      eventChannel.emit("acceptDataFromOpenedPage", {
        data: "拿到music转过来的数据",
      });
    }
  };

  return (
    <View className="music">
      <Text>Hello world!</Text>
      <View>id:{id}</View>
      <Button type="primary" onClick={handleBack}>
        back
      </Button>
    </View>
  );
}

```



## 全局事件总线

- 为了支持`跨组件、跨页面`之间的通信，Taro 提供了全局事件总线:`Taro.eventCenter` 
  - `Taro.eventCenter.on( eventName, function )` 监听一个事件
  - `Taro.eventCenter.trigger( eventName, data)` 触发一个事件
  - `Taro.eventCenter.off( eventName, function )` 取消监听事件
- 注意事项:
  - `需先监听，再触发事件`，比如:你在A界面触发，然后跳转到B页面后才监听是不行的。
  - 通常on 和 off 是同时使用，可以避免多次重复监听
  - `适合页面返回传递参数、适合跨组件通讯，不适合界面跳转传递参数`

```jsx
import { Component } from "react";
import { View, Navigator, Button } from "@tarojs/components";
import Taro from "@tarojs/taro";
import "./index.scss";

export default class Home extends Component {

  onLoad() {
    // 监听
    Taro.eventCenter.on(
      "acceptDataFormDatail03Page",
      this.acceptDataFormDatail03Page
    );
  }
  acceptDataFormDatail03Page(data) {
    console.log(data);
  }
  onUnload() {
    // 取消监听
    Taro.eventCenter.off(
      "acceptDataFormDatail03Page",
      this.acceptDataFormDatail03Page
    );
  }
  
  goToDetail03() {
    Taro.switchTab({
      url: "/pages/category/index",
    });
  }
  

  render() {
    return (
      <View className="home">
      
	   		<Button onClick={() => this.goToDetail03()}>
          goToDetail01 switchTab
        </Button>
      </View>
    );
  }
}

```



```jsx
import { Component } from "react";
import { View, Button } from "@tarojs/components";
import Taro from "@tarojs/taro";
import "./index.scss";

export default class Detail03 extends Component {
  componentDidMount() {}

  componentWillUnmount() {}

  componentDidShow() {}

  componentDidHide() {}
  goBack() {
    Taro.navigateBack({
      delta: 1,
    });

    // 触发一个全局事件
    Taro.eventCenter.trigger("acceptDataFormDatail03Page", {
      data: "将detail03的数据传递到home页面",
    });
  }
  render() {
    return (
      <View className="detail03">
        <Button onClick={() => this.goBack()}>返回</Button>
      </View>
    );
  }
}

```



## 页面生命周期

- Taro 页面组件除了支持 `React` 组件生命周期 方法外，还根据`小程序`的标准，额外支持以下页面生命周期: 
  - `onLoad (options)` 在小程序环境中对应页面的 onLoad。
    - 通过访问 options 参数或调用 getCurrentInstance().router，可以访问到页面路由参数 
  - `componentDidShow()` 在小程序环境中对应页面的 onShow。
  - `onReady ()` 在小程序环境中对应页面的 onReady。
    - 可以使用 createCanvasContext 或 createSelectorQuery 等 API 访问小程序渲染层 DOM 节点 
  - `componentDidHide ()` 在小程序环境中对应页面的 onHide。
  - `onUnload ()` 在小程序环境中对应页面的 onUnload。
    - 一般情况下建议使用 React 的 componentWillUnmount 生命周期处理页面卸载时的逻辑。 
  - `onPullDownRefresh()` 监听用户下拉动作。
  - `onReachBottom()` 监听用户上拉触底事件。
  - 更多生命周期函数: https://docs.taro.zone/docs/react-page

```jsx
import { Component } from "react";
import { View } from "@tarojs/components";
import Taro from "@tarojs/taro";
import "./index.scss";

export default class Detail04 extends Component {
  // 1.组件的生命周期（会调用）
  // UNSAFE_componentWillMount() {
  //   console.log("detail04 UNSAFE_componentWillMount");
  // }

  // componentDidMount() {
  //   console.log("detail04 componentDidMount");
  // }

  // componentWillUnmount() {
  //   console.log("detail04 componentWillUnmount");
  // }

  // 2.页面的生命周期
  onLoad() {
    console.log("detail04 onLoad");
  }
  componentDidShow() {
    console.log("detail04 componentDidShow");
  }
  onReady() {
    console.log("detail04 onReady");
  }
  componentDidHide() {
    console.log("detail04 componentDidHide");
  }
  onUnload() {
    console.log("detail04 onUnload");
  }
  onPullDownRefresh() {
    console.log("detail04 onPullDownRefresh");
    setTimeout(() => {
      Taro.stopPullDownRefresh();
    }, 1000);
  }
  onReachBottom() {
    console.log("detail04 onReachBottom");
  }

  render() {
    return (
      <View className="detail04">
       123
      </View>
    );
  }
}

```







## Hooks 生命周期

- Taro使用Hooks很简单。Taro专有Hooks，例如 `usePageScroll`, `useReachBottom`，需从 `@tarojs/taro` 中引入 
- React框架自己的 Hooks ，例如 `useEffect`, `useState`，从对应的框架引入。
- 更多的Hooks可查看官网: https://docs.taro.zone/docs/hooks

```tsx
import { useEffect, useRef } from "react";
import { View } from "@tarojs/components";
import Taro, {
  useLoad,
  useDidShow,
  useReady,
  useDidHide,
  useUnload,
  usePullDownRefresh,
  useReachBottom,
} from "@tarojs/taro";
import "./index.scss";

const Detail05 = function () {
  // 为什么使用useRef？因为useRef存的对象在整个组件的生命周期中都是保持同一个对象
  const $instance = useRef(Taro.getCurrentInstance());
  console.log("router.params=>", $instance.current.router.params);

  // 1.支持组件的生命周期
  useEffect(() => {
    // console.log("detail05 useEffect");
    return () => {
      // console.log("detail05 useEffect unMount");
    };
  }, []);

  // 2.页面的生命周期
  useLoad((options) => {
    console.log("detail05 useLoad", options);
  });
  useDidShow(() => {
    console.log("detail05 useDidShow");
  });
  useReady(() => {
    console.log("detail05 useReady");
  });
  useDidHide(() => {
    console.log("detail05 useDidHide");
  });
  useUnload(() => {
    console.log("detail05 useUnload");
  });
  usePullDownRefresh(() => {
    console.log("detail05 usePullDownRefresh");
    setTimeout(() => {
      Taro.stopPullDownRefresh();
    }, 1000);
  });

  useReachBottom(() => {
    console.log("detail05 useReachBottom");
  });

  return (
    
  );
};

export default Detail05;

```





## 组件及生命周期

- 在 Taro中，除了应用和页面组件有生命周期之外， Taro 的`组件也是生命周期`，如下图所示:
- 下面我们来编写一个HYButton组件。
  - 创建组件
  - 定义属性
  - 样式编写
  - 定义插槽
  - 定义生命周期
  - 组件可编写页面生命周期吗?
    - class组件默认不行，需要单独处理
    - 但是函数组件是支持的
  - 页面可以编写组件生命周期吗?可以

```tsx
import { View } from "@tarojs/components";
import { memo, useEffect } from "react";
import classNames from "classnames";
import PropTypes from "proptypes";
import { useLoad, useDidShow, useReady } from "@tarojs/taro";

import styles from "./index.modules.scss";

const HYButton = memo(function (props) {
  const { type = "default", onBtnClick } = props;
  const cname = classNames(styles["hy-button"], styles[type]);

  function handleBtnClick() {
    onBtnClick && onBtnClick();
  }

  // 1.组件的生命周期
  useEffect(() => {
    console.log("在组件过载完成的时候会回调");
    return () => {
      console.log("在组件卸载的时候会回调");
    };
  }, []); // 类似vue watch

  // 2.页面的生命周期函数( ok )
  useLoad(() => {
    console.log("useLoad");
  });

  useDidShow(() => {
    console.log("useDidShow");
  });

  useReady(() => {
    console.log("useReady");
  });

  return (
    <View className={cname} onClick={handleBtnClick}>
      {props.children}
    </View>
  );
});

export default HYButton;
HYButton.propTypes = {
  type: PropTypes.string, // arrray func  object bool string number
  onBtnClick: PropTypes.func,
};

```



# 跨端兼容方案

- Taro 的设计初衷就是为了`统一跨平台`的开发方式，并且已经尽力通过运行时框架、组件、API 去抹平多端差异，但是由于不同的 平台之间还是存在一些无法消除的差异，所以为了更好的实现跨平台开发，Taro 中提供了如下的解决方案。

> 方案一:`内置环境变量`

- Taro 在编译时提供了一些`内置的环境变量`来帮助用户做一些特殊处理。
- 通过这个变量来`区分不同环境`，从而使用不同的逻辑。在编译阶段，会移除不属于当前端的代码，只保留当前端的代码。
- 内置环境变量虽然可以解决大部分跨端的问题，但是会让代码中存在`很多逻辑判断的代码`，影了响代码的可维护性，而且也 让代码变得丑陋。
- 为了解决这种问题，Taro 提供了另外一种跨端开发的方式作为补充。 

> 方案二:`统一接口的多端文件`

- 开发者可以通过将文件修改成 `原文件名 + 端类型` 的命名形式(端类型对应着 process.env.TARO_ENV 的取值)，不同端的 文件代码对外保持统一接口，而引用的时候仍然是 import 原文件名的文件。
- Taro 在编译时，会跟根据当前编译平台类型，精准加载对应端类型的文件，从而达到不同的端加载其对应端的文件。



## 内置环境变量

- 内置环境变量( `process.env.TARO_ENV`)，该环境变量可直接使用 
  - `process.env.TARO_ENV`，用于判断当前的编译平台类型，有效值为:weapp / swan / alipay / tt / qq / jd / h5 / rn。 
  - 通过这个变量来区分不同环境，从而使用不同的逻辑。
  - 在编译阶段，会移除不属于当前平台的代码，只保留当前平台的代码，例如:

```jsx
import { Component } from "react";
import { View } from "@tarojs/components";
import HYButton from "@/components/hy-button";
import HYMultiButton from "@/components/hy-multi-button";
import setTitle from "@/utils/set-title";
import "./index.scss";

export default class CrossFlatform extends Component {
  componentDidShow() {}

  componentDidHide() {}

  handleBtnClick() {
    // const { TARO_ENV  } = process.env 不能解构
    if (process.env.TARO_ENV === "h5") {
      console.log("这里可使用浏览器的api document");
    }

    if (process.env.TARO_ENV === "weapp") {
      console.log("这里可使用微信小程序的api wx.login ...");
    }
  }

  hadnleSetTitle() {
    setTitle();
  }

  render() {
    return (
      <View className="cross-flatform">
        <HYButton onBtnClick={() => this.handleBtnClick()}>Button-H5</HYButton>
        {/*决定不同端要加载的组件*/}
        {process.env.TARO_ENV === "h5" && (
          <>
            <View>1.我是H5端专有的组件</View>
            <HYButton type="blue">Button-H5</HYButton>
          </>
        )}
        {process.env.TARO_ENV === "weapp" && (
          <>
            <View>2.我是weapp端专有的组件</View>
            <HYButton type="primary">Button-weapp</HYButton>
          </>
        )}

      </View>
    );
  }
}

```



- 注意事项:`不要解构 process.env 来获取环境变量`，请直接以完整书写的方式(process.env.TARO_ENV)来进行使用。

```ts
// 正确写法
if (process.env.TARO_ENV === 'weapp') {
}

// 错误写法
const { TARO_ENV = 'weapp' } = process.env
if (TARO_ENV === 'weapp') {
}
```



## 统一接口的多端文件

- 统一接口的多端文件这一跨平台兼容写法有如下三个使用要点:
  - 不同端的对应文件一定要`统一接口和调用方式。`
  - 引用文件的时候，`只需写默认文件名，不用带文件后缀`。
  - `最好有一个平台无关的默认文件`，这样在使用 TS 的时候也不会出现报错。
- 常见有以下使用场景:
  - `多端组件`(属性，方法，事件等需统一)
    - 针对不同的端写不同的组件代码
- ![image-20230916105450007](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230916105450007.png)
  - `多端脚本逻辑`(属性、方法等需统一)
    - 针对不同的端写不同的脚本逻辑代码

![image-20230916105506396](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230916105506396.png)

![image-20230916105148238](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230916105148238.png)

```jsx
import { Component } from "react";
import { View } from "@tarojs/components";
import HYMultiButton from "@/components/hy-multi-button";
import setTitle from "@/utils/set-title";
import "./index.scss";

export default class CrossFlatform extends Component {
  componentDidShow() {}

  componentDidHide() {}

  hadnleSetTitle() {
    setTitle();
  }

  render() {
    return (
      <View className="cross-flatform">

        <View>3.我是统一接口+多端的组件</View>
        <HYMultiButton>HYMultiButton</HYMultiButton>

        <View>4.我是统一接口+多端的脚本</View>
        <HYMultiButton type="blue" onBtnClick={() => this.hadnleSetTitle()}>
          多端的脚本
        </HYMultiButton>
      </View>
    );
  }
}

```



# 网络请求

- Taro.request(OBJECT) 发起网络请求。
  - 在各个小程序平台运行时，网络相关的 API 在使用前需要`配置合法域名`(域名白名单)。
  - 微信小程序开发工具在开发阶段可以配置:`不校验合法域名。`
  - `header`中的`content-type`属性的默认值为:application/json

```ts
//request封装
import Taro from "@tarojs/taro";

//Omit以一个类型为基础支持剔除某些属性，然后返回一个新类型。
interface IOptions extends Omit<Taro.request.Option, "url"> {
  url?: string;
}

class Request {
  baseUrl: string;
  timeout: number;

  constructor(baseUrl: string, timeout: number = 2000) {
    this.baseUrl = baseUrl;
    this.timeout = timeout;
  }

  request<T = any>(url: string, options?: IOptions) {
    return new Promise<T>((resolve, reject) => {
      Taro.request<T>({
        url: this.baseUrl + url,
        timeout: this.timeout,
        ...options,

        success(res) {
          resolve(res.data);
        },
        fail(err) {
          console.log(err);
          reject(err);
        },
      });
    });
  }

  post<T = any>(url: string, options?: IOptions) {
    return this.request<T>(url, { ...options, method: "POST" });
  }

  get<T = any>(url: string, options?: IOptions) {
    return this.request<T>(url, { ...options, method: "GET" });
  }
}

export default Request;

```

# 数据缓存 

- `Taro.setStorage(OBJECT)`
  - 将数据存储在本地缓存中指定的 key 中，会覆盖掉原来该 key 对应的内容，这是一个异步接口。
- `Taro.setStorageSync`(KEY, DATA)
  - 将 data 存储在本地缓存中指定的 key 中，会覆盖掉原来该 key 对应的内容，这是一个同步接口。 
- `Taro.getStorage(OBJECT)`
  - 从本地缓存中异步获取指定 key 对应的内容。
- `Taro.getStorageSync(KEY)`
  - 从本地缓存中同步获取指定 key 对应的内容。
- `Taro.removeStorage(OBJECT)`
  - 从本地缓存中异步移除指定 key。 
- `Taro.removeStorageSync(KEY)`
  - 从本地缓存中同步移除指定 key。



```jsx
import { Component } from "react";
import { View, Button } from "@tarojs/components";
import Taro from "@tarojs/taro";
import "./index.scss";

export default class Detail01 extends Component {
  UNSAFE_componentWillMount() {}

  componentDidMount() {}

  componentWillUnmount() {}

  componentDidShow() {}

  componentDidHide() {}
 
  setStorage() {
    Taro.setStorage({
      key: "info",
      data: {
        name: "liujun",
        id: 100,
      },
    });

    Taro.setStorageSync("token", "sdfdffthsdf");
  }
  
  getStorage() {
    Taro.getStorage({
      key: "info",
      success(res) {
        console.log(res.data);
      },
    });
    const token = Taro.getStorageSync("token");
    console.log(token);
  }
  render() {
    return (
      <View className="detail01">
        <View>2.本地数据的存储</View>
        <Button onClick={() => this.setStorage()}>setStorage</Button>
        <Button onClick={() => this.getStorage()}>getStorage</Button>
      </View>
    );
  }
}

```



# 项目打包和部署

- 多端同步调试
  - 可以在 `dist` 目录下创建一个与编译的目标平台名同名的目录，并将结果放在这个目录下。
  - 例如:编译到微信小程序，最终结果是在 dist/weapp 目录下; H5打包结果放在 dist/h5 目录下 
  - 好处是，各个平台使用独立的目录互不影响，从而达到多端同步调试的目的，在 config/index.js 配置如下:

![image-20230916110333528](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230916110333528.png)

- 浏览器端
  - 打包:`npm run build:h5`
- 微信小程序
  - 打包:`npm run build:weapp`
  - 微信开发者工具打开weapp目录进行预览或发包

![image-20230916110432481](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230916110432481.png)