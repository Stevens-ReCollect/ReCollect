import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';

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
            width: 0.8 * MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(width: 1, color: ColorConstants.buttonColor)),
            child: Row(
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
                IconButton(
                    hoverColor: ColorConstants.appBar,
                    iconSize: TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.bodyText),
                    onPressed: () async {
                      await audioPlayer.setUrl(asset);
                      audioPlayer.play(asset);
                      print('playing now');
                    },
                    icon: Icon(Icons.play_arrow,
                        color: ColorConstants.buttonColor)),
                IconButton(
                    hoverColor: ColorConstants.appBar,
                    highlightColor: Colors.black,
                    iconSize: TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.bodyText),
                    onPressed: () {
                      audioPlayer.pause();
                      print('paused');
                    },
                    icon: Icon(Icons.pause, color: ColorConstants.buttonColor))
              ],
            )),
      ],
    );
  }
}
