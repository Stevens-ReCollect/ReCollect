import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';

class MemoryDetailsPage extends StatelessWidget {
  const MemoryDetailsPage({this.memoryData});
  final memoryData;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: deviceHeight * 0.3,
                width: deviceWidth,
                child: Image(
                  image: NetworkImage(memoryData['file_path']),
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: deviceHeight * 0.3,
                width: deviceWidth,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  memoryData['title'],
                  style: TextStyle(
                    color: ColorConstants.buttonText,
                    fontSize: TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.h2),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 20, bottom: 3, top: 10, right: 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.grey,
                    size: TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.h2),
                  ),
                ),
                Text(
                  memoryData['start_date'],
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.bodyText),
                  ),
                ),
                if (memoryData['end_date'] != 'MM-DD-YYYY')
                  Text(
                    " - " + memoryData['end_date'],
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.bodyText),
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.only(
                      left: 20, bottom: 10, top: 3, right: 10),
                  child: Text(
                    memoryData['views'].toString() + ' Views',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: TextSizeConstants.getadaptiveTextSize(
                            context, TextSizeConstants.tag)),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
