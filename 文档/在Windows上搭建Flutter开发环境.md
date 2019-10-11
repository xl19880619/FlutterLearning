# 在Windows上搭建Flutter开发环境
## 一、系统要求
要安装并运行Flutter，开发环境必须满足以下最低要求:
* 操作系统: Windows 7 或更高版本 (64-bit)
* 磁盘空间: 400 MB (不包括Android Studio的磁盘空间).
* 工具: Flutter 依赖下面这些命令行工具.
* Git for Windows (Git命令行工具)
## 二、获取Flutter SDK
* 打开终端窗口运行如下命令：
```
git clone -b beta https://github.com/flutter/flutter.git
```
* 等待SDK下载完毕。
* 下载完成后将SDK整个文件夹拷贝到自己想拷贝的目录下，这里我直接拷贝到D盘下。
* 接下来，配置环境变量。
## 三、环境变量的配置
* 要在终端运行 flutter命令，你需要添加以下环境变量到系统PATH：
追加 flutter\bin的全路径，使用 ; 作为分隔符。
* 由于一些flutter命令需要联网获取数据，如果您是在国内访问，由于众所周知的原因，直接访问很可能不会成功。
PUB_HOSTED_URL和FLUTTER_STORAGE_BASE_URL是google为国内开发者搭建的临时镜像，也需要配置，配置到用户变亮下即可。
PUB_HOSTED_URL值为https://pub.flutter-io.cn
FLUTTER_STORAGE_BASE_URL值为https://storage.flutter-io.cn
* 最后如果没有配置ANDROID_HOME变量，也需要配置上。
## 四、运行 flutter doctor
* 打开终端窗口运行以下命令以查看是否需要安装任何依赖项来完成安装：
```
flutter doctor
```
该命令检查您的环境并在终端窗口中显示报告。
* 第一次运行一个flutter命令（如flutter doctor）时，它会下载它自己的依赖项并自行编译。以后再运行就会快得多。
* 注意：第一次运行有时会耗时很长很长，不要以为出问题了，闹心等待就好了。
## 五、Android Studio配置
* 首先安装Flutter插件，这里安装完插件最好重启一下电脑，而不仅仅是重启Studio，我这安装完新建Flutter项目找不到连接的手机，重启电脑就好了。
* 安装Flutter插件的同时会自动安装Dart插件，无需额外安装。
* 好了，走完以上步骤就可以创建Flutter项目了。关于window下Flutter环境搭建介绍到此为止，希望对你有用。

























