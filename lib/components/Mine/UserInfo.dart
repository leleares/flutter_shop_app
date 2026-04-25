import 'package:flutter/material.dart';

class Userinfo extends StatefulWidget {
  const Userinfo({super.key});

  @override
  State<Userinfo> createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      height: 100,
      padding: EdgeInsets.only(left: 10, bottom: 10),
      decoration: BoxDecoration(color: const Color.fromRGBO(251, 243, 235, 1)),
      child: Row(
        children: [
          Image.asset("lib/assets/goods_avatar.png", width: 50, height: 50),
          SizedBox(width: 10),
          Text(
            "立即登录",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight(600)),
          ),
        ],
      ),
    );
  }
}
