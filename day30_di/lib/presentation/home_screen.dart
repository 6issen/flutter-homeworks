import 'package:flutter/material.dart';
import '../domain/usecases/get_my_data_usecase.dart';

class HomeScreen extends StatefulWidget {
  final GetMyDataUseCase useCase;

  const HomeScreen({super.key, required this.useCase});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _data = 'Загрузка...';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final result = await widget.useCase.call();
    setState(() {
      _data = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DI Example')),
      body: Center(child: Text(_data)),
    );
  }
}