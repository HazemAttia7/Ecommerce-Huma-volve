import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/product_model.dart';

class HomeService {
  final ApiClient apiClient;

  HomeService(this.apiClient);

  Future<List<CategoryModel>> getCategories() async {
    final response = await apiClient.dio.get(ApiEndpoints.categoriesEndpoint);
    return (response.data as List)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }

  Future<List<ProductModel>> getProducts(int? categoryId) async {
    final endpoint = categoryId != null
        ? "${ApiEndpoints.categoriesEndpoint}/$categoryId/${ApiEndpoints.productsEndpoint}"
        : ApiEndpoints.productsEndpoint;
    final response = await apiClient.dio.get(endpoint);
    return (response.data as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}
