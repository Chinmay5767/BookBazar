import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_screen.dart';
import '../userPreferences/current_user.dart';
import '../userPreferences/user_preferences.dart';


class ProfileFragementScreen extends StatelessWidget
{ // taken data from current user.dart
  final CurrentUser _currentUser = Get.put(CurrentUser());

  signOutUser() async
  {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Logout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you sure?\nyou want to logout from app?",
        ),
        actions: [
          TextButton(
              onPressed: ()
              {
                Get.back();  // go back
              },
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                ),
              )
          ),
          TextButton(
              onPressed: ()
              {
                Get.back(result: "loggedOut");  // go back and send response
              },
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                ),
              )
          ),
        ],
      ),
    );

    if(resultResponse == "loggedOut")
    {
      //delete-remove the user data from phone local storage
      RememberUserPrefs.removeUserInfo()
          .then((value)
      {
        Get.off(Login());  // when response is loggedOut then send back to login page
      });
    }
  }

  Widget userInfoItemProfile(IconData iconData, String userData)
  {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(width: 16,),
          Text(
            userData,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(32),
      children: [

        Center(
          child: Image.asset(
          "lib/assets/profile.jpeg",
            width: 240,
          ),
        ),

        const SizedBox(height: 20,),
         // _currentUser is defined above , user is method
        userInfoItemProfile(Icons.person, _currentUser.user.user_name),

        const SizedBox(height: 20,),

        userInfoItemProfile(Icons.email, _currentUser.user.user_email),

        const SizedBox(height: 20,),

        Center(
          child: Material(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: ()
              {
                signOutUser();
              },
              borderRadius: BorderRadius.circular(32),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
