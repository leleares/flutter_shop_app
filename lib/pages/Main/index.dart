import 'package:flutter/material.dart';
import 'package:flutter_shop_app/stores/UserController.dart';
import 'package:get/get.dart';
import 'package:flutter_shop_app/api/user.dart';
import 'package:flutter_shop_app/pages/Cart/index.dart';
import 'package:flutter_shop_app/pages/Category/index.dart';
import 'package:flutter_shop_app/pages/Home/index.dart';
import 'package:flutter_shop_app/pages/Mine/index.dart';
import 'package:flutter_shop_app/stores/TokenManager.dart';
import 'package:flutter_shop_app/viewmodels/user.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // state
  int _activeTabIndex = 0;
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/ic_public_home_normal.png",
      "active_icon": "lib/assets/ic_public_home_active.png",
      "text": "首页",
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png",
      "active_icon": "lib/assets/ic_public_pro_active.png",
      "text": "产品",
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png",
      "active_icon": "lib/assets/ic_public_cart_active.png",
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png",
      "active_icon": "lib/assets/ic_public_my_active.png",
      "text": "我的",
    },
  ];

  List<BottomNavigationBarItem> getBottomNavigationBarItems() {
    return List.generate(_tabList.length, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30),
        activeIcon: Image.asset(
          _tabList[index]["active_icon"]!,
          width: 30,
          height: 30,
        ),
        label: _tabList[index]["text"],
      );
    });
  }

  List<Widget> getTabBodyChildren() {
    return const [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  final UserController _userController = Get.put(UserController());
  void _initUser() async {
    await tokenManager.init();
    // 判断是否有token，有的话请求用户信息并存到Getx
    String token = tokenManager.getToken();
    if (token.isNotEmpty) {
      UserInfo userInfo = await getUserInfoReq();
      _userController.updateUserInfo(userInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea 可有效避开移动端安全区（顶部状态栏）
      // IndexedStack 中的 children 则为动态切换的对应四个 tab 的 body。
      body: SafeArea(
        child: IndexedStack(
          index: _activeTabIndex, // 第几个 child 出现
          children: getTabBodyChildren(), // child 列表
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: getBottomNavigationBarItems(),
        currentIndex: _activeTabIndex,
        onTap: (activeIdx) {
          _activeTabIndex = activeIdx;
          setState(() {}); // 更新 UI
        },
        selectedItemColor: Colors.black, // 选中的tab的label颜色
        showUnselectedLabels: true, // 是否展示未被选中的tab的label
        unselectedItemColor: Colors.black, // 未被选中的tab的label颜色
        type: BottomNavigationBarType.fixed, // 固定底部导航栏每个tab的宽度相同
        selectedFontSize: 12, // 选中的tab的label字体大小
        unselectedFontSize: 12, // 未被选中的tab的label字体大小
      ),
    );
  }
}
