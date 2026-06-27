import 'package:flutter/material.dart';

import '../services/auth_service.dart';

import '../widgets/app_logo.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

import '../utils/validators.dart';
import 'register_screen.dart';
import 'main_layout.dart';
import '../services/popup_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  //------------------------------------------------------
  // Form Key
  //------------------------------------------------------

  final _formKey =
      GlobalKey<FormState>();

  //------------------------------------------------------
  // Debug Login
  //------------------------------------------------------

  final emailController =
      TextEditingController(
    text: "hydrogen@test.com",
  );

  final passwordController =
      TextEditingController(
    text: "123456",
  );

  //------------------------------------------------------

  bool isLoading = false;

  //------------------------------------------------------

  Future<void> login() async {

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final result =
    await AuthService.login(

      emailController.text.trim(),

      passwordController.text,

    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (result["success"] == true) {

      await PopupService.success(

  context,

  "Login Successful",

);

Navigator.pushReplacement(

  context,

  MaterialPageRoute(

    builder: (_) => const MainLayout(),

  ),

);

    } else {

      await PopupService.error(

  context,

  result["message"],

);
    }
  }

  //------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "German AI Trainer",
        ),
      ),

      body: Center(

        child: SingleChildScrollView(

          padding:
              const EdgeInsets.all(25),

          child: Form(

            key: _formKey,

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.stretch,

              children: [

                const AppLogo(),

                const SizedBox(
                  height: 40,
                ),

                CustomTextField(

                  controller:
                      emailController,

                  label: "Email",

                  icon: Icons.email,

                  keyboardType:
                      TextInputType
                          .emailAddress,

                  validator:
                      Validators.email,
                ),

                const SizedBox(
                  height: 20,
                ),

                CustomTextField(

                  controller:
                      passwordController,

                  label: "Password",

                  icon: Icons.lock,

                  obscureText: true,

                  validator:
                      Validators.password,
                ),

                const SizedBox(
                  height: 30,
                ),

                PrimaryButton(

                  text: "LOGIN",

                  loading: isLoading,

                  onPressed: login,
                ),

                const SizedBox(
                  height: 15,
                ),

                TextButton(

  onPressed: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            const RegisterScreen(),

      ),

    );

  },

  child: const Text(

    "Create New Account",

  ),
),

                const Divider(
                  height: 40,
                ),

                ElevatedButton.icon(

                  onPressed: () {

                    emailController.text =
                        "hydrogen@test.com";

                    passwordController
                        .text = "123456";

                    login();
                  },

                  icon: const Icon(
                    Icons.bug_report,
                  ),

                  label: const Text(
                    "Developer Login",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //------------------------------------------------------

  @override
  void dispose() {

    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }
}