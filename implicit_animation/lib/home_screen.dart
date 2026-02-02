import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isVisible = false;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Implicit Animation'), backgroundColor: Colors.white,),
      body: Stack(
        children: [
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                      if (!_isVisible) _isExpanded = false; 
                    });
                  },
                  child: Text(_isVisible ? 'Скрыть' : 'Показать уведомление'),
                ),
              ],
            ),
          ),
          
          // 1. AnimatedAlign: Перемещает виджет
          AnimatedAlign(
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            alignment: _isVisible ? const Alignment(0, -0.5) : const Alignment(0, -1.5),
            
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              
              // 2. AnimatedOpacity: Меняет прозрачность
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: _isVisible ? 1.0 : 0.0,
                
                // 3. AnimatedContainer: Меняет форму и цвет
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: _isExpanded ? 300 : 250,
                  height: _isExpanded ? 150 : 100,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _isExpanded ? Colors.blueAccent : Colors.white,
                    borderRadius: BorderRadius.circular(_isExpanded ? 20 : 10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: _isExpanded ? 20 : 5,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isExpanded ? Icons.check_circle : Icons.message,
                        color: _isExpanded ? Colors.white : Colors.blue,
                        size: 30,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _isExpanded ? "Сообщение прочитано!" : "Новое сообщение",
                        style: TextStyle(
                          color: _isExpanded ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_isExpanded) ...[
                        const SizedBox(height: 5),
                         const Text(
                          "Теперь вы знаете, как работают неявные анимации во Flutter.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}