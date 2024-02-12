import 'package:clowdstores/ui/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/streams_providers.dart';

import '../ui/WebUI/web_Profile.dart';
import '../ui/pages/User/free_user.dart';
import 'Froms/sgingIn_page.dart';

class ProfileState extends ConsumerWidget {
  const ProfileState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateStraem);
    return authState.when(data: (value) {
      if (value != null) {
        return const WebProfile();
      } else {
        return const SgingInPage();
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
