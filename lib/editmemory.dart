import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/firebase/firestore_service.dart';
import 'package:recollect_app/memoryhome.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:recollect_app/main.dart';
import 'constants/routeConstants.dart';
import 'constants/textSizeConstants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EditMemoryPage extends StatefulWidget {
  const EditMemoryPage({this.memoryData});
  final memoryData;

  @override
  _EditMemoryPageState createState() => _EditMemoryPageState();
}

class _EditMemoryPageState extends State<EditMemoryPage> {
  TextEditingController _title = TextEditingController(text: "");
  TextEditingController _startDate = TextEditingController(text: "");
  TextEditingController _endDate = TextEditingController(text: "");
  TextEditingController _description = TextEditingController(text: "");

  File? image;
  bool _loading = false;

  Future setFields() async {
    try {
      _title = TextEditingController(text: widget.memoryData['title']);
      _startDate = TextEditingController(text: widget.memoryData['start_date']);
      _endDate = TextEditingController(text: widget.memoryData['end_date']);
      _description =
          TextEditingController(text: widget.memoryData['description']);
    } on PlatformException catch (e) {
      print("Failed to get image: $e");
    }
  }

  Future pickImage() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file == null) {
        return;
      }
      final imageTemp = File(file.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  loading() {
    if (_loading) {
      return CircularProgressIndicator();
    } else {
      return SizedBox();
    }
  }

  @override
  void initState() {
    setFields();
    super.initState();
  }

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
              margin: const EdgeInsets.only(top: 20.0, left: 30.0),
              child: ListTile(
                title: const Text(
                  'Cover Photo',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0),
                ),
                subtitle: TextButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: image != null
                      ? const Text(
                          'Change Photo',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0),
                        )
                      : const Text("Add Photo"),
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 60.0,
                      minWidth: 60.0,
                      maxHeight: 60.0,
                      maxWidth: 60.0,
                    ),
                    child: image != null
                        ? Image.file(
                            image!,
                            width: 60.0,
                            height: 60.0,
                            fit: BoxFit.cover,
                          )
                        : const FlutterLogo(size: 60.0),
                  ),
                ),
              ),
            ),
            Container(
              width: 0.8 * deviceWidth,
              margin: const EdgeInsets.only(top: 15.0, left: 0.0),
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
                  'Save',
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
                  setState(() {
                    _loading = true;
                  });
                  await FirestoreService().editMemory(
                      title: _title.text,
                      startDate: _startDate.text,
                      endDate: _endDate.text,
                      description: _description.text,
                      thumbnail: image,
                      memoryId: widget.memoryData['doc_id']);

                  Navigator.pop(context, true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
