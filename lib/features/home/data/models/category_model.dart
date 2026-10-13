import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  final String slug;
  final String image;
  final String creationAt;
  final String updatedAt;

  CategoryModel({
    super.id,
    super.name,
    required this.slug,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    String parsedImage = json['image']?.toString().trim() ?? '';
    if (parsedImage.startsWith('["') && parsedImage.endsWith('"]')) {
      parsedImage = parsedImage.substring(2, parsedImage.length - 2);
    } else if (parsedImage.startsWith('[') && parsedImage.endsWith(']')) {
      parsedImage = parsedImage
          .substring(1, parsedImage.length - 1)
          .replaceAll('"', '')
          .replaceAll("'", "");
    }
    parsedImage = parsedImage.replaceAll('"', '').replaceAll("'", "").trim();

    return CategoryModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      image: parsedImage,
      creationAt: json['creationAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }
}
