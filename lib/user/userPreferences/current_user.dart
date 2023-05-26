import 'package:book_store/user/model/user.dart';
import 'package:book_store/user/userPreferences/user_preferences.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CurrentUser extends GetxController {
  Rx<User> _currentUser = User(0, '', '', '').obs;
  // user is explicitly defined method
  User get user => _currentUser.value;

  getUserInfo() async {
    // current user info is assigned to this variable
    User? getUserInfoFromLocalStorage =
        await RememberUserPrefs.readUserInfo();
    _currentUser.value = getUserInfoFromLocalStorage!;
  }
}
