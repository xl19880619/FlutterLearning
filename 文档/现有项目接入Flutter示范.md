# 现有项目接入Flutter示范
## 1.这里以Android项目为例，在你的Android工程目录同级目录下执行命令
```
flutter create -t module my_flutter
```
module可以根据项目自定义，我这里取名my_flutter
## 2.打开你的Android工程的setting.gradle文件，行起一行，加上：
```
setBinding(new Binding([gradle: this]))                        
evaluate(new File(                                                     
        settingsDir.parentFile,                                               
        '\\TestFlutter\\my_flutter\\.android\\include_flutter.groovy'                        
))
```
注意：include_flutter.groovy的路径地址在windows和mac的写法有区别。一个是\\\一个是/，添加完同步后如果提示文件找不到多半是路径问题，检查下路径即可解决。
## 3.最后打开你的app目录下的build.gradle，在依赖中加上:
```
implementation project(':flutter')
```
同步后无报错即现有项目接入Flutter成功。
## 4.原生模块使用Flutter模块有两种方式:
* 直接createView创造一个flutterView，把他添加到你的布局中
* 使用fragment的方式
```
public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        initView();
        initView1();
    }

    //方式一
    private void initView() {
        View flutterView = Flutter.createView(MainActivity.this, getLifecycle(), "route1");
        FrameLayout.LayoutParams layout = new FrameLayout.LayoutParams(600, 800);
        layout.leftMargin = 100;
        layout.topMargin = 200;
        addContentView(flutterView, layout);
    }

    //方式二
    private void initView1() {
        FragmentTransaction tx = getSupportFragmentManager().beginTransaction();
        tx.replace(R.id.container, Flutter.createFragment("route1"));
        tx.commit();
    }

}

```
以上就是两种元素模块应用flutter模块的方式，实际都是一种而已，都是通过Flutter.createView添加了一个FlutterView到原生中而已，通过源码，发现FlutterView实际上是SurfaceView而已，只不过实现了一个特殊的接口BinaryMessenger。