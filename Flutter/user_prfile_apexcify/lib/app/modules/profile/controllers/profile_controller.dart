import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/user_profile.dart';
import '../../../domain/user_profile_repository.dart';

class ProfileController extends GetxController {
  final UserProfileRepository _repository;

  ProfileController(this._repository);

  final Rx<UserProfile?> userProfile = Rx<UserProfile?>(null);
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final Rx<File?> pickedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      userProfile.value = await _repository.getCurrentUserProfile();
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Save the picked image to local storage and store its path
      final localPath = await _repository.saveImageToLocalStorage(File(pickedFile.path));
      if (localPath != null) {
        pickedImage.value = File(localPath); // Store the File object with the local path
      }
    }
  }

  Future<void> updateProfile(String fullName, String email, String bio) async {
    try {
      isLoading.value = true;
      hasError.value = false;

      String? newAvatarPath = userProfile.value?.localAvatarPath; // Keep existing path by default

      if (pickedImage.value != null) {
        // If a new image was picked and saved, update the path
        newAvatarPath = pickedImage.value!.path;
      }

      final updatedProfile = UserProfile(
        id: userProfile.value!.id,
        fullName: fullName,
        email: email,
        bio: bio,
        localAvatarPath: newAvatarPath, // Use the local path
      );

      await _repository.updateUserProfile(updatedProfile);
      userProfile.value = updatedProfile; // Update the controller's user profile
      pickedImage.value = null; // Clear the picked image after successful update
      Get.back(); // Navigate back to the profile screen after saving
    } catch (e) {
      hasError.value = true;
      // Show an error message to the user
      Get.snackbar('Error', 'Failed to update profile. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
}
