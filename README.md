# App-Architecture-Swift
Some simple projects to show how app architecture work in swift.

## MVC

Controller 拥有对 Model 和 View 的强引用，反之没有。
Controller 在初始化的时候应该设置 Model 的默认值并对它进行观察（Notification、KVO)
View 可以通过 target-action、delegate、datasource 把状态数据返回给 Controller
Model 中可以在属性的设置方法中添加发送通知的操作

## MVP
本质是避免将 Controller 的逻辑与 View 的实现耦合在一起，把部分逻辑提取到一个 ViewPresenter 对象中。这个对象只通过协议和 View 进行通信。
好处是逻辑在单独分离层中执行，Controller 变得更加干净；测试的时候只需要实例化协议对象，而不是整个 Controller。
* ViewProtocol 代表的是 View，从数据层面看，是需要与 Model 有交互的 View 的属性。
* ViewPresenter 拥有 Model 的强引用和对协议的弱引用。在这个类中需要完成的事包括把 Model 的值传递给 View，并进行观察；根据 View 的属性更新 Model。
## 极简MVVM
基本逻辑与前两者差不多，为 Model 设置初始值，观察它，根据 View 更新 Model。这个模式与 MVP 的区别是没有对 View 的弱引用，而是通过 KVO 观察属性的改变把数据传递给 View。
## MVVM
使用响应式编程框架实现。响应式编程是一种用来描述数据源和数据消费端之间数据流动的模式，它将这种流动描述为一个变形管道。数据被看作一个在管道中流动的序列，我们使用像是 map，filter 和 flatMap 这样的和 Swift 序列或者集合中函数名字相近的函数，来对数据进行变形。
* ViewModel 中对需要暴露出来的属性进行响应式编程。从信号开始，把通知转化为信号，然后对信号进行变形，然后捕获。
* ViewController 中把信号绑定到视图的属性中。
## MVC + ViewState
这个模式关键在于确保 action 所需要的状态已经从 view 中剥离出来。所以在任何时候都不依靠 view 存储数据。 view 发生变化时，会改变 ViewState，ViewState 必须是全局的。Model 必须从 ViewState 获取数据。