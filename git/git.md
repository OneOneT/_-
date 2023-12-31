# git 开发流程

![image-20230826161838043](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826161838043.png)

## 创建本地仓库和远程仓库链接

> 方案一：

- 但我们`指定上游分支时`：origin/main，执行`git merge`,master 分枝会直接上游分支 origin/main 进行合并。
- 但是，但我们初始化项目时，本地仓库 和 上游分支都`没有共同的祖先`，就会报 [拒绝合并不相干的历史](#拒绝合并不相干的历史)
- 执行 git push 时，但我们本地分支名字（master）和 远程仓库（origin/main）名字不匹配时，需要我们修改`git config push.default upstream` (默认为`simple`，本地分支和远程分支不匹配时报错) -- `upstream`：将本地 master 分支 push 到远程 main 分支

> 方案二：

- 造成方案一的原因是，但我们执行`git push`时，本地分支 master 和 远程分支 main `名字不匹配`
- 执行 `git checkout --track origin/main` 跟踪 origin/main 分支，并且创建 main 分支

# 版本控制

## 集中式版本控制

- CVS 和 SVN 都是是属于集中式版本控制系统(Centralized Version Control Systems，简称 CVCS)
  - 它们的主要`特点`是单一的集中`管理的服务器，保存所有文件的修订版本`;
  - 协同开发人员通过`客户端连接到这台服务器，取出最新的文件或者提交更新;`
- 这种做法带来了许多好处，特别是相较于老式的本地 管理来说，每个人都可以在一定程度上看到项目中的 其他人正在做些什么。
- 但是集中式版本控制也有一个核心的问题:**`中央服务 器不能出现故障`:**
  - 如果宕机一小时，那么在这一小时内，谁都无法提 交更新，也就无法协同工作;
  - 如果中心数据库所在的磁盘发生损坏，又没有做恰 当备份，毫无疑问你将丢失所有数据;

![image-20230824013923306](https://raw.githubusercontent.com/OneOneT/images/main/image-20230824013923306.png)

## **分布式版本控制**

- `Git`是属于分布式版本控制系统(Distributed Version Control System，简称 DVCS)
- 客户端并不只提取最新版本的文件快照， 而是把`代码仓库完整地镜像下来，包括完整的历史记录`;
- 这么一来，任何一处协同工作用的`服务器发生故障`，事后都`可以用任何一个镜像出来的本地仓库恢复`;
- 因为`每一次的克隆操作`，实际上都`是一次对代码仓库的完整备份;`
- 目前在公司开发中我们都是使用**Git 来管理项目的，所以接下来我们会重点 学习 Git 的各种用法;**

![分布式版本控制](https://raw.githubusercontent.com/OneOneT/images/main/image-20230824014458478.png)

# Git**的配置分类**

- 既然已经在系统上安装了 Git**，你会需要做几件事来定制你的** Git 环境:
  - 每台`计算机上只需要配置一次`，程序升级时会保留配置信息;
  - 你可以`在任何时候再次通过运行命令来修改它们;`
- **Git 自带一个 `git config` 的工具来帮助设置控制 Git 外观和行为的配置变量:**
  - `/etc/gitconfig 文件`:包含系统上每一个用户及他们仓库的通用配置
    - ✓ 如果在执行 git config 时带上 --system 选项，那么它就会读写该文件中的配置变量;
    - ✓ 由于它是系统配置文件，因此你需要管理员或超级用户权限来修改它。(开发中通常不修改)
  - `~/.gitconfig 或 C/用户/coderwhy/.gitconfig` 文件:只针对当前用户
    - ✓ 你可以传递 --global 选项让 Git 读写此文件，这会对你系统上 所有 的仓库生效;
  - `当前使用仓库的 Git 目录中的 config 文件(即 .git/config)`:针对该仓库
    - ✓ 你可以传递 --local 选项让 Git 强制读写此文件，虽然默认情况下用的就是它;

# Git**的配置选项**

- ◼ 安装**Git 后，要做的第一件事就是设置你的用户名和邮件地址。**

  - 这一点很重要，因为`每一个 Git 提交都会使用这些信息`，它们`会写入到你的每一次提交中`，不可更改;
  - 如果使用了 `--global 选项，那么该命令只需要运行一次`，因为之后无论你在该系统上做任何事情， Git 都会使用那些信息;

  ![image-20230824015312640](https://raw.githubusercontent.com/OneOneT/images/main/image-20230824015312640.png)

- 检测当前的配置信息:

```shell
git config --list
```

![image-20230824015412324](https://raw.githubusercontent.com/OneOneT/images/main/image-20230824015412324.png)

## Git 的别名(alias)

- **Git** 并不会在你输入部分命令时自动推断出你想要的命令:
  - 如果不想每次都输入完整的 Git 命令，可以通过 `git config` 文件来轻松地为每一个命令设置一个别名。

![image-20230824015543713](https://raw.githubusercontent.com/OneOneT/images/main/image-20230824015543713.png)

# 获取**Git 仓库 –** git init/git clone

- 我们需要一个**Git 来管理源代码，那么我们本地也需要有一个 Git 仓库。**

  ◼ 通常有两种获取 Git 项目仓库的方式:

  - 方式一:`初始化一个Git仓库`，并且可以将当前项目的文件都添加到 Git 仓库中(目前很多的脚手架在创建项目时都会默认创建一个 Git 仓库);
  - 方式二:`从其它服务器 克隆(clone) 一个已存在的 Git 仓库`(第一天到公司通常我们需要做这个操作);

> 方式一:初始化 Git 仓库

- 该命令将创建一个名为 `.git` 的子目录，这个子目录含有你初始化的 Git 仓库中所有的必须文件，这些文件是 Git 仓库的核心;
- 但是，在这个时候，我们仅仅是做了一个初始化的操作，你的项目里的文件还没有被跟踪;
- **`git init`**

> 方式二:从 Git 远程仓库

- git clone https://github.com/coderwhy/hy-react-web-music.git

## **文件的状态划分**

- 现在我们的电脑上已经有一个 Git 仓库:
  - 在实际开发中，你需要将`某些文件交由这个Git仓库`来管理;
  - 并且我们之后会修改文件的内容，当`达成某一个目标时，想要记录下来这次操作，就会将它提交到仓库中;`
- 那么我们需要对文件来划分不同的状态，以确定这个文件是否已经归于 Git 仓库的管理:
  - `未跟踪`:默认情况下，Git 仓库下的文件也没有添加到 Git 仓库管理中，我们需要通过`add`命令来操作;
  - `已跟踪`:添加到 Git 仓库管理的文件处于已跟踪状态，Git 可以对其进行各种跟踪管理;
- 已跟踪的文件又可以进行细分状态划分:
  - `staged`:暂缓区中的文件状态;
  - `Unmodified`:commit 命令，可以将 staged 中文件`提交到Git仓库`
  - `Modified`:修改了某个文件后，会处于 Modified 状态;
- 在工作时，你可以选择性地将这些修改过的文件放入暂存区;
- 然后提交所有已暂存的修改，如此反复;

![image-20230824020122899](https://raw.githubusercontent.com/OneOneT/images/main/image-20230824020122899.png)

## Git 操作流程图

![image-20230824020712349](https://raw.githubusercontent.com/OneOneT/images/main/image-20230824020712349.png)

# 检测文件的状态 - git status

- 我们在有 Git 仓库的目录下新建一个文件，查看文件的状态:

  ```shell
  git status
  ```

- `Untracked files:未跟踪的文件`

  - 未跟踪的文件意味着 Git 在之前的提交中没有这些文件;
  - Git 不会自动将之纳入跟踪范围，除非你明明白白地告诉它“我需要跟踪该文件”;

- 我们也可以查看更加简洁的状态信息:

  ```shell
  git status –s
  ```

  ```shell
  git status --short
  ```

- `左栏`指明了`暂存区的状态`，`右栏`指明了`工作区的状态;`

![image-20230824021100975](https://raw.githubusercontent.com/OneOneT/images/main/image-20230824021100975.png)

# **文件添加到暂存区 –** git add

- **跟踪新文件命令:**

  `git add aaa.js`

  - 使用命令 `git add` 开始跟踪一个文件。

- 跟踪修改的文件命令:

  - 如果我们已经跟踪了某一个文件，这个时候修改了文件也需要重新添加到暂存区中;

- 通过 `git add .` **将所有的文件添加到暂存区中:**

  ```shell
  	git add .
  ```

## git 忽略文件

- 一般我们总会有些文件无需纳入 **Git** 的管理，也不希望它们总出现在未跟踪文件列表。
  - 通常都是些`自动生成的文件`，比如日志文件，或者编译过程中创建 的临时文件等;
  - 我们可以创建一个名为 `.gitignore 的文件`，列出要忽略的文件的模式;
- 在实际开发中，这个文件通常`不需要手动创建`，`在必须的时候添加自己的忽略内容即可;`
- 比如右侧是创建的 Vue 项目自动创建的忽略文件:
  - 包括一些不需要提交的文件、文件夹;
  - 包括本地环境变量文件;
  - 包括一些日志文件;
  - 包括一些编辑器自动生成的文件;

![image-20230824021823734](https://raw.githubusercontent.com/OneOneT/images/main/image-20230824021823734.png)

# **文件更新提交 –** git commit

- <u>现在的暂存区已经准备就绪</u>，可以提交了。

  - 每次准备提交前，先用 `git status` 看下，你所需要的文件是不是都已暂存起来了;
  - 再运行提交命令 `git commit`;
  - 可以在 `commit 命令后添加 -m 选项`，将提交信息与命令放在同一行;

  ```shell
  git commit –m "提交信息"
  ```

- 如果我们修改文件的 add 操作，加上 commit 的操作有点繁琐，那么可以`将两个命令结合来使用`:

  ```shell
  git commit -a -m "修改了bbb文件"
  ```

## **Git**的校验和

- Git 中所有的数据在存储前都计算校验和，然后以 `校验和` 来引用。
  - Git 用以计算校验和的机制叫做 SHA-1 散列(hash，哈希);
  - 这是一个由 40 个十六进制字符(0-9 和 a-f)组成的字符串，基于 Git 中文件的内容或目录结构计算出来;

![image-20230824134159434](https://raw.githubusercontent.com/OneOneT/images/main/image-20230824134159434.png)

# **查看提交的历史 –** **git log**

- 在提交了若干更新，又或者克隆了某个项目之后，有时候我们想要查`看一下所有的历史提交记录`。
- 这个时候我们可以使用`git log`命令:
  - 不传入任何参数的默认情况下，`git log 会按时间先后顺序列出所有的提交`，最近的更新排在最上面;
  - 这个命令会列出每个提交的 SHA-1 校验和、作者的名字和电子邮件地址、提交时间以及提交说明;

```shell
git log
```

![image-20230824140331152](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230824140331152.png)

```shell
git log --pretty=oneline
```

![image-20230824140539243](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230824140539243.png)

```shell
git log --pretty=oneline --graph
```

![image-20230824140833979](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230824140833979.png)

# 版本回退 – git reset

- 如果想要进行版本回退，我们需要先知道`目前处于哪一个版本`:**Git 通过`HEAD指针`记录当前版本。**
  - `HEAD` 是当前分支引用的指针，它总是指向该分支上的最后一次提交;
  - 理解 HEAD 的最简方式，就是将它看做 `该分支上的最后一次提交` 的快照;
  - ![image-20230824141145194](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230824141145194.png)
- 我们可以通过 HEAD 来改变 Git 目前的版本指向:
  - 一个版本就是`HEAD^`，上上一个版本就是`HEAD^^`;
  - 如果是上 1000 个版本，我们可以使用`HEAD~1000`;
  - 我们可以可以指定某一个`commit id`;

```shell
    git reset --hard HEAD^
    git reset --hard HEAD~1000
    git reset --hard 2d44982
```

# 什么是远程仓库?

- 什么是远程仓库(**Remote Repository)呢?**

  - 目`前我们的代码是保存在一个`本地仓库中，也就意味着我们只是在进行本地操作;
  - 在真实开发中，我们通常是多人开发的，所以我们会将管理的代码`共享到远程仓库中`;

- 那么如何创建一个远程仓库呢?

  - 远程仓库通常是搭建在某一个服务器上的(当然本地也可以，但是本地很难共享);
  - 所以我们需要在`Git服务器上搭建一个远程仓库`;

- 目前我们有如下方式可以使用`Git服务器:`

  - 使用第三方的 Git 服务器:比如 GitHub、Gitee、Gitlab 等等;
  - 在自己服务器搭建一个 Git 服务;

  ![image-20230824142351778](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230824142351778.png)

## 远程仓库的验证

- 常见的远程仓库有哪些呢?目前比较流行使用的是三种:
  - GitHub:https://github.com/
  - Gitee:https://gitee.com/
  - 自己搭建 Gitlab:http://152.136.185.210:7888/
- 对于私有的仓库我们想要进行操作，远程仓库会对我们的`身份进行验证`:
  - 如果没有验证，任何人都可以随意操作仓库是一件非常危险的事情;
- 目前**Git 服务器验证手段主要有两种:**
  - 方式一:基于`HTTP的凭证存储`(Credential Storage);
  - 方式二:基于 SSH 的密钥;

## 远程仓库的验证 – 凭证

- 因为本身**`HTTP协议是无状态的连接`，所以每一个连接都需要用户名和密码:**
  - 如果每次都这样操作，那么会非常麻烦;
  - 幸运的是，Git 拥有一个凭证系统来处理这个事情;
- 下面有一些 `Git Crediential` 的选项:
  - 选项一:默认所有都不缓存。 每一次连接都会询问你的用户名和密码;
  - 选项二:“cache” 模式会将凭证存放在内存中一段时间。 密码永远不会被存储在磁盘中，并且在 15 分钟后从内存中清除;
  - 选项三:“store” 模式会将凭证用明文的形式存放在磁盘中，并且永不过期;
  - 选项四:如果你使用的是 `Mac`，Git 还有一种 “osxkeychain” 模式，它会将凭证缓存到你系统用户的钥匙串中(加密的);
  - 选项五:如果你使用的是 Windows，你可以安装一个叫做 “`Git Credential Manager for Windows`” 的辅助工具;
    - 可以在 https://github.com/Microsoft/Git-Credential-Manager-for-Windows 下载。

## **远程仓库的验证 –** SSH 密钥

- Secure Shell**(安全外壳协议，简称 SSH)是一种加密的网络传输协议，可在不安全的网络中为网络服务提供安全的传输环境。**
- SSH 以`非对称加密实现身份验证`。
  - 例如其中一种方法是使用`自动生成的公钥-私钥对来简单地加密网络连接`，随后使用密码认证进行登录;
  - 另一种方法是人工生成一对公钥和私钥，通过生成的密钥进行认证，这样就可以在不输入密码的情况下登录;
  - 公钥需要放在待访问的电脑之中，而对应的私钥需要由用户自行保管;
- 如果我们以**SSH 的方式访问 Git 仓库，那么就需要生产对应的公钥和私钥:**

```shell
  ssh-keygen -t ed25519 -C “your email"
  ssh-keygen -t rsa -b 2048 -C “your email"
```

![image-20230824143115911](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230824143115911.png)

# **管理远程服务器**

- 查看远程地址:比如我们之前从**`GitHub上clone下来的代码，它就是有自己的远程仓库的:`**

  ```shell
  git remote
  git remote -v
  ```

  -v 是 —verbose 的缩写(冗长的)

- 添加远程地址:我们也可以继续添加远程服务器(`让本地的仓库和远程服务器仓库建立连接`):

```shell
git remote add <shortname> <url>

git remote add gitlab http://152.136.185.210:7888/coderwhy/gitremotedemo.git
```

- 重命名远程地址:

```shell
 git remote rename gitlab glab
```

- 移除远程地址:

```shell
git remote remove gitlab
```

## 本地分支的上游分支(跟踪分支)

- 问题一:当前分支没有`track的分支`

![image-20230824224947028](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230824224947028.png)

- 原因:当前分支没有和远程的`origin/main分支进行跟踪`

  - 在没有跟踪的情况下，我们直接执行 pull 操作的时候必须指定从哪一个远程仓库中的哪一个分支中获取内容;

- 如果我们想要直接执行`git fetch`是有一个前提的:必须给当前分支设置一个跟踪分支:

```shell
git branch --set-upstream-to=origin/main
```

![image-20230826234622747](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826234622747.png)

## **拒绝合并不相干的历史**

- 问题二:`合并远程分支时，拒绝合并不相干的历史`

![image-20230825234632500](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230825234632500.png)

- 原因:`我们将两个不相干的分支进行了合并`:
  - https://stackoverflow.com/questions/37937984/git-refusing-to-merge-unrelated-histories-on-rebase

![image-20230825234712508](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230825234712508.png)

- 简单来说就是:`过去git merge允许将两个没有共同基础的分支进行合并`，这导致了一个后果:新创建的项目可能被一个毫不怀疑的维护者合并了很多没有必要的历史，到一个已经存在的项目中，目前这个命令已经被纠正，但是我们依然可以通过`--allow-unrelated-histories`选项来逃逸这个限制，来合并两个独立的项目;

  ```shell
  git merge --allow-unrelated-histories
  ```

# **远程仓库的交互**

- 从`远程仓库`clone 代码:将存储库克隆到新创建的目录中;
  - git clone http://152.136.185.210:7888/coderwhy/gitremotedemo.git
- 将代码`push`到远程仓库:将本地仓库的代码推送到远程仓库中;
  - 默认情况下是将当前分支(比如 master)push 到 origin 远程仓库的;

```shell
git push
git push origin master
```

- 从远程仓库`fetch`代码:从远程仓库获取最新的代码

  - 默认情况下是从 origin 中获取代码;

  ```shell
  git fetch
  git fetch origin
  ```

  - 获取到代码后默认并没有合并到本地仓库，我们需要通过`merge`来合并;

```shell
git merge
```

- 从远程仓库**pull 代码:上面的两次操作有点繁琐，我们可以通过一个命令来操作**

```shell
   git pull
   // 等价于
   git fetch + git merge(rebase)
```

## **合并冲突(**conflict)

- 上面我们通过`pull`从 Git 远程仓库获取到分支内容后会`自动进行合并(merge)`
- 但是并非所有的情况都可以正常的合并，某些情况下合并会出现冲突:

![image-20230825235801203](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230825235801203.png)

- <<<<<<<和

# Git**标签(tag)**

## 创建 tag

- 对于`重大的版本`我们常常会打上一个`标签`，以表示它的`重要性:`

  - Git 可以给仓库历史中的某一个提交打上标签;
  - 比较有代表性的是人们会使用这个功能来`标记`发布结点( v1.0 、 v2.0 等等);

- 创建标签:

  - Git 支持两种标签:`轻量标签`(lightweight)与`附注标签`(annotated);
  - 附注标签:通过-a 选项，并且通过-m 添加额外信息;

  ```shell
  git tag v1.0.0
  git tag -a v1.0.0 -m "附加标签"
  ```

- 默认情况下，`git push`命令并不会传送标签到远程仓库服务器上。

  - 在创建完标签后你`必须显式地推送标签`到共享服务器上，当其他人从仓库中克隆或拉取，他们也能得到你的那些标签;

```shell
git push origin v1.0.0
git push origin --tags
```

## 删除和检出 tag

- `删除本地tag:`
  - 要删除掉你本地仓库上的标签，可以使用命令 `git tag -d <tagname>`

```shell
git tag -d v1.0.0
```

- `删除远程tag:`
  - 要删除远程的 tag 我们可以通过`git push <remote> –delete <tagname>`

```shell
git push origin --delete v1.1
```

- `检出tag:`
  - 如果你想查看`某个标签所指向的文件版本`，可以使用 `git checkout` 命令;
  - 通常我们在检出 tag 的时候还会创建一个对应的分支(分支后续了解);

```shell
git checkout v1.0
```

# Git master 分支

- Git 的分支，其实本质上`仅仅是指向提交对象的可变指针。`
  - Git 的默认分支名字是 `master`，在多次提交操作之后，你其实已经有一个`指向最后那个提交对象的 master 分支;`
  - master 分支会在每次提交时自动移动;
- Git 的 master 分支并不是一个特殊分支。
  - 它就跟其它分支完全没有区别;
  - 之所以几乎每一个仓库都有 master 分支，是因为 git init 命令默认创建它，并且大多数人都懒得去改动它;

![image-20230826003941715](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826003941715.png)

## 为什么需要使用分支呢?

- 让我们来看一个简单的分支新建与分支合并的例子，实际工作中你可能会用到类似的工作流。
  - 开发某个项目，在默认分支`master`上进行开发;
  - 实现项目的功能需求，不断提交;
  - 并且在一个大的版本完成时，发布版本，打上一个`tag` v1.0.0;
  - ![image-20230826005258608](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826005258608.png)
- 继续开发后续的新功能，正在此时，你突然接到一个电话说有个很严重的问题需要紧急修补， 你将按照如下方式来处理:
  - `切换到tag v1.0.0的版本，并且创建一个分支hotfix;`
- `想要新建一个分支并同时切换到那个分支上`，你可以运行一个带有 -b 参数的 `git checkout` 命令:

```shell
git checkout –b hotfix
```

![image-20230826005319070](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826005319070.png)

## Git 创建分支

- Git 是怎么创建新分支的呢?
  - 很简单，它只是为你创建了一个`可以移动的新的指针`;
- 比如，创建一个 testing 分支， 你需要使用 `git branch` 命令:

```shell
git branch testing
```

![image-20230826004206798](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826004206798.png)

- 那么，**Git** 又是怎么知道当前在哪一个分支上呢?
  - 也很简单，它也是通过一个名为 `HEAD` 的特殊指针;

```shell
git checkout testing //切换分支
```

![image-20230826004241490](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826004241490.png)

## Git 分支提交

- 如果我们指向某一个分支，并且在这个分支上提交:

![image-20230826004632711](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826004632711.png)

- 你也可以切换回到**master 分支，继续开发:**

![image-20230826004656151](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826004656151.png)

![image-20230826004717495](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826004717495.png)

## 创建分支同时切换

- 创建新分支的同时切换过去
  - 通常我们会在创建一个新分支后立即切换过去;
  - 这可以用 `git checkout -b <newbranchname>` 一条命令搞定;

```shell
git checkout -b <newbranchname>
```

## 分支开发和合并

- 分支上开发、修复 bug:
  - 我们可以在`创建的hotfix分支`上继续开发工作或者修复 bug;
  - 当完成要做的工作后，重新打上一个`新的tag` v1.0.1;
- 切换回`master分支，但是这个时候master分支也需要修复刚刚的bug:`
  - 所以我们需要将`master分支和hotfix分支进行合并`;

```shell
   git checkout master
   git merge hotfix
```

![image-20230826005543495](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826005543495.png)

![image-20230826005608175](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826005608175.png)

## 查看和删除分支

- 如果我们希望查看当前所有的分支，可以通过以下命令:

- `git branch` # 查看当前所有的分支

- `git branch –v` # 同时查看最后一次提交

- `git branch --merged` # 查看所有合并到当前分支的分支

- `git branch --no-merged` # 查看所有没有合并到当前分支的分支

- 如果某些已经合并的分支我们不再需要了，那么可以将其移除掉:
- `git branch –d hotfix` # 删除当前分支
- `git branch –D hotfix` # 强制删除某一个分支

# Git 的远程分支

- 远程分支是也是一种分支结构:
  - 以 `<remote>/<branch>` 的形式命名的;
- 如果我们刚刚 clone 下来代码，分支的结构如下:

![image-20230827003912125](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230827003912125.png)

- 如果其他人修改了代码，那么远程分支结构如下:
  - 你需要通过`fetch`来获取最新的远程分支提交信息;(然后进行`merge`进行合并)

![image-20230827003928792](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230827003928792.png)

![image-20230827003952089](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230827003952089.png)

## **远程分支的管理**

> 操作一:`推送分支到远程`

- 当你想要公开分享一个分支时，需要将其推送到有写入权限的远程仓库上;
- 运行 `git push <remote> <branch>`;

```shell
git push origin <branch>
```

> 操作二:跟踪远程分支

- 当克隆一个仓库时，它通常会`自动地创建一个跟踪 origin/master 的 master 分支;`

- 如果你愿意的话可以设置其他的跟踪分支，可以通过运行 `git checkout --track <remote>/<branch>`

- 如果你尝试检出的`分支 (a) 不存在且 (b) 刚好只有一个名字与之匹配的远程分支`，那么 Git 就会为你创建一个跟踪分支;

```shell
git checkout --track <remote>/<branch>

git checkout <branch>
```

> 操作三:删除远程分支

- 如果某一个远程分支不再使用，我们想要删除掉，可以运行带有 `--delete` 选项的 git push 命令来删除一个远程分支。

```shell
git push origin --delete <branch>
```

# Git rebase**用法**

- 在 Git 中`整合来自不同分支`的修改主要有两种方法:`merge` 以及 `rebase`。

> 什么是 rebase 呢?

![image-20230828002015979](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230828002015979.png)

![image-20230828002036456](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230828002036456.png)

- 在上面的图例中，你可以提取在 C4 中引入的补丁和修改，然后在 C3 的基础上应用一次;
- 在 Git 中，这种操作就叫做 `变基(rebase)`;
- 你可以使用 `rebase` 命令将`提交到某一分支上的所有修改都移至另一分支上`，就好像“重新播放”一样;
- rebase 这个单词如何理解呢?
  - 我们可以将其理解成改变当前分支的 base;
  - 比如在分支 experiment 上执行 rebase master，那么可以改变 experiment 的 base 为 master

```shell
    git checkout experiment
    git rebase master
```

## rebase 的原理

> rebase 是如何工作的呢?

- 它的原理是首先找到这两个分支(即`当前分支` experiment、`变基操作的目标基底分支` master) 的最近`共同祖先` C2;
- 然后`对比当前分支相对于该祖先的历次提交，提取相应的修改并存为临时文件;`
- 然后将当前分支指向目标基底 C3;
- 最后以此将之前另存为临时文件的修改依序应用;
- 我们可以再次执行`master`上的合并操作:

```shell
 git checkout master
 git merge experiment
```

![image-20230828002319174](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230828002319174.png)

## rebase 和 merge 的选择

> 开发中对于 rebase 和 merge 应该如何选择呢?

- 事实上，**rebase 和 merge 是对 Git 历史的不同处理方法:**
  - merge 用于`记录git的所有历史`，那么分支的历史错综复杂，也全部记录下来;
  - rebase 用于`简化历史记录`，将两个分支的历史简化，整个历史更加简洁;
- 了解了**rebase 的底层原理，就可以根据自己的特定场景选择 merge 或者 rebase。**
- 注意:rebase 有一条黄金法则:`永远不要在主分支上使用rebase`
  - 如果在 main 上面使用 rebase，会造成大量的提交历史在 main 分支中不同;
  - 而多人开发时，其他人依然在原来的 main 中，对于提交历史来说会有很大的变化;

![image-20230828003003902](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230828003003902.png)

# Git 的工作流(git flow)

- 由于**Git 上分支的使用的便捷性，产生了很多 Git 的工作流:**
  - 也就是说，在整个项目开发周期的不同阶段，你可以同时拥有多个开放的分支;
  - 你可以定期地把某些主题分支合并入其他分支中;
- 比如以下的工作流:
  - `master`作为主分支;
  - `develop`作为开发分支，并且有稳定版本时，合并到 master 分支中;
  - `topic`作为某一个主题或者功能或者特性的分支进行开发，开发完成后合并到 develop 分支中;

![image-20230826010230636](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826010230636.png)

## 比较常见的 git flow

![image-20230826010336985](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826010336985.png)

# Git 提交对象(Commit Object)--git 底层原理

- 几乎所有的版本控制系统都以某种形式支持分支。
  - 使用分支意味着你可以把你的工作从开发主线上分离开来，以免影响开发主线。
- 在进行提交操作时，**Git** 会保存一个提交对象(`commit object`):
  - 该提交对象会包含一个指向暂存内容快照的指针;
  - 该提交对象还包含了作者的姓名和邮箱、提交时输入的信息以及指向它的父对象的指针;
    - <u>首次提交产生的提交对象没有父对象，普通提交操作产生的提交对象有一个父对象;</u>
    - <u>而由多个分支合并产生的提交对象有多个父对象;</u>

![image-20230826003607958](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826003607958.png)

![image-20230826003625021](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826003625021.png)

# **常见的开源协议**

![image-20230825235855627](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230825235855627.png)

# **Git**常见命令速查表

![image-20230826010014276](https://cdn.jsdelivr.net/gh/OneOneT/images@main/image-20230826010014276.png)

![image-20230825141357127](/Users/i/Library/Application%20Support/typora-user-images/image-20230825141357127.png)
