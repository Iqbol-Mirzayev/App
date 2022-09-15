import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/data/models/category/category_item.dart';
import 'package:shopping/presentation/widgets/my_custom_button.dart';
import 'package:shopping/presentation/widgets/universal_text_input.dart';
import 'package:shopping/utils/my_utils.dart';
import 'package:shopping/view_models/category_view_model.dart';

class CategoryAddPage extends StatefulWidget {
  const CategoryAddPage({Key? key,})
      : super(key: key);

  @override
  State<CategoryAddPage> createState() => _CategoryAddPageState();
}

class _CategoryAddPageState extends State<CategoryAddPage> {
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController categoryDescriptionController =
      TextEditingController();
  String imageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQCOMUy2yraqtX914uSr6r2owJ3C48jFysRQ&usqp=CAUx`";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Category Add Page"),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: Colors.red)),
        child: Column(
          children: [
            UniversalTextInput(
              hintText: "Category name",
              textController: categoryNameController,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),
            UniversalTextInput(
              hintText: "Description",
              textController: categoryDescriptionController,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 20),
            Image.network(
              imageUrl,
              width: 200,
              height: 150,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {},
              child: const Text(
                "Upload category Image",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            MyCustomButton(
              onTap: () {
                String desc = categoryDescriptionController.text;
                String name = categoryNameController.text;
                if (desc.isEmpty) {
                  MyUtils.getMyToast(message: "Enter category name");
                } else if (name.isEmpty) {
                  MyUtils.getMyToast(message: "Enter category description");
                } else if (imageUrl.isEmpty) {
                  MyUtils.getMyToast(message: "Upload category image!");
                } else {
                  context.read<CategoryViewModel>().addCategory(
                        context: context,
                        categoryItem: CategoryItem(
                          imageUrl: imageUrl,
                          createdAt: DateTime.now(),
                          categoryName: name,
                          categoryId: "",
                          description: desc,
                        ),
                      );
                  Navigator.pop(context);
                }
              },
              text: "Add category",
            )
          ],
        ),
      ),
    );
  }
}