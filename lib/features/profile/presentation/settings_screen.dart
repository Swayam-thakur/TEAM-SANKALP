import 'package:flutter/material.dart';

import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/section_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const routePath = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool marketing = false;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Settings',
      body: ListView(
        children: [
          SectionCard(
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: notifications,
                  onChanged: (value) => setState(() => notifications = value),
                  title: const Text('Push notifications'),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: marketing,
                  onChanged: (value) => setState(() => marketing = value),
                  title: const Text('Offers and promotions'),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: darkMode,
                  onChanged: (value) => setState(() => darkMode = value),
                  title: const Text('Theme preference placeholder'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

