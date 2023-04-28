import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stream_mixin/stream_mixin.dart';

class StatsCard extends StatefulWidget {
  final String title;
  final String? subtitle;
  final updater = StatCardUpdater();
  List<MeasurementData> measuredData = [
    for (int i = 0; i < 10; i++) MeasurementData(i.toDouble(), 25.0)
  ];
  StatsCard({super.key, required this.title, this.subtitle});

  void updateData(List<MeasurementData> data) {
    measuredData.addAll(data);

    while (measuredData.length > 10) {
      measuredData.removeAt(0);
    }

    updater.update(null);
  }

  @override
  State<StatsCard> createState() => _StatsCardState();
}

class StatCardUpdater with StreamMixin {}

class _StatsCardState extends State<StatsCard> {
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
            child: StreamBuilder(
              stream: widget.updater.onChange,
              builder: (cxt, snap) => Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: LineChart(getData(),
                    swapAnimationDuration: const Duration(milliseconds: 150)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text('Current Value: '),
                    Text(
                      'N/A',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                Row(
                  children: [
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
          ),
        ],
      ),
    );
  }

  LineChartData getData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        horizontalInterval: 5.0,
        verticalInterval: 1.0,
      ),
      lineBarsData: [
        LineChartBarData(
            spots: [
              for (final d in widget.measuredData) FlSpot(d.time, d.value)
            ],
            isCurved: true,
            preventCurveOverShooting: true,
            curveSmoothness: 0.5,
            dotData: FlDotData(show: false)
        ),
      ],
      minY: 0.0,
      maxY: 30.0,
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1.0,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 0,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 0,
          ),
        ),
      ),
    );
  }
}

class MeasurementData {
  MeasurementData(this.time, this.value);

  final double time;
  final double value;
}
