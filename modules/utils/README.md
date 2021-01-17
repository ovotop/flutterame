# utils
本模块用来演示如何构建你的工具库并复用它。
utils中将对外提供界面无关，业务无关的工具类和函数。

## 创建utils模块
```
bin/add_module.sh utils
```

新创建的模块目录如下：
```text
./modules/utils
├── README.md
├── lib
│   └── main.dart
├── pubspec.lock
├── pubspec.yaml
├── test
│   └── widget_test.dart
├── utils.iml
└── utils_android.iml

```


因为这个模块都是界面无关的工具类和函数，
删掉其中的"lib/main.dart"和"test/widget_test.dart".


## 添加第一个工具类Https

### 添加要用到的dio库
修改modules/utils/pubspect.yaml：
```yaml
name: utils
#...
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.0
dev_dependencies:
#...
```
修改后
```yaml
name: utils
#...
dependencies:
  flutter:
    sdk: flutter
  dio: 3.x
dev_dependencies:
#...
```
在lib下创建https.dart并在文件中添加类Https.（编程规范：文件名小写单词间用下划线分割。类名首字母大写的驼峰。）

```dart
import 'package:dio/dio.dart';

class Https {
  static void get(String url, Map<String, dynamic> params) async {
    try {
      Response response = await Dio().get(url, queryParameters: params);
      print(response);
    } catch (e) {
      print(e);
    }
  }
}

```

### 添加Https测试代码
在flutterame/modules/utils/test/下添加https_test.dart:
```dart
import 'package:flutter_test/flutter_test.dart';

import 'package:utils/https.dart';

void main() {
  test('Https.get', () async {
    await Https.get("https://jsonplaceholder.typicode.com/users", {"id": 3});
    print("done");
  });
}

```

### 运行单元测试

进入目录flutterame/modules/utils并执行：
```bash
$ flutter test test/https_test.dart
00:14 +0: Https.get
{"id":3,"name":"Clementine Bauch","username":"Samantha","email":"Nathan@yesenia.net","address":{"street":"Douglas Extension","suite":"Suite 847","city":"McKenziehaven","zipcode":"59590-4157","geo":{"lat":"-68.6102","lng":"-47.0653"}},"phone":"1-463-123-4447","website":"ramiro.info","company":{"name":"Romaguera-Jacobson","catchPhrase":"Face to face bifurcated interface","bs":"e-enable strategic applications"}}
done
00:14 +1: All tests passed!   
```

修改我们的Https.get使其返回json。



<!-- https://jsonplaceholder.typicode.com/users/3 -->
<!-- 测试 https://jsonplaceholder.typicode.com/ -->