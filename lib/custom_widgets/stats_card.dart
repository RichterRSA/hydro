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
            child: LineChart(getData()),
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
