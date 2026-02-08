import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_cubit.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Создаем Cubit через BlocProvider
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Cubit: Счетчик + История')),
        body: Column(
          children: [
            const SizedBox(height: 20),
            // 2. BlocSelector обновляет ТОЛЬКО цифру
            BlocSelector<CounterCubit, CounterState, int>(
              selector: (state) => state.value,
              builder: (context, count) {
                return Text('$count', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold));
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(builder: (context) {
                  return IconButton.filledTonal(
                    onPressed: () => context.read<CounterCubit>().decrement(),
                    icon: const Icon(Icons.remove),
                  );
                }),
                const SizedBox(width: 20),
                Builder(builder: (context) {
                  return IconButton.filled(
                    onPressed: () => context.read<CounterCubit>().increment(),
                    icon: const Icon(Icons.add),
                  );
                }),
              ],
            ),
            const Divider(height: 40),
            const Text("История (последние 10):"),
            // 3. BlocBuilder обновляет список истории
            Expanded(
              child: BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  if (state.history.isEmpty) {
                    return const Center(child: Text("История пуста"));
                  }
                  return ListView.builder(
                    itemCount: state.history.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.history, size: 18),
                        title: Text(state.history[index]),
                        dense: true,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        // Кнопка очистки
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().clear(),
            child: const Icon(Icons.delete_forever),
          );
        }),
      ),
    );
  }
}