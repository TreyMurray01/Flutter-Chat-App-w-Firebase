import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:to_do/components/app_button.dart';
import 'package:to_do/components/app_text_field.dart';
import 'package:to_do/components/text_button.dart';
import 'package:to_do/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.Signinwithemailandpassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const Text("Wellcome back! We missed you."),
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
                height: 25,
              ),
              //login button
              MyButton(
                buttonText: "Sign In",
                onTap: signIn,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?"),
                  SizedBox(
                    width: 5,
                  ),
                  MyTextButton(
                      onTap: () =>
                          {Navigator.popAndPushNamed(context, "/signup")},
                      text: "Sign up")
                ],
              )

              // not a member register now
            ]),
          ),
        ),
      ),
    );
  }
}
