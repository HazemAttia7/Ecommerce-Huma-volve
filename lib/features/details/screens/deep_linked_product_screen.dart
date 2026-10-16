import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/core/theme.dart';
import 'package:ecommerce_app_huma_volve/features/details/data/data_source/details_repo_impl.dart';
import 'package:ecommerce_app_huma_volve/features/details/data/data_sources/details_remote_data_source_impl.dart';
import 'package:ecommerce_app_huma_volve/features/details/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/managers/cubits/cubit/details_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/managers/cubits/cubit/details_states.dart';
import 'package:ecommerce_app_huma_volve/features/details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shown when a deep link opens a product. Fetches the product by [productId]
/// and then renders the existing [ProductDetailsScreen].
class DeepLinkedProductScreen extends StatelessWidget {
  final int productId;

  const DeepLinkedProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final apiClient = ApiClient();
    final remoteDataSource = DetailsRemoteDataSourceImpl(apiClient);
    final repo = DetailsRepoImpl(remoteDataSource: remoteDataSource);
    final useCase = GetProductByIdUseCase(repo);

    return BlocProvider(
      create: (context) => DetailsCubit(useCase)..loadProductById(productId),
      child: BlocBuilder<DetailsCubit, DetailsStates>(
        builder: (context, state) {
          if (state is DetailsLoading || state is DetailsInitial) {
            return Scaffold(
              backgroundColor: AppTheme.background,
              appBar: AppBar(backgroundColor: AppTheme.background, elevation: 0),
              body: const Center(child: CircularProgressIndicator()),
            );
          } else if (state is DetailsError) {
            return Scaffold(
              backgroundColor: AppTheme.background,
              appBar: AppBar(backgroundColor: AppTheme.background, elevation: 0),
              body: Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          } else if (state is DetailsSuccess) {
            return ProductDetailsScreen(product: state.product);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
