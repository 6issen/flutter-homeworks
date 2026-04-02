abstract class ApiResponse {
  // Фабричный конструктор для парсинга
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    
    switch (type) {
      case 'text':
        return TextResponse(json['content']);
      case 'image':
        return ImageResponse(json['url']);
      default:
        return UnknownResponse();
    }
  }
}

class TextResponse implements ApiResponse {
  final String content;
  TextResponse(this.content);
}

class ImageResponse implements ApiResponse {
  final String url;
  ImageResponse(this.url);
}

class UnknownResponse implements ApiResponse {}