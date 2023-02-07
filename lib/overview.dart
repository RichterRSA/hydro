import 'package:flutter/material.dart';
import 'package:hydro/custom_widgets/custom_page.dart';
import 'package:hydro/helpers/platform_helper.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    return const CustomPage(
      title: 'Overview',
      children: [
        Text('empty for now...'),
      ],
    );
  }
}
