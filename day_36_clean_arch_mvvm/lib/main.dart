import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart' as di;
import 'features/users/presentation/bloc/user_bloc.dart';
import 'features/users/presentation/bloc/user_event.dart';
import 'features/users/presentation/pages/user_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => di.sl<UserBloc>()..add(GetUsersEvent()),
        child: const UserPage(),
      ),
    );
  }
}
