import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget(this.description, this.asset);
  final description;
  final asset;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height:0.4*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText)),
                Text(description, style: TextStyle(color: ColorConstants.bodyText, fontSize: 0.9*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText)),),
                AspectRatio(aspectRatio: 5/4,
                child:Image.asset(asset, fit: BoxFit.cover,),
                )
              ],
            );
  }
  
}