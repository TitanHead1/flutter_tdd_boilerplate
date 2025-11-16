import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_boilerplate/core/usecase/usecase.dart';
import 'package:flutter_tdd_boilerplate/core/utils/database/database_helper.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/entities/product.dart';
import '../../domain/usecases/get_all_products_use_case.dart';

part 'product_home_event.dart';

part 'product_home_state.dart';

class ProductHomeBloc extends Bloc<ProductHomeEvent, ProductHomeState> {
  final GetAllProductsUseCase _getAllProductsUseCase;

  final DatabaseHelper _dataBaseHelper;

  ProductHomeBloc(this._getAllProductsUseCase, this._dataBaseHelper) : super(ProductHomeInitial()) {
    on<ProductFetchAllProducts>(_onFetchAllProducts);
  }

  void _onFetchAllProducts(
    ProductFetchAllProducts event,
    Emitter<ProductHomeState> emit,
  ) async {

    emit(ProductHomeLoading());
    final res = await _getAllProductsUseCase.execute(NoParams());

    //debugPrint("Database : ${_dataBaseHelper.getAllProducts().toString()}");

    res.fold(
      (l) => emit(ProductHomeFailure(l.message)),
      (r) => emit(ProductDisplaySuccess(r)),
    );
  }
}
