import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/firebase/firestore_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'constants/textSizeConstants.dart';

class AddAudioPage extends StatefulWidget {
  const AddAudioPage({this.memoryData});
  final memoryData;
  @override
  _AddAudioPageState createState() => _AddAudioPageState();
}

class _AddAudioPageState extends State<AddAudioPage> {
  final TextEditingController _description = TextEditingController();
  File? audio;
  String audioName = 'No Audio Selected';
  File? thumbnail;
  bool _loading = false;
  bool _isButtonDisabled = false;

  @override
  void initState() {
    pickAudio();
    super.initState();
  }

  loading() {
    if (_loading) {
      return CircularProgressIndicator();
    } else {
      return SizedBox();
    }
  }

  Future pickAudio() async {
    try {
      final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          allowedExtensions: ['mp3'],
          dialogTitle: 'Add Audio');
      if (result == null) {
        return;
      }
      final platformFile = result.files.first;
      final audioTemp = File(platformFile.path!);
      final audioNameTemp = platformFile.name;
      openFile(platformFile);
      setState(() {
        audio = audioTemp;
        audioName = audioNameTemp;
        convertImageAssetToFile('lib/assets/recollect_logo.png')
            .then((value) => thumbnail = value);
      });
    } on PlatformException catch (e) {
      print('Failed to select audio: $e');
    }
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  Future<File> convertImageAssetToFile(String assetPath) async {
    var bytes = await rootBundle.load(assetPath);
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/recollect_logo.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }

  void openFileFile(File file) {
    try {
      OpenFile.open(file.path);
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context); //responsive sizing
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Add Audio"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 0.1 * deviceWidth),
              title: Text(
                audioName,
                style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0),
              ),
              subtitle: TextButton(
                onPressed: () {
                  pickAudio();
                },
                child: const Text(
                  'Change Audio',
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
                  child: Image.asset(
                    'lib/assets/recollect_logo.png',
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.cover,
                  ),
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
            ElevatedButton(
                onPressed: () {
                  openFileFile(thumbnail!);
                },
                child: Text('Open File')),
            Container(
              margin: const EdgeInsets.only(top: 150.0, left: 0.0),
              width: 0.4 * deviceWidth,
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
                onPressed: _isButtonDisabled
                    ? null
                    : () async {
                        setState(() {
                          _loading = true;
                          _isButtonDisabled = true;
                        });
                        print("Clicked Saved");
                        if (audio != null) {
                          await FirestoreService().addNewMoment(
                              memoryId: widget.memoryData['doc_id'],
                              type: 'Audio',
                              file: audio,
                              name: audioName,
                              thumbnail: thumbnail,
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
    );
  }
}
