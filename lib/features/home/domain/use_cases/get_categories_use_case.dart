import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/errors/failure_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repos/home_repo.dart';

class GetCategoriesUseCase {
  final HomeRepo homeRepo;
  GetCategoriesUseCase(this.homeRepo);

  Future<Either<Failure, List<CategoryEntity>>> invoke() async =>
      await homeRepo.getCategories();
}
