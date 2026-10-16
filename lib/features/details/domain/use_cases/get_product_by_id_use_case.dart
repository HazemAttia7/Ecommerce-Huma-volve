import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/errors/failure_model.dart';
import 'package:ecommerce_app_huma_volve/features/details/domain/repos/details_repo.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';

class GetProductByIdUseCase {
  final DetailsRepo detailsRepo;

  GetProductByIdUseCase(this.detailsRepo);

  Future<Either<Failure, ProductEntity>> invoke(int id) async =>
      await detailsRepo.getProductById(id);
}
