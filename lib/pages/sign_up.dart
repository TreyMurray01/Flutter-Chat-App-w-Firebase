// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/components/app_button.dart';
import 'package:to_do/components/app_text_field.dart';
import 'package:to_do/components/text_button.dart';
import 'package:to_do/services/auth/auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  void signUp() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    if (passwordConfirmController.text != passwordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Passwords don't match")));
    }
    try {
      await authService.signUp(emailController.text, passwordController.text);
      Navigator.of(context).popAndPushNamed('/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error could not create account. Try again later.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 25,
              ),
              // Logo
              const Icon(
                Icons.message,
                size: 80,
              ),
              const SizedBox(
                height: 25,
              ),
              //welcome back message
              const Text("Continue to sign up."),
              const SizedBox(
                height: 25,
              ),
              //Email Text Box
              AppTextField(
                  hint: "E-mail",
                  obscureText: false,
                  controller: emailController),
              const SizedBox(
                height: 10,
              ),
              // Password Box
              AppTextField(
                  hint: "Password",
                  obscureText: true,
                  controller: passwordController),
              const SizedBox(
                height: 10,
              ),
              AppTextField(
                  hint: "Conffirm Password",
                  obscureText: true,
                  controller: passwordConfirmController),
              const SizedBox(
                height: 25,
              ),
              //login button
              MyButton(
                buttonText: "Register",
                onTap: signUp,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already a member?"),
                  const SizedBox(
                    width: 5,
                  ),
                  MyTextButton(
                      onTap: () =>
                          {Navigator.popAndPushNamed(context, "/login")},
                      text: "Log In")
                ],
              )

              // not a member register now
            ]),
          ),
        ),
      ),
    ));
  }
}
