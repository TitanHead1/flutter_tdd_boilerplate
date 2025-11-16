part of 'product_home_bloc.dart';

abstract class ProductHomeEvent extends Equatable {
  const ProductHomeEvent();

  @override
  List<Object?> get props => [];
}

class ProductFetchAllProducts extends ProductHomeEvent{
  const ProductFetchAllProducts();
  @override
  List<Object?> get props => [];
}
