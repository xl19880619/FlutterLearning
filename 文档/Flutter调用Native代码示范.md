# Flutter调用Native代码
* Native和Flutter要定一个通道，比如这里用的是"xplan.flutter.io/plugin"
* Native和Flutter在同一个通道下通过不同的方法名进行区分不同的事件，比如"aesEncrpt"
* Flutter调用Native是异步调用过程，使用时记得用await或者then函数。
## 一、Native代码部分
* 在MainActivity中加入如下代码
```
private static final String METHOD_CHANNEL = "xplan.flutter.io/plugin";

new MethodChannel(getFlutterView(), METHOD_CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if (methodCall.method.equals("aesEncrpt")) {
          /**
           * AES加密
           */
          String text = methodCall.argument("text");
          if (!TextUtils.isEmpty(text)) {
            result.success(AESUtils.encryptData(AESUtils.DEFAULT_KEY, text));
          } else {
            result.error("UNAVAILABLE", "密码为空", null);
          }
        } else if (methodCall.method.equals("unicodeToChinese")) {
          /**
           * unicode码转中文
           */
          String text = methodCall.argument("text");
          if (!TextUtils.isEmpty(text)) {
            result.success(UnicodeUtils.unicodeToString(text));
          } else {
            result.error("UNAVAILABLE", "内容为空", null);
          }
        } else if (methodCall.method.equals("getApiKey")) {
          /**
           * 获取APIKEY
           */
          Map<String, String> map = methodCall.argument("map");
          if (map != null && map.size() > 0) {
            result.success(ApiKeyUtils.getApiKey(map));
          } else {
            result.error("UNAVAILABLE", "参数为空", null);
          }
        } else {
          result.notImplemented();
        }
      }
    });
```
## 二、Flutter代码部分：
```
class PluginUtils{
  static const _platform = const MethodChannel('xplan.flutter.io/plugin');

  static Future<String> aesEncrpt(String text) async {
    try {
      return await _platform.invokeMethod('aesEncrpt',{'text':text});
    } catch (e) {
      return null;
    }
  }

  static Future<String> unicodeToChinese(String text) async {
    try {
      return await _platform.invokeMethod('unicodeToChinese',{'text':text});
    } catch (e) {
      return null;
    }
  }

  static Future<String> getApiKey(Map<String, String> map) async {
    try {
      return await _platform.invokeMethod('getApiKey',{'map':map});
    } catch (e) {
      return null;
    }
  }
}
```
## 三、具体调用Native代码部分：
```
PluginUtils.aesEncrpt(jsonPwd).then((aesPwd) {
        if (aesPwd != null && aesPwd != "") {
          String url = Api.HOST + Api.USER_LOGIN;
          Map<String, String> params = new Map<String, String>();
          params["telphone"] = _telphone;
          params["password"] = aesPwd;
          params["device"] = "123";
          NetUtil.post(url, params: params).then((baseResult) {
            if (baseResult != null) {
              if (baseResult.code == 2) {
                ToastUtils.showShortToast("登录成功");
                try{
                  UserService.saveUserInfo(baseResult.data);
                  Navigator.push(
                    mContext,
                    new MaterialPageRoute(builder: (mContext) => new MainPage()),
                  );
                }catch(e){
                  print(e.toString());
                }
              } else {
                ToastUtils.showShortToast(baseResult.message);
              }
            }
          });
        }
      });
```
## 四、遇到的坑
加完Native后运行app可能会报下面的错误
```
FormatException: Bad UTF-8 encoding 0xb4 (at offset 125)
```
解决方案：找到项目的Setting，找到File Encoding，把project的编码改为UTF-8。重新运行应该就ok了。
