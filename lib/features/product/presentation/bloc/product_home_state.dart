part of 'product_home_bloc.dart';


abstract class ProductHomeState extends Equatable {
  const ProductHomeState();

  @override
  List<Object?> get props => [];
}

class ProductHomeInitial extends ProductHomeState {}

class ProductHomeLoading extends ProductHomeState{}

class ProductHomeFailure extends ProductHomeState {
  final String error;
  const ProductHomeFailure(this.error);

  @override
  List<Object?> get props => [error];
}


class ProductDisplaySuccess extends ProductHomeState {
  final ProductEntityList products;
  const ProductDisplaySuccess(this.products);

  @override
  List<Object?> get props => [products];
}