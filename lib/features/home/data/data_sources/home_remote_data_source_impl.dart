import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;
  HomeRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiClient.dio.get(ApiEndpoints.categoriesEndpoint);
    return (response.data as List)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<ProductModel>> getProducts(int? categoryId, {int offset = 0, int limit = 10}) async {
    final endpoint = categoryId != null
        ? "${ApiEndpoints.categoriesEndpoint}/$categoryId/${ApiEndpoints.productsEndpoint}"
        : ApiEndpoints.productsEndpoint;
    final response = await apiClient.dio.get(
      endpoint,
      queryParameters: {'offset': offset, 'limit': limit},
    );
    return (response.data as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}
