# 基于 flutter 的购物 App

# 功能说明
MainPage 为主页，包含四个底tab：首页、分类、购物车、我的   
LoginPage 为登录页

# 账号密码
账号:
account:13200000001~13200000010
密码:
password:123456

# Flutter 知识点
## mounted
- `mounted` 是 `State` 自带属性，用来判断当前组件是否还挂载在组件树上。
- 异步操作结束后，如果还要调用 `setState()`、`Navigator`、`context`，最好先判断：`if (!mounted) return;`
- 作用：避免页面已经销毁后继续操作 UI 导致报错。

## GetX: put 和 find
- `Get.put()`：注册/创建实例，一般在全局状态第一次需要创建时调用。
- `Get.find()`：获取已经注册过的实例，一般在子组件、其他页面里使用共享状态时调用。
- 核心思想：共享状态只创建一次，多个地方取同一个实例，数据变化后由响应式组件自动刷新 UI。
- 例如：`Get.put(UserController())` 不只是 `new` 了一个对象，还把它注册进了 GetX 容器。
- 之后其他地方 `Get.find<UserController>()`，拿到的通常就是前面 `put` 进去的那一个实例。
- 所以它的使用效果很像“单例”，但更准确地说，是“注册到 GetX 容器中的共享实例”。
- `put` 负责放进去，`find` 负责取出来；`find` 本身不创建实例。

