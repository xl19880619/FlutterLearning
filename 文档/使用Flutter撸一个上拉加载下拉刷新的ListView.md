# 使用Flutter撸一个上拉加载下拉刷新的ListView
这里以X计划收藏列表为例
## 1.构造函数初始化监听
```
_CollectListPageState() {
    ///构造函数进行滚动监听
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      ///如果滚到不能再滚了进行上拉加载请求
      if (maxScroll == pixels) {
        getCollectList(true);
      }
    });
  }
```
## 2.初始化State后State可用
```
@override
void initState() {
    super.initState();
    ///初始化状态后请求收藏列表
    getCollectList(false);
}
```
## 3.请求逻辑
```
  ///获取收藏列表
  void getCollectList(bool loadMore) {
    ///下拉刷新将请求参数的offset重置为0
    if(!loadMore){
      offset = 0;
    }
    ///拼装请求参数
    String url = Api.HOST + Api.COLLECT_GET_LISTS;
    Map<String, String> params = new Map<String, String>();
    params["offset"] = offset.toString();
    ///使用封装的网络请求库发送异步请求
    NetUtil.post(url, params: params).then((data) {
      if (data != null) {
        ///和服务端约定code等于2代表请求成功
        if (data.code == 2) {
          MyCollectListBean myCollectListBean = MyCollectListBean.fromJson(data.data);
          if (myCollectListBean != null) {
            ///如果收藏列表不为空就更新数据并调用setState进行重绘
            setState(() {
              if (!loadMore) {
                _list = myCollectListBean.list;
              } else {
                ///如果是上拉加载，并且没有更多数据，toast提示
                if(mList.length == 0){
                  ToastUtils.showShortToast("没有更多数据了");
                }else{
                  _list.addAll(myCollectListBean.list);
                }
              }
              ///更新下次请求参数
              offset = _list.length;
            });
          }
        }
      }
    });
  }
```
## 4.每次调用setState，就会自动进行调用build方法，进行渲染控件
```
@override
  Widget build(BuildContext context) {
    if (_list == null) {
      ///首次进来先显示圆形loading进度条
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      ///有列表数据了就可以渲染ListView了，考虑到每个item有个分割线，所以count值为列表数据的2倍
      Widget listView = ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _list.length * 2,
        itemBuilder: (context, i) => renderRow(i),
        controller: _controller,
      );
      ///将ListView作为下拉刷新控件子控件
      return new RefreshIndicator(child: listView, onRefresh: _refreshCallBack);
    }
  }
```
## 5.渲染每行布局
```
///渲染每行
Widget renderRow(int i) {
    ///如果列表的索引是奇数，就只渲染分割线，否则渲染真正的item布局
    if (i.isOdd) {
      return Divider(
        color: Colors.grey,
        height: 1.0,
      );
    }
    i = i ~/ 2;
    MyCollectBean itemData = _list[i];
    return _CommonCarListItemWidget(itemData);
  }
```
## 6.渲染每行数据，因为item布局基本只有渲染逻辑，不需要自己调用刷新state，所以可以用用无状态布局，继承StatelessWidget就行
```
class _CommonCarListItemWidget extends StatelessWidget {
  final MyCollectBean item;

  _CommonCarListItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 98.0,
      child: Padding(
        ///设置item布局的padding为15
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            ///车图通过网络获取
            Image.network(item.carimg,
                width: 100.0, height: 67.0, fit: BoxFit.cover),
            ///Expanded类似于Android里面的weight
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                ///Column类似于垂直的LinerLayout
                child: Column(
                  ///设置对其方式为左对齐
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ///车名
                    Text(item.carname,
                        style: TextStyle(
                            color: Color(0xFF1B1B1B),
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold)),
                   ///使用年限及公里数
                   Text(item.carnotime + " / " + item.mileage),
                    Row(
                      children: <Widget>[
                      ///车价
                     Text(item.price,
                            style: TextStyle(
                                color: Color(0xFFF85D00),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ///最右侧一列，两张图片
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Image.asset("images/level_a.png"),
                  Image.asset("images/share_icon.png"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```
至此，一个可以上拉加载下拉刷新的ListView基本搞定了。当然还有很多地方需要优化，比如网络状态、数据为空的处理，还是有很大优化空间的。