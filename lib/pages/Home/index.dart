import 'package:flutter/material.dart' hide Slider;
import 'package:flutter_shop_app/api/home.dart';
import 'package:flutter_shop_app/components/Home/Category.dart';
import 'package:flutter_shop_app/components/Home/Hot.dart';
import 'package:flutter_shop_app/components/Home/MoreList.dart';
import 'package:flutter_shop_app/components/Home/Recommend.dart';
import 'package:flutter_shop_app/components/Home/Slider.dart';
import 'package:flutter_shop_app/utils/ToastUtil.dart';
import 'package:flutter_shop_app/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  // 分页相关
  int _page = 1;
  final int _pageSize = 10;
  bool _isLoading = false;
  bool _hasMore = true;
  // 创建一个 gloablkey，绑定到 widget 上，用于操纵 widget，类似于 react 中的 ref
  final GlobalKey<RefreshIndicatorState> _key = GlobalKey();
  double _paddingTop = 100;

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

  Future<void> _initData() async {
    try {
      await _getBannerList();
      await _getCategoryList();
      await _getHotPreferenceData();
      await _getInVogueData();
      await _getOneStopData();
      await _getRecommendList();
      setState(() {});
      print("数据加载完毕");
    } catch (e) {
      print("初始化数据异常: $e");
    }
  }

  Future<void> _getBannerList() async {
    _bannerList = await getBannerList();
  }

  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryList();
  }

  Future<void> _getHotPreferenceData() async {
    _hotPreferenceResult = await getHotPreferenceData();
  }

  Future<void> _getInVogueData() async {
    _hotInVogueResult = await getHotInVogueData();
  }

  Future<void> _getOneStopData() async {
    _hotOnStopResult = await getHotOnStopData();
  }

  Future<void> _getRecommendList() async {
    if (_isLoading || !_hasMore) {
      print("正在加载或者没有更多数据了");
      return;
    }
    _isLoading = true;
    int requestLimit = _page * _pageSize;
    _recommendList = await getRecommendList({
      "limit": requestLimit,
    }); // 注意这里是全量替换而不是数据拼接，很差劲的分页逻辑
    _isLoading = false;
    setState(() {});
    if (_recommendList.length < requestLimit) {
      _hasMore = false;
      print("没有更多数据了");
      return;
    }
    _page++;
  }

  void _registerEvent() {
    _scrollController.addListener(() {
      // 能滚动的最大距离
      double maxDistance = _scrollController.position.maxScrollExtent;
      // 如果滚动距离等于最大距离，则触底了加载下一页
      double curDistance = _scrollController.position.pixels;
      if (curDistance >= maxDistance - 50) {
        print("加载下一页");
        _getRecommendList();
      }
    });
  }

  Future<void> _onRefresh() async {
    print("下拉刷新");
    // 重置分页状态
    _isLoading = false;
    _page = 1;
    _hasMore = true;
    // 重新fetch数据
    _initData();
    Toastutil.showToast(context, "加载成功");
    _paddingTop = 0;
  }

  @override
  void initState() {
    super.initState();
    _registerEvent();
    Future.microtask(() {
      // 代码驱动方式触发页面下拉刷新
      _key.currentState
          ?.show(); // 可以理解为使用 ref 操作 dom，因此需确保 dom 渲染完毕，所以放到了微任务里，initState -> build -> microTask
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.only(
          top: _paddingTop,
        ), // 模拟实现下拉刷新的距离（为了初始化页面时实现逼真的下拉刷新效果）
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CustomScrollView(
            slivers: _getSliverList(),
            controller: _scrollController,
          ),
        ),
      ),
    );
  }
}
