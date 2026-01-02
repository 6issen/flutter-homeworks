import 'package:flutter/material.dart';
import 'package:hw8/models.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final CounterModel counterModel = CounterModel();

  @override
  void initState() {
    super.initState();
    _setupCounter();
  }

  Future<void> _setupCounter() async {
    await counterModel.loadCounter();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Сохраняемый счетчик')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Текущее значение:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '${counterModel.counter}',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await counterModel.increment();
                setState(() {});
              },
              child: Text('Увеличить'),
            ),
          ],
        ),
      ),
    );
  }
}