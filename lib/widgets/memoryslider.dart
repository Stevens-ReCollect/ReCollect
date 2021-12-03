import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MemorySlider extends StatefulWidget{
  const MemorySlider({Key? key}) : super(key: key);
  @override
  State<MemorySlider> createState() => MemorySliderState();
  
}

List memoryAssets = ['lib/images/wedding-placeholder.jpg', 'lib/images/wedding-placeholder2.jpg'];
List <String> memoryDescripts = ['Hi', 'You and Bobby cutting the cake'];
class MemorySliderState extends State<MemorySlider> {
  
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    return Scaffold(
      body: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 4/3
        ),
        items: memoryAssets
            .map((item) => Column(
                      children: [
                          Image.asset(item, fit: BoxFit.cover, width: 0.8*deviceWidth, height: 0.4*deviceHeight),
                          ]),
                )
            .toList(),
      ));
  }
  
}