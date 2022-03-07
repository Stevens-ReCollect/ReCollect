import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/widgets/affirmButtons.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget(
      this.description, this.title, this.asset, this.doc_id);
  final description;
  final title;
  final asset;
  final doc_id;

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = AudioPlayer();
    format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
    final Future duration = audioPlayer.getDuration();
    final Future currentPos = audioPlayer.getCurrentPosition();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
            height: 0.4 *
                TextSizeConstants.getadaptiveTextSize(
                    context, TextSizeConstants.bodyText)),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            description,
            style: TextStyle(
                color: ColorConstants.bodyText,
                fontSize: 0.9 *
                    TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.bodyText)),
          ),
        ),
        SizedBox(
            height: 0.4 *
                TextSizeConstants.getadaptiveTextSize(
                    context, TextSizeConstants.bodyText)),
        Container(
            width: 0.9 * MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(width: 1, color: ColorConstants.buttonColor)),
            child: Column(children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 0.4 * MediaQuery.of(context).size.width,
                  child: Text(title,
                      style: TextStyle(
                          fontSize: 0.7 *
                              TextSizeConstants.getadaptiveTextSize(
                                  context, TextSizeConstants.bodyText))),
                ),
                
                TextButton.icon(onPressed: () async { 
                  await audioPlayer.setUrl(asset);
                      audioPlayer.play(asset);
                      print('playing');
                    }, 
                    icon: const Icon(Icons.play_arrow), 
                    label: Text('Play',
                      style: TextStyle(
                          fontSize: 0.7*TextSizeConstants.getadaptiveTextSize(
                                  context, TextSizeConstants.bodyText))),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor: MaterialStateProperty.all<Color>(ColorConstants.buttonColor),
                      ),
                  ),
                  TextButton.icon(onPressed: () async { 
                  await audioPlayer.setUrl(asset);
                      audioPlayer.pause();
                      print('paused');
                    }, 
                    icon: const Icon(Icons.pause), 
                    label: Text('Pause',
                      style: TextStyle(
                          fontSize: 0.7*TextSizeConstants.getadaptiveTextSize(
                                  context, TextSizeConstants.bodyText))),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor: MaterialStateProperty.all<Color>(ColorConstants.buttonColor),),),
                    
              ],
            ),
            const SizedBox(height: 20,),
            FutureBuilder<List<dynamic>>(
              future: Future.wait([currentPos, duration]),
              builder: (context, snapshot) {
                var myList = snapshot.data!; 
                   switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Text('No Connection...');
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return const Text('Awaiting result...');
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                  }
                return Row(children: [
                Text(format(Duration(seconds:myList[0])).toString() + '/' + format(Duration(seconds:myList[1])).toString().padLeft(8, "0")),
                Slider.adaptive(
                  value: double.parse(myList[0].toString()), 
                  max: double.parse(myList[1].toString()),
                  activeColor: ColorConstants.buttonColor,
                  onChanged: (value) async {
                    await audioPlayer.setUrl(asset);
                    myList[0] = value;
                   })
                ]);
                 }
            
              }

            ),
            ])),

          AffirmButtonsWidget(doc_id).build(context),
      ],
    );
  }
}
