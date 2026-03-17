import 'package:flutter/material.dart';
import '../theme.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: HireIQTheme.borderLight.withAlpha(76),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: HireIQTheme.primaryNavy, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null
          ? Text(subtitle!, style: Theme.of(context).textTheme.bodySmall)
          : null,
      trailing: trailing ??
          const Icon(Icons.chevron_right,
              size: 20, color: HireIQTheme.borderLight),
      onTap: onTap,
    );
  }
}
