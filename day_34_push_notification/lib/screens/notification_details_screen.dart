import 'package:flutter/material.dart';

class NotificationDetailsScreen extends StatelessWidget {
  const NotificationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем ID, переданный через arguments в навигаторе
    final String itemId = ModalRoute.of(context)?.settings.arguments as String? ?? 'Unknown ID';

    return Scaffold(
      appBar: AppBar(title: const Text('Item Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.notifications_active, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text('You opened a deep link!', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text(
              'Item ID from payload:\n$itemId',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}