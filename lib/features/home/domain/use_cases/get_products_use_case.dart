import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/errors/failure_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repos/home_repo.dart';

class GetProductsUseCase {
  final HomeRepo homeRepo;

  GetProductsUseCase(this.homeRepo);

  Future<Either<Failure, List<ProductEntity>>> invoke(int? categoryId, {int offset = 0, int limit = 10}) async =>
      await homeRepo.getProducts(categoryId, offset: offset, limit: limit);
}
