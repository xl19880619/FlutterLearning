# Flutter性能分析

下面将从包大小,CPU,内存,FPS角度分析Flutter APK和Native APK之间的性能差异。这里由于没有Root手机，Flutter APK大部分测试环境是在Profiler运行模式下用AS自带的Profiler进行测试。使用的测试机是坚果Pro2S。Native和Flutter App的样式分别如下，都是加载1000条数据，样式也很简单。  

## 一、案例样式

### Native:
![native_app](http://pactji2yy.bkt.clouddn.com/native_app.png)

### Flutter:
![flutter_app](http://pactji2yy.bkt.clouddn.com/flutter_app.png)

## 二、案例代码

### Native
```
public class MainActivity extends AppCompatActivity {

    private List<String> data = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        RecyclerView recyclerView = findViewById(R.id.recycle_view);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        for(int i = 0; i < 1000; i++){
            data.add(String.valueOf(i));
        }
        MyAdapter adapter = new MyAdapter(data);
        recyclerView.setAdapter(adapter);
    }

    public class MyAdapter extends RecyclerView.Adapter<ViewHolder>{
        private List<String> datas;

        public MyAdapter(List<String> data) {
            this.datas = data;
        }

        @NonNull
        @Override
        public ViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
            View view = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.item_layout, viewGroup,false);
            ViewHolder holder = new ViewHolder(view);
            return holder;
        }

        @Override
        public void onBindViewHolder(@NonNull ViewHolder viewHolder, int i) {
            String data = datas.get(i);
            viewHolder.textView.setText(data);
        }

        @Override
        public int getItemCount() {
            return datas.size();
        }

    }

    public class ViewHolder extends RecyclerView.ViewHolder{
        TextView textView;

        public ViewHolder(View view) {
            super(view);
            textView =  view.findViewById(R.id.tv);
        }
    }
}

```

### Flutter
```
void main() {
  runApp(new MyApp( items: new List<String>.generate(10000, (i) => "$i"),));
}

class MyApp extends StatelessWidget {
  final List<String> items;

  MyApp({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Flutter App';
    return new MaterialApp(
      title: title,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return new ListTile(
              title: new Text('${items[index]}'),
            );
          },
        ),
      ),
    );
  }
}
```

## 三、包大小比较
### Native
![native_size](http://pactji2yy.bkt.clouddn.com/native_size.png)
### Flutter
![flutter_size](http://pactji2yy.bkt.clouddn.com/flutter_size.png)
从上图可以看出新建一个空的的Flutter Release包大小在5.3M，而新建一个空的Native Release包大小在1.3M左右。主要是多了一个libflutter.so的引擎库和assets下面的框架和应用程序代码。

## 四、CPU比较
### Native:
![native_cpu](http://pactji2yy.bkt.clouddn.com/native_cpu.png)
### Flutter:
![flutter_cpu](http://pactji2yy.bkt.clouddn.com/flutter_cpu.png)
条件是在加载1000条数据，样式几乎一样的情况下。从上图可以看出Flutter和Native一开始的CPU功耗都在15%左右，之后滑动Native基本维持在4%~6%，Flutter基本维护在2%~4%左右，CPU功耗几乎不相上下。

## 五、内存比较
### Native:
![native_memory](http://pactji2yy.bkt.clouddn.com/native_memory.png)
### Flutter:
![flutter_memory](http://pactji2yy.bkt.clouddn.com/flutter_memory.png)
条件是在加载1000条数据，样式几乎一样的情况下。从上图可以看出Flutter和Native一开始的内存消耗都在50M左右，之后滑动Native基本维持在33M，Flutter基本维护在37M左右，Flutter内存占用稍多。

## 六、FPS比较
### Flutter
![flutter_fps](http://pactji2yy.bkt.clouddn.com/flutter_fps.png)
条件是在加载1000条数据，样式几乎一样的情况下。这里使用Flutter自带的Flutter Inspector观察FPS变化。从上图可以看出滑动过程中Flutter的FPS几乎维持在60FPS左右，几乎可以达到原生效果。

## 七、启动速度比较
这里由于没法播放视频，根据我个人的观察，Flutter Release包在启动的时候还是有一个短暂的白屏，如果不对比原生仔细观察基本看不来。

## 八、总结
在功能较为简单的情况下，Flutter运行性能几乎可以媲美原生。包大小和启动白屏问题是开发者需要考虑的，启动白屏网上也有解决方案，所以综合来说，Flutter用来做商业开发还是不错的。