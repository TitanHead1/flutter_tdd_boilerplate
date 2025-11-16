import 'package:flutter_tdd_boilerplate/core/error/failures.dart';
import 'package:flutter_tdd_boilerplate/core/usecase/usecase.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/entities/product.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';


class GetAllProductsUseCase implements UseCase<ProductEntityList , NoParams> {
  final ProductRepositories productRepositories;

  GetAllProductsUseCase(this.productRepositories);

  @override
  Future<Either<Failure, ProductEntityList>> execute(NoParams params) async {

    return await productRepositories.getAllProducts();
  }

}
