import 'package:application/components/alert_dialogs.dart';
import 'package:application/components/list_products_container.dart';
import 'package:application/shared/model/products_model.dart';
import 'package:application/shared/purchases/purchases_controller.dart';
import 'package:application/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ProductsCartCheckout extends StatelessWidget {
  final Size size;
  const ProductsCartCheckout({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final purchasesController = PurchasesController();

    return Container(
      width: size.width,
      height: 300,
      margin: const EdgeInsets.only(bottom: 10),
      child: FutureBuilder(
        future: purchasesController.getShoppingCart(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<dynamic>> snapshot,
        ) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 80, top: 2),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                ProductsModel product = ProductsModel.fromJson(
                  snapshot.data![index],
                );

                return ListProductsContainer(
                  imageUrl: product.image as String,
                  productName: product.name,
                  productDescription: product.description,
                  productCount: product.totalItems,
                  productValue: product.value,
                  hideButtons: false,
                  size: size,
                );
              },
            );
          }

          if (snapshot.hasError) {
            messageDialog(context, "Erro", snapshot.error.toString());
          }

          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.heading,
            ),
          );
        },
      ),
    );
  }
}
