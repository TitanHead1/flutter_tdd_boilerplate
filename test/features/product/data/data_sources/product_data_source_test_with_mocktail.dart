import 'package:flutter_tdd_boilerplate/core/error/exceptions.dart';
import 'package:flutter_tdd_boilerplate/features/product/data/datasourses/poduct_data_source.dart';
import 'package:flutter_tdd_boilerplate/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late ProductDatasourceImpl productDataSource;
  late MockHttpClient mockHTTPClient;

  setUp(() {
    mockHTTPClient = MockHttpClient();
    productDataSource = ProductDatasourceImpl(mockHTTPClient);
  });

  test(
    'given UserRepository class when getUser function is called and status code is 200 then a usermodel should be returned',
    () async {
      // Arrange
      when(
        () => mockHTTPClient.get(
          Uri.parse('https://fakestoreapi.com/products'),
        ),
      ).thenAnswer((invocation) async {
        return Response('''
             [
  {
    "id": 1,
    "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    "price": 109.95,
    "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
    "category": "men's clothing",
    "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"
  }
]''', 200);
      });
      // Act
      final user = await productDataSource.getAllProducts();
      // Assert
      expect(user, isA<List<ProductModel>>());
    },
  );
  test(
    'given UserRepository class when getUser function is called and status code is not 200 then an exception should be thrown',
    () async {
      // arrange
      when(
        () => mockHTTPClient.get(
          Uri.parse('https://fakestoreapi.com/products'),
        ),
      ).thenAnswer((invocation) async => Response('Not Found', 404));
      // act
      final user = productDataSource.getAllProducts();
      // assert
      expect(user, throwsA(isA<ServerException>()));
    },
  );
}
