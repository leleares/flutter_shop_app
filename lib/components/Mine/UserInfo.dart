import 'package:flutter/material.dart';
import 'package:flutter_shop_app/stores/UserController.dart';
import 'package:get/get.dart';

class Userinfo extends StatefulWidget {
  const Userinfo({super.key});

  @override
  State<Userinfo> createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  final UserController userController = Get.find<UserController>();

  void _handleUserInfoClick() {
    if (userController.user.value.token.isNotEmpty) {
      return;
    }
    Navigator.pushNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      height: 100,
      padding: EdgeInsets.only(left: 10, bottom: 10),
      decoration: BoxDecoration(color: const Color.fromRGBO(251, 243, 235, 1)),
      child: GestureDetector(
        onTap: _handleUserInfoClick,
        child: Row(
          children: [
            Obx(() {
              final avatar = userController.user.value.avatar;
              if (avatar.isNotEmpty) {
                return Image.network(avatar, width: 50, height: 50);
              }
              return Image.asset(
                "lib/assets/goods_avatar.png",
                width: 50,
                height: 50,
              );
            }),
            const SizedBox(width: 10),
            Obx(() {
              final user = userController.user.value;
              final displayName = user.nickname.isNotEmpty
                  ? user.nickname
                  : (user.account.isNotEmpty ? user.account : "立即登录");
              return Text(
                displayName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
