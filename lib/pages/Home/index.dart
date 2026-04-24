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
  List<CategoryItem> _categoryList = [];
  HotPreferenceResult _hotPreferenceResult = HotPreferenceResult(
    id: '',
    title: '',
    subTypes: [],
  );
  HotPreferenceResult _hotInVogueResult = HotPreferenceResult(
    id: '',
    title: '',
    subTypes: [],
  );
  HotPreferenceResult _hotOnStopResult = HotPreferenceResult(
    id: '',
    title: '',
    subTypes: [],
  );

  List<Widget> _getSliverList() {
    return [
      // slider
      SliverToBoxAdapter(child: Slider(bannerList: _bannerList)),
      // gap
      SliverToBoxAdapter(child: SizedBox(height: 20)),
      // category
      SliverToBoxAdapter(child: Category(categoryList: _categoryList)),
      // gap
      SliverToBoxAdapter(child: SizedBox(height: 20)),
      // recommend
      SliverToBoxAdapter(child: Recommend(hotPreference: _hotPreferenceResult)),
      // gap
      SliverToBoxAdapter(child: SizedBox(height: 20)),
      // hot
      SliverToBoxAdapter(
        child: Flex(
          direction: Axis.horizontal,
          spacing: 20,
          children: [
            Expanded(
              child: Hot(cardData: _hotInVogueResult, type: "hot"),
            ),
            Expanded(
              child: Hot(cardData: _hotOnStopResult, type: "step"),
            ),
          ],
        ),
      ),
      // gap
      SliverToBoxAdapter(child: SizedBox(height: 20)),
      // more list
      MoreList(),
    ];
  }

  Future<void> _getBannerList() async {
    _bannerList = await getBannerList();
    setState(() {});
  }

  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryList();
    setState(() {});
  }

  Future<void> _getHotPreferenceData() async {
    _hotPreferenceResult = await getHotPreferenceData();
    setState(() {});
  }

  Future<void> _getInVogueData() async {
    _hotInVogueResult = await getHotInVogueData();
    setState(() {});
  }

  Future<void> _getOneStopData() async {
    _hotOnStopResult = await getHotOnStopData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getHotPreferenceData();
    _getInVogueData();
    _getOneStopData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: CustomScrollView(slivers: _getSliverList()),
    );
  }
}
