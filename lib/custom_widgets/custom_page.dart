import 'package:flutter/material.dart';
import '../helpers/platform_helper.dart';

class CustomPage extends StatefulWidget {
  final String title;
  final List<Widget>? children;

  const CustomPage({super.key, required this.title, this.children});

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (useDesktopLayout(context))
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                color: Colors.green,
                alignment: Alignment.center,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: ListView(
            children:
                (widget.children != null) ? widget.children! : [Container()],
          ),
        ),
      ],
    );
  }
}
