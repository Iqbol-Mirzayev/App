import 'package:flutter/material.dart';
import 'package:shopping/presentation/widgets/my_custom_button.dart';
import 'package:shopping/utils/constants.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Admin Panel"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyCustomButton(
            onTap: () => Navigator.pushNamed(context, adminCategories),
            text: "Categories",
          ),
          const SizedBox(height: 30),
          MyCustomButton(
            onTap: () => Navigator.pushNamed(context, adminProducts),
            text: "Products",
          ),
          const SizedBox(height: 30),
          MyCustomButton(
            onTap: () => Navigator.pushNamed(context, adminOrders),
            text: "Users Orders",
          ),
        ],
      ),
    );
  }
}