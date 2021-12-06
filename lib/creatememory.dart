import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/firebase/firestore_service.dart';
import 'package:recollect_app/memoryhome.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:recollect_app/main.dart';
import 'constants/routeConstants.dart';
import 'constants/textSizeConstants.dart';

class CreateMemoryPage extends StatefulWidget {
  @override
  _CreateMemoryPageState createState() => _CreateMemoryPageState();
}

class _CreateMemoryPageState extends State<CreateMemoryPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _endDate = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context); //responsive sizing
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 50.0, left: 10.0),
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  'Create a Memory',
                  style: TextStyle(
                    fontSize: TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.memoryTitle),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Container(
              width: 0.8 * deviceWidth,
              margin: const EdgeInsets.only(top: 30.0, left: 0.0),
              child: TextField(
                controller: _title,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Title',
                  labelStyle: TextStyle(
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.formField)),
                  hintText: 'Example: Christmas 2010',
                  hintStyle: TextStyle(
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.formField)),
                ),
              ),
            ),
            Container(
              width: 0.8 * deviceWidth,
              margin: const EdgeInsets.only(top: 15.0, left: 0.0),
              child: TextField(
                controller: _startDate,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Start Date',
                  labelStyle: TextStyle(
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.formField)),
                  hintText: 'MM/DD/YYY',
                  hintStyle: TextStyle(
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.formField)),
                ),
              ),
            ),
            Container(
              width: 0.8 * deviceWidth,
              margin: const EdgeInsets.only(top: 15.0, left: 0.0),
              child: TextField(
                controller: _endDate,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'End Date',
                  labelStyle: TextStyle(
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.formField)),
                  hintText: 'MM/DD/YYYY',
                  hintStyle: TextStyle(
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.formField)),
                ),
              ),
            ),
            Container(
              height: 0.3 * deviceHeight,
              width: 0.8 * deviceWidth,
              margin: const EdgeInsets.only(top: 15.0, left: 0.0),
              child: TextField(
                controller: _description,
                maxLines: 15,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Description',
                  labelStyle: TextStyle(
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.formField)),
                  hintText: 'Description',
                  hintStyle: TextStyle(
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.formField)),
                  alignLabelWithHint: true,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0, left: 0.0),
              width: 0.5 * deviceWidth,
              child: TextButton(
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.buttonText),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
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
                onPressed: () async {
                  final result = FirestoreService().addNewMemory(
                      title: _title.text,
                      startDate: _startDate.text,
                      endDate: _endDate.text,
                      description: _description.text);

                  if (result != null) {
                    // Navigator.pushNamed(
                    //     context, RouteConstants.memoryHomeRoute);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => MemoryHomePage(memoryData: memoryData))))
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
