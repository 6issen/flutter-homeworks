import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends StatelessWidget {
  // Поле для хранения переданного параметра
  final String id; 

  const ProductDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Детали товара #$id'),
        // go_router автоматически добавит кнопку "Назад" в AppBar, 
        // если в истории маршрутизатора есть предыдущая страница.
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.inventory_2_outlined, 
              size: 100, 
              color: Colors.blueGrey,
            ),
            const SizedBox(height: 20),
            Text(
              'Вы открыли карточку товара\nс ID: $id',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Жесткий переход сразу на Главную страницу, сбрасывая историю
                context.go('/');
              },
              child: const Text('Вернуться на главную'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Мягкий возврат на один шаг назад в истории (к списку товаров)
                if (context.canPop()) {
                  context.pop();
                } else {
                  // На всякий случай, если истории нет
                  context.go('/products'); 
                }
              },
              child: const Text('Назад к списку'),
            ),
          ],
        ),
      ),
    );
  }
}