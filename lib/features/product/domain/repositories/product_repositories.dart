import 'dart:async';

import 'package:flutter_tdd_boilerplate/core/error/failures.dart';
import 'package:flutter_tdd_boilerplate/features/auth/domain/entities/user.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/entities/product.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/usecases/get_all_products_use_case.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/product_model.dart';

abstract interface class ProductRepositories{

  Future<Either<Failure ,ProductEntityList>> getAllProducts();
}