import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme.dart';
import '../../features/mobile_screens.dart';

enum UserRole { candidate, employer, recruiter, admin }

class RoleNavigationBar extends StatelessWidget {
  final UserRole role;

  const RoleNavigationBar({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final String currentRoute = GoRouterState.of(context).uri.path;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: HireIQTheme.primaryTeal,
      unselectedItemColor: HireIQTheme.textMuted,
      currentIndex: _getCurrentIndex(currentRoute),
      onTap: (index) => _onItemTapped(context, index),
      items: _getMenuItems(),
    );
  }

  int _getCurrentIndex(String route) {
    // This is a simplified index matching. In a full app, you'd match by route names.
    return 0; // Default to first item for now
  }

  List<BottomNavigationBarItem> _getMenuItems() {
    switch (role) {
      case UserRole.candidate:
        return const [
          BottomNavigationBarItem(
              icon: Icon(Icons.work_outline), label: 'Jobs'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in_outlined),
              label: 'Applications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ];
      case UserRole.employer:
        return const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined), label: 'Hub'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined), label: 'Listings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outline), label: 'Applicants'),
        ];
      case UserRole.recruiter:
        return const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Console'),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_kanban_outlined), label: 'Pipeline'),
          BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline), label: 'Messages'),
        ];
      case UserRole.admin:
        return const [
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined), label: 'Stats'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outline), label: 'Users'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: 'Config'),
        ];
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (role) {
      case UserRole.candidate:
        if (index == 0) context.go(MobileRoutes.candidateDashboard);
        if (index == 1) context.go(MobileRoutes.candidateApplications);
        if (index == 2) context.go(MobileRoutes.candidateProfile);
        break;
      case UserRole.employer:
        if (index == 0) context.go(MobileRoutes.employerDashboard);
        break;
      case UserRole.recruiter:
        if (index == 0) context.go(MobileRoutes.recruiterDashboard);
        break;
      case UserRole.admin:
        if (index == 0) context.go(MobileRoutes.adminDashboard);
        break;
    }
  }
}
