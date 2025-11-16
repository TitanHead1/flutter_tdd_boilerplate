import 'package:flutter_tdd_boilerplate/core/error/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_tdd_boilerplate/core/constants/api_constants.dart';
import 'package:flutter_tdd_boilerplate/features/product/data/datasourses/poduct_data_source.dart';
import 'package:flutter_tdd_boilerplate/features/product/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import '../../../../helper/json_reader.dart';
import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late ProductDatasourceImpl productDatasourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    productDatasourceImpl = ProductDatasourceImpl(mockHttpClient);
  });

  group('get product list', () {
    test('should return product model when the response code is 200', () async {
      //arrange
      when(mockHttpClient
              .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.product)))
          .thenAnswer((_) async {
        return http.Response(
            readJson('helper/dummy_data/dummy_product_list.json'), 200);
      });

      //act
      final result = await productDatasourceImpl.getAllProducts();

      //assert
      expect(result, isA<List<ProductModel>>());
    });

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        //arrange
        when(
          mockHttpClient
              .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.product)),
        ).thenAnswer((_) async => http.Response('Not found', 404));

        //act
        final result =  productDatasourceImpl.getAllProducts();

        //assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
