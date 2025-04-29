import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/presentation/main_layout/Favorite/favorite.dart';
import 'package:evently_app/presentation/main_layout/Home/home.dart';
import 'package:evently_app/presentation/main_layout/Map/map.dart';
import 'package:evently_app/presentation/main_layout/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;
  List<Widget> tabs = [Home(), Maps(), Favorite(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: buildBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesManager.createEvent);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildBottomNavBar() {
    return BottomAppBar(
      notchMargin: 8,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          currentIndex = newIndex;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(SvgAssets.home),
            activeIcon: SvgPicture.asset(SvgAssets.selectedHome),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(SvgAssets.map),
            activeIcon: SvgPicture.asset(SvgAssets.selectedMap),
            label: AppLocalizations.of(context)!.map,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(SvgAssets.fav),
            activeIcon: SvgPicture.asset(SvgAssets.selectedFav),
            label: AppLocalizations.of(context)!.favorite,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(SvgAssets.profile),
            activeIcon: SvgPicture.asset(SvgAssets.selectedProfile),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
      ),
    );
  }
}
