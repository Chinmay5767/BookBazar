
import 'package:book_store/user/fragements/home_fragement_screen.dart';

import 'package:book_store/user/fragements/profile_fragement_screen.dart';
import 'package:book_store/user/userPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';

import 'favorites_fragment_screen.dart';
import 'order_fragment_screen.dart';


class DashboardOfFragements extends StatelessWidget
{
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  List<Widget> _fragmentScreens =
  [
    HomeFragementScreen(),
   FavoritesFragmentScreen(),
    OrderFragementScreen(),
    ProfileFragementScreen(),
  ];

  List _navigationButtonsProperties =
  [
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_outlined,
      "label": "Home",
    },
    {
      "active_icon": Icons.favorite,
      "non_active_icon": Icons.favorite_border,
      "label": "Favorites",
    },
    {
      "active_icon": FontAwesomeIcons.boxOpen,
      "non_active_icon": FontAwesomeIcons.box,
      "label": "Orders",
    },
    {
      "active_icon": Icons.person,
      "non_active_icon": Icons.person_outline,
      "label": "Profile",
    },
  ];

  RxInt _indexNumber = 0.obs;

  DashboardOfFragements({super.key});

  @override
  Widget build(BuildContext context)
  {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState)
      {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller)
      {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Obx(
                ()=> _fragmentScreens[_indexNumber.value]
            ),
          ),
          bottomNavigationBar: Obx(
              ()=> BottomNavigationBar(
                currentIndex: _indexNumber.value,
                onTap: (value)
                {
                  _indexNumber.value = value;
                },
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white24,
                items: List.generate(4, (index) 
                {
                  var navBtnProperty = _navigationButtonsProperties[index];
                  return BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    icon: Icon(navBtnProperty["non_active_icon"]),
                    activeIcon: Icon(navBtnProperty["active_icon"]),
                    label: navBtnProperty["label"],
                  );
                }),
              ),
          ),
        );
      },
    );
  }
}
