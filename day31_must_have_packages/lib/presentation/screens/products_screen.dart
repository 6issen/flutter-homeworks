import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../data/models/product_dto.dart';
import '../../main.dart'; // для appLocale

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  // Демо-данные (вместо ответа бэкенда)
  List<ProductDto> get mockProducts => [
    ProductDto(
      id: 1,
      title: 'Крутой товар',
      imageUrl: 'https://picsum.photos/200/300', // Тестовая картинка
      price: 1500.50,
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentLang = appLocale.value.languageCode; // 'ru' или 'en'

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список товаров'),
        actions: [
          // Кнопка переключения языка
          TextButton(
            onPressed: () {
              appLocale.value = currentLang == 'ru' 
                  ? const Locale('en') 
                  : const Locale('ru');
            },
            child: Text(currentLang.toUpperCase()),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: mockProducts.length,
        itemBuilder: (context, index) {
          final product = mockProducts[index];
          
          // Форматирование с помощью intl
          final currencyFormat = NumberFormat.currency(
            locale: currentLang == 'ru' ? 'ru_RU' : 'en_US',
            symbol: currentLang == 'ru' ? '₽' : '\$',
          );
          final dateFormat = DateFormat.yMMMMd(
            currentLang == 'ru' ? 'ru_RU' : 'en_US'
          );

          return ListTile(
            // CachedNetworkImage с плейсхолдером и обработкой ошибок
            leading: SizedBox(
              width: 50,
              height: 50,
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                fit: BoxFit.cover,
              ),
            ),
            title: Text(product.title),
            subtitle: Text(dateFormat.format(product.createdAt)),
            trailing: Text(
              currencyFormat.format(product.price),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              // Переход на детальную страницу с передачей ID в go_router
              context.go('/products/${product.id}');
            },
          );
        },
      ),
    );
  }
}