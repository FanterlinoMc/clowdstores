import 'package:clowdstores/ui/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/streams_providers.dart';

import '../ui/WebUI/web_Profile.dart';
import '../ui/pages/User/free_user.dart';

class ProfileState extends ConsumerWidget {
  const ProfileState({Key? key}) : super(key: key);
  chageUser() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isUser = prefs.getBool("isUser");
    return isUser! ? const UserProfile() : const WebProfile();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateStraem);
    return authState.when(data: (value) {
      if (value != null) {
        return const WebProfile();
      } else {
        return const OpeningView();
      }
    }, loading: () {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }, error: (stack, erorr) {
      return const Center(child: Text("Profile Error"));
    });
  }
}
