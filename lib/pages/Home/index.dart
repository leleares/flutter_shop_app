import 'package:flutter/material.dart' hide Slider;
import 'package:flutter_shop_app/api/home.dart';
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
  List<BannerItem> _bannerList = [];

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

  void _getBannerList() async {
    _bannerList = await getBannerList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getBannerList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: CustomScrollView(slivers: _getSliverList()),
    );
  }
}
