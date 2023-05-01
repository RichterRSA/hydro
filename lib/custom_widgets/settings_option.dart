import 'dart:ui';
import 'package:flutter/material.dart';

class SettingsOption extends StatefulWidget {
  final String settingName;
  final String? description;
  final bool? value;
  final bool? enabled;
  final void Function(bool)? onChange;
  final void Function(FlutterView)? onWindowChange;

  const SettingsOption({
    super.key,
    required this.settingName,
    this.description,
    this.value,
    this.onChange,
    this.onWindowChange,
    this.enabled,
  });

  @override
  State<SettingsOption> createState() => _SettingsOptionState();
}

class _SettingsOptionState extends State<SettingsOption> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      switchValue = widget.value!;
    }

    return Container(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.0,
              child: Row(
                children: [
                  Text(
                    widget.settingName,
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  const Spacer(),
                  AbsorbPointer(
                    absorbing:
                        (widget.enabled != null) ? !widget.enabled! : false,
                    child: Switch(
                      activeColor: (widget.enabled != null)
                          ? (widget.enabled!)
                              ? Colors.green
                              : Colors.grey
                          : Colors.green,
                      value: switchValue,
                      onChanged: (value) => {
                        setState(
                          () {
                            switchValue = value;

                            if (widget.onChange != null) {
                              widget.onChange!.call(value);
                            }
                          },
                        )
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
              child: Text(
                (widget.description != null) ? widget.description! : '',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}

class SettingsDropOption extends StatefulWidget {
  final String settingName;
  final String? description;
  final int? value;
  final List<String> options;
  final void Function(int)? onChange;
  final void Function(FlutterView)? onWindowChange;

  const SettingsDropOption({
    super.key,
    required this.settingName,
    this.description,
    this.value,
    this.onChange,
    this.onWindowChange,
    required this.options,
  });

  @override
  State<SettingsDropOption> createState() => _SSettingsDropOptionState();
}

class _SSettingsDropOptionState extends State<SettingsDropOption> {
  String dropdownValue = "null";
  @override
  Widget build(BuildContext context) {
    if (widget.value == null) {
      dropdownValue = widget.options.first;
    } else {
      dropdownValue = widget.options.elementAt(widget.value!);
    }

    return Container(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.0,
              child: Row(
                children: [
                  Text(
                    widget.settingName,
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  const Spacer(),
                  DropdownButton(
                    focusColor: Colors.transparent,
                    value: dropdownValue,
                    items: widget.options
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value!;
                        widget.onChange?.call(widget.options.indexOf(value));
                      });
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
              child: Text(
                (widget.description != null) ? widget.description! : '',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
