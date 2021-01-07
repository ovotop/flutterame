转载请注明出处,保持文章完整：
[Flutter组件化框架](https://juejin.cn/editor/drafts/6911677421720698894)

# 组件化无处不在

![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6621c86e4965450298998c155305744d~tplv-k3u1fbpfcp-watermark.image)

军队中有“军师旅团营”，营是团的组件，师是军的组件。

国家中有“省市县乡村”，村是乡的组件，市是省的组件。

要管理复杂的结构，逐层划分组件是一个很好的方法。

本文探讨的组件化，并非以代码复用为目的。

本文关注于通过组件化，管理比较复杂的工程，提高人效，降低损耗。

# 问题
复杂的工程往往存在如下两个主要问题：
1. 代码量大编译慢。
2. 逻辑复杂难维护。

# 解决思路

## 化整为零

说到代码风格，很多人都知道这个常识。

如果一个函数太长了，需要拆成不同函数。

如果一个类太长了，需要拆成不同类。

如果一个文件太长了，需要拆成不同文件。

同样的，如果我们的项目太大，文件太多，就需要拆分成不同的组件了。

## 减少耦合

如果拆成不同组件后，各个组件仍然有千丝万缕的联系，维护起来仍然会一团乱麻。

我们应当尽量避免组件之间的依赖。减少耦合。

利用router可以很好的解决页面互相跳转时引起的耦合。

后面将会演示如何在flutter中实现通过路由减少耦合。

## 怎样组织你的代码大军

之前见到过一套Android代码“充分”利用了MVP模式。
整个项目下面分了3个目录，M，V，P。
V下面又分 Activities,Views,Adapters,...

虽然逻辑和UI分的很开，但是要修改一个业务或者新加一套功能，需要跨越各个目录，逐一添加代码。

我比较推荐的是下面的划分方法：
```
+------------------------------------------------+
|                    main frame                  |
|  +-----------+-----------+-----------+-----+   |
|  | business1 | business2 | business3 | ... |   |
+--+-----------+-----------+-----------+-----+---+
+------------------------------------------------+
|                   common                       |
+------------------------------------------------+
```
business1,business2,business3,...是不同的业务模块。

例如： 画廊，搜索，课程，推荐,....

这样做的好处是，当你添加代码的时候可以专注于当前业务，
忽略其他业务模块，大大减小了需要维护的代码的范围。

通常产品需求的发展和变化也是按照业务为单位进行的。
比如产品经理想到了一种新的课程模式，这个需求将影响到和课程相关的一些代码。
如果我们的代码本来就已经将课程业务封装在一起的话，修改将都在这个模块内部进行。而不会株连其他部分的代码。

当然我们不是不考虑代码的复用，通常有很多值得复用的代码都是和业务无关的。
和业务无关，也就是说不专属于某个业务，业务A可能会用到，业务B也可能会用到。
这些可复用的业务无关的代码将会方阵上面架构的common部分。


## 总结一下：
1. 以业务模块作为最基础的代码划分，将业务变化隔离在相应的组件内部。
2. 主框架和业务模块都依赖的部分，放入公共库。(公共库中都是业务无关代码)

# Flutter中的实践

Flutter天生就适合组件化，只要你研究的足够深入，就能发现这些特征：
1. 自带工具可创建独立运行组件 (modules)
2. 自带路由支持 (router)
3. 可通过命令行环境变量区分app和组件运行环境(commandline env)

在这里我专门写了一套框架示例： [Flutterame](https://github.com/ovotop/flutterame)

命名含义：Flutterame = Flutter + Frame

## 准备

工欲善其事，必先利其器。

让我们先准备一下.

### 1. 创建工程
flutter create  --org top.ovo --platforms ios,android flutterame

想要学习flutter create的更多用法可以看一下我的另一篇文章：[玩转flutter create命令，做10倍程序员](https://juejin.cn/post/6844904106310500366)
其中除了我对 flutter create --help的翻译还有一些其他的奇怪的小技巧。

### 2. 针对国内网络优化Android编译速度

#### 2.1 手动修改android/build.gradle文件。

修改前：
```gradle
    repositories {
        google()
        jcenter()
    }
```
修改后：
```gradle
    repositories {
        maven { url 'https://maven.aliyun.com/repository/google'} // google()
        maven { url 'https://maven.aliyun.com/repository/jcenter'} // jcenter()
    }
```

#### 2.2 用脚本修改
```
bin/optimize_cn_network.py android/
```
网速优化详情见：[Flutter工程的Android编译网速优化](https://juejin.cn/post/6912647682343469070/)

好了这下你可以愉快的flutter run了。

准备工作完成，接下来我们创建一个组件。

## 开始实现组件化

### 3. 创建组件

假如我们要在项目下的modules/目录下创建名为gallery的模块，我们可以先进入modules目录再用flutter create创建模块
```bash
flutter create -t module --org top.ovo gallery
```
这里的-t module表示要创建的是一个组件而不是完整的app。

创建的组件目录如下：

```
.
├── .android
├── .dart_tool
├── .gitignore
├── .ios
├── .metadata
├── .packages
├── README.md
├── build
├── gallery.iml
├── gallery_android.iml
├── lib
│   └── main.dart
├── pubspec.lock
├── pubspec.yaml
└── test
```
#### 3.1 组件可以直接运行
在当前组件目录中，我们可以直接用flutter run 运行这个组件。
不久你就能看到熟悉的计数器demo页面。
它和一个普通的app没有太大区别。

![刚创建完的组件运行的样子](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/cb91dd0609a14a5cbe99d9d1864073b7~tplv-k3u1fbpfcp-watermark.image)

由此可见，Flutter的开发者充分考虑到了组件化的需求。你不但可以把组件放在app中运行，也可以单独运行组件。

#### 3.2 神奇的“.android” 和 “.ios”
如果你仔细观察创建好的目录，你会发现一个有趣的现象：

在app中android和ios目录不见了。取而代之的是两个隐藏目录 “.android” 和 “.ios”。

也就是说这两个目录是隐藏的，默认情况下是不会被添加到git中的。
那如果其他人拉取了这套代码，还能单独运行这个组件吗？

**经过实验发现：**

如果在没有“.android” 和 “.ios”目录的组件目录中运行flutter run的时候。

Flutter会重新创建“.android” 和 “.ios”目录。

正因为.android目录是代码生成的，你在里面所做的一切修改，随时可能会被丢弃。
因此在我的[Flutter工程的Android编译网速优化](https://juejin.cn/post/6912647682343469070)一文中还介绍了脚本自动优化网速，以免除每次手动修改的麻烦。

创建完组件就该使用了，接下来我们一起看看如何使用组件代码。

#### 3.3 在app中嵌入你的组件界面。

##### 3.3.1 创建组件界面

首先我们创建一个简单的组件界面Galleria，将其存放在组件的gallria.dart文件中

modules/gallery/lib/gallria.dart:
```dart
import 'package:flutter/material.dart';

class Galleria extends StatelessWidget {
  const Galleria();

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Galleria"));
  }
}
```

##### 3.3.2 app中添加对组件对依赖

我们的app要调用组件中的代码，需要先声明对组件的依赖：

我们可以修改pubspec.yaml来完成这个声明

修改前：
```yaml
dependencies:
  flutter:
    sdk: flutter

```

修改后：
```yaml
dependencies:
  flutter:
    sdk: flutter
  gallery:
    path: modules/gallery
```
强调一下因为我们的组件目前在本地，因此需要用 **path：+相对目录** 声明这个依赖。

修改完成后你可以执行：flutter pub get来完成安装。

如果你用的是vscode 当你修改完pubspect.yaml后会自动执行‘flutter pub get’。
![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5182ac2f4a554bb7969a738c5cf83526~tplv-k3u1fbpfcp-watermark.image)

##### 3.3.3 app中引用组件中的类

app中导入modules/gallery/lib/gallria.dart文件：

```dart
import 'package:gallery/galleria.dart';
import 'package:flutterame/mine.dart';


//...
const TabItems = {
  TabItem.galleria: {'icon': Icons.school, 'title': '画廊', 'widget': Galleria()},
  TabItem.mine: {'icon': Icons.more_horiz, 'title': '我的', 'widget': Mine()}
};
//...
```
在我们的app中添加了底部tab，使用了Galleria()来创建组件中的控件。

仔细观察不难发现，组件的层级是独立的，而不是嵌入到app中。
```dart
import 'package:gallery/galleria.dart'; //这和flutterame没有半毛钱关系。
import 'package:flutterame/mine.dart';
```

这对我们将来复用组件代码也很有利。

到目前为止，我们完成了一个最粗略的组件化示例app。

**来吧，展示**

当我们在模块的目录下运行"flutter run"的时候，我们将会看到组件单独运行的结果。

当我们在项目根目录下运行"flutter run"的时候，我们将会看到整个app的运行结果。

组件中运行|app中运行
:----:|:----:
![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c3846f91f4734d05b766546c02a41b3b~tplv-k3u1fbpfcp-watermark.image)|![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5d5bd84863fb48689377fdf817f3d85c~tplv-k3u1fbpfcp-watermark.image)

**然而事情并没有结束**

我在组件中添加了json文件作为显示用的数据。

结果当我运行插件的时候，一切正常。

但是当我运行整个app的时候发生了错误。

### 4. 组件中添加资源

事情的经过时这样的：

首先在组件目录下创datas建目录并添加资源文件:

modules/gallery/datas/gallery_source.json
```
.
├── .android
├── .ios
├── datas
│   └── gallery_source.json
├── lib
├── pubspec.lock
├── pubspec.yaml
└── test
```

然后修改modules/gallery/pubspec.yaml，添加assets字段：

修改前：
```yaml

flutter:
  uses-material-design: true

  # To add Flutter specific assets to your application, add an assets section,
  # like this:
  # assets:
  #   - images/a_dot_burr.jpeg
  #   - images/a_dot_ham.jpeg
```

修改后：
```yaml

flutter:
  uses-material-design: true

  assets:
    - datas/gallery_source.json
```

利用DefaultAssetBundle在代码中引用资源：
```dart

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('datas/gallery_source.json'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: Text('Loading...'));
            default:
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              else {
                //若_calculation执行正常完成
                const json = const JsonCodec();
                var data = json.decode(snapshot.data.toString());
                return _buildLoaded(data);
              }
          }
        });
  }
```

#### 4.1 问题来了

当我启动组件的时候可以看到正确结果，但是在我运行app显示组件中的页面时却报错了。


组件中运行|app中运行
:----:|:----:
![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0ca9168a0f404022ab46ea9769289621~tplv-k3u1fbpfcp-watermark.image)|![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/16717c5dd3b341e6ac01db2cd9882df8~tplv-k3u1fbpfcp-watermark.image)

这是为什么呢？

#### 4.2 探索结果

经过探索发现，app和组件中的资源被打包之后的路径是不同的。
```
app中资源：packages/gallery/datas/gallery_source.json
组件中资源：datas/gallery_source.json
```
因此当我们在插件中可以找到资源文件，但是换到app中运行的时候就找不到了。

**探索的过程**也不复杂。

找到app和插件的安装包按照zip解压。

整个app的安装包文件结构：
build/app/outputs/apk/debug/app-debug.apk：
```
.
├── AndroidManifest.xml
├── META-INF
├── assets
│   └── flutter_assets
│       ├── AssetManifest.json
│       ├── FontManifest.json
│       ├── NOTICES
│       ├── fonts
│       ├── isolate_snapshot_data
│       ├── kernel_blob.bin
│       ├── packages
│       │   ├── cupertino_icons
│       │   └── gallery
│       │       └── datas
│       │           └── gallery_source.json
│       └── vm_snapshot_data
├── classes.dex
├── kotlin
├── lib
├── project.txt
├── res
└── resources.arsc
```

单一组件的安装包文件结构：
modules/gallery/build/host/outputs/apk/app.apk：
```
.
├── .DS_Store
├── AndroidManifest.xml
├── META-INF
├── assets
│   ├── .DS_Store
│   └── flutter_assets
│       ├── AssetManifest.json
│       ├── FontManifest.json
│       ├── NOTICES
│       ├── datas
│       │   └── gallery_source.json
│       ├── fonts
│       ├── isolate_snapshot_data
│       ├── kernel_blob.bin
│       ├── packages
│       └── vm_snapshot_data
├── classes.dex
├── lib
├── res
└── resources.arsc
```

#### 4.3 解决方法

一番百谷歌度，参考了几篇文章之后，终于找到了解决方法。

利用CommandArgument+bool.fromEnvironment区分环境。

原来fromEnvironment函数不仅可以判断是否是生产环境,像这样:
```
final isProd = const bool.fromEnvironment('dart.vm.product');
```

还可以判断通过命令行传递给flutter run命令的参数。

用法如下：

##### 4.3.1 在命令行中传递自定义参数：
启动组件的时候不仅仅用flutter run 还要给它传递参数
```bash
flutter run --dart-define=IS_RUN_ALONE=true
```
##### 4.3.2 在代码中判断：
```dart
class EnvironmentConfig {
  static const IS_RUN_ALONE =
      bool.fromEnvironment('IS_RUN_ALONE', defaultValue: false);
}
```
##### 4.3.3 根据不同环境加载不同资源
```dart
  @override
  Widget build(BuildContext context) {
    const isRunAlone = EnvironmentConfig.IS_RUN_ALONE;
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString(isRunAlone
            ? 'datas/gallery_source.json'
            : 'packages/gallery/datas/gallery_source.json'),
        builder: (context, snapshot) {
         //...
        });
  }
```
这下终于完美了：
组件中运行|app中运行
:----:|:----:
![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0ca9168a0f404022ab46ea9769289621~tplv-k3u1fbpfcp-watermark.image)|![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4be8c4660cbd4df6a9e3c66dd45ca14a~tplv-k3u1fbpfcp-watermark.image)

经验证这套方案在ios上也可以正常工作。

##### 4.3.4 参考文章：

[Flutter 1.17 — no more Flavors, no more iOS Schemas. Command argument that changes everything](https://itnext.io/flutter-1-17-no-more-flavors-no-more-ios-schemas-command-argument-that-solves-everything-8b145ed4285d)

[bool.fromEnvironment](https://api.flutter-io.cn/flutter/dart-core/bool/bool.fromEnvironment.html)

[String.fromEnvironment](https://api.flutter-io.cn/flutter/dart-core/String/String.fromEnvironment.html)

[int.fromEnvironment](https://api.flutter-io.cn/flutter/dart-core/int/int.fromEnvironment.html)


### 5. 如何解耦

经过十几年的摸爬滚打发现，以下两点可以有效的减少耦合：
1. 杜绝从组件中引用框架里的代码。
2. 尽量减少从框架中引用组件中的代码的引用。

你可以很容易的做到第一点，只要你的gallery模块中不添加对Flutterame的依赖就可以了。
如果有一些代码确实需要在Flutterame和gallery之间公用，不妨考虑将其放入公共库中。
然后在Flutterame和gallery中添加对公共库的依赖。

要做到第二点，你则需要考虑每一个Flutterame中每一个import 'package:gallery/*.dart'是否是必须的。

举个例子：
假如你在Flutterame中要跳转到gallery中的一个页面AboutGallery。

你当然可以直接这样写
```dart
Navigator.push(context, MaterialPageRoute(builder: (_) {
            return new AboutGallery();
          }));
```
#### 问题：
这样，为了能够创建AboutGallery，你还需要在所有调用这个跳转的地方引入文件 
```dart
import 'package:gallery/about.dart';
```
#### 解决方法：
使用路由，如果我们使用pushNamed代替就可以凭借路由跳转而不必导入Widget
```dart
    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GalleryAbout()));
    Navigator.pushNamed(context, "/gallery/about");
```
但是使用路由也不是这么简单，需要做一些准备工作。

#### 5.1 在组件中创建路由
在组件modules/gallery/lib/中添加文件 routs.dart:
```dart
import 'package:flutter/material.dart';
import 'package:gallery/main.dart';
import 'package:gallery/detail.dart';
import 'package:gallery/about.dart';

class GalleryRouteGenerator {
  //配置路由
  static final routes = {
    "/": (context, {arguments}) => MyHomePage(title: '画廊'),
    "/gallery/detail": (context, {arguments}) => Detail(gallery: arguments),
    "/gallery/about": (context, {arguments}) => GalleryAbout(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String name = settings.name;
    final Function pageContentBuilder = routes[name];
    if (pageContentBuilder != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      return _errorPage('找不到页面');
    }
  }

  static Route _errorPage(msg) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('未知页面')), body: Center(child: Text(msg)));
    });
  }
}
```

#### 5.2 在组件中使用路由
在组件modules/gallery/lib/main.dart中导入文件 routs.dart:
```dart
import 'package:gallery/routes.dart';
//...
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Module: gallery'),
      initialRoute: '/',
      onGenerateRoute: GalleryRouteGenerator.generateRoute,
    );
  }
  //...
}
```
到目前为止，组件中的路由已经可以工作了。



如果想要在app中使用路由还需要，做一点点工作。

#### 5.3 在App中添加组件路由

在app的 lib/目录下添加routs.dart:
```dart
import 'package:flutter/material.dart';
import 'package:flutterame/about.dart';
import 'package:flutterame/home.dart';

class RouteGenerator {
  //配置路由
  static final routes = {
    "/": (context, {arguments}) => MyHomePage(title: '画廊'),
    "/about": (context, {arguments}) => About(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String name = settings.name;
    final Function pageContentBuilder = routes[name];
    if (pageContentBuilder != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      return _errorPage('找不到页面');
    }
  }

  static Route _errorPage(msg) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('未知页面')), body: Center(child: Text(msg)));
    });
  }
}
```

在这个文件中添加组件路由：
```dart
//...
import 'package:gallery/routes.dart';

class RouteGenerator {
  //配置路由
  static final routes = {
    ...GalleryRouteGenerator.routes,
    "/": (context, {arguments}) => MyHomePage(title: '画廊'),
    "/about": (context, {arguments}) => About(),
  };
  //...
}
```

...GalleryRouteGenerator.routes这个语法，我在ReactNative中经常用，怀着试一试的想法运行了一下居然管用，开心😊😊😊

这三个点的意思是，将后面的对象（GalleryRouteGenerator.routes）拆开，合并到新的对象（RouteGenerator.routes）中。

#### 5.4 在App中使用组件路由

在lib/mine.dart文件中调用：
```dart
Navigator.pushNamed(context, "/gallery/about")
```
Navigator会拿着 "/gallery/about"去app的路由里面找Widget。找到之后就跳转到那个页面去了。

收工，完整的代码在github上： [Flutterame](https://github.com/ovotop/flutterame)

#### 又到了展示环节

##### 组件中使用路由
我们先进入modules/gallery/启动组件：
```bash
flutter run --dart-define=IS_RUN_ALONE=true
```
当我们点击图片封面的时候，会进入详情页面。点击右下角“About”按钮进入组件的关于页面显示了“about gallery”。

##### app中使用路由
接下来我们回到项目根目录 通过flutter run 启动整个app。

在第一个tab中点击图片封面，进入了组件中的详情页。这里运用了Flutter特有的Hero组件实现了跨屏动画，喜欢😍😍😍

在第二个tab中点击“about”进入app的关于页面。

在第二个tab中点击“gallery about” 进入组件的关于页面。

组件中运行|app中运行
:----:|:----:
![组件中运行](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/35b40ebeee444c54b8854a03035d0cc6~tplv-k3u1fbpfcp-watermark.image)|![app中运行](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5ba9e299253d4979ab846fcba185733b~tplv-k3u1fbpfcp-watermark.image)


<br><br><br><br><br>

⭐️|⭐️⭐️⭐️|⭐️
----:|:----:|:----
⭐️ |![眼巴巴盼着你点赞](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8a54462fedea49eaad84c2ab6e97aa23~tplv-k3u1fbpfcp-watermark.image)| ⭐️
⭐️ |**本文作者正眼巴巴盼着你转发、点赞、加关注**| ⭐️