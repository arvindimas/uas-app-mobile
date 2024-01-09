import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_text_field.dart';
import 'package:flutter_application_1/components/color_palette.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './home.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  InputDecoration textFieldDecoration(String label) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        borderSide: BorderSide(
          color: ColorPalette.green100,
          width: 2.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        borderSide: BorderSide(
          color: ColorPalette.green100,
          width: 2.0,
        ),
      ),
      labelText: label,
      labelStyle: TextStyle(
        color: ColorPalette.green100,
      ),
    );
  }

  Future<void> handleSignupButtonClick() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save user credentials locally
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);

    // Navigate to home page
    goToHomePage();
  }

  void goToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => NavPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 150,
              ),
              const Text(
                "Halo,\nSilahkan Daftar",
                style: TextStyle(
                  color: ColorPalette.green100,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              AppTextField(
                controller: emailController,
                label: 'Email',
                textColor: ColorPalette.dark25,
                borderColor: ColorPalette.light20,
                focusedBorderColor: ColorPalette.green100,
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                controller: passwordController,
                label: 'Password',
                textColor: ColorPalette.dark25,
                borderColor: ColorPalette.light20,
                focusedBorderColor: ColorPalette.green100,
                obscureText: true,
              ),
              const SizedBox(
                height: 35,
              ),
              AppButton(
                text: 'Daftar',
                color: ColorPalette.green100,
                textColor: Colors.white,
                onPressed: handleSignupButtonClick,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Sudah memiliki akun?",
                          style: TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                        TextSpan(
                          text: " Login",
                          style: const TextStyle(
                            color: ColorPalette.green100,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to the login page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => LoginPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
