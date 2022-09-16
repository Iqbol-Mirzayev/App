import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/data/models/category/category_item.dart';

import '../../../../data/models/products/product_item.dart';
import '../../../../view_models/product_view_model.dart';

class CategoryProducts extends StatelessWidget {
  const CategoryProducts({Key? key, required this.categoryItem})
      : super(key: key);

  final CategoryItem categoryItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar:  FlatAppBarBackWithText(title:categoryItem.categoryName ,),
      body: StreamBuilder<List<ProductItem>>(
        stream: context
            .read<ProductViewModel>()
            .getCategoryProducts(categoryId: categoryItem.categoryId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            final products = snapshot.data!;
            return products.isNotEmpty
                ? GridView.count(
              childAspectRatio: 1,
              crossAxisCount: 2,
              children: List.generate(
                products.length,
                    (index) => ProductItemView(
                    onTap: () {
                      Navigator.pushNamed(context, productDetail,
                          arguments: products[index]);
                    },
                    productItem: products[index]),
              ),
            )
                : const Center(child: Text("List Empty"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}