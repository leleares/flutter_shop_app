import 'package:flutter/material.dart';
import 'package:flutter_shop_app/api/home.dart';
import 'package:flutter_shop_app/viewmodels/home.dart';

class Category extends StatefulWidget {
  final List<CategoryItem> categoryList;
  const Category({super.key, required this.categoryList});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          CategoryItem category = widget.categoryList[index];
          return Container(
            margin: EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 238, 230, 231),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(category.picture, width: 50, height: 50),
                Text(
                  category.name,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
