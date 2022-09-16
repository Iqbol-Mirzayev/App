import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InputLogin extends StatelessWidget {
   InputLogin({super.key, required this.labelText, required TextEditingController anyController});


  String labelText;
  final TextEditingController anyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final TextEditingController emailController = TextEditingController();
    // final TextEditingController passwordController = TextEditingController();

    

    return TextFormField(
      controller: anyController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          fillColor: Colors.grey.shade400,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
              color: Colors.brown, fontWeight: FontWeight.bold)),
    );
  }
}
