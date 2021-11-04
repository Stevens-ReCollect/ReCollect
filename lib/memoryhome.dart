import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';

class MemoryHomePage extends StatefulWidget {
  @override
  _MemoryHomePageState createState() => _MemoryHomePageState();
}

class _MemoryHomePageState extends State<MemoryHomePage> {
  final List<String> _moments = ['Photo', 'Video', 'Audio'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<int>(
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: const ShapeDecoration(
                color: ColorConstants.buttonColor,
                shape: CircleBorder(),
              ),
              child: const Icon(Icons.add, color: ColorConstants.buttonText),
            ),
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                child: Text('Add Photo'),
                value: 0,
              ),
              const PopupMenuItem<int>(
                child: Text('Add Video'),
                value: 1,
              ),
              const PopupMenuItem<int>(
                child: Text('Add Audio'),
                value: 2,
              ),
            ],
          )
        ],
      ),
      body: ReorderableListView(
        header: const Text('{Memory Title}',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              fontSize: 30.0,
            )),
        children: [
          for (final moment in _moments)
            Card(
              key: ValueKey(moment),
              color: Colors.white,
              elevation: 0,
              child: ListTile(
                title: Text(
                  moment,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 24.0,
                  ),
                ),
                trailing: const Icon(Icons.reorder),
              ),
            ),
        ],
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          setState(
            () {
              final String moment = _moments[oldIndex];
              _moments.removeAt(oldIndex);
              _moments.insert(newIndex, moment);
            },
          );
        },
      ),
    );
  }
}

class AddMomentMenu {
  static const items = <String>[
    photo,
    video,
    audio,
  ];

  static const String photo = 'Add Photo';
  static const String video = 'Add Video';
  static const String audio = 'Add Audio';
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      print('Clicked Add Photo');
      break;
    case 1:
      print('Clicked Add Video');
      break;
    case 2:
      print('Clicked Add Audio');
      break;
  }
}
