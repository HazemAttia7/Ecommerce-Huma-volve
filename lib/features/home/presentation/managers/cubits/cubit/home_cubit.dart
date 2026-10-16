import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/managers/cubits/cubit/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  static const int _pageLimit = 10;

  // Tracks which category's products are currently loaded.
  int? _currentCategoryId;
  // Offset for the next page load.
  int _currentOffset = 0;
  // Whether a products request is in-flight.
  bool _isLoadingMore = false;

  HomeCubit(this.getCategoriesUseCase, this.getProductsUseCase)
      : super(HomeInitial());

  Future<void> loadHomeData() async {
    const int categoryId = 1;
    emit(CategoriesLodaing());

    final categories = await getCategoriesUseCase.invoke();
    categories.fold(
      (failure) => emit(CategoriesError(failure.errMessage)),
      (categories) => emit(CategoriesSuccess(categories)),
    );

    _currentCategoryId = categoryId;
    _currentOffset = 0;
    emit(ProductsLoading());
    final products = await getProductsUseCase.invoke(
      categoryId,
      offset: 0,
      limit: _pageLimit,
    );
    products.fold(
      (failure) => emit(ProductsError(failure.errMessage)),
      (products) {
        _currentOffset = products.length;
        emit(ProductsSuccess(
          products,
          hasReachedMax: products.length < _pageLimit,
        ));
      },
    );
  }

  Future<void> getProductsByCategoryId(int categoryId) async {
    _currentCategoryId = categoryId;
    _currentOffset = 0;
    emit(ProductsLoading());
    final products = await getProductsUseCase.invoke(
      categoryId,
      offset: 0,
      limit: _pageLimit,
    );
    products.fold(
      (failure) => emit(ProductsError(failure.errMessage)),
      (products) {
        _currentOffset = products.length;
        emit(ProductsSuccess(
          products,
          hasReachedMax: products.length < _pageLimit,
        ));
      },
    );
  }

  Future<void> loadMoreProducts() async {
    // Do nothing if already loading or no more pages.
    if (_isLoadingMore) return;
    final currentState = state;
    if (currentState is! ProductsSuccess) return;
    if (currentState.hasReachedMax) return;

    _isLoadingMore = true;
    final requestCategoryId = _currentCategoryId;

    // Signal that a load-more is in progress while keeping existing list.
    emit(ProductsSuccess(
      currentState.products,
      hasReachedMax: currentState.hasReachedMax,
      isLoadingMore: true,
    ));

    final result = await getProductsUseCase.invoke(
      requestCategoryId,
      offset: _currentOffset,
      limit: _pageLimit,
    );

    // Ignore the response if the user switched categories while this was in-flight.
    if (_currentCategoryId != requestCategoryId) {
      _isLoadingMore = false;
      return;
    }

    result.fold(
      (failure) {
        // Keep the current list visible, reset the loading flag.
        emit(ProductsSuccess(
          currentState.products,
          hasReachedMax: currentState.hasReachedMax,
          isLoadingMore: false,
        ));
      },
      (newProducts) {
        _currentOffset += newProducts.length;
        emit(ProductsSuccess(
          [...currentState.products, ...newProducts],
          hasReachedMax: newProducts.length < _pageLimit,
          isLoadingMore: false,
        ));
      },
    );

    _isLoadingMore = false;
  }
}
