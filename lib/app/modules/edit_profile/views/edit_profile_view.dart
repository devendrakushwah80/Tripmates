import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../routes/app_pages.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            TmMintAppBar(title: 'Edit profile', showBack: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  CircleAvatar(
                    radius: 52,
                    backgroundColor: scheme.surfaceContainerHighest,
                    child: const Text('YA', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: TripMatesColors.green)),
                  ),
                  const SizedBox(height: 18),
                  const TextField(decoration: InputDecoration(labelText: 'Display name', hintText: 'Yassin Albawani')),
                  const SizedBox(height: 10),
                  const TextField(decoration: InputDecoration(labelText: 'Email', hintText: 'yassin@example.com')),
                  const SizedBox(height: 10),
                  const TextField(decoration: InputDecoration(labelText: 'Phone', hintText: '+46 70 000 00 00')),
                  const SizedBox(height: 10),
                  const TextField(decoration: InputDecoration(labelText: 'Bio', hintText: 'Short intro for fellow travelers')),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TmBottomNav(
        selectedIndex: 4,
        onTap: UserHomeNavigation.handleGlobalBottomTap,
      ),
    );
  }
}
