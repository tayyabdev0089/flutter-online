
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class EditProfileScreen extends GetView<ProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fullNameController =
        TextEditingController(text: controller.userProfile.value?.fullName);
    final emailController =
        TextEditingController(text: controller.userProfile.value?.email);
    final bioController =
        TextEditingController(text: controller.userProfile.value?.bio);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (controller.userProfile.value != null) {
                controller.updateProfile(
                  fullNameController.text,
                  emailController.text,
                  bioController.text,
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => GestureDetector(
                  onTap: controller.pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: controller.pickedImage.value != null
                        ? FileImage(controller.pickedImage.value!)
                        : (controller.userProfile.value?.avatarUrl != null &&
                                controller.userProfile.value!.avatarUrl!.isNotEmpty
                            ? NetworkImage(controller.userProfile.value!.avatarUrl!)
                            : null) as ImageProvider?,
                    child: controller.pickedImage.value == null &&
                            (controller.userProfile.value?.avatarUrl == null ||
                                controller.userProfile.value!.avatarUrl!.isEmpty)
                        ? const Icon(Icons.camera_alt, size: 40)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: bioController,
                decoration: const InputDecoration(labelText: 'Bio'),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
