import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import '../../shared/navigation/web_nav_bar.dart';
import '../../shared/footer/web_footer.dart';

class WebLayout extends StatelessWidget {
  final Widget child;
  final bool showNavBar;
  final bool showFooter;
  final Color backgroundColor;

  const WebLayout({
    super.key,
    required this.child,
    this.showNavBar = true,
    this.showFooter = true,
    this.backgroundColor = HireIQTheme.background,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: showNavBar ? const WebNavBar() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1440),
                child: child,
              ),
            ),
            if (showFooter) const WebFooter(),
          ],
        ),
      ),
    );
  }
}
