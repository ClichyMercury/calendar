import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget({super.key});

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay time = TimeOfDay(hour: 08, minute: 30);
  @override
  Widget build(BuildContext context) {
    final hours = time.hour.toString().padLeft(2, "0");
    final minutes = time.hour.toString().padLeft(2, "0");
    return TextButton(
        onPressed: () async {
          TimeOfDay? newTime =
              await showTimePicker(context: context, initialTime: time);
          if (newTime == null) return;
          setState(() => time = newTime);
        },
        child: Text('$hours:$minutes'));
  }
}