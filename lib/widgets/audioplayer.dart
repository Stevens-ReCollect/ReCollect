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
  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    Future duration = audioPlayer.getDuration();
    Future currentPos = audioPlayer.getCurrentPosition();

    initState() {
      audioPlayer.setUrl(widget.asset);
    }

    format(Duration d) =>
        d.toString().split('.').first.padLeft(8, "0"); //duration format

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
              FutureBuilder<dynamic>(
                  // to get current position and duration
                  future: currentPos,
                  builder: (context, snapshot1) {
                    switch (snapshot1.connectionState) {
                      case ConnectionState.none:
                        return const Text('No Connection...');
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return const Text('Awaiting result...');
                      case ConnectionState.done:
                        if (snapshot1.hasError) {
                          return Text('Error: ${snapshot1.error}');
                        } else {
                          return FutureBuilder<dynamic>(
                              future: duration,
                              builder: (context, snapshot2) {
                                switch (snapshot2.connectionState) {
                                  case ConnectionState.none:
                                    return const Text('No Connection...');
                                  case ConnectionState.active:
                                  case ConnectionState.waiting:
                                    return const Text('Awaiting result...');
                                  case ConnectionState.done:
                                    if (snapshot2.hasError) {
                                      return Text('Error: ${snapshot2.error}');
                                    } else {
                                      return Row(children: [
                                        Text(format(Duration(
                                                seconds: snapshot1.data)) +
                                            '/' +
                                            format(Duration(
                                                    seconds: snapshot2.data))
                                                .padLeft(8, "0")),
                                        // Slider.adaptive(
                                        //     value: double.parse(
                                        //         snapshot1.data.toString()),
                                        //     max: double.parse(
                                        //         snapshot2.data.toString()),
                                        //     activeColor:
                                        //         ColorConstants.buttonColor,
                                        //     onChanged: (value) async {
                                        //       await audioPlayer
                                        //           .setUrl(widget.asset);
                                        //     })
                                      ]);
                                    }
                                }
                              });
                        }
                    }
                  })
            ])),
        AffirmButtonsWidget(widget.doc_id).build(context),
      ],
    );
  }
}
