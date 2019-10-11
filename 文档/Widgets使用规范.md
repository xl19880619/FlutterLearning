# Widgets使用规范
## 1.Container
### 构造函数
```
Container({

    //Container唯一标识符，用于查找更新。
    Key key,

    //控制child的对齐方式，如果container或者container父节点尺寸大于child的尺寸，这个属性设置会起作用，有很多种对齐方式。
    this.alignment,

    //decoration内部的空白区域，如果有child的话，child位于padding内部。padding与margin的不同之处在于，padding是包含在content内，而margin则是外部边界，设置点击事件的话，padding区域会响应，而margin区域不会响应。
    this.padding,

    //用来设置container背景色，如果foregroundDecoration设置的话，可能会遮盖color效果。
    Color color,

    //绘制在child后面的装饰，设置了decoration的话，就不能设置color属性，否则会报错，此时应该在decoration中进行颜色的设置。
    Decoration decoration,

    //绘制在child前面的装饰。
    this.foregroundDecoration,

    //container的宽度，设置为double.infinity可以强制在宽度上撑满，不设置，则根据child和父节点两者一起布局。s
    double width,

    //container的高度，设置为double.infinity可以强制在高度上撑满。
    double height,

    //添加到child上额外的约束条件。
    BoxConstraints constraints,

    //围绕在decoration和child之外的空白区域，不属于内容区域。
    this.margin,

    //设置container的变换矩阵，类型为Matrix4。
    this.transform,

    //container中的内容widget。
    this.child,
  })
```
### 布局行为：
* Container在没有子节点（children）的时候，会试图去变得足够大。除非constraints是unbounded限制，在这种情况下，Container会试图去变得足够小。
* 带子节点的Container，会根据子节点尺寸调节自身尺寸，但是Container构造器中如果包含了width、height以及constraints，则会按照构造器中的参数来进行尺寸的调节。
## 2.Padding
### 构造函数
```
const Padding({

    Key key,

    //一般都是使用EdgeInsets
    @required this.padding,

    Widget child,
  })
```
### 布局行为：
* 当child为空的时候，会产生一个宽为left+right，高为top+bottom的区域；
* 当child不为空的时候，Padding会将布局约束传递给child，根据设置的padding属性，缩小child的布局尺寸。然后Padding将自己调整到child设置了padding属性的尺寸，在child周围创建空白区域。
## 3.Align
### 构造函数
```
const Align({
    Key key,
    //Alignment实际上是包含了两个属性的，其中第一个参数，-1.0是左边对齐，1.0是右边对齐，第二个参数，-1.0是顶部对齐，1.0是底部对齐。
    this.alignment: Alignment.center,
    //宽度因子，如果设置的话，Align的宽度就是child的宽度乘以这个值，不能为负数。
    this.widthFactor,
    //高度因子，如果设置的话，Align的高度就是child的高度乘以这个值，不能为负数。
    this.heightFactor,
    Widget child
  })
```
## 4.Center
Center继承自Align，只不过是将alignment设置为Alignment.center。
## 5.FittedBox
### 构造函数
```
const FittedBox({

    Key key,

    //缩放的方式，
    //BoxFit.contain:类似于centerInside
    //BoxFit.cover:类似于centerCrop
    this.fit: BoxFit.contain,

    this.alignment: Alignment.center,

    Widget child,
})
```
## 6.AspectRatio
### 构造函数
```
const AspectRatio({
    Key key,
    //aspectRatio是宽高比，最终可能不会根据这个值去布局，具体则要看综合因素，外层是否允许按照这种比率进行布局，只是一个参考值
    @required this.aspectRatio,
    Widget child
})
```
## 7.ConstrainedBox
### 构造函数
```
const ConstrainedBox({

    Key key,

    //添加到child上的额外限制条件，其类型为BoxConstraints。BoxConstraints的作用是干啥的呢？其实很简单，就是限制各种最大最小宽高。说到这里插一句，double.infinity在widget布局的时候是合法的，也就说，例如想最大的扩展宽度，可以将宽度值设为double.infinity。
    @required this.constraints,

    Widget child
})
```
## 8.Row
### 构造函数
```
const Row({
    Key key,
    //主轴方向上的对齐方式，会对child的位置起作用，默认是start。
    //center：将children放置在主轴的中心；
    //end：将children放置在主轴的末尾；
    //spaceAround：将主轴方向上的空白区域均分，使得children之间的空白区域相等，但是首尾child的空白区域为1/2；
    //spaceBetween：将主轴方向上的空白区域均分，使得children之间的空白区域相等，首尾child都靠近首尾，没有间隙；
    //spaceEvenly：将主轴方向上的空白区域均分，使得children之间的空白区域相等，包括首尾child；
    //start：将children放置在主轴的起点；
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection textDirection,
    //定义了children摆放顺序，默认是down
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline textBaseline,
    List<Widget> children = const <Widget>[],
})
```
## 9.Image
### 构造函数
```
const Image({
    Key key,
    @required ImageProvider image,
    double width,
    double height,

    //color和colorBlendMode一般配合使用，BlendMode, 为混合模式的意思，包含如下诸多模式。感觉和Android中Xfermode是一个原理。
    Color color,
    BlendMode colorBlendMode,
    //填充模式
    BoxFit fit,
    AlignmentGeometry alignment: Alignment.center,
    ImageRepeat repeat: ImageRepeat.noRepeat,

    //enterSlice定义的矩形区域会被拉伸，可以理解成我们在图片内部定义来一个点9文件用作拉伸。
    Rect centerSlice,

    bool matchTextDirection: false,
    //当ImageProvider发生变化后，重新加载图片的过程中，原图片的展示是否保留。若值为true，保留，若为false，不保留，直接空白等待下一张图片加载
    bool gaplessPlayback: false
})
```
## 10.Text
### 构造函数
```
const Text(
    //文字内容
    String data, {
    Key key,
    TextStyle style,
    TextAlign textAlign,
    TextDirection textDirection,
    //是否自动换行，若为false，文字将不考虑容器大小，单行显示，超出屏幕部分将默认截断处理
    bool softWrap,
    //当文字超出屏幕的时候，如何处理,TextOverflow.clip(裁剪),TextOverflow.fade(渐隐),TextOverflow.ellipsis(省略号)
    TextOverflow overflow,
    //字体显示倍率，上面的例子使用的字体大小是40.0，将字体设置成20.0，然后倍率为2，依然可以实现相同的效果
    double textScaleFactor,
    int maxLines
})
```
## 11.Button
### 常用Button包括RaisedButton,FloatingActionButton,FlatButton,IconButton,PopupMenuButton
### 构造函数
```
const RaisedButton({
    Key key,
    @required VoidCallback onPressed,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    double elevation: 2.0,
    double highlightElevation: 8.0,
    double disabledElevation: 0.0,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Duration animationDuration: kThemeChangeDuration,
    Widget child
})
```
## 12.TextFormField
### 构造函数
```
TextFormField({
    Key key,
    TextEditingController controller,
    String initialValue,
    FocusNode focusNode,
    InputDecoration decoration: const InputDecoration(),
    TextInputType keyboardType: TextInputType.text,
    TextStyle style,
    TextAlign textAlign: TextAlign.start,
    bool autofocus: false,
    bool obscureText: false,
    bool autocorrect: true,
    //是否自动校验
    bool autovalidate: false,
    bool maxLengthEnforced: true,
    int maxLines: 1,
    int maxLength,
    ValueChanged<String> onFieldSubmitted,
    //点击完成
    FormFieldSetter<String> onSaved,
    //校验器
    FormFieldValidator<String> validator,
    List<TextInputFormatter> inputFormatters,
    bool enabled
})
```
## 13.AnimatedCrossFade
### 构造函数
```
const AnimatedCrossFade({
    Key key,
    //第一个动画
    @required Widget firstChild,
    //第二个动画
    @required Widget secondChild,
    Curve firstCurve: Curves.linear,
    Curve secondCurve: Curves.linear,
    Curve sizeCurve: Curves.linear,
    AlignmentGeometry alignment: Alignment.topCenter,
    //交叉动画状态
    @required CrossFadeState crossFadeState,
    //动画耗时
    @required Duration duration,
    AnimatedCrossFadeBuilder layoutBuilder: defaultLayoutBuilder
})
```
## 14.Animate
### Animation使用
```
animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
animation = Tween(begin: 50.0, end: 200.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
      });
animationController.forward();
```
### AnimatedWidget使用
```
class AnimatedContainer extends AnimatedWidget {

  AnimatedContainer({Key key, Animation<double> animation})
      : super (key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.redAccent
        ),
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
      ),
    );
  }
}
```
### AnimatedBuilder使用
```
body: Center(
      child: AnimatedBuilder(
        animation: animation,
        child: Container(
          decoration: BoxDecoration(color: Colors.redAccent),
        ),
        builder: (context, child) {
          return Container(
            width: animation.value,
            height: animation.value,
            child: child,
          );
        },
      ),
    ),
```
## 15.GestureDetector
### GestureDetector的使用
```
new GestureDetector(
  onTap: () {
    setState(() { _lights = true; });
  },
  child: new Container(
    color: Colors.yellow,
    child: new Text('TURN LIGHTS ON'),
  ),
)
```
## 16.Navigator
### Navigator的使用
```
void main() {
  runApp(new MaterialApp(
    home: new MyAppHome(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/a': (BuildContext context) => new MyPage(title: 'page A'),
      '/b': (BuildContext context) => new MyPage(title: 'page B'),
      '/c': (BuildContext context) => new MyPage(title: 'page C'),
    },
  ));
}
Navigator.pushNamed(context, '/b');
```
## 17.Transform
### 构造函数
```
const Transform({
    Key key,
    @required Matrix4 transform,
    Offset origin,
    AlignmentGeometry alignment,
    bool transformHitTests: true,
    Widget child
})
```