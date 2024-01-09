import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_text_field.dart';
import 'package:flutter_application_1/components/color_palette.dart';
import 'package:flutter_application_1/pages/nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './home.dart';
import './signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

Future<void> handleLoginButtonClick() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? savedEmail = prefs.getString('email');
  final String? savedPassword = prefs.getString('password');

  if (savedEmail == emailController.text && savedPassword == passwordController.text) {
    // Simpan informasi login jika diperlukan
    prefs.setBool('isLoggedIn', true);

    // Navigasi ke Nav setelah berhasil login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => NavPage(),
      ),
    );
  } else {
    // Tampilkan pesan kesalahan atau tangani kredensial yang tidak valid
    print('Invalid credentials');
  }
}

  void goToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => NavPage(),
      ),
    );
  }

  void handleSignupButtonClick() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => SignupPage(),
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
                "Halo,\nSilahkan Login",
                style: TextStyle(
                  color: ColorPalette.green100,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 40),
              AppTextField(
                controller: emailController,
                label: 'Email',
                textColor: ColorPalette.dark25,
                borderColor: ColorPalette.light20,
                focusedBorderColor: ColorPalette.green100,
              ),
              const SizedBox(height: 20),
              AppTextField(
                controller: passwordController,
                label: 'Password',
                textColor: ColorPalette.dark25,
                borderColor: ColorPalette.light20,
                focusedBorderColor: ColorPalette.green100,
                obscureText: true,
              ),
              const SizedBox(height: 35),
              AppButton(
                text: 'Login',
                color: ColorPalette.green100,
                textColor: Colors.white,
                onPressed: handleLoginButtonClick,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Belum memiliki akun?",
                          style: TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                        TextSpan(
                          text: " Daftar",
                          style: const TextStyle(
                            color: ColorPalette.green100,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = handleSignupButtonClick,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
