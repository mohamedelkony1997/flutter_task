import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task/models/item.dart';
import 'package:riverpod/riverpod.dart';

final dashboardViewModelProvider = ChangeNotifierProvider((ref) => DashboardViewModel());

class DashboardViewModel extends ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void editItem(int index, Item newItem) {
    _items[index] = newItem;
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
