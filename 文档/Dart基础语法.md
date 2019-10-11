# Dart基础语法
## 1.数据类型

Dart中所有东西都是对象，包括数字、函数等，它们都继承自Object，并且默认值都是null（包括数字）因此数字、字符串都可以调用各种方法，Dart中支持以下数据类型：
* Numbers
* Strings
* Booleans
* List(数组)
* Maps

变量:var
var i = 10;

常量:const和final
相同点：
const和final定义的都是常量，值不能改变，并且在声明的时候就必须初始化

不同点：
const定义的是编译时常量，只能用编译时常量来初始化
final定义的常量可以用变量来初始化

## 2.函数
```
String sayHello(String name)
{
  return 'Hello $name!';
}

```
等价于
```
sayHello(name) {
  return 'Hello $name!';
}

```
等价于
```
sayHello(name) => 'Hello $name!';
```
等价于
```
var sayHello = (name)=>'Hello$name!';
```

## 3.闭包
```
makeSubstract(num n) {
  return (num i) => n - i;
}

void main() {
  var x = makeSubstract(5);
  print(x(2));
}
```
初始化变量的时候，参数对应的是函数的参数num n，调用函数类型变量的时候，参数对应的是返回值中的参数num i，结果为3

## 4.可选参数
```
FunX(a, {b, c:3, d:4, e}) {
  print('$a $b $c $d $e');
}

void main() {
  FunX(1, b:3, d:5);
  FunY(1, 3, 5);
}
```

## 5.级联
当你要对一个单一的对象进行一系列的操作的时候，可以使用级联操作符 ..
```
class Person {
    String name;
    String country;
    void setCountry(String country){
      this.country = country;
    }
    String toString() => 'Name:$name\nCountry:$country';
}
void main() {
  Person p = new Person();
  p ..name = 'Wang'
    ..setCountry('China');
  print(p);
}
```

## 6.循环
```
var collection = [0, 1, 2];
collection.forEach((x) => print(x));
```

## 7.构造函数
如果只是简单的参数传递，可以在构造函数的参数前加this关键字定义，或者参数后加 : 再赋值
```
class Point {
    num x;
    num y;
    num z;

    Point(this.x, this.y, z) { //第一个值传递给this.x，第二个值传递给this.y
            this.z = z;
    }

    Point.fromeList(var list): //命名构造函数，格式为Class.name(var param)
            x = list[0], y = list[1], z = list[2]{//使用冒号初始化变量
    }

    //当然，上面句你也可以简写为：
    //Point.fromeList(var list):this(list[0], list[1], list[2]);
     String toString() => 'x:$x  y:$y  z:$z';
}

void main() {
    var p1 = new Point(1, 2, 3);
    var p2 = new Point.fromeList([1, 2, 3]);
    print(p1);//默认调用toString()函数
}
```

## 8.get和set
每个字段都对应一个隐式的Getter和Setter
但是调用的时候是obj.x，而不是obj.x()
```
class Rectangle {
    num left;
    num top;
    num width;
    num height;

    Rectangle(this.left, this.top, this.width, this.height);

    // right 和 bottom 两个属性的计算方法
    num get right => left + width;
    set right(num value) => left = value - width;
    num get bottom => top + height;
    set bottom(num value) => top = value - height;
}

main() {
    var rect = new Rectangle(3, 4, 20, 15);
    assert(rect.left == 3);
    rect.right = 12;
    assert(rect.left == -8);
}
```

## 9.初始化的方式
```
class Point{
    var x = 0; y = 0;
}

class Point{
    var x,y;
    Point(this.x, this.y);
}

class Point{
    var x,y;
    Point(a, b) : x = a, y = b;
}

class Point{
    var x,y;
    Point(a, b){
        x = a;
        y = b;
    }
}
```

## 10.抽象类
在Dart中类和接口是统一的，类就是接口
如果你想重写部分功能，那么你可以继承一个类
如果你想实现某些功能，那么你也可以实现一个类
使用abstract关键字来定义抽象类，并且抽象类不能被实例化
抽象方法不需要关键字，直接以分号 ; 结束即可
```
abstract class Shape { // 定义了一个 Shape 类/接口
    num perimeter(); // 这是一个抽象方法，不需要abstract关键字，是隐式接口的一部分。
}

class Rectangle implements Shape { // Rectangle 实现了 Shape 接口
    final num height, width;
    Rectangle(num this.height, num this.width);  // 紧凑的构造函数语法
    num perimeter() => 2*height + 2*width;       // 实现了 Shape 接口要求的 perimeter 方法
}

class Square extends Rectangle { // Square 继承 Rectangle
    Square(num size) : super(size, size); // 调用超类的构造函数
}
```

## 11.工厂构造函数
```
class Logger {
    final String name;
    bool mute = false;

    // 变量前加下划线表示私有属性
    static final Map<String, Logger> _cache = <String, Logger>{};

    factory Logger(String name) {
        if (_cache.containsKey(name)) {
            return _cache[name];
        } else {
            final logger = new Logger._internal(name);
            _cache[name] = logger;
            return logger;
        }
    }

    Logger._internal(this.name);

    void log(String msg) {
        if (!mute) {
            print(msg);
        }
    }
}

var logger = new Logger('UI');
logger.log('Button clicked');
```

## 12.容器
### StringBuffer
```
StringBuffer sb = new StringBuffer();
sb.write("Use a StringBuffer ");
sb.writeAll(['for ', 'efficient ', 'string ', 'creation ']);
sb..write('if you are ')..write('building lots of string.');
print(sb.toString());
sb.clear();
```

### List
```
// 使用List的构造函数，也可以添加int参数，表示List固定长度
var vegetables = new List();

// 或者简单的用List来赋值
var fruits = ['apples', 'oranges'];

// 添加元素
fruits.add('kiwis');

// 添加多个元素
fruits.addAll(['grapes', 'bananas']);

// 获取List的长度
assert(fruits.length == 5);

// 利用索引获取元素
assert(fruits[0] == 'apples');

// 查找某个元素的索引号
assert(fruits.indexOf('apples') == 0);

// 利用索引号删除某个元素
var appleIndex = fruits.indexOf('apples');
fruits.removeAt(appleIndex);
assert(fruits.length == 4);

// 删除所有的元素
fruits.clear();
assert(fruits.length == 0);

//排序
var fruits = ['bananas', 'apples', 'oranges'];

fruits.sort((a, b) => a.compareTo(b));
assert(fruits[0] == 'apples');

// 下面的List只能包含String
var fruits = new List<String>();

fruits.add('apples');
var fruit = fruits[0];
assert(fruit is String);

fruits.add(5); // 错误: 在checked mode中会抛出异常
```

### Map
```
// Map的声明
var hawaiianBeaches = {
    'oahu' : ['waikiki', 'kailua', 'waimanalo'],
    'big island' : ['wailea bay', 'pololu beach'],
    'kauai' : ['hanalei', 'poipu']
};
var searchTerms = new Map();

// 指定键值对的参数类型
var nobleGases = new Map<int, String>();

// Map的赋值，中括号中是Key，这里可不是数组
nobleGase[54] = 'dart';

//Map中的键值对是唯一的
//同Set不同，第二次输入的Key如果存在，Value会覆盖之前的数据
nobleGases[54] = 'xenon';
assert(nobleGases[54] == 'xenon');

// 检索Map是否含有某Key
assert(nobleGases.containsKey(54));

//删除某个键值对
nobleGases.remove(54);
assert(!nobleGases.containsKey(54));

var keys = hawaiianBeaches.getKeys();
assert(keys.length == 3);
assert(new Set.from(keys).contains('oahu'));

var values = hawaiianBeaches.getValues();
assert(values.length == 3);

//迭代器中有一个有意思的函数any，用来检测迭代器中的数据
//当其中一个元素运行函数时return true，那么any的返回值就为true，否则为false
//与之相对的是函数every，要所有函数运行函数return true，那么every返回true
assert(values.any((v) => v.indexOf('waikiki') != -1));

// 你可以用foreach来遍历数据，但记住它是无序的
hawaiianBeaches.forEach((k,v) {
print('I want to visit $k and swim at $v');
});

//检索是否包含某个Key或Value
assert(hawaiianBeaches.containsKey('oahu'));
assert(!hawaiianBeaches.containsKey('florida'));

//V putIfAbsent(K key, Function V ifAbsent())函数，通过Key来查找Value
//当某个Key不存在的时候，会执行第二参数的Function来添加Value
var teamAssignments = {};
teamAssignments.putIfAbsent('Catcher', () => 'Catcher'.length);
assert(teamAssignments['Catcher'] != null);
```

### 13.import
```
//dart:前缀表示Dart的标准库，如dart:io、dart:html
import 'dart:math';

//当然，你也可以用相对路径或绝对路径的dart文件来引用
import 'lib/student/student.dart';

//Pub包管理系统中有很多功能强大、实用的库，可以使用前缀 package:
import 'package:args/args.dart';
```

### 14.export
```
library math;

export 'random.dart';
export 'point.dart';
```

### 15.mixin
```
class A {
  a() {
    print("A's a()");
  }
}

class B {
  b() {
    print("B's b()");
  }
}

// 使用with关键字，表示类C是由类A和类B混合而构成
class C = A with B;

main() {
  C c = new C();
  c.a(); // A's a()
  c.b(); // B's b()
}
```