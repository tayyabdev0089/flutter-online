import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
  const UserProfile({
    required this.id, // Added ID
    required this.fullName,
    required this.email,
    required this.bio,
    this.avatarUrl,
  });

  final String id; // Added ID
  final String fullName;
  final String email;
  final String bio;
  final String? avatarUrl;

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String, // Added ID
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      bio: map['bio'] as String,
      avatarUrl: map['avatarUrl'] as String?,
    );
  }

  const UserProfile.empty()
      : id = '', // Added ID
        fullName = '',
        email = '',
        bio = '',
        avatarUrl = null;

  bool get isEmpty => id.isEmpty && fullName.isEmpty && email.isEmpty; // Added ID check
}
