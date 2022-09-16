import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/utils/login_const/login_const.dart';
import 'package:shopping/utils/my_pic.dart';
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
      // appBar: AppBar(
      //   title: const Text("Login Page"),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyIcons.backImage), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///   INPUT FIELD REGISTRATION

              InputLogin(
                labelText: "Email ...",
                anyController: emailController,
              ),
              const SizedBox(height: 10),
              InputLogin(
                labelText: "Password ...",
                anyController: passwordController,
              ),
              const SizedBox(height: 12),

              /////    SIGN IN BUTTON IS HERE

              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.brown),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: signIn,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text("Login", style: TextStyle(fontSize: 20),),
                ),
              ),
             
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.teal, fontSize: 18),
                  text: "No Account ?    ",
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickSignUp,
                      text: "Sign Up",
                      style: const TextStyle(
                        color: Colors.black
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
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
