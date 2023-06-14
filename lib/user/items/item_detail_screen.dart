import 'dart:convert';

import 'package:book_store/user/cart/cart_list_screen.dart';
import 'package:book_store/user/model/Books.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../api_connection/api_connection.dart';
import '../item_controller/item_details_controller.dart';
import '../userPreferences/current_user.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Books? itemInfo;

  ItemDetailsScreen({
    this.itemInfo,
  });

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final itemDetailsController = Get.put(ItemsDetailsController());
  final currentOnlineUser = Get.put(CurrentUser());

  addItemToCart() async {
    try {
      var res = await http.post(
        Uri.parse(API.AddToCart),
        body: {
          "user_id": currentOnlineUser.user.user_id.toString(),
          "item_id": widget.itemInfo!.item_id.toString(),
          "quantity": itemDetailsController.quantityItem.toString(),
        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
      {
        var resBodyOfAddCart = jsonDecode(res.body);
        if (resBodyOfAddCart['success'] == true) {
          Fluttertoast.showToast(msg: "item saved to Cart Successfully.");
        } else {
          Fluttertoast.showToast(
              msg: "Error Occur. Item not saved to Cart and Try Again.");
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      print("Error :: " + errorMsg.toString());
    }
  }

  validateFavoriteList() async {
    try {
      var res = await http.post(
        Uri.parse(API.validateFavorite),
        body: {
          "user_id": currentOnlineUser.user.user_id.toString(),
          "item_id": widget.itemInfo!.item_id.toString(),
        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
      {
        var resBodyOfFavorite = jsonDecode(res.body);
        if (resBodyOfFavorite['favoriteFound'] == true) {
         
          itemDetailsController.setIsFavourite(true);
        } else {
         
              itemDetailsController.setIsFavourite(false);
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (e) {
      print("Error :: " + e.toString());
    }
  }

  addItemToFavoriteList() async {
    try {
      var res = await http.post(
        Uri.parse(API.addFavorite),
        body: {
          "user_id": currentOnlineUser.user.user_id.toString(),
          "item_id": widget.itemInfo!.item_id.toString(),
        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
      {
        var resBodyOfAddfavorite = jsonDecode(res.body);
        if (resBodyOfAddfavorite['success'] == true) {
          Fluttertoast.showToast(
              msg: "item saved to favorite list Successfully.");
          validateFavoriteList();
        } else {
          Fluttertoast.showToast(
              msg: "Error Occur. Item not saved to favorite list");
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      print("Error :: " + errorMsg.toString());
    }
  }

  deleteItemFromFavoriteList() async {
    try {
      var res = await http.post(
        Uri.parse(API.deleteFavorite),
        body: {
          "user_id": currentOnlineUser.user.user_id.toString(),
          "item_id": widget.itemInfo!.item_id.toString(),
        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
      {
        var resBodyOfDeletefavorite = jsonDecode(res.body);
        if (resBodyOfDeletefavorite['success'] == true) {
          Fluttertoast.showToast(
              msg: "item deleted from favorite list Successfully.");
          validateFavoriteList();
        } else {
          Fluttertoast.showToast(
              msg: "Error Occur. Item not deleted from favorite list");
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      print("Error :: " + errorMsg.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    validateFavoriteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          //item image
          FadeInImage(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            placeholder: const AssetImage("images/place_holder.png"),
            image: NetworkImage(
              widget.itemInfo!.image!,
            ),
            imageErrorBuilder: (context, error, stackTraceError) {
              return const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                ),
              );
            },
          ),

          //item information
          Align(
            alignment: Alignment.bottomCenter,
            child: itemInfoWidget(),
          ),
          // 3 buttons back, favorite , shopping cart
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.purpleAccent,
                    ),
                  ),

                  const Spacer(),
                  // favorite
                  Obx(
                    () => IconButton(
                      onPressed: () {},
                      icon: Icon(
                        itemDetailsController.isFavouriteItem
                            ? Icons.bookmark
                            : Icons.bookmark_border_outlined,
                        color: Colors.purpleAccent,
                      ),
                    ),
                  ),
                  // shopping cart icon
                  IconButton(
                    onPressed: () {
                      Get.to(CartListScreen());
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.purpleAccent,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  itemInfoWidget() {
    return Container(
      height: MediaQuery.of(Get.context!).size.height * 0.6,
      width: MediaQuery.of(Get.context!).size.width,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -3),
            blurRadius: 6,
            color: Colors.purpleAccent,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 18,
            ),

            Center(
              child: Container(
                height: 8,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            //name
            Text(
              widget.itemInfo!.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            //rating + rating num
            //tags
            //price
            //quantity item counter
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //rating + rating num
                //tags
                //price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //rating + rating num
                      Row(
                        children: [
                          //rating bar
                          RatingBar.builder(
                            initialRating: widget.itemInfo!.rating!,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, c) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (updateRating) {},
                            ignoreGestures: true,
                            unratedColor: Colors.grey,
                            itemSize: 20,
                          ),

                          const SizedBox(
                            width: 8,
                          ),

                          //rating num
                          Text(
                            "(" + widget.itemInfo!.rating.toString() + ")",
                            style: const TextStyle(
                              color: Colors.purpleAccent,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      //type
                      Text(
                        widget.itemInfo!.type!
                            .toString()
                            .replaceAll("[", "")
                            .replaceAll("]", ""),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 16),

                      //price
                      Text(
                        "\$" + widget.itemInfo!.price.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                //quantity item counter
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //+
                      IconButton(
                        onPressed: () {
                          itemDetailsController.setQuantity(
                              itemDetailsController.quantityItem + 1);
                        },
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        itemDetailsController.quantityItem.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //-
                      IconButton(
                        onPressed: () {
                          if (itemDetailsController.quantityItem - 1 >= 1) {
                            itemDetailsController.setQuantity(
                                itemDetailsController.quantityItem - 1);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Quantity must be 1 or greater than 1");
                          }
                        },
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //sizes
            const Text(
              "author:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // author show here

            //description
            const Text(
              "Description:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.itemInfo!.description!,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            //add to cart button
            Material(
              elevation: 4,
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  addItemToCart();
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
