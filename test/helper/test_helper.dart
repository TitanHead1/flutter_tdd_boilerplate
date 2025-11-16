import 'package:flutter_tdd_boilerplate/core/network/connection_checker.dart';
import 'package:flutter_tdd_boilerplate/core/utils/database/database_helper.dart';
import 'package:flutter_tdd_boilerplate/features/product/data/datasourses/poduct_data_source.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/repositories/product_repositories.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/usecases/get_all_products_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
    [
      ProductRepositories,
      ProductDataSource,
     //ConnectionChecker,
      GetAllProductsUseCase,
      DatabaseHelper
    ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)


void main(){}

