import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/errors/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/errors/failure_model.dart';
import 'package:ecommerce_app_huma_volve/features/details/data/data_sources/details_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/details/domain/repos/details_repo.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';

class DetailsRepoImpl implements DetailsRepo {
  final DetailsRemoteDataSource remoteDataSource;

  DetailsRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int id) async {
    try {
      final product = await remoteDataSource.getProductById(id);
      return Right(product);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }
}
