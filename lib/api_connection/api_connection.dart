class API {
  static const hostConnection = "http://192.168.93.75/api_book_store";
  // the address v4 config of lan adapter wifi 2
  // type ipconfig
  //
   static const hostConnectionUser = "$hostConnection/user";
   static const hostConnectionAdmin = "$hostConnection/admin";

   // sign up
   static const validateEmail = "http://192.168.93.75/api_book_store/user/validate_email.php";
   static const signUp = "$hostConnection/user/signup.php";
   static const login = "$hostConnection/user/login.php";

   //admin
   static const adminLogin = "$hostConnection/admin/login.php";

}
