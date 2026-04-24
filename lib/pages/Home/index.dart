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
  final ScrollController _scrollController = ScrollController();
  // 分页相关
  final int _page = 1;
  bool _isLoading = false;
  final bool _hasMore = true;

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
  List<RecommendItem> _recommendList = [];

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
      MoreList(recommendList: _recommendList),
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

  Future<void> _getRecommendList() async {
    if (!_isLoading || !_hasMore) {
      print("正在加载或者没有下一页了");
      return;
    }
    _isLoading = true;
    _recommendList = await getRecommendList({"limit": 20});
    _isLoading = false;
    setState(() {});
  }

  void _registerEvent() {
    _scrollController.addListener(() {
      // 能滚动的最大距离
      double maxDistance = _scrollController.position.maxScrollExtent;
      // 如果滚动距离等于最大距离，则触底了加载下一页
      double curDistance = _scrollController.position.pixels;
      if (curDistance >= maxDistance - 50) {
        print("到底啦");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _registerEvent();
    _getBannerList();
    _getCategoryList();
    _getHotPreferenceData();
    _getInVogueData();
    _getOneStopData();
    _getRecommendList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: CustomScrollView(
        slivers: _getSliverList(),
        controller: _scrollController,
      ),
    );
  }
}
