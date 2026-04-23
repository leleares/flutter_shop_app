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
