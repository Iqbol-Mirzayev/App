import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/category/category_item.dart';


class CategoryItemView extends StatelessWidget {
  const CategoryItemView({Key? key, required this.categoryItem, required this.onTap})
      : super(key: key);

  final CategoryItem categoryItem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 77,
        width: double.infinity,
        margin: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(3, 4),
                  color: Colors.grey.withOpacity(0.3))
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                categoryItem.imageUrl,
                width: 80,
                height: 77,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    categoryItem.categoryName,
                    style: MyTextStyle.sfProSemibold.copyWith(
                      fontSize: 18,
                      color: MyColors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          categoryItem.description,
                          style: MyTextStyle.sfProRegular.copyWith(
                            fontSize: 14,
                            color: MyColors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        DateFormat.yMMMd().format(categoryItem.createdAt),
                        style: MyTextStyle.sfProRegular.copyWith(
                          fontSize: 12,
                          color: MyColors.black,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}