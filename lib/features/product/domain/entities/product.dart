import 'package:equatable/equatable.dart';

class ProductEntityList extends Equatable {
  const ProductEntityList({required this.productEntityList});
  final List<ProductEntity>  productEntityList;

  @override
  // TODO: implement props
  List<Object?> get props => [productEntityList];
}

class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  final int? id;
  final String? title;
  final String? price;
  final String? description;
  final String? category;
  final String? image;

  @override
  List<Object?> get props => [id, title, price, description, category, image];
}


