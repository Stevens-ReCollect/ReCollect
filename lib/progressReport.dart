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

class BarChartData {
  BarChartData(this.type, this.remember, this.subtract);
  final String type;
  final double remember;
  final double subtract;
}

class ProgressReport extends StatefulWidget {
  const ProgressReport({Key? key}) : super(key: key);

  @override
  State<ProgressReport> createState() => ProgressReportState();
}

class ProgressReportState extends State<ProgressReport> {
  double overallRememberanceRate = 0;
  double photoRememberanceRate = 0;
  double videoRememberanceRate = 0;
  double audioRememberanceRate = 0;

  Future getRates() async {
    try {
      final tempRate = await FirestoreService().getOverallRememberanceRate();
      print(tempRate);
      setState(() {
        overallRememberanceRate = double.parse((tempRate).toStringAsFixed(1));
      });
    } on PlatformException catch (e) {
      print('Failed to get Overall Rememberance Rate: $e');
    }
    try {
      final tempRate = await FirestoreService().getPhotoRememberanceRate();
      print(tempRate);
      setState(() {
        photoRememberanceRate = double.parse((tempRate).toStringAsFixed(1));
      });
    } on PlatformException catch (e) {
      print('Failed to get Photo Rememberance Rate: $e');
    }
    try {
      final tempRate = await FirestoreService().getVideoRememberanceRate();
      print(tempRate);
      setState(() {
        videoRememberanceRate = double.parse((tempRate).toStringAsFixed(1));
      });
    } on PlatformException catch (e) {
      print('Failed to get Video Rememberance Rate: $e');
    }
    try {
      final tempRate = await FirestoreService().getAudioRememberanceRate();
      print(tempRate);
      setState(() {
        audioRememberanceRate = double.parse((tempRate).toStringAsFixed(1));
      });
    } on PlatformException catch (e) {
      print('Failed to get Audio Rememberance Rate: $e');
    }
  }

  @override
  void initState() {
    getRates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(
          'Remembrance Rate', overallRememberanceRate, ColorConstants.appBar),
      ChartData('Subtract', 100 - overallRememberanceRate, Colors.white),
    ];
    final List<BarChartData> barChartData = [
      BarChartData('Audio', audioRememberanceRate, 100 - audioRememberanceRate),
      BarChartData('Video', videoRememberanceRate, 100 - videoRememberanceRate),
      BarChartData('Photo', photoRememberanceRate, 100 - photoRememberanceRate),
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
              child: Column(
                //alignment: Alignment.center,
                children: <Widget>[
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
                                'Overall Rememberance Rate',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstants.bodyText,
                                  fontSize:
                                      TextSizeConstants.getadaptiveTextSize(
                                    context,
                                    TextSizeConstants.bodyText,
                                  ),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: deviceWidth,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        isVisible: true,
                      ),
                      primaryYAxis: CategoryAxis(isVisible: true),
                      series: <ChartSeries>[
                        StackedBar100Series<BarChartData, String>(
                          dataSource: barChartData,
                          color: ColorConstants.appBar,
                          xValueMapper: (BarChartData data, _) => data.type,
                          yValueMapper: (BarChartData data, _) => data.remember,
                        ),
                        StackedBar100Series<BarChartData, String>(
                            dataSource: barChartData,
                            color: Color.fromARGB(255, 255, 255, 255),
                            xValueMapper: (BarChartData data, _) => data.type,
                            yValueMapper: (BarChartData data, _) =>
                                data.subtract)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
