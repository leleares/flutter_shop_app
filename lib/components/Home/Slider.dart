import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/viewmodels/home.dart';

class Slider extends StatefulWidget {
  const Slider({super.key, required this.bannerList});
  final List<BannerItem> bannerList;

  @override
  State<Slider> createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  @override
  Widget build(BuildContext context) {
    // flutter 中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CarouselSlider(
          items: List.generate(widget.bannerList.length, (index) {
            return Image.network(
              widget.bannerList[index].imgUrl,
              fit: BoxFit.cover,
              width: screenWidth,
            );
          }),
          options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: true,
            autoPlayAnimationDuration: Duration(milliseconds: 500),
            autoPlayInterval: Duration(seconds: 2),
          ),
        ),
        Positioned(child: Text("搜索框")),
        Positioned(child: Text("导航栏")),
      ],
    );
  }
}
