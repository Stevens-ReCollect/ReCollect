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
    super.initState();
    getMomentsFromFirebase().then((data) {
      setState(() {
        moments = data;
        numOfMoments = data.length;
      });
    });
  }

  Future getMomentsFromFirebase() async {
    var data = await FirestoreService()
        .getMoments(memoryId: widget.memoryData['doc_id']);
    return data;
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
              carouselController: _controller,
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
                },
              ),
              items: moments.map((moment) {
                // print(moment);
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
          ),
        ]),
      ),
    );
  }
}
