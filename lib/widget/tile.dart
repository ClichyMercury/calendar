import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  const MyListTile(
      {super.key,
      required this.checkpoint,
      this.function,
      required this.title,
      required this.description});
  final bool checkpoint;
  final void Function(bool?)? function;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.deepPurple)),
      child: Row(
        children: [
          Checkbox(value: checkpoint, onChanged: function),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
