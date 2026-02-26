import 'package:flutter/material.dart';
import 'core/di/service_locator.dart';
import 'domain/usecases/get_my_data_usecase.dart';
import 'presentation/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator(); 
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(
        useCase: locator<GetMyDataUseCase>(),
      ),
    );
  }
}