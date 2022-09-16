import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/products/product_item.dart';
import '../../../view_models/product_view_model.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: const FlatAppBarText(
        title: "All Products",
      ),
      body: Column(
        children: [
          ProductPageTop(
            sortText: "Ascending",
            sortClick: () {},
            filterClick: () {},
            categoryClick: () {},
          ),
          const SizedBox(height: 24),
          Expanded(
            child: StreamBuilder<List<ProductItem>>(
              stream: context.read<ProductViewModel>().getProducts(),
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
          )
        ],
      ),
    );
  }
}