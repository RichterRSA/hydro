import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
    int l = measuredData.length;
    for (int i = l; i < l + count; i++) {
      double value = generateRandom(min, max);
      measuredData.add(_MeasurementData(i * 1.0, value));
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
        _MeasurementData(measuredData[measuredData.length - 1].time + 0.1,
            generateRandom(min, max)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 300.0,
            child: FutureBuilder(
              builder: (context, snapshot) {
                return LineChart(getData());
              },
              future: addValues(0, 20),
            ),
          ),
          const Spacer(),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: const [
                  Text('Current Value: '),
                  Text(
                    'N/A',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
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

  LineChartData getData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        horizontalInterval: 1,
        verticalInterval: 1,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: [for (final d in measuredData) FlSpot(d.time, d.value)],
        ),
      ],
    );
  }
}

class _MeasurementData {
  _MeasurementData(this.time, this.value);

  final double time;
  final double value;
}
