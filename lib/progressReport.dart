import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChartData {
        ChartData(this.x, this.y, this.color);
            final String x;
            final double y;
            final Color color;
}

class ProgressReport extends StatefulWidget{
  @override
  State<ProgressReport> createState() => ProgressReportState();
  
}

class ProgressReportState extends State<ProgressReport>{
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
            ChartData('Remembrance Rate', 80, ColorConstants.appBar),
        ];
  MediaQueryData queryData = MediaQuery.of(context);
  var deviceWidth = queryData.size.width;
  var deviceHeight = queryData.size.height;
    return Scaffold(
      body: AspectRatio(
        aspectRatio: 100 / 100,
        child: Column(
          children: <Widget>[
          Text('Progress Report'),
          SfCircularChart(
                        series: <CircularSeries>[
                            DoughnutSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                // Corner style of doughnut segment
                                cornerStyle: CornerStyle.bothCurve
                            ),
          ]
        ),
          ]
      )
    ));
  }
  
}

