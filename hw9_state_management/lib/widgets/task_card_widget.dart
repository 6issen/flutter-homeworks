import 'package:flutter/material.dart';
import 'package:hw9_state_management/entity/task_entity.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.item,
  });

  final TaskEntity item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.all(Radius.circular(12.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          const SizedBox(height: 5.0),
          Text(item.description, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
          const SizedBox(height: 5.0),
          Text(item.createdDate.toString(), style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}