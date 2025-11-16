import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_boilerplate/core/error/failures.dart';
import 'package:flutter_tdd_boilerplate/core/usecase/usecase.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/entities/product.dart';
import 'package:flutter_tdd_boilerplate/features/product/presentation/bloc/product_home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockGetAllProductsUseCase mockGetAllProductsUseCase;
  late ProductHomeBloc productHomeBloc;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockGetAllProductsUseCase = MockGetAllProductsUseCase();
    mockDatabaseHelper = MockDatabaseHelper();
    productHomeBloc =
        ProductHomeBloc(mockGetAllProductsUseCase, mockDatabaseHelper);
  });

  const tProductList = ProductEntityList(productEntityList: [
    ProductEntity(
        id: 12,
        title: "Test",
        price: "100",
        description: "Testdesc",
        category: "Cat",
        image: "image")
  ]);

  test('initial state should be empty', () {
    expect(productHomeBloc.state, ProductHomeInitial());
  });

  blocTest<ProductHomeBloc, ProductHomeState>(
      'should emit [ProductHomeLoading, ProductDisplaySuccess] when data is gotten successfully',
      build: () {
        when(mockGetAllProductsUseCase.execute(NoParams()))
            .thenAnswer((_) async => const Right(tProductList));
        return productHomeBloc;
      },
      act: (bloc) => bloc.add(const ProductFetchAllProducts()),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [ProductHomeLoading(), const ProductDisplaySuccess(tProductList)]);

  blocTest<ProductHomeBloc, ProductHomeState>(
      'should emit [ProductHomeLoading, ProductHomeFailure] when get data is unsuccessful',
      build: () {
        when(mockGetAllProductsUseCase.execute(NoParams())).thenAnswer(
            (_) async => const Left(ServerFailure('Server failure')));
        return productHomeBloc;
      },
      act: (bloc) => bloc.add(const ProductFetchAllProducts()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            ProductHomeLoading(),
            const ProductHomeFailure('Server failure'),
          ]);
}
