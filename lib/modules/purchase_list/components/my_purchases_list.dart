import 'package:application/components/alert_dialogs.dart';
import 'package:application/modules/purchase_list/controllers/get_my_purchases_list.dart';
import 'package:application/shared/model/purchase_order_list.dart';
import 'package:application/shared/themes/app_colors.dart';
import 'package:application/shared/themes/app_text_style.dart';
import 'package:flutter/material.dart';

class MyPyrchasesList extends StatefulWidget {
  const MyPyrchasesList({Key? key}) : super(key: key);

  @override
  State<MyPyrchasesList> createState() => _MyPyrchasesListState();
}

class _MyPyrchasesListState extends State<MyPyrchasesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Meus Pedidos',
            style: TextStyles.trailingRegular,
          ),
          Container(
            padding: const EdgeInsets.only(top: 15),
            child: FutureBuilder(
              future: getMyPurchasesList(context),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<dynamic>> snapshot,
              ) {
                // if (snapshot.hasData) {
                //   return ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: snapshot.data!.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       // PurchaseOrderList orderList = PurchaseOrderList.fromMap(
                //       //   snapshot.data![index],
                //       // );

                //       return Text('orderList.purchaseTotal.toString()');
                //     },
                //   );
                // }

                if (snapshot.hasError) {
                  messageDialog(context, 'Erro', snapshot.error.toString());
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
