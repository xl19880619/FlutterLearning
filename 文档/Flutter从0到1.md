# Flutter从0到1
## 一、Flutter简介
Flutter is ==Google==’s mobile app ==SDK== for crafting ==high-quality== native interfaces on ==iOS== and ==Android== in record time. Flutter works with ==existing code==, is used by developers and organizations around the world, and is free and ==open source==.
## 二、Flutter架构
![image1](http://pactji2yy.bkt.clouddn.com/image1.png)
- Framework的最底层叫做Foundation，其中定义的大都是非常基础的、提供给其他所有层使用的工具类和方法。
- Animation是动画相关的类，提供了类似Android系统的ValueAnimator的功能，并且提供了丰富的内置插值器。
- Painting封装了Flutter Engine提供的绘制接口，主要是为了在绘制控件等固定样式的图形时提供更直观、更方便的接口，比如绘制缩放后的位图、绘制文本、插值生成阴影以及在盒子周围绘制边框等等。
- Gesture提供了手势识别相关的功能，包括触摸事件类定义和多种内置的手势识别器。
- Flutter的控件树在实际显示时会转换成对应的渲染对象（RenderObject）树来实现布局和绘制操作。
- Flutter的控件库提供了非常丰富的控件，包括最基本的文本、图片、容器、输入框和动画等等。在Flutter中“一切皆是控件”，通过组合、嵌套不同类型的控件，就可以构建出任意功能、任意复杂度的界面。
- Flutter本身支持Android和iOS两个平台，除了性能和开发语言上的“native”化之外，它还提供了两套设计语言的控件实现Material & Cupertino，可以帮助App更好地在不同平台上提供原生的用户体验。

## 三、Flutter的优点

![image1](http://pactji2yy.bkt.clouddn.com/image2.png)
- 强类型：包含了生产力，但不强制写数据类型
- 跨平台：支持Android，IOS
- JIT,AOT：debug模式下JIT，支持HotReload；Release模式下支持AOT，编译阶段直接转成机器码。
- 底层库：有网络，io，图片等库
- Tree Shaking：为减少release包大小将无用代码删掉
- 半空间GC：方便内存快速回收

## 四、Dart语言介绍

- Dart是同时非常适合AOT编译和JIT编译的少数语言之一。支持这两种编译方式为Dart和（特别是）Flutter提供了显著的优势。JIT编译在开发过程中使用，编译器速度特别快。然后，当一个应用程序准备发布时，它被AOT编译。因此，借助先进的工具和编译器，Dart具有两全其美的优势：极快的开发周期、快速的执行速度和极短启动时间。
- AOT编译代码还有一个更大的优势，那就是避免了“JavaScript桥梁”。当动态语言（如JavaScript）需要与平台上的本地代码互操作时，它们必须通过桥进行通信，这会导致上下文切换，从而必须保存特别多的状态（可能会存储到辅助存储）。这些上下文切换具有双重打击，因为它们不仅会减慢速度，还会导致严重的卡顿。
- Dart可以更轻松地创建以60fps运行的流畅动画和转场。Dart可以在没有锁的情况下进行对象分配和垃圾回收。就像JavaScript一样，Dart避免了抢占式调度和共享内存（因而也不需要锁）。由于Flutter应用程序被编译为本地代码，因此它们不需要在领域之间建立缓慢的桥梁（例如，JavaScript到本地代码）。它的启动速度也快得多。
- Dart使Flutter不需要单独的声明式布局语言，如JSX或XML，或单独的可视化界面构建器，因为Dart的声明式编程布局易于阅读和可视化。所有的布局使用一种语言，聚集在一处，Flutter很容易提供高级工具，使布局更简单。

## 五、Flutter和原有框架对比

![image1](http://pactji2yy.bkt.clouddn.com/image3.png)

### 1.Flutter VS Native

#### (1)包大小比较。条件：只做了很简单的界面
Native:
![image1](http://pactji2yy.bkt.clouddn.com/image4.png)
Flutter:
![image1](http://pactji2yy.bkt.clouddn.com/image5.png)

##### (2)运行性能测试比较。条件：用 ListView 展示10000条数据
Native:
![image1](http://pactji2yy.bkt.clouddn.com/image6.png)
Flutter:
![image1](http://pactji2yy.bkt.clouddn.com/image7.png)
- CPU资源占用 首先，我们看 CPU 的占用，正常情况下，两者都没有占用多少 CPU 资源，当我滑动 listview 的时候，原生的大约会占用最高 7.7% 的 CPU 资源，而 flutter 版的则占用高一些，峰值大概在 18.8%。
- 内存占用 原生的app内存占用维持在 12M 左右，而 flutter 版的则维持在 21M 左右，原生应用比 flutter 大约低了 9M 的内存占用。
- 从上边两种模式的性能检测结果分析我们可以总结出，flutter 应用在 CPU 和内存的资源占用上会比原生方式多一些，所以单纯的从性能上来说，android 原生是肯定要优于 flutter 的，但是从用户体验上来说，两者的滑动同样顺畅无比，几乎感觉不到差别。

#### (3)FPS比较。条件：用ListView展示10000条数据
![image1](http://pactji2yy.bkt.clouddn.com/image8.png)
测试手机是小米Note 2，高通骁龙821处理器 4G 内存，性能大概属于 Android 阵营中上等。打开 app 后先是平稳的滑动 listview，然后又快速的滑动，由图可看出，刷新率起初恒定在 60fps，当快速滑动的时候，刷新率大约保持在58~59 之间，所以 flutter 官方所说 fps 恒定在 60fps 还是可信的。
### 2.Flutter VS RN
#### (1)底层架构的比较
RN
![image1](http://pactji2yy.bkt.clouddn.com/image9.png)

Flutter
![image1](http://pactji2yy.bkt.clouddn.com/image10.png)
- ReactNative、Weex 核心是通过 Javascript 开发，执行时需要 Javascript 解释器，UI 是通过原生控件渲染。Flutter 与用于构建移动应用程序的其它大多数框架不同，因为 Flutter 既不使用 WebView，也不使用操作系统的原生控件。 相反，Flutter 使用自己的高性能渲染引擎来绘 制 widget。Flutter 使用 C、C ++、Dart 和 Skia（2D渲染引擎）构建。
- 在 ReactNative 中，引入了虚拟 DOM 来减少DOM的回流和重绘，系统将虚拟 DOM 与真正的 DOM 进行比较，生成一组最小的更改，然后执行这些更改，以更新真正的 DOM。最后，平台重新绘制真实的 DOM 到画布中。
- ReactNative 是移动开发的一大进步，并且是 Flutter 的灵感来源，但 Flutter 更进一步。 在 Flutter 中，UI 组件和渲染器已经从平台中集成到用户的应用程序中。没有系统 UI 组件可以操作，所以原来虚拟控件树的地方现在是真实的控件树。Flutter 渲染 UI 控件树并将其绘制到平台画布上。

#### (2)UI一致性
- Flutter 因为是自己做的渲染，因此在iOS和Android的效果基本完全一致。ReactNative存在将RN控件转换为对应平台原生控件的过程，存在一定的差异（如之前在调研里提到过的Button在iOS和Android下面显示效果不一样）。

#### (3)动态化技术
- Flutter使用的Dart语言，支持AOT和JIT两种模式，在Dev时候，通过JIT可以实现热重载，开发者可以即时的看到代码修改的效果。而在ReleaseBuild的时候，通过AOT事先编译，来最大化的优化性能。因此目前Flutter不支持代码的热更新。
ReactNative 的代码通过加载 JSBundle.js执行，JSBundle.js可以保存在本地，也可以通过远程加载。目前有很多RN的热更新方案供选择。

#### (4)App体积

- Flutter iOS空项目 30M左右，Android空项目 7M左右。 （iOS需要额外集成Skia）ReactNative iOS空项目 3M左右，Android20M左右。（Android会加入OKHttp导致体积增大）

#### (5)使用案例

- Google 的 AdWords 已经使用了Flutter进行开发。国内阿里巴巴的闲鱼 Team 已经在部分页面使用了Flutter并输出了很多相关的技术文章。
- 国外Facebook、Skype、Walmart、Uber、Instagrams国内京东、QQ、手机百度等App使用ReactNative构建。

#### (6)第三方Library数量

- Flutter 目前有1000+ library。ReactNatve 专用library有11000+ （以react-native名称开头的包），与web开发可以共用的包700000+。

## 六、Flutter渲染流程

### 1.整个渲染流程
![image1](http://pactji2yy.bkt.clouddn.com/image11.png)

### 2.布局流程
![image1](http://pactji2yy.bkt.clouddn.com/image12.png)

### 3.绘制流程
![image1](http://pactji2yy.bkt.clouddn.com/image13.png)

## 七、Flutter构建流程
### 1.Debug和Release的APK比较
![image1](http://pactji2yy.bkt.clouddn.com/image14.png)

### 2.Debug包文件内容
![image1](http://pactji2yy.bkt.clouddn.com/image15.png)

### 3.Release包文件内容
![image1](http://pactji2yy.bkt.clouddn.com/image16.png)

## 八、Flutter运行模式
### 1.Debug模式
![image1](http://pactji2yy.bkt.clouddn.com/image17.png)

### 2.Release模式
![image1](http://pactji2yy.bkt.clouddn.com/image18.png)

## 九、大厂Flutter发展情况
咸鱼
https://juejin.im/post/5b3f098ce51d45199840f4bb
https://juejin.im/post/5b5811f3e51d4519700f6979

美团
https://juejin.im/post/5b6d59476fb9a04fe91aa778

腾讯
https://juejin.im/post/5b55819ef265da0f8d36615e

## 十、Flutter预研项目介绍
* 每周一篇Flutter相关文章，按照难度由浅入深每周进行更新。
* Flutter常用控件demo，里面有常用的控件代码。
* 使用Flutter重写Xplan项目。目前已基本完成登录页、收藏列表、线索列表、我的页面，后面会根据自己的空余时间进行后续功能的补充。
### 1.项目地址
http://git.xin.com/zoudong/flutterdemo
### 2.Demo APK下载地址
https://fir.im/flutterdemo