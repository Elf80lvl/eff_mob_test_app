import 'package:eff_mob_tes_app/widgets/appbar_button.dart';
import 'package:flutter/material.dart';

typedef AppBarButtonCallback = void Function(int page);

class AppBarContent extends StatelessWidget {
  final AppBarButtonCallback onTap;
  final int currentPageIndex;

  const AppBarContent({
    super.key,
    required this.onTap,
    required this.currentPageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBarButton(
            text: 'Characters',
            onPressed: () => onTap(0),
            isActive: currentPageIndex == 0,
          ),
          const SizedBox(width: 32),
          AppBarButton(
            text: 'Favorites',
            onPressed: () => onTap(1),
            isActive: currentPageIndex == 1,
          ),
          const SizedBox(width: 32),
          AppBarButton(
            text: 'Settings',
            onPressed: () => onTap(2),
            isActive: currentPageIndex == 2,
          ),
        ],
      ),
    );
  }
}
