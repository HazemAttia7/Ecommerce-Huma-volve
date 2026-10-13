import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/errors/failure_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';

abstract class HomeRepo {
   Future<Either<Failure, List<ProductEntity>>> getProducts(int? categoryId);
   Future<Either<Failure, List<CategoryEntity>>> getCategories();
 }