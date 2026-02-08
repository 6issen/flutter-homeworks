import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'list_screen.dart'; // Импорт следующего экрана

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      "title": "Welcome",
      "desc": "Добро пожаловать в мир анимаций Flutter.",
      "lottie": "https://assets10.lottiefiles.com/packages/lf20_w51pcehl.json"
    },
    {
      "title": "Learn",
      "desc": "Изучай Hero, Staggered и AnimatedList.",
      "lottie": "https://assets9.lottiefiles.com/packages/lf20_bo8vqwyw.json"
    },
    {
      "title": "Create",
      "desc": "Создавай плавные и красивые интерфейсы.",
      "lottie": "https://assets2.lottiefiles.com/packages/lf20_h9kds1my.json"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 250,
                        child: Lottie.network(
                          _pages[index]["lottie"]!,
                          errorBuilder: (context, error, stack) =>
                              const Icon(Icons.image, size: 100, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        _pages[index]["title"]!,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _pages[index]["desc"]!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  );
                },
              ),
            ),
            // Индикаторы страниц
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 10,
                  width: _currentPage == index ? 30 : 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.indigo : Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Переход на следующий экран с кастомной анимацией
                Navigator.of(context).pushReplacement(_createRoute());
              },
              child: const Text("Начать"),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Кастомный переход (Fade + Slide)
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const ListScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }
}