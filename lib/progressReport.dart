// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'firebase/firestore_service.dart';

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class ProgressReport extends StatefulWidget {
  const ProgressReport({Key? key}) : super(key: key);

  @override
  State<ProgressReport> createState() => ProgressReportState();
}

class ProgressReportState extends State<ProgressReport> {
  double overallRememberanceRate = 0;
  String bestMemory = "";
  double memoryRememberanceRate = 0;
  String bestMoment = "";
  double momentRememberanceRate = 0;

  Future getRates() async {
    try {
      final tempRate = await FirestoreService().getOverallRememberanceRate();
      setState(() {
        overallRememberanceRate = double.parse((tempRate).toStringAsFixed(1));
      });
      print(overallRememberanceRate);
    } on PlatformException catch (e) {
      print('Failed to get Overall Rememberance Rate: $e');
    }
  }

  Future getMemoryRate() async {
    num tempRate = 0;

    try {
      final allmemories = await FirestoreService().getBestMemory();

      allmemories.forEach((key, value) {
        if (value > tempRate) {
          bestMemory = key;
          tempRate = value;
        }
      });
      setState(() {
        memoryRememberanceRate = double.parse((tempRate).toStringAsFixed(1));
      });
    } on PlatformException catch (e) {
      print('Failed to get Memory Rememberance Rate: $e');
    }
  }

  Future getMomentRate() async {
    num tempRate = 0;

    try {
      final allmemories = await FirestoreService().getBestMoment();

      allmemories.forEach((key, value) {
        if (value > tempRate) {
          bestMoment = key;
          tempRate = value;
        }
      });
      setState(() {
        momentRememberanceRate = double.parse((tempRate).toStringAsFixed(1));
      });
    } on PlatformException catch (e) {
      print('Failed to get Moment Rememberance Rate: $e');
    }
  }

  @override
  void initState() {
    getRates();
    getMemoryRate();
    getMomentRate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(
          'Remembrance Rate', overallRememberanceRate, ColorConstants.appBar),
      ChartData('Subtract', 100 - overallRememberanceRate, Colors.white),
    ];
    final List<ChartData> chartDataMemory = [
      ChartData(
          'Remembrance Rate', memoryRememberanceRate, ColorConstants.appBar),
      ChartData('Subtract', 100 - memoryRememberanceRate, Colors.white),
    ];
    final List<ChartData> chartDataMoment = [
      ChartData(
          'Remembrance Rate', momentRememberanceRate, ColorConstants.appBar),
      ChartData('Subtract', 100 - momentRememberanceRate, Colors.white),
    ];
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    return Scaffold(
      appBar: AppBar(
        // App bar properties
        // title: Text(widget.title),
        automaticallyImplyLeading: true,
        backgroundColor: ColorConstants.appBar,
        title: Text(
          'Progress Report',
          style: TextStyle(
            fontSize: TextSizeConstants.getadaptiveTextSize(
              context,
              TextSizeConstants.buttonText,
            ),
          ),
        ),
      ),
      body: AspectRatio(
        aspectRatio: 100 / 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  // Container(
                  //   margin: const EdgeInsets.only(top: 200.0),
                  //   width: 0.9 * deviceWidth,
                  //   child: Text(
                  //     'Progress Report is Currently in Development',
                  //     style: TextStyle(
                  //         fontSize: 40, fontWeight: FontWeight.w800),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  Container(
                    width: deviceWidth,
                    child: SfCircularChart(
                      palette: [
                        // Color(0xFF00CB5D),
                        ColorConstants.appBar,
                        Colors.white,
                      ],
                      series: <CircularSeries>[
                        DoughnutSeries<ChartData, String>(
                          dataSource: chartData,
                          radius: '90%',
                          innerRadius: '80%',
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          // Corner style of doughnut segments
                          cornerStyle: CornerStyle.bothFlat,
                        ),
                      ],
                      annotations: <CircularChartAnnotation>[
                        CircularChartAnnotation(
                          width: '100%',
                          height: '70%',
                          radius: '0%',
                          horizontalAlignment: ChartAlignment.center,
                          verticalAlignment: ChartAlignment.center,
                          widget: Column(
                            children: [
                              Text(
                                '$overallRememberanceRate%',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstants.bodyText,
                                  fontSize:
                                      TextSizeConstants.getadaptiveTextSize(
                                    context,
                                    TextSizeConstants.h2,
                                  ),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Memory Rememberance Rate: $memoryRememberanceRate, $momentRememberanceRate, $overallRememberanceRate',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstants.bodyText,
                                  fontSize:
                                      TextSizeConstants.getadaptiveTextSize(
                                    context,
                                    TextSizeConstants.hint,
                                  ),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // CircularChartAnnotation(
                        //   width: '100%',
                        //   height: '40%',
                        //   radius: '0%',
                        //   horizontalAlignment: ChartAlignment.center,
                        //   verticalAlignment: ChartAlignment.center,
                        //   widget: Text(
                        //     'Overall Rememberance Rate',
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //       color: ColorConstants.bodyText,
                        //       fontSize: TextSizeConstants.getadaptiveTextSize(
                        //         context,
                        //         TextSizeConstants.bodyText,
                        //       ),
                        //       fontWeight: FontWeight.w400,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
