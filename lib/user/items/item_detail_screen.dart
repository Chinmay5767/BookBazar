import 'package:book_store/user/model/Books.dart';
import 'package:flutter/material.dart';

class ItemsDetailScreen extends StatefulWidget {
  final Books? itemInfo;
  ItemsDetailScreen({this.itemInfo});

  @override
  State<ItemsDetailScreen> createState() => _ItemsDetailScreenState();
}

class _ItemsDetailScreenState extends State<ItemsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
