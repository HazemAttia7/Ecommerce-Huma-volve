import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/product_model.dart';

void main() {
  group('ApiEndpoints tests', () {
    test('categoriesEndpoint and productsEndpoint exist and format correctly', () {
      expect(ApiEndpoints.categoriesEndpoint, 'categories');
      expect(ApiEndpoints.productsEndpoint, 'products');

      const categoryId = 5;
      final url = "${ApiEndpoints.categoriesEndpoint}/$categoryId/${ApiEndpoints.productsEndpoint}";
      expect(url, 'categories/5/products');
    });
  });

  group('CategoryModel tests', () {
    test('parses clean and messy json correctly', () {
      final json = {
        "id": 1,
        "name": "Electronics",
        "slug": "electronics",
        "image": "[\"https://i.imgur.com/ZANVnHE.jpeg\"]",
        "creationAt": "2026-10-12T13:58:35.000Z",
        "updatedAt": "2026-10-12T13:58:35.000Z",
      };

      final model = CategoryModel.fromJson(json);
      expect(model.id, 1);
      expect(model.name, "Electronics");
      expect(model.slug, "electronics");
      expect(model.image, "https://i.imgur.com/ZANVnHE.jpeg");
      expect(model.creationAt, "2026-10-12T13:58:35.000Z");

      final map = model.toJson();
      expect(map['id'], 1);
      expect(map['name'], "Electronics");
    });

    test('handles nulls safely', () {
      final model = CategoryModel.fromJson({});
      expect(model.id, 0);
      expect(model.name, '');
      expect(model.image, '');
    });
  });

  group('ProductModel tests', () {
    test('parses clean and messy json correctly', () {
      final json = {
        "id": 1,
        "title": "Majestic Mountain Graphic T-Shirt",
        "slug": "majestic-mountain-graphic-t-shirt",
        "price": 44, // int price
        "description": "A great t-shirt\nwith new lines",
        "category": {
          "id": 1,
          "name": "Clothes",
          "slug": "clothes",
          "image": "https://i.imgur.com/ZANVnHE.jpeg",
          "creationAt": "2026-10-12T13:58:35.000Z",
          "updatedAt": "2026-10-12T13:58:35.000Z"
        },
        "images": ["[\"https://i.imgur.com/QkIa5tT.jpeg\"]", "https://i.imgur.com/jb5Yu0h.jpeg"],
        "creationAt": "2026-10-12T13:58:35.000Z",
        "updatedAt": "2026-10-12T13:58:35.000Z"
      };

      final model = ProductModel.fromJson(json);
      expect(model.id, 1);
      expect(model.title, "Majestic Mountain Graphic T-Shirt");
      expect(model.price, 44.0);
      expect(model.category.name, "Clothes");
      expect(model.images.length, 2);
      expect(model.images.first, "https://i.imgur.com/QkIa5tT.jpeg");
      expect(model.images.last, "https://i.imgur.com/jb5Yu0h.jpeg");
      expect(model.description, contains("\n"));

      final map = model.toJson();
      expect(map['title'], "Majestic Mountain Graphic T-Shirt");
      expect(map['price'], 44.0);
    });

    test('handles nulls safely', () {
      final model = ProductModel.fromJson({});
      expect(model.id, 0);
      expect(model.title, '');
      expect(model.price, 0.0);
      expect(model.images, isEmpty);
      expect(model.category.id, 0);
    });
  });
}
