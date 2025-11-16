import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_boilerplate/core/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/entities/product.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/usecases/get_all_products_use_case.dart';
import '../../../../helper/test_helper.mocks.dart';

void main() {
  late GetAllProductsUseCase useCase;
  late MockProductRepositories mockProductRepositories;

  setUp(() {
    mockProductRepositories = MockProductRepositories();
    useCase = GetAllProductsUseCase(mockProductRepositories);
  });

  const tProduct = ProductEntityList(productEntityList: [
    ProductEntity(
        id: 12,
        title: "Test",
        price: "100",
        description: "Testdesc",
        category: "Cat",
        image: "image")
  ]);
  provideDummy(tProduct);

  test(
    'should get List<Product> from the repository',
    () async {
      // arrange
      when(mockProductRepositories.getAllProducts())
          .thenAnswer((_) async => const Right(tProduct));
      // act
      final result = await useCase.execute(NoParams());

      // assert
      expect(result, const Right(tProduct));
    },
  );
}
