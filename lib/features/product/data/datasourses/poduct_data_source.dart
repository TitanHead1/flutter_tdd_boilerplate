import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tdd_boilerplate/features/product/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';

abstract interface class ProductDataSource {
  Future<List<ProductModel>> getAllProducts();
}

class ProductDatasourceImpl implements ProductDataSource {
  final http.Client client;

  ProductDatasourceImpl(this.client);

  @override
  Future<List<ProductModel>> getAllProducts() async {
   // try {
      debugPrint("Products : Started");
      final response = await client.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.product),
      );
      debugPrint("Products : ${response.body.toString()}");
      if (response.statusCode == 200) {
        List<ProductModel> products = [];
        List<dynamic> jsonList = jsonDecode(response.body);
        for (var item in jsonList) {
          products.add(ProductModel.fromJson(item));
        }
        debugPrint("Products : ${products.toString()}");
        return products;
      } else {
        throw ServerException();
      }
    // } catch (e) {
    //   debugPrint(e.toString());
    //   throw ServerException();
    //   //throw Exception(e.toString());
    // }
  }
}
