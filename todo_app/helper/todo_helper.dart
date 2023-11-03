import 'package:todo_app_using_sharedpref/todo_app/helper/db_helper.dart';
import 'package:todo_app_using_sharedpref/todo_app/model/todo_model.dart';

class TodoHelper {
  static addTodo(Fruits fruit) async {
    final fruits = await DbHelper.loadItemsFromSharedPreferences();
    fruits.add(
      Fruits(fruit: fruit.fruit, description: fruit.description),
    );
    await DbHelper.saveItemsToSharedPreferences(fruits);
  }

  static updateTodo(
    String title,
    String desc,
    int index,
  ) async {
    final fruitList = await DbHelper.loadItemsFromSharedPreferences();
    fruitList.replaceRange(
        index, index + 1, [Fruits(fruit: title, description: desc)]);
    await DbHelper.saveItemsToSharedPreferences(fruitList);
  }

  static deleteTodo(List<Fruits> fruitsData, int index) async {
    fruitsData.removeAt(index);
    await DbHelper.saveItemsToSharedPreferences(fruitsData);
  }

  static void deleteSelectedItems(
      List<Fruits> fruitsData, List<int> selectedIndices) async {
    selectedIndices.sort((a, b) => b.compareTo(a));
    for (final index in selectedIndices) {
      if (index >= 0 && index < fruitsData.length) {
        fruitsData.removeAt(index);
      }
    }
    await DbHelper.saveItemsToSharedPreferences(fruitsData);
  }
}
