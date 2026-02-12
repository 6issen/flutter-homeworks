import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../core/dio_client.dart';
import '../core/error_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Инициализируем наш клиент
  final DioClient _client = DioClient();
  
  CancelToken? _cancelToken;
  String _message = 'Нажмите кнопку для теста';
  bool _isLoading = false;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _cancelToken = CancelToken();
  }

  @override
  void dispose() {
    // ОТМЕНА ЗАПРОСА ПРИ УХОДЕ
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel();
    }
    super.dispose();
  }

  Future<void> _fetchData() async {
    _startLoading('Загрузка данных...');
    _refreshToken(); // Обновляем токен, если он был отменен

    try {
      // /delay/2 задерживает ответ на 2 секунды (для теста)
      final response = await _client.dio.get(
        '/delay/2',
        cancelToken: _cancelToken,
      );
      
      if (mounted) {
        setState(() => _message = '✅ Успех!\nURL: ${response.data['url']}');
      }
    } on DioException catch (e) {
      if (mounted) {
        setState(() => _message = ErrorHandler.getMessage(e));
      }
    } finally {
      _stopLoading();
    }
  }

  Future<void> _downloadImage() async {
    _startLoading('Скачивание файла...');
    _refreshToken();

    try {
      final url = 'https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg';
      
      await _client.dio.get(
        url,
        cancelToken: _cancelToken,
        options: Options(responseType: ResponseType.bytes),
        onReceiveProgress: (received, total) {
          if (total != -1 && mounted) {
            setState(() {
              _progress = received / total;
            });
          }
        },
      );
      
      if (mounted) setState(() => _message = '💾 Файл успешно загружен в память!');
    } on DioException catch (e) {
      if (mounted) setState(() => _message = ErrorHandler.getMessage(e));
    } finally {
      _stopLoading();
    }
  }

  Future<void> _forceError404() async {
    _startLoading('Тест ошибки...');
    try {
      await _client.dio.get('/status/404');
    } on DioException catch (e) {
      if (mounted) setState(() => _message = ErrorHandler.getMessage(e));
    } finally {
      _stopLoading();
    }
  }

  // Вспомогательные методы
  void _refreshToken() {
    if (_cancelToken?.isCancelled ?? true) {
      _cancelToken = CancelToken();
    }
  }

  void _startLoading(String msg) {
    setState(() {
      _isLoading = true;
      _message = msg;
      _progress = 0.0;
    });
  }

  void _stopLoading() {
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dio Homework')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading) ...[
              if (_progress > 0) 
                LinearProgressIndicator(value: _progress)
              else 
                const CircularProgressIndicator(),
              const SizedBox(height: 20),
            ],
            
            Text(
              _message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            
            const Spacer(),
            
            // Кнопки управления
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _fetchData,
                child: const Text('GET Запрос (с задержкой)'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _downloadImage,
                child: const Text('Скачать файл (с прогрессом)'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100),
                onPressed: _isLoading ? null : _forceError404,
                child: const Text('Вызвать ошибку 404'),
              ),
            ),
            const SizedBox(height: 10),
            
            if (_isLoading)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _cancelToken?.cancel(),
                  child: const Text('Отменить текущий запрос'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}