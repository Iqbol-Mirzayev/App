import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/category/category_item.dart';
import '../../../view_models/category_view_model.dart';
import 'widgets/category_item_view.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: const FlatAppBarText(
        title: "Categories",
      ),
      body: StreamBuilder<List<CategoryItem>>(
        stream: context.read<CategoryViewModel>().getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            final categories = snapshot.data!;
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: categories
                  .map((category) => CategoryItemView(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          categoryProductsPage,
                          arguments: category,
                        );
                      },
                      categoryItem: category))
                  .toList(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}