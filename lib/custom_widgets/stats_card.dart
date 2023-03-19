import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsCard extends StatefulWidget {
  final String title;
  final String? subtitle;
  const StatsCard({super.key, required this.title, this.subtitle});

  @override
  State<StatsCard> createState() => _StatsCardState();
}

class _StatsCardState extends State<StatsCard> {
  List<_MeasurementData> measuredData = [];

  void generateRandomData(int min, int max, int count) {
    for (int i = 0; i < count; i++) {
      double value = generateRandom(min, max);
      DateTime dt = DateTime(2023, 0, 0, 0, 0, i);
      measuredData.add(_MeasurementData(dt, value));
    }
  }

  double generateRandom(int min, int max) {
    Random r = Random();
    return (r.nextInt(max - min) + min).toDouble();
  }

  Future<void> addValues(int min, int max) async {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      measuredData.add(
        _MeasurementData(
            measuredData[measuredData.length - 1]
                .time
                .add(const Duration(seconds: 1)),
            generateRandom(min, max)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    generateRandomData(20, 30, 10);
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: Text(widget.title),
            subtitle: Text(
              (widget.subtitle != null) ? widget.subtitle! : '',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          SfCartesianChart(
            primaryXAxis: DateTimeAxis(),
            series: <ChartSeries<_MeasurementData, DateTime>>[
              // Renders line chart
              LineSeries<_MeasurementData, DateTime>(
                  dataSource: measuredData,
                  xValueMapper: (_MeasurementData data, _) => data.time,
                  yValueMapper: (_MeasurementData data, _) => data.value)
            ],
          ),
          const Spacer(),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Current Value: N/A'),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // Perform some action
                },
                child: const Text('More'),
              ),
              TextButton(
                onPressed: () {
                  // Perform some action
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MeasurementData {
  _MeasurementData(this.time, this.value);

  final DateTime time;
  final double value;
}
