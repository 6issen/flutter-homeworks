import 'package:flutter/material.dart';

class TaskButton extends StatelessWidget {
  const TaskButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 12.0)
      ),
      onPressed: onPressed, 
      child: Text(
        title,  
        style: TextStyle(color: Colors.white), ));
  }
}
