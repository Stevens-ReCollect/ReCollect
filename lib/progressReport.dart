// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChartData {
        ChartData(this.x, this.y, this.color);
            final String x;
            final double y;
            final Color color;
}

class ProgressReport extends StatefulWidget{
  const ProgressReport({Key? key}) : super(key: key);

  @override
  State<ProgressReport> createState() => ProgressReportState();
  
}

class ProgressReportState extends State<ProgressReport>{
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
            ChartData('Remembrance Rate', 70, Color(0xFF00CB5D)),
            ChartData('Subtract', 30, Colors.white),
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
        title: Text('Progress Report')
      ),
      body: AspectRatio(
        aspectRatio: 100 / 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Expanded(child: 
        Stack(
          alignment: Alignment.center,
          children: <Widget> [
          Container(
           width: deviceWidth,
          child:SfCircularChart(
            palette: [Color(0xFF00CB5D), Colors.white],
                        series: <CircularSeries>[
                            DoughnutSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                // Corner style of doughnut segments
                                cornerStyle: CornerStyle.bothFlat
                            ),
          ]
        )),
        Container(width:0.4*deviceWidth,
        child: Text('70% Overall Remembrance Rate', 
                style: TextStyle(
                fontSize: TextSizeConstants.formField, 
                fontWeight: FontWeight.w800), textAlign: TextAlign.center,),
                ),
          ]
      ),

    )])));
  }
  
}

