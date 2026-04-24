// 轮播图数据类型
class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});

  factory BannerItem.fromJSON(Map<String, dynamic> json) {
    return BannerItem(id: json["id"], imgUrl: json["imgUrl"]);
  }
}

// 分类数据类型
class CategoryItem {
  String id;
  String name;
  String picture;

  CategoryItem({required this.id, required this.name, required this.picture});
  factory CategoryItem.fromJSON(Map<String, dynamic> json) {
    return CategoryItem(
      id: json["id"],
      name: json["name"],
      picture: json["picture"],
    );
  }
}

// 特惠推荐响应数据类型
class HotPreferenceResult {
  String id;
  String title;
  List<HotPreferenceSubType> subTypes;

  HotPreferenceResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory HotPreferenceResult.fromJSON(Map<String, dynamic> json) {
    return HotPreferenceResult(
      id: json["id"],
      title: json["title"],
      subTypes: (json["subTypes"] as List)
          .map((item) => HotPreferenceSubType.fromJSON(item))
          .toList(),
    );
  }
}

class HotPreferenceSubType {
  String id;
  String title;
  HotPreferenceGoodsList goodsItems;

  HotPreferenceSubType({
    required this.id,
    required this.title,
    required this.goodsItems,
  });

  factory HotPreferenceSubType.fromJSON(Map<String, dynamic> json) {
    return HotPreferenceSubType(
      id: json["id"],
      title: json["title"],
      goodsItems: HotPreferenceGoodsList.fromJSON(json["goodsItems"]),
    );
  }
}

class HotPreferenceGoodsList {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<HotPreferenceGoodsItem> items;

  HotPreferenceGoodsList({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory HotPreferenceGoodsList.fromJSON(Map<String, dynamic> json) {
    return HotPreferenceGoodsList(
      counts: json["counts"],
      pageSize: json["pageSize"],
      pages: json["pages"],
      page: json["page"],
      items: (json["items"] as List)
          .map((item) => HotPreferenceGoodsItem.fromJSON(item))
          .toList(),
    );
  }
}

class HotPreferenceGoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;

  HotPreferenceGoodsItem({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory HotPreferenceGoodsItem.fromJSON(Map<String, dynamic> json) {
    return HotPreferenceGoodsItem(
      id: json["id"],
      name: json["name"],
      desc: json["desc"],
      price: json["price"],
      picture: json["picture"],
      orderNum: json["orderNum"],
    );
  }
}
