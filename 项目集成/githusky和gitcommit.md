### git Husky 和 eslint

- 虽然我们已经要求项目使用`eslint`了，但是不能保证组员提交代码之前都将eslint中的问题解决掉了：

  * 也就是我们希望保证代码仓库中的代码都是符合eslint规范的；


  * 那么我们需要在组员执行 `git commit ` 命令的时候对其进行校验，如果不符合eslint规范，那么自动通过规范进行修复；


- 那么如何做到这一点呢？可以通过`Husky`工具：

  * husky是一个git hook工具，可以帮助我们触发git提交的各个阶段：pre-commit、commit-msg、pre-push


> 如何使用husky呢？
>

- 这里我们可以使用自动配置命令：


```shell
npx husky-init && npm install
```

- 这里会做三件事：


1.安装husky相关的依赖：

![image-20230830145448550](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230830145448550.png)

2.在项目目录下创建 `.husky` 文件夹(会自动生成)：

![image-20230830145528820](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230830145528820.png)

3.在`package.json`中添加一个脚本(会自动添加)：

![image-20230830150050438](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230830150050438.png)

接下来，我们需要去完成一个操作：在进行`commit`时，`执行lint脚本`：

![image-20230830150223216](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230830150223216.png)



这个时候我们执行git commit的时候会自动对代码进行lint校验。

### git commit规范

#### 代码提交风格

通常我们的`git commit`会按照统一的风格来提交，这样可以快速定位每次提交的内容，方便之后对版本进行控制。

![image-20230830150634134](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230830150634134.png)

但是如果每次手动来编写这些是比较麻烦的事情，我们可以使用一个工具：`Commitizen`

* `Commitizen` 是一个帮助我们编写规范 `commit message` 的工具；

1.安装`Commitizen`

```shell
npm install commitizen -D
```

2.安装`cz-conventional-changelog`，并且`初始化cz-conventional-changelog`：

```shell
npx commitizen init cz-conventional-changelog --save-dev --save-exact
```

这个命令会帮助我们安装`cz-conventional-changelog`：

![image-20230830151122684](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230830151122684.png)

并且在package.json中进行配置：

![image-20230830151023563](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230830151023563.png)

这个时候我们提交代码需要使用 `npx cz`：

* 第一步是选择type，本次更新的类型

| Type     | 作用                                                         |
| -------- | ------------------------------------------------------------ |
| feat     | 新增特性 (feature)                                           |
| fix      | 修复 Bug(bug fix)                                            |
| docs     | 修改文档 (documentation)                                     |
| style    | 代码格式修改(white-space, formatting, missing semi colons, etc) |
| refactor | 代码重构(refactor)                                           |
| perf     | 改善性能(A code change that improves performance)            |
| test     | 测试(when adding missing tests)                              |
| build    | 变更项目构建或外部依赖（例如 scopes: webpack、gulp、npm 等） |
| ci       | 更改持续集成软件的配置文件和 package 中的 scripts 命令，例如 scopes: Travis, Circle 等 |
| chore    | 变更构建流程或辅助工具(比如更改测试环境)                     |
| revert   | 代码回退                                                     |

* 第二步选择本次修改的范围（作用域）

![image-20230830151340887](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230830151340887.png)

* 第三步选择提交的信息

![image-20230830151439196](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230830151439196.png)

* 第四步提交详细的描述信息

![image-20230830151737715](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230830151737715.png)

* 第五步是否是一次重大的更改

![image-20230830151601371](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230830151601371.png)

* 第六步是否影响某个open issue

![image-20230830151714312](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230830151714312.png)



我们也可以在scripts中构建一个命令来执行 cz：



#### 代码提交验证

如果我们按照`cz`来规范了提交风格，但是依然有同事通过 `git commit` 按照不规范的格式提交应该怎么办呢？

* 我们可以通过`commitlint`来限制提交；

1.安装 @commitlint/config-conventional 和 @commitlint/cli

```shell
npm i @commitlint/config-conventional @commitlint/cli -D
```

2.在根目录创建`commitlint.config.js`文件，配置`commitlint`

```js
module.exports = {
  extends: ['@commitlint/config-conventional']
}
```

```js
 // 继承的规则
  extends: ['@commitlint/config-conventional'],
  // 定义规则类型
  rules: {
    // type 类型定义，表示 git 提交的 type 必须在以下类型范围内
    'type-enum': [
      2,
      'always',
      [
        'init',//初始化
        'feat', // 新功能 feature
        'fix', // 修复 bug
        'docs', // 文档注释
        'style', // 代码格式(不影响代码运行的变动)
        'refactor', // 重构(既不增加新功能，也不是修复bug)
        'perf', // 性能优化
        'test', // 增加测试
        'chore', // 构建过程或辅助工具的变动
        'revert', // 回退
        'build', // 打包
        'ci', // 与持续集成服务有关的改动
      ],
    ],
    // subject 大小写不做校验
    'subject-case': [0],
  },

```

3.使用`husky`生成`commit-msg文件`，`验证提交信息`：

```shell
npx husky add .husky/commit-msg "npx --no-install commitlint --edit $1"
```

