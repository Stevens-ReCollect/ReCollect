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
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class CreateMemoryPage extends StatefulWidget {
  @override
  _CreateMemoryPageState createState() => _CreateMemoryPageState();
}

class _CreateMemoryPageState extends State<CreateMemoryPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _startDate =
      TextEditingController(text: "MM-DD-YYYY");
  final TextEditingController _endDate =
      TextEditingController(text: "MM-DD-YYYY");
  final TextEditingController _description = TextEditingController();

  DateTime sDate = DateTime.now();
  DateTime eDate = DateTime.now();

  File? image;
  bool _loading = false;
  bool _isButtonDisabled = false;

  dateError(BuildContext context) {
    //Error Message
    return AlertDialog(
      title: Text('Date Error!',
          style: TextStyle(
            fontSize: TextSizeConstants.getadaptiveTextSize(
                context, TextSizeConstants.bodyText),
            color: Colors.red,
          )),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15),
              primary: ColorConstants.buttonColor),
          onPressed: () async {
            Navigator.pop(context);
          },
          child: Text('Okay',
              style: TextStyle(
                  fontSize: 0.7 *
                      TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.buttonText))),
        )
      ],
      content: Text(
          'Change the dates so that the start date is before or the same date as the end date!',
          style: TextStyle(
            fontSize: 0.8 *
                TextSizeConstants.getadaptiveTextSize(
                    context, TextSizeConstants.bodyText),
          )),
    );
  }

  startDatePicker() async {
    //start date picker
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
      helpText: 'Select a Start Date',
    );

    if (newDate != null) {
      setState(() {
        String formattedDate = DateFormat('MM-dd-yyyy').format(newDate);
        sDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(newDate));
        _startDate.text = formattedDate;
      });
    }
  }

  endDatePicker() async {
    //start date picker
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
      helpText: 'Select a End Date',
    );

    if (newDate != null) {
      setState(() {
        String formattedDate = DateFormat('MM-dd-yyyy').format(newDate);
        eDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(newDate));
        _endDate.text = formattedDate;
      });
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
      _isButtonDisabled = false;
      return SizedBox();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context); //responsive sizing
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    String logInResult = "";

    return Container(
        child: Stack(children: <Widget>[
      Container(
          child: Scaffold(
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
                margin: const EdgeInsets.only(top: 0.0),
                child: Center(
                  child: Text(
                    'Create a Memory',
                    style: TextStyle(
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.memoryTitle),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0, left: 30.0),
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
                        primary: ColorConstants.buttonColor),
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
                margin: const EdgeInsets.only(top: 5.0, left: 0.0),
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.hintText)),
                child: Row(children: <Widget>[
                  TextButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              ColorConstants.buttonColor)),
                      onPressed: () {
                        startDatePicker();
                      },
                      child: Text(
                        'Start Date',
                        style: TextStyle(
                            fontSize: TextSizeConstants.getadaptiveTextSize(
                                context, TextSizeConstants.formField)),
                      )),
                  Text(
                    _startDate.text,
                    style: TextStyle(
                        fontSize: TextSizeConstants.getadaptiveTextSize(
                            context, TextSizeConstants.formField)),
                  ),
                ]),
              ),
              Container(
                  width: 0.8 * deviceWidth,
                  margin: const EdgeInsets.only(top: 15.0, left: 0.0),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorConstants.hintText)),
                  child: Row(children: <Widget>[
                    TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                ColorConstants.buttonColor)),
                        onPressed: () {
                          endDatePicker();
                        },
                        child: Text(
                          'End Date',
                          style: TextStyle(
                              fontSize: TextSizeConstants.getadaptiveTextSize(
                                  context, TextSizeConstants.formField)),
                        )),
                    Text(
                      _endDate.text,
                      style: TextStyle(
                          fontSize: TextSizeConstants.getadaptiveTextSize(
                              context, TextSizeConstants.formField)),
                    ),
                  ])),
              Container(
                height: 0.23 * deviceHeight,
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
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(10)),
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
                      if (sDate.isAfter(eDate) || eDate.isBefore(sDate)) {
                        //Date Check
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) => dateError(context),
                        );
                      }

                      if (_title != null &&
                          (sDate.isBefore(eDate) ||
                              sDate.isAtSameMomentAs(eDate))) {
                        setState(() {
                          _loading = true;
                        });
                        logInResult = "";
                        final result = await FirestoreService().addNewMemory(
                            title: _title.text,
                            startDate: _startDate
                                .text, //TODO: figure out outputs for date picker
                            endDate: _endDate.text,
                            description: _description.text,
                            file: image);
                        //if (result != null) {
                        // Navigator.pushNamed(
                        //     context, RouteConstants.memoryHomeRoute);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => MemoryHomePage(memoryData: memoryData))))
                        Navigator.pop(context);
                      }
                    }),
              ),
            ],
          ),
        ),
      )),
      Container(alignment: Alignment.center, child: loading())
    ]));
  }
}
