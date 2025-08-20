import '../domain/user_profile.dart';
import '../domain/user_profile_repository.dart';

class InMemoryUserProfileRepository implements UserProfileRepository {
  // In-memory storage for the user profile
  UserProfile? _currentUserProfile = const UserProfile(
    id: '1', // Example ID
    fullName: 'Muhammad Tayyab',
    email: 'muhammad.tayyab@apexcify.com',
    bio:
        'Mobile engineer at ApexcifyTechnology. Passionate about clean architecture and delightful user experiences.',
    avatarUrl: null,
  );

  @override
  Future<UserProfile?> getCurrentUserProfile() async {
    await Future.delayed(const Duration(seconds: 1)); // Reduced delay
    return _currentUserProfile;
  }

  // Method to update the user profile
  @override
  Future<void> updateUserProfile(UserProfile updatedProfile) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    _currentUserProfile = updatedProfile;
  }
}
