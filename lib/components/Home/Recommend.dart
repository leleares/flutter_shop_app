import 'package:flutter/material.dart';
import 'package:flutter_shop_app/viewmodels/home.dart';

class Recommend extends StatefulWidget {
  const Recommend({super.key, required this.hotPreference});
  final HotPreferenceResult hotPreference;

  @override
  State<Recommend> createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  List<HotPreferenceGoodsItem> _get3SubItemsData() {
    if (widget.hotPreference.subTypes.isEmpty) return [];

    return widget.hotPreference.subTypes.first.goodsItems.items
        .take(3)
        .toList();
  }

  List<Widget> _buildSubItems() {
    List<HotPreferenceGoodsItem> displayItems = _get3SubItemsData();
    return List.generate(displayItems.length, (index) {
      HotPreferenceGoodsItem item = displayItems[index];
      return Container(
        child: Column(
          children: [
            // ClipRRect 裁剪组件，可设置圆角
            ClipRRect(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
              child: Image.network(
                // 图片加载失败的 fallback，可在这里返回一个通用骨架图片
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "lib/assets/home_cmd_sm.png",
                    width: 100,
                    height: 140,
                    fit: BoxFit.cover,
                  );
                },
                item.picture,
                width: 100,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(top: 5, right: 10, bottom: 5, left: 10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              child: Text(
                "¥ ${item.price}",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_sm.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "特惠推荐",
                style: TextStyle(
                  color: Color.fromARGB(255, 86, 24, 20),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 10),
              Text(
                "精选省攻略",
                style: TextStyle(
                  color: Color.fromARGB(255, 130, 52, 46),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Flex(
            direction: Axis.horizontal,
            spacing: 20,
            children: [
              Expanded(
                child: Container(
                  width: 100,
                  height: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/assets/home_cmd_inner.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              ..._buildSubItems(),
            ],
          ),
        ],
      ),
    );
  }
}
