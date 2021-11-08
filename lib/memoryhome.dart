// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';

class MemoryHomePage extends StatefulWidget {
  @override
  _MemoryHomePageState createState() => _MemoryHomePageState();
}

class _MemoryHomePageState extends State<MemoryHomePage> {
  final List<String> _moments = ['Photo', 'Video', 'Audio'];
  // final List<String> _moments = [];

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_moments.isNotEmpty) {
      body = ReorderableListView(
        header: Container(
          margin: const EdgeInsets.all(20.0),
          child: const Text(
            '{Memory Title}',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              fontSize: 30.0,
            ),
          ),
        ),
        children: [
          for (final moment in _moments)
            Card(
              key: ValueKey(moment),
              color: Colors.white,
              elevation: 0,
              margin: const EdgeInsets.all(10.0),
              // child: Slidable(
              child: ListTile(
                title: Text(
                  moment,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 24.0,
                  ),
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    height: 80.0,
                    width: 80.0,
                    child: Image.network(
                      'https://www.brides.com/thmb/1bR5-1Y1y0drTsbS8fhu3gYJxBQ=/1425x0/filters:no_upscale():max_bytes(200000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__brides__public__brides-services__production__2018__12__03__5c057f05648d6b2dd3b5a13a_kristen-and-jonathan-wedding22-fd1d0dc5dfa94482a9c3273b663c4a2d.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                trailing: const Icon(Icons.reorder),
              ),
              //   actionPane: const SlidableScrollActionPane(),
              //   actions: const <Widget>[
              //     IconSlideAction(
              //       caption: 'Delete',
              //       color: Colors.red,
              //       icon: Icons.delete,
              //     )
              //   ],
              //   actionExtentRatio: 1 / 1,
              // ),
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
      );
    } else {
      body = SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: const Text(
                    '{Memory Title}',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Text>[
                Text(
                  'No moments',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 24.0,
                  ),
                ),
                Text(
                  'Press “+” to add moments to this memory',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: PopupMenuButton<int>(
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: ShapeDecoration(
                    color: ColorConstants.buttonColor,
                    shape: const CircleBorder(),
                  ),
                  child: Icon(Icons.add, color: ColorConstants.buttonText),
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
              ),
            ),
          ],
        ),
        body: body);
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
