import 'package:flutter/material.dart' hide Slider;
import 'package:flutter_shop_app/components/Home/Category.dart';
import 'package:flutter_shop_app/components/Home/Hot.dart';
import 'package:flutter_shop_app/components/Home/MoreList.dart';
import 'package:flutter_shop_app/components/Home/Recommend.dart';
import 'package:flutter_shop_app/components/Home/Slider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> _getSliverList() {
    return [
      // slider
      SliverToBoxAdapter(child: Slider()),
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
