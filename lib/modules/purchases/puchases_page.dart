import 'package:application/shared/purchases/purchases_controller.dart';
import 'package:flutter/material.dart';
import 'package:application/components/app_bar.dart';
import 'package:application/components/bottom_navigation_bar.dart';
import 'package:application/components/drawer.dart';
import 'package:application/components/alert_dialogs.dart';
import 'package:application/components/list_products_container.dart';
import 'package:application/modules/purchases/controllers/get_all_products.dart';
import 'package:application/shared/model/products_model.dart';
import 'package:application/shared/themes/app_colors.dart';
import 'package:flutter/widgets.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final purchasesController = PurchasesController();

  List<ProductsModel> productsList = [];

  @override
  Widget build(BuildContext context) {
    final params =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final size = MediaQuery.of(context).size;

    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
        drawer: DrawerDashboard(
          isAdmin: params['isAdmin'] as bool,
          username: params['name'] as String,
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: AppBarApp(
            username: params['name'],
            onPressFunction: () {},
          ),
        ),
        body: FutureBuilder(
          future: getAllProducts(),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<ProductsModel>> snapshot,
          ) {
            if (snapshot.hasData) {
              productsList.clear();
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 80, top: 2),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  productsList.add(snapshot.data![index]);

                  return ListProductsContainer(
                    imageUrl: snapshot.data![index].image as String,
                    productName: snapshot.data![index].name,
                    productDescription: snapshot.data![index].description,
                    productCount: snapshot.data![index].totalItems,
                    productValue: snapshot.data![index].value,
                    addItem: () async {
                      await purchasesController.addItem(
                        snapshot.data![index].id,
                      );

                      int totalItem = await purchasesController.getItem(
                        snapshot.data![index].id,
                      );

                      setState(() {
                        snapshot.data![index].totalItems = totalItem;
                      });
                    },
                    removeItem: () async {
                      if (snapshot.data![index].totalItems == 0) {
                        return;
                      }

                      await purchasesController.removeItem(
                        snapshot.data![index].id,
                      );

                      int totalItem = await purchasesController.getItem(
                        snapshot.data![index].id,
                      );

                      setState(() {
                        snapshot.data![index].totalItems = totalItem;
                      });
                    },
                    size: size,
                  );
                },
              );
            }

            if (snapshot.hasError) {
              messageDialog(
                  context, "Erro", "Erro ao consultar produtos na API");
            }

            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.heading,
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            messageConfirmation(
              context,
              'Carrinho',
              'Deseja proceguir para o checkout?',
              () {
                Navigator.pop(context);
              },
              () async {
                await purchasesController.createShoppingCart(
                  context,
                  productsList,
                );
              },
            );
          },
          child: const Icon(Icons.shopping_cart_checkout_outlined),
          elevation: 30,
        ),
      ),
    );
  }
}
