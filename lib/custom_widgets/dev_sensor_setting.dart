import 'package:flutter/material.dart';

class DevSensor extends StatefulWidget {
  final String sensorName;
  final bool canToggle;
  final String? unit;

  const DevSensor(
      {super.key,
      required this.sensorName,
      required this.canToggle,
      this.unit});

  @override
  State<DevSensor> createState() => _DevSensorState();
}

class _DevSensorState extends State<DevSensor> {
  bool switchValue = true;
  @override
  Widget build(BuildContext context) {
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
                    widget.sensorName,
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  const Spacer(),
                  (widget.canToggle)
                      ? Switch(
                          activeColor: Colors.green,
                          value: switchValue,
                          onChanged: (value) => {
                            setState(
                              () {
                                switchValue = value;
                              },
                            )
                          },
                        )
                      : const Text(''),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const Text(
                  'Trigger:',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: SizedBox(
                    width: 200.0,
                    height: 45.0,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Value',
                      ),
                    ),
                  ),
                ),
                (widget.unit != null)
                    ? SizedBox(
                        width: 50.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.unit!),
                        ),
                      )
                    : const SizedBox(
                        width: 50.0,
                      ),
              ],
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
