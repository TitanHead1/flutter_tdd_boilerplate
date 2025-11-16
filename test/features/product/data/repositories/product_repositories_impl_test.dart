import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_boilerplate/core/error/exceptions.dart';
import 'package:flutter_tdd_boilerplate/core/error/failures.dart';
import 'package:flutter_tdd_boilerplate/features/product/data/models/product_model.dart';
import 'package:flutter_tdd_boilerplate/features/product/data/repositories/product_repositories_impl.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helper/test_helper.mocks.dart';



void main() {
  late MockProductDataSource mockProductDataSource;
  late ProductRepositoriesImpl productRepositoriesImpl;

  setUp(() {
    mockProductDataSource = MockProductDataSource();
    productRepositoriesImpl = ProductRepositoriesImpl(
      mockProductDataSource,
    );
  });


  const tProductModel = <ProductModel>[
    ProductModel(
        id: 12,
        title: "Test",
        price: "100",
        description: "Testdesc",
        category: "Cat",
        image: "image")
  ];

  const tProductEntity =  ProductEntityList(productEntityList: [
    ProductEntity(
        id: 12,
        title: "Test",
        price: "100",
        description: "Testdesc",
        category: "Cat",
        image: "image")
  ]);

  group('get product list', () {
    test(
      'should return product list when a call to data source is successful',
      () async {
        // arrange
        when(mockProductDataSource.getAllProducts())
            .thenAnswer((_) async => tProductModel);

        // act
        final result = await productRepositoriesImpl.getAllProducts();
        print(result.hashCode.toString());
        print(tProductModel.hashCode.toString());
        print(tProductEntity.hashCode.toString());

        // assert
        expect(result, equals(const Right(tProductEntity)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
          () async {
        // arrange
        when(mockProductDataSource.getAllProducts())
            .thenThrow( ServerException());

        // act
        final result = await productRepositoriesImpl.getAllProducts();

        // assert
        expect(result, equals(const Left(ServerFailure('An error has occurred'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
          () async {
        // arrange
        when(mockProductDataSource.getAllProducts())
            .thenThrow(const SocketException('Failed to connect to the network'));

        // act
        final result = await productRepositoriesImpl.getAllProducts();

        // assert
        expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
      },
    );
  });
}
