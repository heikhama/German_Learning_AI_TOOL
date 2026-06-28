import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../services/api_service.dart';
import '../../services/auth_service.dart';
import '../../services/popup_service.dart';

class AvatarScreen extends StatefulWidget {
  const AvatarScreen({super.key});

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  File? selectedImage;

  bool loading = true;
  bool uploading = false;

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
      final UserModel? user = await AuthService.getProfile();

      if (!mounted) return;

      if (user != null) {
        avatarUrl = user.avatar;
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      debugPrint("Load Avatar Error : $e");

      if (!mounted) return;

      setState(() {
        loading = false;
      });
    }
  }

  //--------------------------------------------------

  Future<void> pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result == null) return;

    setState(() {
      selectedImage = File(result.files.single.path!);
    });
  }

  //--------------------------------------------------

  Future<void> uploadAvatar() async {
    if (selectedImage == null) {
      await PopupService.error(
        context,
        "Please select an image",
      );
      return;
    }

    setState(() {
      uploading = true;
    });

    try {
      final result =
          await AuthService.uploadAvatar(
        selectedImage!,
      );

      if (!mounted) return;

      setState(() {
        uploading = false;
      });

      if (result["success"] == true) {
        await PopupService.success(
          context,
          result["message"] ??
              "Avatar uploaded successfully",
        );

        Navigator.pop(context, true);
      } else {
        await PopupService.error(
          context,
          result["message"] ??
              result["detail"] ??
              "Upload failed",
        );
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        uploading = false;
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
        title: const Text("Change Avatar"),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding:
                  const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  CircleAvatar(
                    radius: 80,
                    backgroundColor:
                        Colors.grey.shade200,

                    backgroundImage:
                        selectedImage != null
                            ? FileImage(
                                selectedImage!,
                              )
                            : avatarUrl.isNotEmpty
                                ? NetworkImage(
                                    "${ApiService.baseUrl}$avatarUrl"
                                    "?t=${DateTime.now().millisecondsSinceEpoch}",
                                  )
                                : null,

                    child: selectedImage ==
                                null &&
                            avatarUrl.isEmpty
                        ? const Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.grey,
                          )
                        : null,
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width:
                        double.infinity,
                    child:
                        ElevatedButton.icon(
                      icon: const Icon(
                        Icons.photo_library,
                      ),
                      label: const Text(
                        "Choose Image",
                      ),
                      onPressed:
                          pickImage,
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width:
                        double.infinity,
                    height: 50,
                    child:
                        ElevatedButton(
                      onPressed:
                          uploading
                              ? null
                              : uploadAvatar,
                      child: uploading
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
                              "UPLOAD AVATAR",
                            ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}