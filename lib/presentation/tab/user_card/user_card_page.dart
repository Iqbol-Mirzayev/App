import 'package:flutter/material.dart';

class UserCardsPage extends StatefulWidget {
  const UserCardsPage({Key? key}) : super(key: key);

  @override
  State<UserCardsPage> createState() => _UserCardsPageState();
}

class _UserCardsPageState extends State<UserCardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Card"),
      ),
    );
  }
}