import 'package:application/components/alert_dialogs.dart';
import 'package:application/components/app_bar.dart';
import 'package:application/components/bottom_navigation_bar.dart';
import 'package:application/components/drawer.dart';
import 'package:application/modules/purchase_list/components/my_purchases_list.dart';
import 'package:application/modules/purchase_list/controllers/get_my_purchases_list.dart';
import 'package:application/modules/purchase_list/controllers/index_page_purchase_list_controller.dart';
import 'package:application/shared/model/purchase_order_list.dart';
import 'package:application/shared/themes/app_colors.dart';
import 'package:application/shared/themes/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchaseListPage extends StatefulWidget {
  const PurchaseListPage({Key? key}) : super(key: key);

  @override
  State<PurchaseListPage> createState() => _PurchaseListPageState();
}

class _PurchaseListPageState extends State<PurchaseListPage> {
  final pageIndexController = PageIndexPurchaseListController();

  @override
  Widget build(BuildContext context) {
    final params =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
          body: Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            child: FutureBuilder(
              future: getMyPurchasesList(context),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<dynamic>> snapshot,
              ) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      PurchaseOrderList orderList = PurchaseOrderList.fromMap(
                        snapshot.data![index],
                      );

                      String status = 'Pendente';

                      switch (orderList.status) {
                        case 0:
                          status = 'Pagamento Pendente';
                          break;
                        case 1:
                          status = 'Pedido está a caminho';
                          break;
                        case 6:
                          status = 'Pedido Entregue';
                          break;
                        default:
                          status = 'Pendente';
                          break;
                      }

                      return GestureDetector(
                        onTap: () {
                          if (orderList.status == 0) {
                            messageConfirmation(
                              context,
                              'Pagamento pendente',
                              'Este pedido de compra está com pagamento pendente, deseja confirmar o pagamento agora?',
                              () {
                                Navigator.pop(context);
                              },
                              () {},
                            );
                          }
                        },
                        child: Container(
                          height: 100,
                          margin: const EdgeInsets.only(top: 7, bottom: 7),
                          padding: const EdgeInsets.only(top: 4, left: 5),
                          decoration: const BoxDecoration(
                            color: AppColors.background,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.dark,
                                offset: Offset(0.1, 0.1),
                                blurRadius: 1.0,
                              )
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Pedido#: ',
                                        style: TextStyles.trailingBold,
                                      ),
                                      Text(
                                        orderList.id,
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    orderList.purchaseDate,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.only(top: 32),
                                        child: Text(
                                          'Status: ' + status,
                                          style: TextStyle(
                                            color: orderList.status == 0
                                                ? Colors.red
                                                : orderList.status == 6
                                                    ? Colors.green
                                                    : Colors.blue,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: 90,
                                        ),
                                        child: orderList.status == 0
                                            ? const Icon(
                                                Icons.cancel_presentation,
                                                size: 55,
                                              )
                                            : orderList.status == 6
                                                ? const Icon(
                                                    Icons.price_check_sharp,
                                                    size: 55,
                                                  )
                                                : const Icon(
                                                    Icons.privacy_tip_outlined,
                                                    size: 55,
                                                  ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                if (snapshot.hasError) {
                  messageDialog(context, 'Erro', snapshot.error.toString());
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          bottomNavigationBar: BottomNavigationBarApp(
            hideAllButtons: true,
            heightBar: 30,
            pressButtonHome: () {},
            pressButtonList: () {},
          )),
    );
  }
}
