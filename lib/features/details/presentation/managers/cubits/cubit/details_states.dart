import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';

abstract class DetailsStates {}

class DetailsInitial extends DetailsStates {}

class DetailsLoading extends DetailsStates {}

class DetailsSuccess extends DetailsStates {
  final ProductEntity product;

  DetailsSuccess(this.product);
}

class DetailsError extends DetailsStates {
  final String errorMessage;

  DetailsError(this.errorMessage);
}
