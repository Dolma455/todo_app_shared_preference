import 'package:flutter/material.dart';
import 'package:todo_app_using_sharedpref/todo_app/helper/todo_helper.dart';
import 'package:todo_app_using_sharedpref/todo_app/model/todo_model.dart';
import 'package:todo_app_using_sharedpref/todo_app/screen/home_page.dart';

class UpdateFruit extends StatefulWidget {
  const UpdateFruit({
    super.key,
    required this.fruits,
    required this.index,
  });
  final Fruits fruits;
  final int index;

  @override
  State<UpdateFruit> createState() => _UpdateFruitState();
}

class _UpdateFruitState extends State<UpdateFruit> {
  late String desc;
  TextEditingController textController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = widget.fruits.description;
    titleController.text = widget.fruits.fruit;
    desc = widget.fruits.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: titleController,
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: textController,
            onChanged: (newDescription) {
              setState(() {
                desc = newDescription;
              });
            },
          ),
          TextButton(
            onPressed: () async {
              TodoHelper.updateTodo(
                titleController.text,
                desc,
                widget.index,
              );
              if (!mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const FruitsPage(),
                ),
              );
            },
            child: Text("Update".toUpperCase()),
          ),
        ],
      ),
    );
  }
}
