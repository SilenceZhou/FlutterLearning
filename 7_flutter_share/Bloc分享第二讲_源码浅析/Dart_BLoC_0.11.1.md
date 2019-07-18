# > 一个有助于实现[BLoC模式](https://www.didierboelens.com/2018/08/reactive-programming---streams---bloc/)的 dart包。
> 此包用于处理flutter_bloc和angular_bloc。


[toc]
#### 一、源码结构

[dart_bloc_0.11.1]()
```dart
├── bloc.dart 
└── src
    ├── bloc.dart
    ├── bloc_delegate.dart
    ├── bloc_supervisor.dart
    └── transition.dart
```

#### 二、源码解读

##### 1、bloc.dart

> 需要Event流(stream)的作为输入，并将其变换成State流(Stream)作为输出。
> bloc.dart为BLoC框架的核心文件，主要是对Stream的一系列封装

我们来看下该文件下的方法和属性：

![4635991b77196b7916876d9cbd094df5.png](evernotecid://0EDB46F3-902C-4651-9B97-77A82F9248E3/appyinxiangcom/4405394/ENResource/p1028)

**a 内部私有属性和方法详解如下：**

> **_bindStateSubject** 状态绑定, 这个为关键方法，在其内部进行了：
> * mapEventToState
> * 错误转发
> * onTransition 代理方法截取
> * onTransition(transition) 方法调用
> * _stateSubject.add 发送数据


> **_handleError** 错误处理，在其内部进行的操作为:
> * 把错误信息与堆栈转发给 onError(子类重写)
> * 把错误信息与堆栈转发给代理
> BlocSupervisor().delegate?.onError(error, stacktrace);

> **_eventSubject** : PublishSubject是广播（又称热门）控制器，以便履行Rx主题合同。 这意味着可以多次收听主题的“流”。

> **_stateSubject** : 状态流控制器

**关键方法与属性的详解如下：**


> **Bloc()** : 抽象构造方法，内部进行的操作为：
> * 初始化_stateSubject控制器
> * 状态绑定:_bindStateSubject();

> **initialtate** 是处理任何事件之前的状态（在mapEventToState调用之前）。
> `initialState 必须赋值`

> **mapEventToState** 是类扩展时必须实现的方法Bloc。该函数将传入事件作为参数。mapEventToState每当事件是dispatched由表示层时调用。mapEventToState必须将该事件转换为新状态，并Stream以表示层使用的形式返回新状态。

> **dispatch** 是一个接受event和触发的方法mapEventToState。dispatch可以从表示层或从Bloc内部调用（参见示例）并通知Bloc一个新的event。

> **transform** 是一种Stream<Event>将next函数转换为函数的方法Stream<State>。需要处理的事件mapEventToState需要传递给next。默认情况下asyncExpand，用于确保按接收顺序处理所有事件。您可以覆盖transform高级用法，以便操纵mapEventToState调用的频率和特异性以及处理哪些事件。


> **onTransition** 是一种可以被覆盖的方法，以便在Transition发生时进行处理。调度Transitionnew Event并mapEventToState调用new时会发生A. onTransition在Bloc状态更新之前调用。
> `添加特定BLoC的日志记录/分析的地方`


> **onError** 是一种方法，可以在被Exception抛出时重写以处理。默认情况下，将忽略所有异常，并且Bloc功能不受影响。
> `添加特定BLoC的错误处理的地方。`


##### 2、bloc_delegate.dart
> 处理来自所有[Bloc]的事件, 由 `BlocSupervisor` 进行委托。

> 前提：BlocSupervisor().delegate = SimpleBlocDelegate();
> SimpleBlocDelegate为BlocDelegate的子类


> 添加全局通用日志记录/分析的地方。
> onTransition 在任何[Bloc]中使用给定[Transition]发生转换时调用。当 新的[Event]被分发(dispatched)并且执行 `mapEventToState` 时发生 转换 [Transition]。 `onTransition`在[Bloc]的状态更新之前被调用。

> 添加全局通用错误处理的好地方。
onError无论何时在任何一个bloc中的mapEventToState 抛出 Exception，onError都会被调用。
> 如果状态流在没有[StackTrace]的情况下收到错误，则stacktrace参数可以是“null”。 添加通用错误处理的好地方。

```dart
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}
```

##### 3、bloc_supervisor.dart
> 监督所有[Bloc] 并 将责任委托给[BlocDelegate]。

##### 4、transition.dart
> 当 event 被分发(dispatched) 后，但在[Bloc]的[State]更新之前调度[Event]时发生。
> 转换（Transition）由currentState、已分派的事件(event)和 nextState组成。



#### 三、自己的解读与总结


---
参考链接： 
[flutter_bloc](https://pub.dartlang.org/packages/bloc#-readme-tab-)