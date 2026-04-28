# Flutter 学习笔记

记录开发 `flutter_shop_app` 过程中遇到的知识点和命令。

## mounted

- `mounted` 是 `State` 自带属性，用来判断当前组件是否还挂载在组件树上。
- 异步操作结束后，如果还要调用 `setState()`、`Navigator`、`context`，最好先判断：`if (!mounted) return;`
- 作用：避免页面已经销毁后继续操作 UI 导致报错。

## GetX：put 和 find

- `Get.put()`：注册/创建实例，一般在全局状态第一次需要创建时调用。
- `Get.find()`：获取已经注册过的实例，一般在子组件、其他页面里使用共享状态时调用。
- 核心思想：共享状态只创建一次，多个地方取同一个实例，数据变化后由响应式组件自动刷新 UI。
- 例如：`Get.put(UserController())` 不只是 `new` 了一个对象，还把它注册进了 GetX 容器。
- 之后其他地方 `Get.find<UserController>()`，拿到的通常就是前面 `put` 进去的那一个实例。
- 所以它的使用效果很像"单例"，但更准确地说，是"注册到 GetX 容器中的共享实例"。
- `put` 负责放进去，`find` 负责取出来；`find` 本身不创建实例。

## flutter create .

- `flutter create .` 用于在当前目录补全或重新生成 Flutter 工程所需的基础文件。
- 常见用途：把一个普通目录初始化成 Flutter 项目，或者在缺失 `android`、`ios` 等平台目录时重新生成它们。

## flutter build apk --debug

打 Android 测试包。
