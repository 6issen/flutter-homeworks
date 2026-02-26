import 'package:freezed_annotation/freezed_annotation.dart';

// Эти два файла будут сгенерированы автоматически
part 'product_dto.freezed.dart';
part 'product_dto.g.dart';

@freezed
abstract class ProductDto with _$ProductDto {
  const factory ProductDto({
    required int id,
    required String title,
    required String imageUrl,
    required double price,
    required DateTime createdAt,
  }) = _ProductDto;

  factory ProductDto.fromJson(Map<String, dynamic> json) => 
      _$ProductDtoFromJson(json);
}