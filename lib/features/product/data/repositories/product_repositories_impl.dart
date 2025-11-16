import 'dart:io';

import 'package:flutter_tdd_boilerplate/core/error/failures.dart';
import 'package:flutter_tdd_boilerplate/core/network/connection_checker.dart';
import 'package:flutter_tdd_boilerplate/features/product/data/datasourses/poduct_data_source.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/product.dart';

class ProductRepositoriesImpl implements ProductRepositories {
  final ProductDataSource productDataSource;

  ProductRepositoriesImpl(this.productDataSource);

  @override
  Future<Either<Failure, ProductEntityList>> getAllProducts() async {
    try {
      final blogs = await productDataSource.getAllProducts();
      List<ProductEntity> list = [];
      for (var i in blogs) {
        list.add(i.toEntity());
      }
      ProductEntityList productEntityList =
          ProductEntityList(productEntityList: list);
      return Right(productEntityList);
    } on ServerException catch (e) {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
