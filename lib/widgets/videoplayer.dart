import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/widgets/affirmButtons.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget(this.description, this.asset, this.doc_id);
  final description;
  final asset;
  final doc_id;

  @override
  Widget build(BuildContext context) {
    VideoPlayerController _videoController =
        VideoPlayerController.network(asset)..initialize();
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        // Find videoplayer package
        SizedBox(
            height: 0.4 *
                TextSizeConstants.getadaptiveTextSize(
                    context, TextSizeConstants.bodyText)),
        Padding(padding: const EdgeInsets.all(10),
          child:Text(
          description,
          style: TextStyle(
              color: ColorConstants.bodyText,
              fontSize: 0.9 *
                  TextSizeConstants.getadaptiveTextSize(
                      context, TextSizeConstants.bodyText)),
        )),
        Stack(
          children: <Widget>[
            AspectRatio(
                aspectRatio: 5 / 4, child: VideoPlayer(_videoController)),
            IconButton(
              iconSize: 1.5 *
                TextSizeConstants.getadaptiveTextSize(
                    context, TextSizeConstants.bodyText),
              color: Colors.white,
              onPressed: () {
                _videoController.value.isPlaying
                    ? _videoController.pause()
                    : _videoController.play();
              },
              icon: Icon(
                _videoController.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
            ),
          ],
        ),
        AffirmButtonsWidget(doc_id).build(context),
      ],
    );
  }
}
