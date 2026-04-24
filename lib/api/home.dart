import 'package:flutter_shop_app/constants/index.dart';
import 'package:flutter_shop_app/utils/DioRequest.dart';
import 'package:flutter_shop_app/viewmodels/home.dart';

// 获取轮播图列表
Future<List<BannerItem>> getBannerList() async {
  List<BannerItem> bannerList =
      (await dioRequest.get(HttpConstants.BANNER_LIST) as List).map((item) {
        return BannerItem.fromJSON(item as Map<String, dynamic>);
      }).toList();

  return bannerList;
}

// 获取分类列表
Future<List<CategoryItem>> getCategoryList() async {
  List<CategoryItem> categoryList =
      (await dioRequest.get(HttpConstants.CAREGORY_LIST) as List).map((item) {
        return CategoryItem.fromJSON(item as Map<String, dynamic>);
      }).toList();

  return categoryList;
}

// 获取特惠推荐数据
Future<HotPreferenceResult> getHotPreferenceData() async {
  Map<String, dynamic> result = await dioRequest.get(
    HttpConstants.HOT_PREFERENCE,
  );

  HotPreferenceResult hotPreference = HotPreferenceResult.fromJSON(result);
  return hotPreference;
}

// 获取爆款推荐数据
Future<HotPreferenceResult> getHotInVogueData() async {
  Map<String, dynamic> result = await dioRequest.get(HttpConstants.HOT_INVOGUE);

  HotPreferenceResult hotInVogue = HotPreferenceResult.fromJSON(result);
  return hotInVogue;
}

// 获取一站买全数据
Future<HotPreferenceResult> getHotOnStopData() async {
  Map<String, dynamic> result = await dioRequest.get(HttpConstants.HOT_ONESTOP);

  HotPreferenceResult hotOneStop = HotPreferenceResult.fromJSON(result);
  return hotOneStop;
}

// 获取一站买全数据
Future<List<RecommendItem>> getRecommendList(
  Map<String, dynamic> params,
) async {
  List list = await dioRequest.get(HttpConstants.HOT_RECOMMEND, params: params);

  return list.map((recommend) {
    return RecommendItem.fromJSON(recommend as Map<String, dynamic>);
  }).toList();
}
