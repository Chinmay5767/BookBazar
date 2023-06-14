import 'package:get/get.dart';

class ItemsDetailsController {
  RxInt _quantity = 0.obs;
  
  RxBool _isFavourite = false.obs;

  int get quantityItem => _quantity.value;
  bool get isFavouriteItem => _isFavourite.value;

  setQuantity(int QuantityOfItem) {
    _quantity.value = QuantityOfItem;
  }

  setIsFavourite(bool isFavouriteOfItem) {
    _isFavourite.value = isFavouriteOfItem;
  }

}
