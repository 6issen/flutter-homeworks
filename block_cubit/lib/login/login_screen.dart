import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Bloc: Логин форма')),
        body: BlocListener<LoginBloc, LoginState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == FormStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Успешный вход!'), backgroundColor: Colors.green),
              );
            }
            if (state.status == FormStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? 'Ошибка'), backgroundColor: Colors.red),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Поле Email
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (prev, curr) => prev.email != curr.email,
                  builder: (context, state) {
                    return TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: const OutlineInputBorder(),
                        errorText: (state.email.isNotEmpty && !state.isValidEmail) ? 'Нужен символ @' : null,
                      ),
                      onChanged: (value) => context.read<LoginBloc>().add(LoginEmailChanged(value)),
                    );
                  },
                ),
                const SizedBox(height: 15),
                // Поле Пароль
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (prev, curr) => prev.password != curr.password,
                  builder: (context, state) {
                    return TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Пароль',
                        border: const OutlineInputBorder(),
                        errorText: (state.password.isNotEmpty && !state.isValidPassword) ? 'Минимум 6 символов' : null,
                      ),
                      onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChanged(value)),
                    );
                  },
                ),
                const SizedBox(height: 25),
                // Кнопка входа
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state.status == FormStatus.loading) {
                      return const CircularProgressIndicator();
                    }
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: state.isValidEmail && state.isValidPassword
                            ? () => context.read<LoginBloc>().add(const LoginFormSubmitted())
                            : null,
                        child: const Text('Войти'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}