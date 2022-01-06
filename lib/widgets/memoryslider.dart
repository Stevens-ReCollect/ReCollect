import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';

class MemorySlider extends StatefulWidget{
  const MemorySlider({Key? key}) : super(key: key);
  @override
  State<MemorySlider> createState() => MemorySliderState();

}

//TODO: Figure out how to make list of assets 

class MemoryList{
  String type;
  String asset;
  String title;
  String description;
  MemoryList(this.type, this.asset,  this.title, this.description);

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
      VideoPlayerController _videoController = VideoPlayerController.network(asset)..initialize();
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Find videoplayer package
                Text(description, style: TextStyle(color: ColorConstants.bodyText, fontSize: 0.8*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText)),),
                Stack(
                  children: <Widget>[
                AspectRatio(aspectRatio: 5/4,
                child:VideoPlayer(_videoController)),
                FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                      _videoController.value.isPlaying
                          ? _videoController.pause()
                          : _videoController.play();
                  },
                  child: Icon(
                    _videoController.value.isPlaying ? Icons.pause: Icons.play_arrow,
                  ))]),
                  
              ],
            );
    } else if(type == 'audio'){
      AudioPlayer audioPlayer = AudioPlayer();
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Find audioplayer package
               Text(description, style: TextStyle(color: ColorConstants.bodyText, fontSize: 0.8*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText)),),
              const SizedBox(height: 30),
              Container(
                width:0.8*MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:Colors.white,
                  border: Border.all(width: 1, color: ColorConstants.buttonColor)
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Container(
                    width:0.4*MediaQuery.of(context).size.width,
                    child: Text(title, style: TextStyle(fontSize:0.7*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText))),
                  ),
                  IconButton(
                  hoverColor: ColorConstants.appBar,
                  iconSize: TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText),
                  onPressed: () async {
                      await audioPlayer.setUrl(asset);
                      audioPlayer.play(asset);
                      print('playing now');
                  },
                  icon: Icon(Icons.pause, color: ColorConstants.buttonColor)),
                
                 IconButton(
                  hoverColor: ColorConstants.appBar,
                  highlightColor: Colors.black,
                  iconSize: TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText),
                  onPressed: () {
                      audioPlayer.pause();
                      print('paused');
                  },
                  icon: Icon(Icons.play_arrow, color: ColorConstants.buttonColor))
                ],
                )),
                
            ],);
    } else {
      return const SizedBox();
    }
}
}

var _videoController;
// List <Widget> myList = [m1, m2, m3];
class MemorySliderState extends State<MemorySlider> {
   

  // List memoryAssets = ['lib/images/wedding-placeholder.jpg', 'lib/images/wedding-placeholder2.jpg', _videoController];
  // List <String> memoryDescripts = ['Hi', 'You and Bobby cutting the cake'];

  @override
  Widget build(BuildContext context) {
    var m1  = MemoryList('photo', 'lib/images/wedding-placeholder.jpg', '','This is when you and Grandpa Bobby fed each other the cake.');
    var m2  = MemoryList('photo', 'lib/images/wedding-placeholder2.jpg', '', 'This is when you and Grandpa Bobby cut your wedding cake.');
    var m3  = MemoryList('video', 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4', '', 'This is a placeholder of a bee.');
    var m4  = MemoryList('audio', 'lib/images/birdsflying.mp3', 'Birds Flying','This is a placeholder an audio of birds flying.');

    final List<Widget> memList = [m1.selectType(context), m2.selectType(context), m3.selectType(context), m4.selectType(context)] ;
    // int _current = 0;
    // final CarouselController _controller = CarouselController();

    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    return Scaffold(
      body: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 1/1,
          viewportFraction: 1,
        ),
        items: memList
            .map((item) => Container(
                  child: item,
                  padding: const EdgeInsets.all(10),
                  color: Colors.blueGrey[50],
                ))
            .toList()),

         );
  }
  // @override
  // void dispose() {
  //   super.dispose();
  //   _videoController.dispose();
  // }

}