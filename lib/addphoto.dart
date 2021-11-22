import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/signup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'constants/routeConstants.dart';

// void main() => runApp(AddPhotoPage());

class AddPhotoPage extends StatefulWidget {
  @override
  _AddPhotoPageState createState() => _AddPhotoPageState();
}

class _AddPhotoPageState extends State<AddPhotoPage> {
  String _description = '';
  String _image =
      ('https://www.brides.com/thmb/1bR5-1Y1y0drTsbS8fhu3gYJxBQ=/1425x0/filters:no_upscale():max_bytes(200000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__brides__public__brides-services__production__2018__12__03__5c057f05648d6b2dd3b5a13a_kristen-and-jonathan-wedding22-fd1d0dc5dfa94482a9c3273b663c4a2d.jpg');

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
                // subtitle: Text('Change Photo'),
                subtitle: TextButton(
                  onPressed: () {},
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
                    // child: Image.file(_image),
                    child: CachedNetworkImage(
                      imageUrl: "http://via.placeholder.com/150x150",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Container(
                height: 0.3 * deviceHeight,
                width: 0.8 * deviceWidth,
                margin: const EdgeInsets.only(top: 15.0, left: 0.0),
                child: const TextField(
                  maxLines: 15,
                  decoration: InputDecoration(
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
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RouteConstants.memoryHomeRoute);
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
