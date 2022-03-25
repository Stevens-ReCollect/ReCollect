import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/firebase/firestore_service.dart';
import 'package:recollect_app/widgets/photowidget.dart';
import 'package:recollect_app/widgets/videoplayer.dart';
import 'package:recollect_app/widgets/audioplayer.dart';
import 'package:dots_indicator/dots_indicator.dart';

class MemoryPage extends StatefulWidget {
  const MemoryPage({this.memoryData});
  // ignore: prefer_typing_uninitialized_variables
  final memoryData;
  @override
  _MemoryState createState() => _MemoryState();
}

class _MemoryState extends State<MemoryPage> {
  int _currentPage = 0;
  int numOfMoments = 1;
  List moments = [];
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    getMoments();
    super.initState();
  }

  void updatePostiton(double position) {
    setState(() {
      _currentPage = position.toInt();
    });
  }

  getMoments() async {
    moments = await FirestoreService()
        .getMoments(memoryId: widget.memoryData['doc_id']);
    // print(moments);
    // print(moments.length);
    numOfMoments = moments.length;
  }

  memoryCarouselSlider() {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceHeight = queryData.size.height;
    var deviceWidth = queryData.size.width;
    Stream<QuerySnapshot> _momentStream = FirebaseFirestore.instance
        .collection('moments')
        .where("memory_id", isEqualTo: widget.memoryData['doc_id'])
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _momentStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          numOfMoments = snapshot.data!.docs.length;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: deviceWidth,
                height: 0.7 * deviceHeight,
                child: Center(
                  child: CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                      autoPlay: false,
                      aspectRatio: 1 / 1,
                      height: deviceHeight,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        _currentPage = index;
                        // updatePostiton(index.toDouble());
                        print('Current Page: $index');
                      },
                    ),
                    items: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Builder(builder: (BuildContext context) {
                        // print("Print data: $data");
                        if (data.isEmpty) {
                          return const Text("This memory is empty.");
                        } else {
                          if (data['type'] == 'Photo') {
                            return PhotoWidget(data['description'],
                                data['file_path'], data['doc_id']);
                          } else if (data['type'] == 'Video') {
                            return VideoPlayerWidget(data['description'],
                                data['file_path'], data['doc_id']);
                          } else if (data['type'] == 'Audio') {
                            return AudioPlayerWidget(
                                data['description'],
                                data['name'],
                                data['file_path'],
                                data['doc_id']);
                          } else {
                            return const SizedBox();
                          }
                        }
                      });
                    }).toList(),
                  ),
                ),
              ),
              DotsIndicator(
                dotsCount: numOfMoments,
                position: _currentPage.toDouble(),
                decorator: DotsDecorator(
                  activeColor: Colors.grey[850],
                  color: Colors.grey,
                ),
                onTap: (pos) {
                  print(pos);
                  // setState(() => _currentPage = pos.toInt());
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: ColorConstants.appBar,
        title: Text(
          widget.memoryData['title'],
          style: TextStyle(
              fontSize: TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.buttonText)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            width: deviceWidth,
            height: 0.7 * deviceHeight,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
                aspectRatio: 1 / 1,
                height: deviceHeight,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                  });
                  // updatePostiton(index.toDouble());
                  print('Current Page: $index');
                },
              ),
              items: moments.map((moment) {
                print(moment);
                return Builder(builder: (BuildContext context) {
                  if (moment == null) {
                    return const Text("This memory is empty.");
                  } else {
                    if (moment['type'] == 'Photo') {
                      return PhotoWidget(
                        moment['description'],
                        moment['file_path'],
                        moment['doc_id'],
                      );
                    } else if (moment['type'] == 'Video') {
                      return VideoPlayerWidget(
                        moment['description'],
                        moment['file_path'],
                        moment['doc_id'],
                      );
                    } else if (moment['type'] == 'Audio') {
                      return AudioPlayerWidget(
                        moment['description'],
                        moment['name'],
                        moment['file_path'],
                        moment['doc_id'],
                      );
                    } else {
                      return const SizedBox();
                    }
                  }
                });
              }).toList(),
            ),
          ),
          DotsIndicator(
            dotsCount: numOfMoments,
            position: _currentPage.toDouble(),
            decorator: DotsDecorator(
              activeColor: Colors.grey[850],
              color: Colors.grey,
            ),
            onTap: (pos) {
              print(pos);
              // setState(() => _currentPage = pos.toInt());
            },
          ),
        ]),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisSize: MainAxisSize.max,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     SizedBox(
        //       width: deviceWidth,
        //       height: 0.7 * deviceHeight,
        //       child: Center(child: memoryCarouselSlider()),
        //     ),
        //     DotsIndicator(
        //       dotsCount: numOfMoments,
        //       position: _currentPage.toDouble(),
        //       decorator: DotsDecorator(
        //         activeColor: Colors.grey[850],
        //         color: Colors.grey,
        //       ),
        //     )
        //   ],
        // ),
      ),
      // )
    );
  }
}
