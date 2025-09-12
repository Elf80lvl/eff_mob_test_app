import 'package:eff_mob_tes_app/data/const.dart';
import 'package:eff_mob_tes_app/services/screen_helper.dart';
import 'package:eff_mob_tes_app/view/favorites_page.dart';
import 'package:eff_mob_tes_app/view/home_page.dart';
import 'package:eff_mob_tes_app/view/settings_page.dart';
import 'package:eff_mob_tes_app/widgets/appbar_content.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: ScreenHelper.isMobile(context)
          ? null
          : AppBar(
              title: AppBarContent(
                currentPageIndex: _currentPageIndex,
                onTap: (page) {
                  setState(() {
                    _currentPageIndex = page;
                  });
                },
              ),
            ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: kAppMaxWidth),
          child: IndexedStack(
            index: _currentPageIndex,
            children: [HomePage(), FavoritesPage(), SettingsPage()],
          ),
        ),
      ),
      bottomNavigationBar: ScreenHelper.isMobile(context)
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: BottomNavigationBar(
                    elevation: 1,
                    selectedItemColor: Color(kColorAccent),
                    showUnselectedLabels: false,
                    showSelectedLabels: true,
                    currentIndex: _currentPageIndex,

                    onTap: (value) {
                      setState(() {
                        _currentPageIndex = value;
                      });
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Icon(Icons.contacts),
                        ),
                        label: 'Characters',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.grade, size: 28),
                        label: 'Favorites',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: 'Settings',
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
