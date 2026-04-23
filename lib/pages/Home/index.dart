import 'package:flutter/material.dart' hide Slider;
import 'package:flutter_shop_app/components/Home/Category.dart';
import 'package:flutter_shop_app/components/Home/Hot.dart';
import 'package:flutter_shop_app/components/Home/MoreList.dart';
import 'package:flutter_shop_app/components/Home/Recommend.dart';
import 'package:flutter_shop_app/components/Home/Slider.dart';
import 'package:flutter_shop_app/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<BannerItem> _bannerList = [
    BannerItem(
      id: "1",
      imgUrl:
          "https://piccdn3.umiwi.com/img/202603/29/202603291614225598209531.jpeg",
    ),
    BannerItem(
      id: "2",
      imgUrl:
          "https://piccdn3.umiwi.com/img/202602/01/202602011437088764224110.jpeg",
    ),
  ];

  List<Widget> _getSliverList() {
    return [
      // slider
      SliverToBoxAdapter(child: Slider(bannerList: _bannerList)),
      // gap
      SliverToBoxAdapter(child: SizedBox(height: 20)),
      // category
      SliverToBoxAdapter(child: Category()),
      // gap
      SliverToBoxAdapter(child: SizedBox(height: 20)),
      // recommend
      SliverToBoxAdapter(child: Recommend()),
      // gap
      SliverToBoxAdapter(child: SizedBox(height: 20)),
      // hot
      SliverToBoxAdapter(
        child: Flex(
          direction: Axis.horizontal,
          spacing: 20,
          children: [
            Expanded(child: Hot()),
            Expanded(child: Hot()),
          ],
        ),
      ),
      // gap
      SliverToBoxAdapter(child: SizedBox(height: 20)),
      // more list
      MoreList(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: CustomScrollView(slivers: _getSliverList()),
    );
  }
}
