class API {
  static const hostConnection = "https://bookbazar9898.000webhostapp.com";
  // the address v4 config of lan adapter wifi 2
  // type ipconfig
  //
   static const hostConnectionUser = "$hostConnection/user";
   static const hostConnectionAdmin = "$hostConnection/admin";
   static const hostUploadItem = "$hostConnection/items";
   static const hostBooks = "$hostConnection/books";
   static const hostCart = "$hostConnection/cart";
   static const hostFavorite = "$hostConnection/favorite";
   static const hostOrder = "$hostConnection/order";
   static const hostImage = "$hostConnection/transactions_proof_images/";

   // sign up
   static const validateEmail = "$hostConnection/user/validate_email.php";
   static const signUp = "$hostConnection/user/signup.php";
   static const login = "$hostConnection/user/login.php";

   //admin
   static const adminLogin = "$hostConnection/admin/login.php";
   static const AdminGetAllOrders = "$hostConnection/admin/read_orders.php";
   //search item
   static const searchItems = "$hostUploadItem/search.php";

   // save item
   static const uploadNewItem = "$hostConnection/items/upload.php";

   //trending clothes
   static const TrendingBooks= "$hostConnection/books/trending.php";
   static const GetAllBooks= "$hostConnection/books/all.php";
   //cart 
   static const AddToCart= "$hostCart/add.php";
   static const getCartList= "$hostCart/read.php";
   static const deleteSelectedItemsFromCartList= "$hostCart/delete.php";
   static const updateItemInCartList= "$hostCart/update.php";
  // favorite
  static const validateFavorite= "$hostFavorite/validate_favorite.php";
  static const addFavorite= "$hostFavorite/add.php";
  static const deleteFavorite= "$hostFavorite/delete.php";
  static const readFavorite= "$hostFavorite/read.php";

  // order
  static const addOrder= "$hostOrder/add.php";
  static const readOrder= "$hostOrder/read.php";





   


  

}
