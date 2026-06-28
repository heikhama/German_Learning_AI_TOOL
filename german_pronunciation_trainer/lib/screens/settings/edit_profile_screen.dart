import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../services/api_service.dart';
import '../../services/auth_service.dart';
import '../../services/popup_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
      TextEditingController();

  bool loading = true;
  bool saving = false;

  String avatarUrl = "";

  //--------------------------------------------------

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  //--------------------------------------------------

  Future<void> loadProfile() async {
    try {
      final UserModel? user =
          await AuthService.getProfile();

      if (!mounted) return;

      if (user != null) {
        nameController.text = user.name;
        avatarUrl = user.avatar;
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      debugPrint("Load Profile Error : $e");

      if (!mounted) return;

      setState(() {
        loading = false;
      });

      await PopupService.error(
        context,
        "Unable to load profile",
      );
    }
  }

  //--------------------------------------------------

  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      saving = true;
    });

    try {
      final result =
          await AuthService.updateProfile(
        nameController.text.trim(),
      );

      if (!mounted) return;

      setState(() {
        saving = false;
      });

      if (result["success"] == true) {
        await PopupService.success(
          context,
          result["message"] ??
              "Profile updated successfully",
        );

        Navigator.pop(context, true);
      } else {
        await PopupService.error(
          context,
          result["message"] ??
              "Unable to update profile",
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

  //--------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
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
                    CircleAvatar(
                      radius: 60,
                      backgroundColor:
                          Colors.grey.shade200,
                      backgroundImage:
                          avatarUrl.isNotEmpty
                              ? NetworkImage(
                                  "${ApiService.baseUrl}$avatarUrl"
                                  "?t=${DateTime.now().millisecondsSinceEpoch}",
                                )
                              : null,
                      child: avatarUrl.isEmpty
                          ? const Icon(
                              Icons.person,
                              size: 60,
                              color:
                                  Colors.grey,
                            )
                          : null,
                    ),

                    const SizedBox(
                        height: 30),

                    TextFormField(
                      controller:
                          nameController,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Full Name",
                        prefixIcon:
                            Icon(Icons.person),
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
                          return "Please enter your name";
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
                        onPressed: saving
                            ? null
                            : saveProfile,
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
                                "SAVE PROFILE",
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  //--------------------------------------------------

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}