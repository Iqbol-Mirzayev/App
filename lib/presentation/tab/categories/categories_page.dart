import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopping/data/models/category/category_item.dart';
import 'package:shopping/utils/constants.dart';
import 'package:shopping/view_models/category_view_model.dart';

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
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
        title: const Text("Categories Page"),
        // actions: [
        //   // IconButton(
        //   //   onPressed: () {
        //   //     Navigator.pushNamed(context, profilePage);
        //   //   },
        //   //   icon: const Icon(
        //   //     Icons.person,
        //   //     color: Colors.white,
        //   //   ),
        //   // )
        // ],
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
              children: categories
                  .map((category) => CategoryItemView(categoryItem: category))
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