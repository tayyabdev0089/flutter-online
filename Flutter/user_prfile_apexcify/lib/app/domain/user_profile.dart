import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
  const UserProfile({
    required this.id, // Added ID
    required this.fullName,
    required this.email,
    required this.bio,
    this.localAvatarPath, // Changed from avatarUrl
  });

  final String id; // Added ID
  final String fullName;
  final String email;
  final String bio;
  final String? localAvatarPath;

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String, // Added ID
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      bio: map['bio'] as String,
      localAvatarPath: map['localAvatarPath'] as String?,
    );
  }

  UserProfile copyWith({
    String? id,
    String? fullName,
    String? email,
    String? bio,
    String? localAvatarPath,
  }) {
    return UserProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      localAvatarPath: localAvatarPath ?? this.localAvatarPath,
    );
  }

  const UserProfile.empty()
      : id = '', // Added ID
        fullName = '',
        email = '',
        bio = '',
        localAvatarPath = null;

  bool get isEmpty => id.isEmpty && fullName.isEmpty && email.isEmpty; // Added ID check
}
