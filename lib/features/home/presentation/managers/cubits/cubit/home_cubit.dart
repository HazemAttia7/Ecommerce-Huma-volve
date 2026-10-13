import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/managers/cubits/cubit/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  HomeCubit(this.getCategoriesUseCase, this.getProductsUseCase)
      : super(HomeInitial());

  Future<void> loadHomeData() async {
    int categoryId = 1;
    emit(CategoriesLodaing());

    final categories = await getCategoriesUseCase.invoke();
    categories.fold(
      (failure) => emit(CategoriesError(failure.errMessage)),
      (categories) => emit(CategoriesSuccess(categories)),
    );

    emit(ProductsLoading());
    final products = await getProductsUseCase.invoke(categoryId);
    products.fold(
      (failure) => emit(ProductsError(failure.errMessage)),
      (products) => emit(ProductsSuccess(products)),
    );
  }

  Future<void> getProductsByCategoryId(int categoryId) async {
    emit(ProductsLoading());
    // fold
    final products = await getProductsUseCase.invoke(categoryId);
    products.fold(
      (failure) => emit(ProductsError(failure.errMessage)),
      (products) => emit(ProductsSuccess(products)),
    );
  }
}
