import 'package:flutter/material.dart';

class ExplicitAnimationScreen extends StatefulWidget {
  const ExplicitAnimationScreen({super.key});

  @override
  State<ExplicitAnimationScreen> createState() => _ExplicitAnimationScreenState();
}

// Подключаем Mixin. Без него vsync не заработает.
class _ExplicitAnimationScreenState extends State<ExplicitAnimationScreen>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2), 
      vsync: this, 
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack, // Немного оттягивается назад перед стартом
    );

    // Настройка Tween (диапазонов)
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 2.5).animate(curvedAnimation);

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero, 
      end: const Offset(0, 0), // Сдвигаем вверх на 1.5 высоты объекта
    ).animate(curvedAnimation);
  }

  @override
  void dispose() {
    // КРАЙНЕ ВАЖНО: Освобождаем ресурсы контроллера
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explicit Animation')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              // 6. AnimatedBuilder - оптимизация.
              child: AnimatedBuilder(
                animation: _controller,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.rocket_launch, color: Colors.white, size: 50),
                ),
                builder: (context, childWidget) {
                  return Transform.translate(
                    offset: _slideAnimation.value * 100, // *100 для перевода в пиксели, если Offset в долях
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: childWidget,
                    ),
                  );
                },
              ),
            ),
          ),

          // Панель управления
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.blueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                  icon: Icons.play_arrow,
                  label: "Start",
                  onTap: () {
                    if (_controller.isCompleted) {
                      _controller.reset();
                    }
                    _controller.forward();
                  },
                ),
                _buildButton(
                  icon: Icons.pause,
                  label: "Stop",
                  onTap: () {
                    _controller.stop();
                  },
                ),
                _buildButton(
                  icon: Icons.replay,
                  label: "Reverse",
                  onTap: () {
                    _controller.reverse();
                  },
                ),
                _buildButton(
                  icon: Icons.loop,
                  label: "Repeat",
                  onTap: () {
                    _controller.repeat(reverse: true);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon),
          color: Colors.white,
          iconSize: 32,
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white)),
      ],
    );
  }
}