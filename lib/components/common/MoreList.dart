import 'package:flutter/material.dart';
import 'package:flutter_shop_app/viewmodels/home.dart';

class MoreList extends StatefulWidget {
  const MoreList({super.key, required this.recommendList});
  final List<RecommendItem> recommendList;

  @override
  State<MoreList> createState() => _MoreListState();
}

class _MoreListState extends State<MoreList> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 20,
        childAspectRatio: 0.65,
      ),
      itemCount: widget.recommendList.length,
      itemBuilder: (BuildContext context, int index) {
        RecommendItem recommendData = widget.recommendList[index];
        return Container(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(recommendData.picture),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 238, 230, 231),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(6),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.topLeft,
                        height: 40,
                        child: Text(
                          recommendData.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "¥${recommendData.price}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              "${recommendData.price}",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                //中划线
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          Text(
                            "${recommendData.payCount}人付款",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
