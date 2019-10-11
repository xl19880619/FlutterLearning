# Flutter请求封装与JSON解析
这里以X计划请求工具类为例，对dart自带的http请求api进行简单封装。
## 一、POST请求
```
static Future<BaseResult> post(String url, {Map<String, String> params})async {
    ///获取请求公共参数
    Map<String, String> defaultParams = await getDefaultParams();
    ///加上每个接口的请求参数
    params.addAll(defaultParams);
    ///这里需要根据所有参数算出一个加密的apikey，并把它当做一个参数
    String apikey = await ApiKeyUtils.getApiKey(params);
    params["_apikey"] = apikey;
    ///打印请求日志
    print("***********************\n请求地址:$url\n参数:$params");
    params.forEach((key,value){
      if(value == null){
        value = "";
      }
    });
    ///采用dart包下原生http库发送异步请求
    http.Response response = await http.post(url, body: params);
    ///将返回数据的unicode码转成中文方便查看响应日志
    String aesPwd = await PluginUtils.unicodeToChinese(response.body.toString());
    ///打印响应日志
    print("返回数据:$aesPwd\n***********************");
    ///返回解析后的数据
    return parseData(response.body);
  }
```
## 二、GET请求
```
static Future<BaseResult> get(String url, {Map<String, String> params}) async{
    if(params != null && params.isNotEmpty){
      StringBuffer sb = new StringBuffer();
      sb.write("?");
      params.forEach((key, value){
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramsStr = sb.toString();
      paramsStr = paramsStr.substring(0, paramsStr.length - 1);
      url += paramsStr;
    }
    http.Response response = await http.get(url);
    return parseData(response.body);
}
```
## 三、解析响应
```
static BaseResult parseData(String response){
    BaseResult result = new BaseResult();
    ///将返回的json转化为map格式
    Map map = jsonDecode(response);
    ///将map的值一一映射到返回对象中
    result.code = map["code"];
    result.data = map["data"];
    result.message = map["message"];
    return result;
}
```
## 四、如何使用该工具类
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
## 五、JSON解析
这里采用json_serializable生成JSON序列化模板，以降低手动解析容易出错的风险。 具体如何使用，官网有文档：https://flutterchina.club/json/  
这里以X计划收藏列表为例，需要按照如下模板写出原始的类
```
part 'MyCollectListBean.g.dart';

@JsonSerializable()
class MyCollectListBean{

  List<MyCollectBean> list;
  int offset;

  MyCollectListBean(this.list, this.offset);

  factory MyCollectListBean.fromJson(Map<String, dynamic> json) => _$MyCollectListBeanFromJson(json);
}
```
然后在项目根目录运行如下命令，就会自动生成MyCollectListBean.g.dart代码
```
flutter packages pub run build_runner build
```
使用的时候通过如下方式进行序列化与反序列化
```
///序列化
Map userMap = JSON.decode(json);
var user = new User.fromJson(userMap);

///反序列化
String json = JSON.encode(user);
```
到此，请求库的封装与JSON自动解析就搞定了。当然在项目中，请求库更推荐使用dio。dio是一个强大的Dart Http请求库，支持Restful API、FormData、拦截器、请求取消、Cookie管理、文件上传/下载、超时等。项目地址在 https://github.com/flutterchina/dio ，有机会可以将项目里面的请求库换成这个并体验带来的好处。