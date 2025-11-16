import 'package:flutter_tdd_boilerplate/features/product/domain/entities/product.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required int id,
    required String title,
    required String price,
    required String description,
    required String category,
    required String image,
  }) : super(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        title: json['title'],
        price: json['price'].toString(),
        description: json['description'],
        category: json['category'],
        image: json['image'],
      );

  Map < String, dynamic > toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'description': description,
    'category': category,
    'image': image,
  };

  ProductEntity toEntity() => ProductEntity(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image);
}
