import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_boilerplate/presentation/common_widgets/app_prompt.dart';
import 'package:flutter_tdd_boilerplate/features/product/presentation/bloc/product_home_bloc.dart';
import 'package:flutter_tdd_boilerplate/features/product/presentation/widgets/product_widgets.dart';
import '../../../../presentation/common_widgets/circular_loading_widget.dart';
import '../../domain/entities/product.dart';

class ProductHomePage extends StatefulWidget {
  const ProductHomePage({super.key});

  @override
  State<ProductHomePage> createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {
  List<ProductEntity> productList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductHomeBloc, ProductHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProductHomeLoading) {
            return const CircularLoadingWidget();
          }
          if (state is ProductDisplaySuccess) {
            productList = state.products.productEntityList;

            return Container(
              key: const Key('product_data'),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  // Calculate the number of columns based on the container width
                  int crossAxisCount = (constraints.maxWidth / 150)
                      .floor(); // Example: each item takes 150px

                  return GridView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        // Dynamic columns count
                        crossAxisSpacing: 10.0,
                        // Spacing between each column
                        mainAxisSpacing: 10.0,
                        // Spacing between each row
                        childAspectRatio: 1,
                        mainAxisExtent: 270),
                    itemCount: productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(4),
                          child: Center(
                            child: ProductCard(product: productList[index]),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }

          if (state is ProductHomeFailure) {
            AppPrompt.showToast(mgs: state.error);
          }
          return const Center(child: Text("No Data available"));
        },
      ),
    );
  }
}
