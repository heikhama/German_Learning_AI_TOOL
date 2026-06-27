import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../widgets/app_logo.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../utils/validators.dart';
import '../services/popup_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final _formKey =
      GlobalKey<FormState>();

  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  //----------------------------------------------------------

  //----------------------------------------------------------
// Register User
//----------------------------------------------------------

Future<void> register() async {

  // Hide keyboard
  FocusScope.of(context).unfocus();

  // Validate form
  if (!_formKey.currentState!.validate()) {
    return;
  }

  // Check password confirmation
//   if (passwordController.text !=
//       confirmPasswordController.text) {

//     await PopupService.error(

//       context,

//       "Passwords do not match",

//     );

//     return;
//   }

  // Show loading
  setState(() {

    isLoading = true;

  });

  //--------------------------------------------------------
  // Call API
  //--------------------------------------------------------

  final result =
      await AuthService.register(

    nameController.text.trim(),

    emailController.text.trim(),

    passwordController.text,

  );

  if (!mounted) return;

  setState(() {

    isLoading = false;

  });

  //--------------------------------------------------------
  // Registration Success
  //--------------------------------------------------------

  if (result["success"] == true) {

    await PopupService.success(

      context,

      result["message"],

    );

    Navigator.pop(context);

    return;

  }

  //--------------------------------------------------------
  // Registration Failed
  //--------------------------------------------------------

  await PopupService.error(

    context,

    result["message"],

  );

}

  //----------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Create Account",
        ),
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Form(

          key: _formKey,

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.stretch,

            children: [

              const SizedBox(height: 20),

              const AppLogo(),

              const SizedBox(height: 40),

              CustomTextField(

                controller:
                    nameController,

                label: "Full Name",

                icon: Icons.person,
                
                validator: (value) {

  if (value == null ||
      value.trim().isEmpty) {

    return "Please enter your name";

  }

  if (value.trim().length < 3) {

    return "Name must contain at least 3 characters";

  }

  return null;

},

),

const SizedBox(height:20),
                

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

              const SizedBox(height: 20),

              CustomTextField(

                controller:
                    passwordController,

                label: "Password",

                icon: Icons.lock,

                obscureText: true,

                validator: (value) {

  if (value == null || value.isEmpty) {

    return "Please confirm password";

  }

  if (value != passwordController.text) {

    return "Passwords do not match";

  }

  return null;

},
              ),

              const SizedBox(height: 20),

              CustomTextField(

                controller:
                    confirmPasswordController,

                label:
                    "Confirm Password",

                icon: Icons.lock,

                obscureText: true,

                validator:
                    Validators.password,
              ),

              const SizedBox(height: 30),

              PrimaryButton(

                text:
                    "CREATE ACCOUNT",

                loading:
                    isLoading,

                onPressed:
                    register,
              ),

              const SizedBox(height: 20),

              TextButton(

                onPressed: () {

                  Navigator.pop(
                      context);

                },

                child: const Text(

                  "Already have an account? Login",

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //----------------------------------------------------------

  @override
  void dispose() {

    nameController.dispose();

    emailController.dispose();

    passwordController.dispose();

    confirmPasswordController.dispose();

    super.dispose();

  }
}