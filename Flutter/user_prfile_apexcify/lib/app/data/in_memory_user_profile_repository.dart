import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../domain/user_profile.dart';
import '../domain/user_profile_repository.dart';

class InMemoryUserProfileRepository implements UserProfileRepository {
  // In-memory storage for the user profile
  UserProfile? _currentUserProfile = const UserProfile(
    // Use const for initial value
    id: '1', // Example ID
    fullName: 'Muhammad Tayyab',
    email: 'muhammad.tayyab@apexcify.com',
    bio:
        'Mobile engineer at ApexcifyTechnology. Passionate about clean architecture and delightful user experiences.',
    localAvatarPath: null,
  );

  @override
  Future<UserProfile?> getCurrentUserProfile() async {
    await Future.delayed(const Duration(seconds: 1)); // Reduced delay
    // In a real app, you would load the profile and its avatar path from local storage here.
    return _currentUserProfile;
  }

  // Method to update the user profile
  @override
  Future<void> updateUserProfile(UserProfile updatedProfile) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // The controller already saves the image and passes the updated profile with the correct localAvatarPath.
    // So, we just need to update the in-memory profile.
    _currentUserProfile = updatedProfile;
  }

  // Helper method to save the picked image to local storage
  @override
  Future<String?> saveImageToLocalStorage(File imageFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      // Create a unique file name, e.g., using timestamp or UUID
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${imageFile.uri.pathSegments.last}';
      final savedFile = await imageFile.copy('${directory.path}/$fileName');
      return savedFile.path;
    } catch (e) {
      // Removed print statement for production code
      return null;
    }
  }
}
