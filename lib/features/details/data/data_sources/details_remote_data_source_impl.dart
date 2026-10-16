import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/details/data/data_sources/details_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

class DetailsRemoteDataSourceImpl implements DetailsRemoteDataSource {
  final ApiClient apiClient;

  DetailsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ProductModel> getProductById(int id) async {
    final response = await apiClient.dio.get(ApiEndpoints.productByIdEndpoint(id));
    return ProductModel.fromJson(response.data as Map<String, dynamic>);
  }
}
