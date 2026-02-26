import 'package:go_router/go_router.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/products_screen.dart';
import '../../presentation/screens/product_detail_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) => const ProductsScreen(),
      routes: [
        GoRoute(
          // Передача параметра :id
          path: ':id',
          builder: (context, state) {
            // Получаем параметр из URL
            final productId = state.pathParameters['id']!;
            return ProductDetailScreen(id: productId);
          },
        ),
      ],
    ),
  ],
);