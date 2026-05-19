import 'package:flutter/material.dart';

class UpdateEvent extends StatefulWidget {
  const UpdateEvent({super.key, required this.data, required this.index});

  final Map<String, dynamic> data;
  final int index;

  @override
  State<UpdateEvent> createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Update Event Screen",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
