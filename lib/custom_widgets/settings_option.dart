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
  bool init = false;

  // TODO: What was this doing???
  // @override
  // void initState() {
  //   super.initState();
  //   final window = WidgetsBinding.instance.window;
  //   final window = View.of(context);

  //   if (widget.onWindowChange != null) {
  //     widget.onWindowChange!.call(window);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null && !init) {
      switchValue = widget.value!;
      // init = true;
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
