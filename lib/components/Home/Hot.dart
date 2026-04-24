import 'package:flutter/material.dart';
import 'package:flutter_shop_app/viewmodels/home.dart';

class Hot extends StatefulWidget {
  const Hot({super.key, required this.cardData, required this.type});
  final HotPreferenceResult cardData;
  final String type;

  @override
  State<Hot> createState() => _HotState();
}

class _HotState extends State<Hot> {
  // 计算属性，加 get 关键字，跟方法比少了一个小括号
  List<HotPreferenceGoodsItem> get getDisplayItems {
    if (widget.cardData.subTypes.isEmpty) {
      return [];
    }

    return widget.cardData.subTypes.first.goodsItems.items.take(2).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      width: 100,
      height: 130,
      decoration: BoxDecoration(
        color: widget.type == "hot"
            ? Colors.lightBlue[100]
            : Colors.yellow[100],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.type == "hot" ? "爆款推荐" : "一站买全",
                style: TextStyle(
                  color: Color.fromARGB(255, 86, 24, 20),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 5),
              Text(
                widget.type == "hot" ? "最受欢迎" : "精心优选",
                style: TextStyle(
                  color: Color.fromARGB(255, 130, 52, 46),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: List.generate(getDisplayItems.length, (index) {
              HotPreferenceGoodsItem item = getDisplayItems[index];
              return Expanded(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(10),
                      ),
                      child: Image.network(item.picture, width: 50, height: 70),
                    ),
                    Text(
                      "¥ ${item.price}",
                      style: TextStyle(
                        color: Color.fromARGB(255, 130, 52, 46),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
