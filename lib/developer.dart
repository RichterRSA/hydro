import 'package:flutter/material.dart';
import 'package:hydro/custom_widgets/custom_page.dart';

import 'custom_widgets/dev_sensor_setting.dart';

class DeveloperPage extends StatefulWidget {
  const DeveloperPage({super.key});

  @override
  State<DeveloperPage> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  @override
  Widget build(BuildContext context) {
    return const CustomPage(
      title: 'Developer Options',
      children: [
        DevSensor(
          sensorName: 'pH Sensor',
          canToggle: true,
        ),
        DevSensor(
          sensorName: 'Temp Sensor',
          canToggle: true,
          unit: 'deg',
        ),
        DevSensor(
          sensorName: 'Ultrasonic Sensor',
          canToggle: true,
          unit: 'cm',
        ),
        DevSensor(
          sensorName: 'EC Sensor',
          canToggle: true,
          unit: 'units',
        ),
        DevSensor(
          sensorName: 'pH Sensor',
          canToggle: true,
        ),
        DevSensor(
          sensorName: 'Temp Sensor',
          canToggle: true,
          unit: 'deg',
        ),
        DevSensor(
          sensorName: 'Ultrasonic Sensor',
          canToggle: true,
          unit: 'cm',
        ),
        DevSensor(
          sensorName: 'EC Sensor',
          canToggle: true,
          unit: 'units',
        ),
      ],
    );
  }
}


//  -------------------------------
//  | SENSOR_NAME         TOGGLE  |
//  |   SETTING           VALUE   |
//  ------------------------------- 

// -  Ultrasonic sensor(tank water level)
//         Ons wil die target distance(hoe vol die tank is) kan stel, dit sal n afstand in cm wees
// - Temperature + humidity sensors
//         Ons wil die target temperatuur waarby die fans aanskakel kan stel sowel as die target                      humidity waarby die fans aansit kan stel.
// -ec sensor:
//         Word gebruik om die nutrientlevels te meet, moet die target ec (electrical conductivity) kan              stel waarby die peristaltic pumps nog nutrients byvoeg
// -Selfde storie met pH sensor