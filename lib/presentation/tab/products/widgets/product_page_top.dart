import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductPageTop extends StatelessWidget {
  const ProductPageTop(
      {Key? key,
      required this.sortText,
      required this.sortClick,
      required this.filterClick,
      required this.categoryClick})
      : super(key: key);

  final String sortText;
  final VoidCallback sortClick;
  final VoidCallback filterClick;
  final VoidCallback categoryClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: sortClick,
            child: Container(
              height: 33,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  width: 1.5,
                  color: MyColors.C_A7A9BE,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    sortText,
                    style: MyTextStyle.sfProMedium.copyWith(
                      color: MyColors.C_A7A9BE,
                    ),
                  ),
                  const SizedBox(width: 9),
                  const Icon(Icons.arrow_upward_rounded, size: 12),
                  const SizedBox(width: 6),
                  const Icon(Icons.expand_more_outlined, size: 12),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: filterClick,
            child: Row(
              children: [
                Text(
                  "Filters",
                  style: MyTextStyle.sfProMedium.copyWith(
                    color: MyColors.C_A7A9BE,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.expand_more_outlined, size: 12),
              ],
            ),
          ),
          GestureDetector(
              onTap: categoryClick, child: SvgPicture.asset(MyIcons.categ))
        ],
      ),
    );
  }
}