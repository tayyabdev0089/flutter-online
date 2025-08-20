import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_prfile_apexcify/app/routes/app_routes.dart';
import '../controllers/profile_controller.dart';
import '../../../domain/user_profile.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.hasError.value ||
            controller.userProfile.value == null) {
          return EmptyState(onRetry: controller.loadUserProfile);
        } else {
          final userProfile = controller.userProfile.value!;
          return RefreshIndicator(
            onRefresh: controller.loadUserProfile,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileHeader(userProfile: userProfile),
                          const SizedBox(height: 24),
                          _buildInfoCard(
                            context,
                            icon: Icons.email,
                            title: 'Email',
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.email_outlined),
                              title: Text(
                                userProfile.email.isEmpty
                                    ? 'Not provided'
                                    : userProfile.email,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoCard(
                            context,
                            icon: Icons.info,
                            title: 'Bio',
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                userProfile.bio.isEmpty
                                    ? 'No bio yet.'
                                    : userProfile.bio,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(Routes.editProfile),
        label: const Text('Edit Profile'),
        icon: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.userProfile});

  final UserProfile userProfile;

  String get _initials {
    final names = userProfile.fullName.split(' ');
    if (names.isEmpty || names.first.isEmpty) return '?';
    if (names.length == 1) return names.first[0].toUpperCase();
    return (names.first[0] + names.last[0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasAvatar =
        userProfile.localAvatarPath != null &&
        userProfile.localAvatarPath!.isNotEmpty;

    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: theme.colorScheme.primaryContainer,
            backgroundImage: hasAvatar
                ? FileImage(userProfile.localAvatarPath as File)
                : null,
            child: !hasAvatar
                ? Text(
                    _initials,
                    style: TextStyle(
                      fontSize: 40,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            userProfile.fullName.isEmpty ? 'User' : userProfile.fullName,
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            userProfile.email.isEmpty ? 'Not provided' : userProfile.email,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.black26),
            const SizedBox(height: 16),
            const Text(
              'Could not load profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'An error occurred while fetching the user profile. Please try again.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
