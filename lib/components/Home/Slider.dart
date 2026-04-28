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
  // variables
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int curActiveIdx = 0;

  // handler
  void handleDotClick(int idx) {
    _carouselController.animateToPage(idx);
  }

  @override
  Widget build(BuildContext context) {
    // flutter 中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
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
            autoPlayAnimationDuration: Duration(milliseconds: 400),
            autoPlayInterval: Duration(seconds: 4),
            onPageChanged: (index, reason) {
              curActiveIdx = index;
              setState(() {});
            },
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: 200,
              height: 30,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, .4),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Text(
                "搜索",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.bannerList.length, (index) {
                return GestureDetector(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: curActiveIdx == index ? 40 : 20,
                    height: 6,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: curActiveIdx == index
                          ? Colors.white
                          : Color.fromRGBO(0, 0, 0, .3),
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                  ),
                  onTap: () => handleDotClick(index),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
