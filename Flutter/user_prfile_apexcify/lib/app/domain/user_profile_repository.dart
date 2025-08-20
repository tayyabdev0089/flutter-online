import 'user_profile.dart';

abstract class UserProfileRepository {
  Future<UserProfile?> getCurrentUserProfile();
  Future<void> updateUserProfile(UserProfile userProfile); // Added update method
}
