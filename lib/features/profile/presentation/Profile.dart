import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uni_lost_and_found/features/profile/presentation/providers/profile_provider.dart';
import '../../../widgets/custom_bottom_nav_bar.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final profileNotifier = ref.read(profileProvider.notifier);

    // Load profile if not already loading and no data/error exists
    if (!profileState.isLoading && profileState.profile == null && profileState.error == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        profileNotifier.loadProfile();
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Builder( // Using Builder to get a context for CircularProgressIndicator, etc.
          builder: (context) {
            if (profileState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (profileState.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${profileState.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => profileNotifier.loadProfile(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final profile = profileState.profile;
            if (profile == null) {
              return const Center(child: Text('No profile data available'));
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: profile.avatar != null
                              ? NetworkImage(profile.avatar!)
                              : null,
                          child: profile.avatar == null
                              ? const Icon(Icons.person, size: 40)
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.username,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                profile.email,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Profile Actions
                    ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text('Edit Profile'),
                      onTap: () => context.push('/edit-profile'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.list),
                      title: const Text('My Items'),
                      onTap: () => context.push('/my-items'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.delete, color: Colors.red),
                      title: const Text('Delete Account',
                          style: TextStyle(color: Colors.red)),
                      onTap: () => context.push('/delete-account'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4), // Assuming index 4 is Profile
    );
  }
}