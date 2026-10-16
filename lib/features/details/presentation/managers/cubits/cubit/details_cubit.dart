import 'package:ecommerce_app_huma_volve/features/details/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/managers/cubits/cubit/details_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsCubit extends Cubit<DetailsStates> {
  final GetProductByIdUseCase getProductByIdUseCase;

  DetailsCubit(this.getProductByIdUseCase) : super(DetailsInitial());

  Future<void> loadProductById(int id) async {
    emit(DetailsLoading());
    final result = await getProductByIdUseCase.invoke(id);
    result.fold(
      (failure) => emit(DetailsError(failure.errMessage)),
      (product) => emit(DetailsSuccess(product)),
    );
  }
}
