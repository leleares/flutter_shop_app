import 'package:flutter_shop_app/viewmodels/home.dart';

class GuessYouLikeGoodsResp {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GuessYouLikeGoodItem> items;

  GuessYouLikeGoodsResp({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GuessYouLikeGoodsResp.fromJSON(Map<String, dynamic> json) {
    return GuessYouLikeGoodsResp(
      counts: json["counts"],
      pageSize: json["pageSize"],
      pages: json["pages"],
      page: json["page"],
      items: (json["items"] as List<dynamic>)
          .map(
            (item) =>
                GuessYouLikeGoodItem.fromJSON(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class GuessYouLikeGoodItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;

  GuessYouLikeGoodItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory GuessYouLikeGoodItem.fromJSON(Map<String, dynamic> json) {
    return GuessYouLikeGoodItem(
      id: json["id"],
      name: json["name"],
      desc: json["desc"] ?? "",
      price: json["price"],
      picture: json["picture"],
      orderNum: json["orderNum"],
    );
  }

  RecommendItem toRecommendItem() {
    return RecommendItem(
      id: id,
      name: name,
      price: double.parse(price),
      picture: picture,
      payCount: orderNum,
    );
  }
}
