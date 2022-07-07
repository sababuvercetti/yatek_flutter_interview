import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yatek_interview/profile_screen/profile_provider/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
            onPressed: () {
              ref.read(profileProvider.notifier).updateProfile();
            },
            child: Text('Profile')),
      ),
    );
  }
}
