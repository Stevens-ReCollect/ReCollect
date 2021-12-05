import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/firebase/firestore_service.dart';
import 'package:recollect_app/signup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'constants/routeConstants.dart';

class AddPhotoPage extends StatefulWidget {
  const AddPhotoPage({this.memoryData});
  final memoryData;

  @override
  _AddPhotoPageState createState() => _AddPhotoPageState();
}

class _AddPhotoPageState extends State<AddPhotoPage> {
  final TextEditingController _description = TextEditingController();
  File? image;

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

  @override
  void initState() {
    pickImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context); //responsive sizing
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    return MaterialApp(
      home: Scaffold(
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
              ListTile(
                title: const Text(
                  'Photo Selected',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0),
                ),
                subtitle: TextButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: const Text(
                    'Change Photo',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0),
                  ),
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
              Container(
                height: 0.3 * deviceHeight,
                width: 0.8 * deviceWidth,
                margin: const EdgeInsets.only(top: 15.0, left: 0.0),
                child: TextField(
                  controller: _description,
                  maxLines: 15,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                    hintText: 'Desciption',
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: const Center(
                  child: Text(
                    'Add tags',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 250.0, left: 0.0),
                width: 0.4 * deviceWidth,
                child: TextButton(
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 24.0,
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
                  onPressed: () async {
                    print("Clicked");
                    if (image != null) {
                      await FirestoreService().addNewMoment(
                          memoryId: widget.memoryData['docId'],
                          type: 'Photo',
                          file: image,
                          description: _description.text);
                    }
                    // Navigator.pushNamed(
                    //     context, RouteConstants.memoryHomeRoute);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
