import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/data/models/products/product_item.dart';
import 'package:shopping/utils/constants.dart';
import 'package:shopping/view_models/product_view_model.dart';

import 'widgets/product_item_admin.dart';

class ProductsAdminPage extends StatelessWidget {
  const ProductsAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, addProduct),
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: StreamBuilder<List<ProductItem>>(
        stream: context.read<ProductViewModel>().getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            final products = snapshot.data!;
            return products.isNotEmpty
                ? ListView(
                    children: List.generate(
                      products.length,
                      (index) => ProductItemAdmin(
                          onDeleteTap: () {
                            context.read<ProductViewModel>().deleteProduct(
                                  context: context,
                                  docId: products[index].productId,
                                );
                          },
                          productItem: products[index],
                          onUpdateTap: () {
                            // Navigator.pushNamed(
                            //   context,
                            //   updateCategory,
                            //   arguments: Updatep(
                            //     categoryItem: categories[index],
                            //     docId: products[index].categoryId,
                            //   ),
                            // );
                          }),
                    ),
                  )
                : const Center(
                    child: Text("List Empty"),
                  );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
