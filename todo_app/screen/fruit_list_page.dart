import 'package:flutter/material.dart';
import 'package:todo_app_using_sharedpref/todo_app/model/todo_model.dart';

class FruitsProvider extends ChangeNotifier {
  var ffruits = [
    Fruits(
        id: UniqueKey().hashCode,
        fruit: "Apple",
        description: "This is an apple"),
    Fruits(
        id: UniqueKey().hashCode,
        fruit: "Mango",
        description: "This is a mango"),
    Fruits(
        id: UniqueKey().hashCode,
        fruit: "Banana",
        description: "This is a banana"),
    Fruits(
        id: UniqueKey().hashCode,
        fruit: "Apple",
        description: "This is an apple"),
  ];

  void toggleItemSelection(int index) {
    // setState(() {
    ffruits[index].isSelected = !ffruits[index].isSelected;
    //});
    notifyListeners();
  }

  void deleteSelectedItems() {
    //setState(() {
    ffruits.removeWhere((fruit) => fruit.isSelected);
    //});
    notifyListeners();
  }
}
