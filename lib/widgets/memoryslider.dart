import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:video_player/video_player.dart';

class MemorySlider extends StatefulWidget{
  const MemorySlider({Key? key}) : super(key: key);
  @override
  State<MemorySlider> createState() => MemorySliderState();

}

//TODO: Figure out how to make list of assets 

class MemoryList {
  String type;
  String asset;
  String description;
  MemoryList(this.type, this.asset, this.description);

Widget selectType(BuildContext context){
  if(type == 'photo'){
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(description, style: TextStyle(color: ColorConstants.bodyText, fontSize: 0.8*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText)),),
                AspectRatio(aspectRatio: 5/4,
                child:Image.asset(asset, fit: BoxFit.cover,),
                ) 
              ],
            );
    } else if( type == 'video'){
      VideoPlayerController _videoController = VideoPlayerController.network(asset);
      return Column(
              children: <Widget>[
                // Find videoplayer package
                Text(description, style: TextStyle(color: ColorConstants.bodyText, fontSize: 0.8*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText)),),
                VideoPlayer(_videoController),
              ],
            );
    } else if(type == 'audio'){
      return Column(
              children: <Widget>[
                // Find audioplayer package
               Text(description, style: TextStyle(color: ColorConstants.bodyText, fontSize: 0.8*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText)),),
              ],
            );
    } else {
      return const SizedBox();
    }
}
}

var _videoController;
// List <Widget> myList = [m1, m2, m3];
class MemorySliderState extends State<MemorySlider> {
  @override
  void initState() {
    var _videoController = VideoPlayerController.network('https://www.youtube.com/watch?v=ZnpY9UmdoRo').initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }
  
  // List memoryAssets = ['lib/images/wedding-placeholder.jpg', 'lib/images/wedding-placeholder2.jpg', _videoController];
  // List <String> memoryDescripts = ['Hi', 'You and Bobby cutting the cake'];

  @override
  Widget build(BuildContext context) {
    String firstDesc = 'This is when you and Grandpa Bobby fed each other the cake.';
    var m1  = MemoryList('photo', 'lib/images/wedding-placeholder.jpg', firstDesc);
    String secDesc = 'This is when you and Grandpa Bobby cut your wedding cake.';
    var m2  = MemoryList('photo', 'lib/images/wedding-placeholder2.jpg', secDesc);
    String thirdDesc = 'This is a film of your wedding day.';

    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    return Scaffold(
      body: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 1/1,
          viewportFraction: 1,
        ),
        items: [m1.selectType(context), m2.selectType(context)],
                ),
  
      );
  }
  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

}