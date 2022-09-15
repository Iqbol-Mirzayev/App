import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/data/models/category/category_item.dart';
import 'package:shopping/data/models/category/update_arguments.dart';
import 'package:shopping/utils/constants.dart';
import 'package:shopping/view_models/category_view_model.dart';

import 'widgets/category_item_admin.dart';

class CategoriesAdminPage extends StatelessWidget {
  const CategoriesAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, addCategory),
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
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
            return categories.isNotEmpty
                ? ListView(
                    children: List.generate(
                      categories.length,
                      (index) => CategoryItemAdmin(
                        onDeleteTap: () {
                          context.read<CategoryViewModel>().deleteCategory(
                                context: context,
                                docId: categories[index].categoryId,
                              );
                        },
                        categoryItem: categories[index],
                        onUpdateTap: () => Navigator.pushNamed(
                          context,
                          updateCategory,
                          arguments: UpdateCategoryArgs(
                            categoryItem: categories[index],
                            docId: categories[index].categoryId,
                          ),
                        ),
                      ),
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