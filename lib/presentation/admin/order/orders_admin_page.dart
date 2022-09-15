import 'package:flutter/material.dart';

class OrderssAdminPage extends StatefulWidget {
  const OrderssAdminPage({Key? key}) : super(key: key);

  @override
  State<OrderssAdminPage> createState() => _OrderssAdminPageState();
}

class _OrderssAdminPageState extends State<OrderssAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
    );
  }
}