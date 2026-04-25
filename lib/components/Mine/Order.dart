import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final List<Map<String, String>> _menus = [
    {"icon": "lib/assets/ic_user_order.png", "label": "全部订单"},
    {"icon": "lib/assets/ic_user_obligation.png", "label": "待付款"},
    {"icon": "lib/assets/ic_user_unreceived.png", "label": "待发货"},
    {"icon": "lib/assets/ic_user_unshipped.png", "label": "待收货"},
    {"icon": "lib/assets/ic_user_unevaluated.png", "label": "待评价"},
  ];

  List<Widget> _getMenus() {
    return List.generate(_menus.length, (int idx) {
      Map<String, dynamic> menu = _menus[idx];
      return Expanded(
        child: Center(
          child: Column(
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
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
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
            alignment: Alignment.centerLeft,
            child: Text("我的订单", style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          SizedBox(height: 5),
          Flex(direction: Axis.horizontal, children: _getMenus()),
        ],
      ),
    );
  }
}
