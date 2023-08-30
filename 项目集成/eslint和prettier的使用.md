# 项目搭建规范

## 一. 代码规范

### 1.1. 集成 editorconfig 配置

EditorConfig 有助于为不同 IDE 编辑器上处理同一项目的多个开发人员维护一致的编码风格。

配置 .editorconfig 文件：

```yaml
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

VSCode 需要安装一个插件：EditorConfig for VS Code

![image-20230825150104817](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230825150104817.png)

### 1.2. 使用 prettier 工具

Prettier 是一款强大的代码格式化工具，支持 JavaScript、TypeScript、CSS、SCSS、Less、JSX、Angular、Vue、GraphQL、JSON、Markdown 等语言，基本上前端能用到的文件格式它都可以搞定，是当下最流行的代码格式化工具。

#### 1.安装 prettier

```npm
npm install prettier -D
```

#### 2.配置.prettierrc 文件：

- useTabs：使用 tab 缩进还是空格缩进，选择 false；
- tabWidth：tab 是空格的情况下，是几个空格，选择 2 个；
- printWidth：当行字符的长度，推荐 80，也有人喜欢 100 或者 120；
- singleQuote：使用单引号还是双引号，选择 true，使用单引号；
- trailingComma：在多行输入的尾逗号是否添加，设置为 `none`；
- semi：语句末尾是否要加分号，默认值 true，选择 false 表示不加；

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

#### 3.创建.prettierignore 忽略文件

```
/dist/*
.local
.output.js
/node_modules/**

**/*.svg
**/*.sh

/public/*
```

#### 4.VSCode 需要安装 prettier 的插件

![image-20230825150151099](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230825150151099.png)

#### 5.测试 prettier 是否生效

- 测试一：在代码中保存代码；
- 测试二：配置一次性修改的命令；

在 package.json 中配置一个 scripts：

```shell
  "prettier": "prettier --write ."
```

### 1.3. 使用 ESLint 检测

1.在前面创建项目的时候，我们就选择了 ESLint，所以 Vue 会默认帮助我们配置需要的 ESLint 环境。

#### 1.安装 eslint：

```shell
npm install eslint -D
```

#### 2.初始化 eslint

```shell
npm init @eslint/config
```

```shell
npx eslint --init
```

#### 3.VSCode 需要安装 ESLint 插件：

#### ![image-20230825150217942](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230825150217942.png)4.解决 eslint 和 prettier 冲突的问题：

安装插件：（vue 在创建项目时，如果选择 prettier，那么这两个插件会自动安装）

- `eslint-config-prettier`: 关闭所有不必要的或可能与 Prettier 冲突的规则, 是一个规则集
- `eslint-plugin-prettier`: 仅仅使用`eslint-config-prettier`, 还需要增加一些配置才能让 eslint 运行`eslint-config-prettier`中的规则并报错, 使用`eslint-plugin-prettier`相当于省略了那些配置

注意`eslint-plugin-prettier`依赖`prettier`

```shell
npm i eslint-plugin-prettier eslint-config-prettier -D
```

#### 5.添加 prettier 插件：

```json
  "extends": [
        "eslint:recommended",
        "plugin:@typescript-eslint/recommended"
    ],
```

```json
//添加插件
"plugin:prettier/recommended"
```

#### 6.VSCode 中 eslint 的配置(可以忽略)

```json
  "eslint.lintTask.enable": true,
  "eslint.alwaysShowStatus": true,
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact"
  ],
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
```
