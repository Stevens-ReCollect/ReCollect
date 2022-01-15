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

class MemoryList{
  String type; //file type
  String asset; //link or data call to the file
  String title; //title for audio files
  String description; //description 
  MemoryList(this.type, this.asset,  this.title, this.description);
  //These parameters can be changed to best reflect the firebase or vice versa

Widget selectType(BuildContext context){
  if(type == 'photo'){
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const SizedBox(height:10),
                Text(description, style: TextStyle(color: ColorConstants.bodyText, fontSize: 0.7*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText)),),
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
                const SizedBox(height:10),
                Text(description, style: TextStyle(color: ColorConstants.bodyText, fontSize: 0.7*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText)),),
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
                const SizedBox(height:10),
               Text(description, style: TextStyle(color: ColorConstants.bodyText, fontSize: 0.7*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText)),),
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
                  SizedBox(
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
                  icon: Icon(Icons.play_arrow, color: ColorConstants.buttonColor)),
                
                 IconButton(
                  hoverColor: ColorConstants.appBar,
                  highlightColor: Colors.black,
                  iconSize: TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText),
                  onPressed: () {
                      audioPlayer.pause();
                      print('paused');
                  },
                  icon: Icon(Icons.pause, color: ColorConstants.buttonColor))
                ],
                )),
                
            ],);
    } else {
      return const SizedBox();
    }
}
}

var _videoController;
class MemorySliderState extends State<MemorySlider> {
   var _current;

   @override
  void initState() {
    _current = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Sample moments (will be deleted) that contain file type, link to asset, title (for audio), and description
    
    var m1  = MemoryList('photo', 'lib/assets/wedding-placeholder.jpg', '','This is when you and Grandpa Bobby fed each other the cake.');
    var m2  = MemoryList('photo', 'lib/assets/wedding-placeholder2.jpg', '', 'This is when you and Grandpa Bobby cut your wedding cake.');
    var m3  = MemoryList('video', 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4', '', 'This is a placeholder of a bee.');
    var m4  = MemoryList('audio', 'lib/assets/birdsflying.mp3', 'Birds Flying','This is a placeholder an audio of birds flying.');

    //This list would contain the data calls from firebase, could use a function to make the calls
    //and return the moments
    final List<Widget> memList = [m1.selectType(context), m2.selectType(context), m3.selectType(context), m4.selectType(context)] ;

    return Scaffold(
      body: 
      Stack(
        alignment: AlignmentDirectional.topCenter,
        fit: StackFit.passthrough,
        children: [
        CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 1/1,
          viewportFraction: 1,
          onPageChanged:(index, reason) {
                  setState(() {
                    _current = index + 1;
                  });
                }),
        items: memList
            .map((item) => Container(
                  child: item,
                  padding: const EdgeInsets.all(10),
                  color: Colors.blueGrey[50],
                ))
            .toList()),
            Text((_current.toString()+ "/" + memList.length.toString()),
            style: TextStyle(fontSize:0.6*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText), 
            color: ColorConstants.buttonColor, backgroundColor: Colors.blueGrey[50],
            )),

  ]));
  }
  // @override
  // void dispose() {
  //   super.dispose();
  //   _videoController.dispose();
  // }

}