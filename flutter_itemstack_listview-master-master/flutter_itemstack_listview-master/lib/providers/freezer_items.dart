import 'package:flutter/foundation.dart';
import 'dart:io';

import '../models/items.dart';
import '../helpers/db_helper.dart';

class FreezerItems with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items {
    return [..._items];
  }

  void addFreezerItem(
    String pickedTitle,
    File pickedImage,
  ) 
  {
    final newFreezerItems = Item(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
    );
    _items.add(newFreezerItems);
    notifyListeners();
    DBHelper.insert('user_items', {
      'id': newFreezerItems.id,
      'title': newFreezerItems.title,
      'image': newFreezerItems.image.path
    });
  }

  Future<void> fetchAndSetFreezerItems() async {
    final dataList = await DBHelper.getData('user_items');
    _items = dataList
        .map(
          (item) => Item(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
