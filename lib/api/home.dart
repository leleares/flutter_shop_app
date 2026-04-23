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
