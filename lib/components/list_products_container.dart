import 'package:application/shared/purchases/format_currency.dart';
import 'package:application/shared/themes/app_colors.dart';
import 'package:application/shared/themes/app_text_style.dart';
import 'package:flutter/material.dart';

class ListProductsContainer extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String productDescription;
  final double productValue;
  final int productCount;
  final Size size;
  final bool hideButtons;
  final VoidCallback? addItem;
  final VoidCallback? removeItem;

  const ListProductsContainer({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.productDescription,
    required this.productCount,
    required this.productValue,
    this.addItem,
    this.removeItem,
    required this.size,
    this.hideButtons = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: AppColors.dark,
            offset: Offset(0.1, 0.1),
            blurRadius: 6.0,
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 3,
            ),
            child: Image.network(
              imageUrl,
              width: 100,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  productName,
                  style: TextStyles.trailingRegular,
                ),
                Text(productDescription),
                SizedBox(height: size.height * 0.01),
                Text(
                  getCurrency(productValue),
                  style: TextStyles.titleListTile,
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              if (!hideButtons) ...[
                SizedBox(
                  width: 40,
                  height: 40,
                  child: IconButton(
                    onPressed: removeItem,
                    icon: const Icon(Icons.remove),
                  ),
                ),
              ],
              Text(productCount.toString()),
              SizedBox(width: size.height * 0.02),
              if (!hideButtons) ...[
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.subtleBlue,
                        AppColors.primary,
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: IconButton(
                    onPressed: addItem,
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.background,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }
}
