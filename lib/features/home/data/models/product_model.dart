import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  final String creationAt;
  final String updatedAt;

  ProductModel({
    super.id,
    super.title,
    super.slug,
    super.price,
    super.description,
    super.category,
    super.images,
    required this.creationAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedImages = [];
    if (json['images'] != null && json['images'] is List) {
      for (var item in json['images']) {
        if (item != null) {
          String str = item.toString().trim();
          if (str.startsWith('["') && str.endsWith('"]')) {
            str = str.substring(2, str.length - 2);
          } else if (str.startsWith('[') && str.endsWith(']')) {
            str = str
                .substring(1, str.length - 1)
                .replaceAll('"', '')
                .replaceAll("'", "");
          }
          str = str.replaceAll('"', '').replaceAll("'", "").trim();
          if (str.isNotEmpty) {
            parsedImages.add(str);
          }
        }
      }
    }

    return ProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      category:
          json['category'] != null && json['category'] is Map<String, dynamic>
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : CategoryModel(
              id: 0,
              name: '',
              slug: '',
              image: '',
              creationAt: '',
              updatedAt: '',
            ),
      images: parsedImages,
      creationAt: json['creationAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }
}
