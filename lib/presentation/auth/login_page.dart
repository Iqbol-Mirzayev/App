import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/view_models/auth_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.onClickSignUp}) : super(key: key);

  final VoidCallback onClickSignUp;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(60)),
              onPressed: signIn,
              icon: const Icon(
                Icons.lock_open,
                size: 32,
              ),
              label: const Text(
                "Sign in",
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.teal, fontSize: 18),
                text: "No Account  ",
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickSignUp,
                    text: "Sign Up",
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    context.read<AuthViewModel>().signIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          context: context,
        );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}