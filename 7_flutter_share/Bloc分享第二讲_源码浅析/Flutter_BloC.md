# [TOC]
> 一个Flutter包，有助于实现 [BLoC模式](https://www.didierboelens.com/2018/08/reactive-programming---streams---bloc/)。
> 这个包是为了与 [bloc](https://pub.dev/packages/bloc) 起使用而构建的。


#### 一、源码结构

```dart
.
├── flutter_bloc.dart
└── src
    ├── bloc_builder.dart
    ├── bloc_listener.dart
    ├── bloc_provider.dart
    └── bloc_provider_tree.dar
```

#### 二、源码解读

##### 1. bloc_builder.dart

> **BlocBuilder** 是一个Flutter小部件，它需要一个 `Bloc` 和一个 `builder` 函数。 
> `BlocBuilder` 处理构建窗口小部件以响应新状态。
> `BlocBuilder` 与 `StreamBuilder` 非常相似，但它有一个更简单的API来减少所需的样板代码量。
> `builder` 函数可能会被多次调用，并且应该是一个纯函数，它返回一个小部件以响应状态。

如果要“响应”状态更改（例如导航，显示对话框等）“执行”任何操作，请参阅 **BlocListener**


```dart
BlocBuilder(
  bloc: BlocA(),
  builder: (context, state) {
    // return widget here based on BlocA's state
  }
)
```

如果你想要当构造器函数被调用时，你可以提供一个可选的过度细粒度的控制condition来BlocBuilder。
该条件采用先前的bloc状态和当前bloc状态并返回布尔值。
如果condition返回true，builder将调用，currentState并且窗口小部件将重建。
如果condition返回false，builder则不会调用，currentState也不会发生重建。

```
BlocBuilder(
  bloc: BlocA(),
  condition: (previousState, currentState) {
    // return true/false to determine whether or not
    // to rebuild the widget with currentState
  },
  builder: (context, state) {
    // return widget here based on BlocA's state
  }
)
```

##### 2.bloc_listener.dart
> BlocListener是一个Flutter小部件，它接受Bloc和BlocWidgetListener并调用listener以响应bloc中的状态更改.
> 它应该用于每个状态更改需要发生一次的功能，例如导航，显示SnackBar，显示Dialog等等...
> listener对于每个状态更改（包括initialState），只调用一次，而不像builderin BlocBuilder和is void函数。

```dart
BlocListener(
  bloc: _bloc,
  listener: (context, state) {
    if (state is Success) {
      Navigator.of(context).pushNamed('/details');
    }
  },
  child: BlocBuilder(
    bloc: _bloc,
    builder: (context, state) {
      if (state is Initial) {
        return Text('Press the Button');
      }
      if (state is Loading) {
        return CircularProgressIndicator();
      }
      if (state is Success) {
        return Text('Success');
      }
      if (state is Failure) {
        return Text('Failure');
      }
    },
  }
)
```

**BlocListenerTree** 是一个Flutter小部件，可将多个BlocListener小部件合并为一个小部件。BlocListenerTree提高了可读性并消除了嵌套多个的需要BlocListeners。通过使用BlocListenerTree我们可以从：
```
BlocListener<BlocAEvent, BlocAState>(
  bloc: BlocA(),
  listener: (BuildContext context, BlocAState state) {},
  child: BlocListener<BlocBEvent, BlocBState>(
    bloc: BlocB(),
    listener: (BuildContext context, BlocBState state) {},
    child: BlocListener<BlocCEvent, BlocCState>(
      bloc: BlocC(),
      listener: (BuildContext context, BlocCState state) {},
      child: ChildA(),
    ),
  ),
)
```

到：

```
BlocListenerTree(
  blocListeners: [
    BlocListener<BlocAEvent, BlocAState>(
      bloc: BlocA(),
      listener: (BuildContext context, BlocAState state) {},
    ),
    BlocListener<BlocBEvent, BlocBState>(
      bloc: BlocB(),
      listener: (BuildContext context, BlocBState state) {},
    ),
    BlocListener<BlocCEvent, BlocCState>(
      bloc: BlocC(),
      listener: (BuildContext context, BlocCState state) {},
    ),
  ],
  child: ChildA(),
)
```

##### 3.bloc_provider.dart

> **BlocProvider** 是一个Flutter小部件
> 它通过BlocProvider.of <T>（context）为其子节点提供一个集合。
> 它用作DI小部件，以便可以向子树内的多个小部件提供单个bloc实例。

```dart
BlocProvider(
  bloc: BlocA(),
  child: ChildA(),
);
```
然后从ChildA我们可以检索BlocA：

```dart
BlocProvider.of<BlocA>(context)
```

##### 4.bloc_provider_tree.dar

> BlocProviderTree是一个Flutter小部件
> 可将多个BlocProvider小部件合并为一个小部件。
> BlocProviderTree提高了可读性并消除了嵌套多个的需要BlocProviders。
> 通过使用BlocProviderTree我们可以从
```dart
BlocProvider<BlocA>(
   bloc: BlocA(),
   child: BlocProvider<BlocB>(
     bloc: BlocB(),
     child: BlocProvider<BlocC>(
       value: BlocC(),
       child: ChildA(),
     )
   )
 )
```
到
```dart
BlocProviderTree(
  blocProviders: [
    BlocProvider<BlocA>(bloc: BlocA()),
    BlocProvider<BlocB>(bloc: BlocB()),
    BlocProvider<BlocC>(bloc: BlocC()),
  ],
  child: ChildA(),
)
```

参考链接： 
[flutter_bloc](https://pub.dartlang.org/packages/flutter_bloc#-readme-tab-)