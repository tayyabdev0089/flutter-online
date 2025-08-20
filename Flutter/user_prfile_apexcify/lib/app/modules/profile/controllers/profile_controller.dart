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
      pickedImage.value = File(pickedFile.path);
    }
  }

  Future<void> updateProfile(String fullName, String email, String bio) async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final updatedProfile = UserProfile(
        id: userProfile.value!.id,
        fullName: fullName,
        email: email,
        bio: bio,
        avatarUrl: userProfile.value!.avatarUrl,
      );

      if (pickedImage.value != null) {
// TODO: Implement image upload logic and update avatarUrl
// For now, we'll just use a placeholder or keep the existing one
// Image upload logic would go here. After a successful upload,
// avatarUrl would be updated with the new image URL.
// Example:
// Future<void> uploadImage(File imageFile) async {
//   // ... upload logic ...
//   String imageUrl = await uploadImageToService(imageFile);
//   avatarUrl.value = imageUrl;
// }
        // updatedProfile.avatarUrl = await uploadImage(pickedImage.value!);
      }

      await _repository.updateUserProfile(updatedProfile);
      userProfile.value = updatedProfile;
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
