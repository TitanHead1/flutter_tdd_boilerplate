import 'dart:convert';
import 'package:flutter_tdd_boilerplate/features/product/data/models/product_model.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/json_reader.dart';

void main() {
  const testProductModel = ProductModel(
      id: 12,
      title: "Test",
      price: "100",
      description: "Testdesc",
      category: "Cat",
      image: "image");

  test('should be a subclass of product entity', () async {
    //assert
    expect(testProductModel, isA<ProductEntity>());
  });

  test('should return a valid model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helper/dummy_data/dummy_product_response.json'),
    );

    //act
    final result = ProductModel.fromJson(jsonMap);

    //assert
    expect(result, equals(testProductModel));
  });

  test(
    'should return a json map containing proper data',
    () async {
      // act
      final result = testProductModel.toJson();

      // assert
      final expectedJsonMap = {
        'id': 12,
        'title': "Test",
        'price': "100",
        'description': "Testdesc",
        'category': "Cat",
        'image': "image",
      };

      expect(result, equals(expectedJsonMap));
    },
  );
}
