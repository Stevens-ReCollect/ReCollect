import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/memory.dart';

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
          Container(
            alignment: Alignment.centerLeft,
            padding:
                const EdgeInsets.only(left: 20, bottom: 10, top: 3, right: 10),
            child: Text(
              memoryData['views'].toString() + ' Views',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: TextSizeConstants.getadaptiveTextSize(
                      context, TextSizeConstants.tag)),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding:
                const EdgeInsets.only(left: 20, bottom: 10, top: 6, right: 10),
            child: Text(
              memoryData['description'],
              style: TextStyle(
                color: ColorConstants.bodyText,
                fontSize: TextSizeConstants.getadaptiveTextSize(
                    context, TextSizeConstants.bodyText),
              ),
            ),
          ),
          const Spacer(),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 75),
            child: SizedBox(
              height: 2.5 * TextSizeConstants.bodyText,
              width: 0.5 * deviceWidth,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MemoryPage(memoryData: memoryData)));
                },
                child: Text(
                  'View',
                  style: TextStyle(
                    fontSize: TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.buttonText),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      ColorConstants.buttonColor),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      ColorConstants.buttonText),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
