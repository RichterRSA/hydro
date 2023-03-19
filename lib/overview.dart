import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hydro/custom_widgets/custom_page.dart';
import 'package:hydro/custom_widgets/stats_card.dart';
import 'package:hydro/helpers/readings.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

const double minItemWidth = 300.0;
const double itemHeight = 450;

class _OverviewPageState extends State<OverviewPage> {
  int getCrossAxisCount(double width) {
    return (width / minItemWidth).floor().clamp(1, 4);
  }

  int getMainAxis(double width, int itemCount) {
    int ca = getCrossAxisCount(width);
    return (itemCount / ca).ceil();
  }

  List<FixedTrackSize> getCrossAxisSizes(double width) {
    List<FixedTrackSize> result = [];

    int count = getCrossAxisCount(width);

    for (int i = 1; i <= count; i++) {
      result.add((width / count).round().px);
    }

    return result;
  }

  List<FixedTrackSize> getMainAxisSizes(double width, int itemCount) {
    List<FixedTrackSize> result = [];

    int rowCount = getMainAxis(width, itemCount);

    for (int i = 1; i <= rowCount; i++) {
      result.add(itemHeight.round().px);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var items = [
      const StatsCard(title: 'Temperature', subtitle: '*C'),
      const StatsCard(title: 'Humidity', subtitle: '%'),
      const StatsCard(title: 'Electrical Conductivity', subtitle: 'mS'),
      const StatsCard(title: 'pH'),
      const StatsCard(title: 'Power Consumption', subtitle: 'mW'),
      const StatsCard(title: 'Water Flow', subtitle: 'm^3/s'),
      const StatsCard(title: 'Tank Water Level', subtitle: '%'),
    ];

    return CustomPage(
      title: 'Overview',
      children: [
        FutureBuilder(
          future: getReading(),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: LayoutBuilder(builder: (context, constraints) {
                return LayoutGrid(
                  // Note that the number of columns and rows matches the grid above (3x3)
                  columnSizes: getCrossAxisSizes(constraints.maxWidth - 5.0),
                  rowSizes: getMainAxisSizes(
                    constraints.maxWidth,
                    items.length,
                  ),
                  children: items,
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
