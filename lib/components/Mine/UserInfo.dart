import 'package:flutter/material.dart';
import 'package:flutter_shop_app/stores/TokenManager.dart';
import 'package:flutter_shop_app/stores/UserController.dart';
import 'package:flutter_shop_app/utils/LoadingDialog.dart';
import 'package:flutter_shop_app/viewmodels/user.dart';
import 'package:get/get.dart';

class Userinfo extends StatefulWidget {
  const Userinfo({super.key});

  @override
  State<Userinfo> createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  final UserController userController = Get.find<UserController>();

  void _handleUserInfoClick() {
    if (userController.user.value.id.isNotEmpty) {
      return;
    }
    Navigator.pushNamed(context, "/login");
  }

  void _hanldeLogout() {
    showDialog(
      context: context,
      builder: (contetx) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("确认退出登录吗?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("取消"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                // 退出登录逻辑
                // 1. 清除SharedPreferences用户数据（硬盘数据）
                await tokenManager.removeToken();
                // 2. 清除Getx用户数据（内存数据）
                userController.updateUserInfo(UserInfo.fromJSON({})); // 用户信息置空
              },
              child: Text("确认"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      height: 100,
      padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
      decoration: BoxDecoration(color: const Color.fromRGBO(251, 243, 235, 1)),
      child: GestureDetector(
        onTap: _handleUserInfoClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              return Expanded(
                child: Text(
                  displayName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }),
            Obx(() {
              final user = userController.user;
              if (user.value.id.isNotEmpty) {
                return Container(
                  child: GestureDetector(
                    onTap: _hanldeLogout,
                    child: Text(
                      "退出",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }
              return SizedBox.shrink(); // 空组件，不占用空间
            }),
          ],
        ),
      ),
    );
  }
}
