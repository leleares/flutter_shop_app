import 'package:flutter/material.dart';

class MySpace extends StatefulWidget {
  const MySpace({super.key});

  @override
  State<MySpace> createState() => _MySpaceState();
}

class _MySpaceState extends State<MySpace> {
  final List<Map<String, String>> _menus = [
    {"icon": "lib/assets/ic_user_collect.png", "label": "我的收藏"},
    {"icon": "lib/assets/ic_user_history.png", "label": "我的足迹"},
    {"icon": "lib/assets/ic_user_service.png", "label": "我的客服"},
  ];

  List<Widget> _getMenus() {
    return List.generate(_menus.length, (int idx) {
      Map<String, dynamic> menu = _menus[idx];
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(menu["icon"], width: 30, height: 30),
              SizedBox(height: 5),
              Text(menu["label"], style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Color.fromRGBO(229, 197, 158, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "lib/assets/ic_user_vip.png",
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      "升级商城会员，尊享各项服务",
                      style: TextStyle(color: Colors.brown, fontSize: 13),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      right: 8,
                      bottom: 5,
                      left: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(110, 43, 30, 1),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Text(
                      "立即开通",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Flex(direction: Axis.horizontal, children: _getMenus()),
          ),
        ],
      ),
    );
  }
}
