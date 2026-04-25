import 'package:flutter/material.dart';
import 'package:flutter_shop_app/api/mine.dart';
import 'package:flutter_shop_app/components/Mine/MySpace.dart';
import 'package:flutter_shop_app/components/Mine/Order.dart';
import 'package:flutter_shop_app/components/Mine/StickyGuessYouLike.dart';
import 'package:flutter_shop_app/components/Mine/UserInfo.dart';
import 'package:flutter_shop_app/components/common/MoreList.dart';
import 'package:flutter_shop_app/stores/UserController.dart';
import 'package:flutter_shop_app/viewmodels/home.dart';
import 'package:get/get.dart';

class MineView extends StatefulWidget {
  const MineView({super.key});

  @override
  State<MineView> createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  final int _pageSize = 10;
  bool _isLoading = false;
  bool _hasMore = true;
  List<RecommendItem> _guessYouLikeGoodsList = [];

  Widget _guessYouLike() {
    return SliverPersistentHeader(delegate: StickyGuessYouLike(), pinned: true);
  }

  List<Widget> _getSlivers() {
    return [
      SliverToBoxAdapter(child: Userinfo()),
      SliverToBoxAdapter(child: MySpace()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: Order()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      _guessYouLike(),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverPadding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
        sliver: MoreList(recommendList: _guessYouLikeGoodsList),
      ),
    ];
  }

  Future<void> _getGuessYouLikeGoodsList() async {
    if (_isLoading || !_hasMore) {
      return;
    }

    _isLoading = true;
    try {
      final result = await getGuessYouLikeGoodsResult({
        "page": _page,
        "pageSize": _pageSize,
      });
      final newItems = result.items
          .map((item) => item.toRecommendItem())
          .toList();
      if (!mounted) return;
      setState(() {
        if (_page == 1) {
          _guessYouLikeGoodsList = newItems;
        } else {
          _guessYouLikeGoodsList.addAll(newItems);
        }
      });

      if (result.page >= result.pages) {
        _hasMore = false;
        return;
      }

      _page++;
    } catch (e) {
      debugPrint("获取猜你喜欢商品失败: $e");
    } finally {
      _isLoading = false;
    }
  }

  void _registerEvent() {
    _scrollController.addListener(() {
      final maxDistance = _scrollController.position.maxScrollExtent;
      final curDistance = _scrollController.position.pixels;
      if (curDistance >= maxDistance - 50) {
        _getGuessYouLikeGoodsList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<UserController>()) {
      Get.put(UserController());
    }
    _registerEvent();
    _getGuessYouLikeGoodsList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: _getSlivers(),
    );
  }
}
