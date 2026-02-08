import 'package:flutter_bloc/flutter_bloc.dart';

// --- Состояние (State) ---
class CounterState {
  final int value;
  final List<String> history;

  CounterState({required this.value, required this.history});
}

// --- Логика (Cubit) ---
class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(value: 0, history: []));

  // Метод для обновления истории (ограничиваем 10 записями)
  List<String> _updateHistory(String action) {
    final newHistory = List<String>.from(state.history)..insert(0, action);
    if (newHistory.length > 10) {
      newHistory.removeLast(); // Удаляем старое, если больше 10
    }
    return newHistory;
  }

  void increment() {
    emit(CounterState(
      value: state.value + 1,
      history: _updateHistory('Увеличено (+1) -> ${state.value + 1}'),
    ));
  }

  void decrement() {
    emit(CounterState(
      value: state.value - 1,
      history: _updateHistory('Уменьшено (-1) -> ${state.value - 1}'),
    ));
  }

  void clear() {
    emit(CounterState(value: 0, history: []));
  }
}