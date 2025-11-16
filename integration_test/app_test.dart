import 'package:flutter/material.dart';
import 'package:flutter_tdd_boilerplate/features/product/presentation/pages/product_home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_tdd_boilerplate/main.dart' as app;


void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end test', (){

    testWidgets('username, password and button click with navigate screen',
            (tester) async {

        app.main();
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextFormField).at(0), 'Username');
        await tester.enterText(find.byType(TextFormField).at(1), 'Password');
        await tester.tap(find.byType(ElevatedButton),);



        await tester.pumpAndSettle();

        expect(find.byType(ProductHomePage), findsOneWidget);



        }
    );
  },);
}