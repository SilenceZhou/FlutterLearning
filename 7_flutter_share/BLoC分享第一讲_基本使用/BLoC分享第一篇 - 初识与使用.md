

[TOC]


> **下次分享:《BLoC分享第二篇 - 第三方框架Flutter_BLoC源码分析与实战技巧》**
> 
> [**基础概念参可参考博客《Flutter-BLoC-第一讲》**](https://juejin.im/post/5ca396b5518825440563e0f5#heading-16)


### 一、BLoC有什么优势或作用？（结论先行吧😆）

> **优势**
> 
> * **责任分离 (解耦)**
> 
>  `UI表现层` 与 `业务逻辑层` 进行分离操作, 表现层只需要关注自己的UI展示，业务逻辑层由BLoC来进行封装. 方便后续业务的变更与重构。
>.  
>  * **可测试性**
>  
>  测试业务逻辑变得更加容易。无需再通过用户界面测试业务逻辑。只需要测试子类化的Bloc类。
>.
> * **自由组织布局**
> 
> 由于使用了Streams，你现在可以独立于业务逻辑组织布局。
>.
> * **减少 `build` 的次数**
> 
> 不使用 `setState()` , 而是使用 **StreamBuilder** 或 **BlocBuilder** 会大大减少了 `build` 的次数，只更新指定的widget。
> 性能提升：由于减少了UI的刷新和计算的次数


### 二、学习BLoC需什么基础概念？

> Stream、RxDart、Reactive Programming

#### 1、Stream

##### 1.1. **Stream**  

> Stream为直译为流，可以理解为管道, 一端流进(event)一端流出(state).
> Stream 并不是 Flutter 中特有的，而是 Dart 中自带的逻辑。


> 在 Flutter 中，状态管理除了 InheritedWidget 之外，无论 rxdart，Bloc 模式，flutter_redux ，fish_redux 都离不开 Stream 的封装.


##### 1.2. Stream中的概念
整个 Stream 设计外部暴露的对象主要如下图，主要包含了 StreamController 、Sink 、Stream 、StreamSubscription 四个对象。
> StreamController ： 管理stream
> StreamSink ：作为stream(事件)的入口
> Stream ： 用于对象的监听(流入的为事件，流出的为state)
> StreamSubscription ： 管理事件订阅




##### 1.4. Stream的类型

> 在BLoC模式中我们会广播流

**单订阅流（Stream）** 
> 这种类型的Stream只允许在该Stream的整个生命周期内使用单个监听器。
> `即在第一个订阅被取消后，也无法在此类流上收听两次。`

**广播流（Stream）** 
> 允许任意数量的监听器。
> `可以随时向广播流添加监听器。新的监听器将在它开始收听Stream时收到事件。`


#### 2.RxDart

PublishSubject、BehaviorSubject、ReplaySubject 都是一个广播StreamController，它返回一个Observable，而不是Stream。

区别：

> **PublishSubject**
> 
> 仅向监听器发送在订阅之后添加到Stream的事件。
> 
> **BehaviorSubject**
> 
> 在PublishSubject基础上，还将最后发送的事件发送给刚刚订阅的监听器。
> 
> **ReplaySubject**
> 
> 将Stream已经发出的所有事件作为第一个事件发送给任何新的监听器。
> 



#### 3.Reactive Programming(响应式编程)

##### 3.1.维基百科定义

> 响应式编程或反应式编程（英语：Reactive programming）
> 
> 是一种面向 **数据流** 和 **变化传播** 的编程范式。 这意味着可以在编程语言中很方便地表达静态或动态的数据流，而相关的计算模型会自动将变化的值通过数据流进行传播。

##### 3.2. 应用反应式编程, 程序的特征

> * 变的异步
> * 围绕Streams和listeners的概念进行架构
> * 当某事在某处发生时（事件，变量的变化......），会向Stream发送通知
> * 如果 "某人" 监听该流（无论其在应用程序中的任何位置），它将被通知并将采取适当的行动.


### 三、BLoC

#### 1. BLoC背景
> BLoC模式由Paolo Soares 和 Cong Hui设计，并谷歌在2018的 DartConf 首次提出，可以在  [YouTube](https://www.youtube.com/watch?v=PLHln7wHgPE) 上观看。

#### 2. 定义
> BLoC表示为业务逻辑组件 (Business Logic Component)


#### 3.使用BLoC需要的操作

> * 将 **业务逻辑转(Business Logic)** 移到一个或几个BLoC
> 
> * 尽可能把 **业务逻辑转(Business Logic)** 从UI表现层删除，换句话说，UI组件应该只关心UI事物而不关心业务
> 
> * 依赖 Streams 独家使用输入（Sink）和输出（stream）
> * 保持平台独立，
> * 保持环境独立。

事实上，BLoC模式最初被设想为允许独立于平台重用相同的代码：Web应用程序，移动应用程序，后端。


#### 4.设计理念

> BLoC模式是利用我们刚才上面所讨论的观念:  Streams(流),围绕这个stream来进行架构
> 
> 设计理念用下图展示:

![image.png](https://upload-images.jianshu.io/upload_images/699599-2924b4cd35807a27.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


> * Widgets 通过 Sinks 向 BLoC 发送事件(event)
> * BLoC 通过流(stream)通知小部件(widgets)
> * 由BLoC实现的业务逻辑不是UI层关注的问题。

#### 5.简单应用 


##### 5.1. **对官方示例Counter的改造**

**详细Demo如下链接**
> * [bloc_manual]()
> 
>  初始版本中的provider(时间复杂度为O(n))
> 
> * [bloc_manual_upgrade]()
> 升级本中的provider(时间复杂度为O(1), 即在原来 `StatefulWidget` 的 `child` 外面再包了一个 InheritedWidget)

##### 5.2. 类的说明

> **子类化的BLoC**
> 需要Event流(stream)的作为输入，并将其变换成State流(Stream)作为输出。
> bloc.dart为BLoC框架的核心文件，主要是对Stream的一系列封装
> 
> **BlocProvider**
> 通过BlocProvider.of <T>（context）为其子节点提供一个集合。
> 用作DI小部件，以便可以向子树内的多个小部件提供单个bloc实例。



##### 5.3. BLoC使用场景


> * **应用中任何地方可用:**
> 
>   用户的鉴权(登陆注册)、用户的设置、添加删除购物车商品等 用户交互操作(或者说：数据或状态变更的相关操作)，都可以用BLoC把业务逻辑封装起来。
>   
> * **在子视图树(多个页面或组件)中可用**
> 
>   大多数时候，我们只需要在应用的部分页面/组件树中使用 BLoC。
> 
> * 单一组件中可用
>  如果只在某一个组件(Widget)中使用 BLoC，只需要在该组件内构建 BLoC 实例即可



**在子视图树(多个页面或组件)中可用** 示例如下
```dart
class MyTree extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return BlocProvider<MyBloc>(
      bloc: MyBloc(),
      child: Column(
        children: <Widget>[
          MyChildWidget(),
        ],
      ),
    );
  }
}

class MyChildWidget extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    MyBloc = BlocProvider.of<MyBloc>(context);
    return Container();
  }
}
```

每次 MyTree 重构(rebuild)时都会重新初始化 BLoC ,但是样会有如下问题：
> 丢失 BLoC 中已经存在的数据内容
> 重新初始化BLoC 要占用 CPU 时间

解决这个问题可以使用StatefulWidget，利用其持久化 State 的特性解决上述问题



##### 5.4. BLoC的使用方案

> 实际开发中可以自行选择合适的： `全局单列` 或 `注入视图顶层方案`


###### 5.4.1 全局单例

> 这种方案使用了一个不在Widget视图树中的 Global 对象，实例化后可用供所有 Widget 使用。



```dart
import 'package:rxdart/rxdart.dart';

class GlobalBloc {
  ///
  /// Streams related to this BLoC
  ///
  BehaviorSubject<String> _controller = BehaviorSubject<String>();
  Function(String) get push => _controller.sink.add;
  Stream<String> get stream => _controller;

  ///
  /// Singleton factory
  ///
  static final GlobalBloc _bloc = new GlobalBloc._internal();
  factory GlobalBloc(){
    return _bloc;
  }
  GlobalBloc._internal();
  
  ///
  /// Resource disposal
  ///
  void dispose(){
    _controller?.close();
}

GlobalBloc globalBloc = GlobalBloc();
```

要使用全局单例 BLoC，只需要 import 后调用定义好的方法即可：

```dart
import 'global_bloc.dart';

class MyWidget extends StatelessWidget {
    @override
    Widget build(BuildContext context){
        globalBloc.push('building MyWidget'); //调用 push 方法添加数据 
        return Container();
    }
}
```


**使用总结：**
> 简单易用
> 不依赖任何 BuildContext
> 当然也不需要通过 context 查找 BlocProvider 的方式来获取 BLoC
> 释放资源也很简单，只需将 application Widget 基于 StatefulWidget 实现，然后重写其 dispose() 方法，在 dispose() 中调用 globalBloc.dispose() 即可


###### 5.4.2. 注入到视图树顶层

> 实现方案：将 BlocProvider 作为 MaterialApp 的父级才能实现在应用中任何位置都可使用 BLoC

```dart
void main() => runApp(Application());

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: AuthenticationBloc(),
      child: MaterialApp(
        title: 'BLoC Samples',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InitializationPage(),
      ),
    );
  }
}
```

在针对实际场景中的情况，如果用上面的 写法可能稍显复杂，如果你想 深入了解是如何实现的推荐看下这篇文章[事件与状态管理(Event - State)](https://www.jianshu.com/p/83232e728d4a).


如何简复杂写法请参考第四模块


### 四、Flutter_bloc框架介绍与使用

##### 1.概述
第三方框架为：[Flutter_bloc](https://pub.dartlang.org/packages/flutter_bloc)

简单介绍可以参考一下我的这边博客 [Flutter_bloc第三讲](https://www.jianshu.com/p/e31e8268d2cd)


##### 2.使用Flutter_bloc的便利之处

> Flutter_bloc把BLoC的核心逻辑进行了分装，按照作者提供的示例模式来进行编码，简化逻辑，让编码更加规范。



##### 3.拿到一个业务需求，利用Flutter_bloc来进行规范化BLoC编码个人推荐方案：

> * **分析业务的操作**
>   定义事件Event, 编写Event.dart
>  
> * **分析业务操作相关的状态** 
>  定义好state, 编写state.dart
> 
> * **把业务操作 和 相关状态进行关联**
>  定义子类化的BLoC.dart文件关键为重写mapEventToState
>  
> * **然后在合适的widget上用BlocProvider进行注入**
> 
> 这就可以在其相应的用BlocBuilder包裹的子widget里通过 `BlocProvider.of<子类Bloc>(context)` 来获取 `子类Bloc`, 来进行数据交互操作



##### 4.来看实操示例

> **counter** : 官方、stream、简单的模板BLoC、第三方flutter_bloc
> **inifinite list** : 无限列表
> **login logic** : 登陆逻辑相关








