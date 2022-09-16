import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../utils/my_utils.dart';
import '../../view_models/auth_view_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.onClickedSignIn}) : super(key: key);

  final VoidCallback onClickedSignIn;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.C_0001FC,
      appBar: const AuthAppBar(
        text: "Register",
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(MyIcons.register, width: 200, height: 200),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? "Enter a valid email"
                          : null,
                  style: MyTextStyle.sfProRegular.copyWith(
                    color: MyColors.white,
                    fontSize: 17,
                  ),
                  decoration: getInputDecoration(label: "Email"),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) =>
                      password != null && password.length < 6
                          ? "Enter at least 6 charcter !"
                          : null,
                  style: MyTextStyle.sfProRegular.copyWith(
                    color: MyColors.white,
                    fontSize: 17,
                  ),
                  decoration: getInputDecoration(label: "Password"),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: TextFormField(
                  controller: confirmPasswordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) =>
                      password != null && password.length < 6
                          ? "Enter at least 6 charcter !"
                          : null,
                  style: MyTextStyle.sfProRegular.copyWith(
                    color: MyColors.white,
                    fontSize: 17,
                  ),
                  decoration: getInputDecoration(label: "Confirm password"),
                ),
              ),
              const SizedBox(height: 50),
              MyWhiteButton(onTap: signUp, text: "Sign Up"),
              const SizedBox(height: 20),
              RichText(
                  text: TextSpan(
                      style: MyTextStyle.sfProRegular.copyWith(
                          color: const Color(0xFFFBDF00), fontSize: 18),
                      text: "Already have an account? ",
                      children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: "Sign In",
                      style: MyTextStyle.sfProBold.copyWith(
                        color: const Color(0xFFFBDF00),
                        fontSize: 18,
                      ),
                    )
                  ]))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (confirmPassword == password) {
      context.read<AuthViewModel>().signUp(
            email: email,
            password: password,
            context: context,
          );
    } else {
      MyUtils.getMyToast(message: "Passwords don't match!");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}