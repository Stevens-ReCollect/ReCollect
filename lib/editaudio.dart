import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/firebase/firestore_service.dart';
import 'package:recollect_app/signup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'constants/routeConstants.dart';

class EditAudioPage extends StatefulWidget {
  EditAudioPage({required this.momentData});
  final momentData;

  @override
  _EditAudioPageState createState() => _EditAudioPageState();
}

class _EditAudioPageState extends State<EditAudioPage> {
  TextEditingController _description = TextEditingController(text: "");
  File? _audio;
  File? _thumbnail;
  String _audioName = 'No Audio Selected';
  bool _loading = false;
  bool _isButtonDisabled = false;

  Future setFields() async {
    try {
      _description =
          TextEditingController(text: widget.momentData['description']);
    } on PlatformException catch (e) {
      print("Failed to get image: $e");
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
      setState(() {
        _audio = audioTemp;
        _audioName = audioNameTemp;
        convertImageAssetToFile('lib/assets/audioicon.png')
            .then((value) => _thumbnail = value);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  Future<File> convertImageAssetToFile(String assetPath) async {
    var bytes = await rootBundle.load(assetPath);
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/audioicon.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
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
    return Container(
        child: Stack(children: <Widget>[
      Container(
          child: MaterialApp(
        home: Scaffold(
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
            title: const Text("Edit Audio"),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0.1 * deviceWidth),
                  title: const Text(
                    'Audio Selected',
                    style: TextStyle(
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
                      child: _audio == null
                          ? Image.network(
                              widget.momentData['thumbnail_path'],
                              fit: BoxFit.fill,
                            )
                          : Image.file(
                              _thumbnail!,
                              fit: BoxFit.fill,
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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                      hintText: 'Desciption',
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      openFileFile(_audio!);
                    },
                    child: Text('Open File')),
                /*
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
              */
                Container(
                  margin: const EdgeInsets.only(top: 170.0, left: 0.0),
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
                    onPressed: _isButtonDisabled
                        ? null
                        : () async {
                            setState(() {
                              _loading = true;
                              _isButtonDisabled = true;
                            });
                            print("Clicked Saved");
                            print('$_audio');

                            await FirestoreService().editMoment(
                                memoryId: widget.momentData['memory_id'],
                                momentId: widget.momentData['doc_id'],
                                file: _audio,
                                name: _audioName,
                                thumbnail: _thumbnail,
                                description: _description.text);

                            Navigator.pop(context);
                          },
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
      Container(alignment: Alignment.center, child: loading())
    ]));
  }
}
