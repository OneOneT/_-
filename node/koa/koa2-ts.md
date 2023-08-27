# 一. 项目依赖

## 1. typeScript

```
npm install typescript
```

tsconfig.json的配置

```
{
  "compilerOptions": {
    "target": "ESNext",
    "module": "ESNext",
    "moduleResolution": "NodeNext",
    "useDefineForClassFields": true,
    "strict": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "resolveJsonModule": true,
    "baseUrl": "./",
    "paths": {
      "@/*": ["src/*"]
    }
  },
  "include": ["src/**/*.ts", "src/**/*.d.ts"],
  "exclude": ["node_modules"]
}

```



## 2. esbuild 和 esbuild-register(esmodule风格)

​	https://juejin.cn/s/nodemon%20esbuild-register

```
npm i esbuild esbuild-register -D
```



## 3. nodemon

```
npm install --save-dev nodemo
```

配置 nodemon

```
"start": "nodemon --watch src -e ts --exec \"node -r esbuild-register\" src/main.ts"
```



## 4. koa

```
npm install koa
npm install @types/koa -D 
```



## 5. koa-bodyparser和koa-body

https://juejin.cn/s/koa-bodyparser%E5%92%8Ckoa-body



## 6. koa-router

```
npm install @koa/router
```



## 7. koa-bodyparser

```
npm i koa-bodyparser
```



## 8. koa-multer

```
npm install --save @koa/multer multer
```



## 9. mysql2

```
npm install --save mysql2
```



## 10. jsonwebtoken

```
npm install jsonwebtoken
```



## 11. dotenv

```js
npm install dotenv --save

const env = require("dotenv");
env.config();
module.exports = { SERVER_HOST } = process.env;
```



## 12.  对数据MD5加密(node自带模块)

```js
const crypto = require('crypto')


function md5password(password) {
  const md5 = crypto.createHash('md5')
  const md5pwd = md5.update(password).digest('hex')//hex转化为十六进制

  return md5pwd
}
```





# 二. 代码规范

### 1.1. 集成editorconfig配置

EditorConfig 有助于为不同 IDE 编辑器上处理同一项目的多个开发人员维护一致的编码风格。

 配置 .editorconfig文件：

```
# http://editorconfig.org

root = true

[*] # 表示所有文件适用
charset = utf-8 # 设置文件字符集为 utf-8
indent_style = space # 缩进风格（tab | space）
indent_size = 2 # 缩进大小
end_of_line = lf # 控制换行类型(lf | cr | crlf)
trim_trailing_whitespace = true # 去除行首的任意空白字符
insert_final_newline = true # 始终在文件末尾插入一个新行

[*.md] # 表示仅 md 文件适用以下规则
max_line_length = off
trim_trailing_whitespace = false
```

VSCode需要安装一个插件：EditorConfig for VS Code

![image-20230825150104817](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230825150104817.png)

### 1.2. 使用prettier工具

Prettier 是一款强大的代码格式化工具，支持 JavaScript、TypeScript、CSS、SCSS、Less、JSX、Angular、Vue、GraphQL、JSON、Markdown 等语言，基本上前端能用到的文件格式它都可以搞定，是当下最流行的代码格式化工具。

#### 1.安装prettier

```npm
npm install prettier -D
```

#### 2.配置 .prettierrc 文件：

- useTabs：使用tab缩进还是空格缩进，选择false；
- tabWidth：tab是空格的情况下，是几个空格，选择2个；
- printWidth：当行字符的长度，推荐80，也有人喜欢100或者120；
- singleQuote：使用单引号还是双引号，选择true，使用单引号；
- trailingComma：在多行输入的尾逗号是否添加，设置为 `none`；
- semi：语句末尾是否要加分号，默认值true，选择false表示不加；

```
{
  "useTabs": false,
  "tabWidth": 2,
  "printWidth": 80,
  "singleQuote": true,
  "trailingComma": "none",
  "semi": false
}
```

#### 3.创建 .prettierignore 忽略文件

```
/dist/*
.local
.output.js
/node_modules/**

**/*.svg
**/*.sh

/public/*
```

#### 4.VSCode需要安装prettier的插件

![image-20230825150151099](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230825150151099.png)

#### 5.测试prettier是否生效

- 测试一：在代码中保存代码；
- 测试二：配置一次性修改的命令；

在package.json中配置一个scripts：

```
  "prettier": "prettier --write ."
```

### 1.3. 使用ESLint检测

1.在前面创建项目的时候，我们就选择了ESLint，所以Vue会默认帮助我们配置需要的ESLint环境。

####  1.安装eslint：

```
npm install eslint -D
```

####  2.初始化eslint

```
npm init @eslint/config
```

#### 3.VSCode需要安装ESLint插件：

![image-20230825150217942](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230825150217942.png)

#### 4.解决eslint和prettier冲突的问题：

安装插件：（vue在创建项目时，如果选择prettier，那么这两个插件会自动安装）

- `eslint-config-prettier`: 关闭所有不必要的或可能与Prettier冲突的规则, 是一个规则集
- `eslint-plugin-prettier`: 仅仅使用`eslint-config-prettier`, 还需要增加一些配置才能让eslint运行`eslint-config-prettier`中的规则并报错, 使用`eslint-plugin-prettier`相当于省略了那些配置

注意`eslint-plugin-prettier`依赖`prettier`

```
npm i eslint-plugin-prettier eslint-config-prettier -D
```

#### 5.添加prettier插件：

```
  "extends": [
        "eslint:recommended",
        "plugin:@typescript-eslint/recommended"
    ],
```

```
//添加插件
'plugin:prettier/recommended'
```

# 三. 项目目录

```
├─ .env 										//环境变量
├─ package.json

├─ src
│    ├─ app
│    │    ├─ database.js 							//数据库配置文件
│    │    └─ index.js								//koa配置文件
│    ├─ config
│    │    ├─ error.js								//错误信息变量
│    │    ├─ keys									//密钥和私钥
│    │    ├─ path.js
│    │    ├─ screct.js
│    │    └─ server.js
│    ├─ controller									//控制器(放回给客户端逻辑)
│    │    ├─ comment.controller.js
│    │    ├─ file.controller.js
│    │    ├─ label.controller.js
│    │    ├─ login.controller.js
│    │    ├─ moment.controller.js
│    │    └─ user.controller.js
│    ├─ main.js										//入口文件
│    ├─ middleware									//中间件(中间件逻辑处理,如验证账号逻辑)
│    │    ├─ file.middleware.js
│    │    ├─ label.middleware.js
│    │    ├─ login.middleware.js
│    │    ├─ permission.middleware.js
│    │    └─ user.middleware.js
│    ├─ router										//路由文件(配置路由)
│    │    ├─ comment.router.js
│    │    ├─ file.router.js
│    │    ├─ index.js
│    │    ├─ label.router.js
│    │    ├─ login.router.js
│    │    ├─ moment.router.js
│    │    └─ user.router.js
│    ├─ service										//数据库文件(处理数据库)
│    │    ├─ comment.service.js
│    │    ├─ file.service.js
│    │    ├─ label.service.js
│    │    ├─ moment.service.js
│    │    ├─ permission.service.js
│    │    └─ user.service.js
│    └─ utils
│           ├─ handle-error.js							//错误信息处理
│           └─ md5-password.js							//密码加密处理
└─ uploads                   							//文件上传目录
       ├─ 03faa4e939cae28885b1b12adfe8a85f
       ├─ 3de1f736febeb5945039a2e4c71a79c3
       ├─ 44373957d6b16b379bfd09b0baaeba89
       ├─ a96f2e5207609d2ba8b314c913366640
       ├─ ae0a8c7318c6a03d711ecbed88d02bb5
       ├─ cf383bf3b4a113a1e5bbe3c6a85b8ed6
       └─ f26f8df208637fe881ce0111a5c8472d
```

# 四. 路由自动化

```js
const fs = require('fs')

function registerRouters(app) {
  // 1.读取当前文件夹下的所有文件
  const files = fs.readdirSync(__dirname)

  // 2.遍历所有的文件
  for (const file of files) {
    if (!file.endsWith('.router.js')) continue
    const router = require(`./${file}`)
    app.use(router.routes())
    app.use(router.allowedMethods())
  }
}

module.exports = registerRouters

//--------------------------------------------------------------
const fs = require("fs");
const path = require("path");

//实现路由自动化
function registerRouter(app) {
  const routerFiles = fs.readdirSync(path.resolve(__dirname, "../router"));
  // console.log(routerFiles);

  routerFiles.forEach((item) => {
    // console.log(item);

    // endsWith()以什么为结尾
    if (item.endsWith(".router.js")) {
      // console.log(item);
      const Router = require(`./${item}`);
      app.use(Router.routes());
      app.use(Router.allowedMethods());
    }
  });
}

```

# 五. 数据库配置信息

```js
const mysql = require("mysql2");

// 1.创建连接池
const connectionPool = mysql.createPool({
  host: "localhost",
  port: "3306",
  database: "coderhub",
  user: "root",
  password: "88888888",
});

// 2.获取连接是否成功
connectionPool.getConnection((err, connection) => {
  // 1.判断是否有错误信息
  if (err) {
    console.log("连接数据库失败!!!", err);
    return;
  }
  // 2.获取connection, 尝试和数据库建立一下连接
  connection.connect((err) => {
    if (err) {
      console.log("连接数据库超时", err);
    } else {
      console.log("数据库连接成功, 可以操作数据库~");
    }
  });
});

// 3.获取连接池中连接对象(promise)
const connection = connectionPool.promise();

module.exports = connection;

```











