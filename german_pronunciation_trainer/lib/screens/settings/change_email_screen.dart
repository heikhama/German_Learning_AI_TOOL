import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/popup_service.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() =>
      _ChangeEmailScreenState();
}

class _ChangeEmailScreenState
    extends State<ChangeEmailScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController =
      TextEditingController();

  bool loading = true;
  bool saving = false;

  //------------------------------------------------

  @override
  void initState() {
    super.initState();

    loadProfile();
  }

  //------------------------------------------------

  Future<void> loadProfile() async {
    try {
      UserModel? user =
          await AuthService.getProfile();

      if (!mounted) return;

      if (user != null) {
        emailController.text = user.email;
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      debugPrint(e.toString());

      if (!mounted) return;

      setState(() {
        loading = false;
      });
    }
  }

  //------------------------------------------------

  Future<void> changeEmail() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      saving = true;
    });

    try {
      final result =
          await AuthService.changeEmail(
        emailController.text.trim(),
      );

      if (!mounted) return;

      setState(() {
        saving = false;
      });

      if (result["success"] == true) {
        await PopupService.success(
          context,
          result["message"] ??
              "Email updated successfully",
        );

        Navigator.pop(context, true);
      } else {
        await PopupService.error(
          context,
          result["message"] ??
              "Unable to update email",
        );
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        saving = false;
      });

      await PopupService.error(
        context,
        e.toString(),
      );
    }
  }

  //------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Change Email"),
      ),
      body: loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding:
                  const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [

                    const Icon(
                      Icons.email,
                      size: 80,
                      color: Colors.blue,
                    ),

                    const SizedBox(
                        height: 30),

                    TextFormField(
                      controller:
                          emailController,
                      keyboardType:
                          TextInputType
                              .emailAddress,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Email Address",
                        prefixIcon:
                            Icon(Icons.email),
                        border:
                            OutlineInputBorder(),
                      ),
                      validator:
                          (value) {
                        if (value ==
                                null ||
                            value
                                .trim()
                                .isEmpty) {
                          return "Please enter email";
                        }

                        if (!RegExp(
                          r'^[^@]+@[^@]+\.[^@]+',
                        ).hasMatch(
                            value.trim())) {
                          return "Invalid email";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(
                        height: 30),

                    SizedBox(
                      width:
                          double.infinity,
                      height: 50,
                      child:
                          ElevatedButton(
                        onPressed:
                            saving
                                ? null
                                : changeEmail,
                        child: saving
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth:
                                      2,
                                  color: Colors
                                      .white,
                                ),
                              )
                            : const Text(
                                "UPDATE EMAIL",
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  //------------------------------------------------

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }
}