import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/widgets/affirmButtons.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget(this.description, this.asset, this.doc_id, {Key? key}) : super(key: key);
  final String description;
  final String asset;
  final String doc_id;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          height: 0.4 *
              TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(description,
              style: TextStyle(
                color: ColorConstants.bodyText,
                fontSize: 0.9 *
                    TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.bodyText),
              )),
        ),
        
        AspectRatio(
            aspectRatio: 5 / 4, child: Image.network(asset, fit: BoxFit.cover)),

        AffirmButtonsWidget(this.doc_id).affirmingResponse(context),
      ],
    );
  }
}
