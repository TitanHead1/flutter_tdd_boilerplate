import 'dart:convert';
import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/entities/product.dart';
import 'package:flutter_tdd_boilerplate/features/product/presentation/bloc/product_home_bloc.dart';
import 'package:flutter_tdd_boilerplate/features/product/presentation/pages/product_home_page.dart';
import 'package:flutter_tdd_boilerplate/features/product/presentation/widgets/product_widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:mocktail/mocktail.dart';

import '../../data/data_sources/product_data_source_test_with_mocktail.dart';

class MockProductHomeBloc extends MockBloc<ProductHomeEvent, ProductHomeState>
    implements ProductHomeBloc {}

void main() {
  late MockProductHomeBloc mockProductHomeBloc;

 // late MockHttpClient mockHttpClient;

  setUp(() {
   // mockHttpClient=MockHttpClient();
    mockProductHomeBloc = MockProductHomeBloc();
    HttpOverrides.global = null;
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<ProductHomeBloc>(
      create: (context) => mockProductHomeBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const tProductList = ProductEntityList(productEntityList: [
    ProductEntity(
        id: 12,
        title: "Test",
        price: "100",
        description: "Testdesc",
        category: "Cat",
        image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")
  ]);

  testWidgets(
    'should show progress indicator when state is loading',
    (widgetTester) async {
      //arrange
      when(() => mockProductHomeBloc.state).thenReturn(ProductHomeLoading());

      //act
      await widgetTester
          .pumpWidget(makeTestableWidget(const ProductHomePage()));

      //assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should show widget contain product data when state is product loaded',
    (widgetTester) async {


      //arrange
      when(() => mockProductHomeBloc.state)
          .thenReturn(const ProductDisplaySuccess(tProductList));

      //act
      await widgetTester
          .pumpWidget(makeTestableWidget(const ProductHomePage()));

      //assert
      expect(find.byKey(const Key("product_data")), findsOneWidget);

    },
  );
}
