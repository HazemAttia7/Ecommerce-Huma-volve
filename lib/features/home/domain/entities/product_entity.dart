import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';

class ProductEntity {
  final int id;
  final String title;
  final String slug;
  final double price;
  final String description;
  final CategoryEntity category;
  final List<String> images;

  ProductEntity({
    this.id = 0,
    this.title = '',
    this.slug = '',
    this.price = 0.0,
    this.description = '',
    this.category = const CategoryEntity(),
    this.images = const [],
  });
}
