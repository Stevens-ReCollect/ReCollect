import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/widgets/affirmButtons.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget(this.description, this.title, this.asset, this.doc_id,
      {Key? key})
      : super(key: key);

  final description;
  final title;
  final asset;
  final doc_id;

  @override
  AudioPlayerState createState() => AudioPlayerState();
}

 
class AudioPlayerState extends State<AudioPlayerWidget> {
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  Duration _position = Duration();
  Duration _duration = Duration();

    @override
    void initState() {
      audioPlayer.setUrl(widget.asset);
      audioPlayer.onAudioPositionChanged.listen((Duration  p) => {
        setState(() => _position = p)
      });
        audioPlayer.onDurationChanged.listen((Duration  d) => {
        setState(() => _duration = d)
      });
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    // Future duration = audioPlayer.getDuration();
    // Future currentPos = audioPlayer.getCurrentPosition();
      format(Duration d) =>
        d.toString().split('.').first.padLeft(8, "0");

    getAssetDuration() {
      var d = double.parse(_duration.inSeconds.toString());
      var p = double.parse(_position.inSeconds.toString());

      if (_duration == Duration(seconds: 0)){
        return Container();
      }
      return Row(children: [
        Text(format(_position) + "/" + format(_duration)),
        SliderTheme(
        data:  SliderThemeData(
                thumbColor: ColorConstants.appBar,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5)),
        child:Slider(
            activeColor: ColorConstants.appBar,
            max: d,
            value: p,
            onChanged: (value) {
              setState(() {
                p = value;
              });
            }))
      ]);
    }
            
       

 //duration format

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
            widget.description,
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
                    child: Text(widget.title,
                        style: TextStyle(
                            fontSize: 0.7 *
                                TextSizeConstants.getadaptiveTextSize(
                                    context, TextSizeConstants.bodyText))),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      await audioPlayer.setUrl(widget.asset);
                      audioPlayer.play(widget.asset);
                      print('playing');
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: Text('Play',
                        style: TextStyle(
                            fontSize: 0.6 *
                                TextSizeConstants.getadaptiveTextSize(
                                    context, TextSizeConstants.bodyText))),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          ColorConstants.buttonColor),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      await audioPlayer.setUrl(widget.asset);
                      audioPlayer.pause();
                      print('paused');
                    },
                    icon: const Icon(Icons.pause),
                    label: Text('Pause',
                        style: TextStyle(
                            fontSize: 0.6 *
                                TextSizeConstants.getadaptiveTextSize(
                                    context, TextSizeConstants.bodyText))),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          ColorConstants.buttonColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              getAssetDuration(),
            ])),
        AffirmButtonsWidget(widget.doc_id).build(context),
      ],
    );
  }
}
