import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../services/popup_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final currentPasswordController =
      TextEditingController();

  final newPasswordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  bool saving = false;

  bool hideCurrent = true;
  bool hideNew = true;
  bool hideConfirm = true;

  //------------------------------------------------

  Future<void> changePassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      saving = true;
    });

    try {
      final result =
          await AuthService.changePassword(
        oldPassword:
            currentPasswordController.text.trim(),
        newPassword:
            newPasswordController.text.trim(),
      );

      if (!mounted) return;

      setState(() {
        saving = false;
      });

      if (result["success"] == true) {
        await PopupService.success(
          context,
          result["message"] ??
              "Password changed successfully",
        );

        Navigator.pop(context, true);
      } else {
        await PopupService.error(
          context,
          result["message"] ??
              "Unable to change password",
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
            const Text("Change Password"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(
                Icons.lock,
                size: 80,
                color: Colors.blue,
              ),

              const SizedBox(height: 30),

              //------------------------------------------------
              // Current Password
              //------------------------------------------------

              TextFormField(
                controller:
                    currentPasswordController,
                obscureText: hideCurrent,
                decoration: InputDecoration(
                  labelText:
                      "Current Password",
                  prefixIcon:
                      const Icon(Icons.lock),
                  border:
                      const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      hideCurrent
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        hideCurrent =
                            !hideCurrent;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return "Enter current password";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              //------------------------------------------------
              // New Password
              //------------------------------------------------

              TextFormField(
                controller:
                    newPasswordController,
                obscureText: hideNew,
                decoration: InputDecoration(
                  labelText:
                      "New Password",
                  prefixIcon:
                      const Icon(Icons.lock_outline),
                  border:
                      const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      hideNew
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        hideNew =
                            !hideNew;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return "Enter new password";
                  }

                  if (value.length < 6) {
                    return "Minimum 6 characters";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              //------------------------------------------------
              // Confirm Password
              //------------------------------------------------

              TextFormField(
                controller:
                    confirmPasswordController,
                obscureText: hideConfirm,
                decoration: InputDecoration(
                  labelText:
                      "Confirm Password",
                  prefixIcon:
                      const Icon(Icons.lock_reset),
                  border:
                      const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      hideConfirm
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        hideConfirm =
                            !hideConfirm;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return "Confirm your password";
                  }

                  if (value !=
                      newPasswordController.text) {
                    return "Passwords do not match";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 35),

              //------------------------------------------------
              // Update Button
              //------------------------------------------------

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: saving
                      ? null
                      : changePassword,
                  child: saving
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "UPDATE PASSWORD",
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
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
}