import 'package:flutter/material.dart';
import 'package:malika_shop/data/models/products/product_item.dart';
import 'package:malika_shop/utils/ui_needs/color.dart';
import 'package:malika_shop/utils/ui_needs/style.dart';

class ProductItemView extends StatelessWidget {
  const ProductItemView(
      {Key? key, required this.productItem, required this.onTap})
      : super(key: key);

  final ProductItem productItem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(3, 2),
                  color: Colors.grey.withOpacity(0.3))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  productItem.productImages[0],
                  width: 120,
                  height: 84,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              productItem.productName,
              style: MyTextStyle.sfProRegular.copyWith(
                fontSize: 16,
                color: MyColors.black,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  productItem.currency,
                  style: MyTextStyle.sfProRegular.copyWith(
                    fontSize: 12,
                    color: MyColors.C_0001FC,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  productItem.price.toString(),
                  style: MyTextStyle.sfProRegular.copyWith(
                    fontSize: 12,
                    color: MyColors.C_0001FC,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}