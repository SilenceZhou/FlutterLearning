# BloC源码解读

[toc]
**参考链接：**
[使用教程](https://felangel.github.io/bloc/#/gettingstarted)
[dart_bloc](https://pub.dev/packages/bloc)
[flutter_bloc](https://pub.dev/packages/flutter_bloc)


### **一、文件结构与概念**

* [文件结构图](https://www.processon.com/mindmap/5d2edf74e4b065dc42a818f7)

* [Dart_BLoC源码通读bloc-0.11.1](evernote:///view/4405394/s11/7b972382-726f-4264-94c5-50bd0cf46573/7b972382-726f-4264-94c5-50bd0cf46573)
* [Flutter_BLoC源码通读 0.7.1](https://app.yinxiang.com/shard/s11/nl/4405394/750aeb65-0a90-4ea2-aded-c901c0bc9e46/)


### **二、使用流程**
[使用流程图](https://www.processon.com/diagraming/5d2ebb93e4b0511f13082c07)


### **三、通读逻辑**


1、把两个库copy出来直接进行文件导入，进行翻译、断点调试来学习。

* 旧Demo ： 
    * flutter_bloc : 0.7.1
    * dart_bloc : 0.11.1
* 新Demo
    * flutter_bloc : 0.19.1
    * dart_bloc : 0.14.4


备注：新版的变化
* dart_bloc 基本没变化
* flutter_bloc
借助：provider: ^3.0.0+1
更改 tree 概念改为 multi
新增 listener_provider 用于监听
新增 repository_provider
listener_provider 和 repository_provider 使用模式还是provider


### **四、使用优缺点**

优点：
1. 业务逻辑 和 UI 进行相对解耦, 便于重复应用
2. 两个库的作者迭代更新还比较快

缺点:
1. 使用StateFullWidget来对 bloc 进行释放
2. 需要编写的文件比较多


### **五、状态新推荐 provide**

推荐理由：
* 1. 背书 google
* 2. 简单简洁 
* 3. 可以和我们的mvp 同时使用 比起 bloc更加简单
* 4. 可以使用更加轻量级的 StatelessWidget

