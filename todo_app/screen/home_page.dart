import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_using_sharedpref/todo_app/helper/db_helper.dart';
import 'package:todo_app_using_sharedpref/todo_app/helper/todo_helper.dart';
import 'package:todo_app_using_sharedpref/todo_app/model/todo_model.dart';
import 'package:todo_app_using_sharedpref/todo_app/screen/fruit_list_page.dart';
import 'package:todo_app_using_sharedpref/todo_app/screen/update_page.dart';

class FruitsPage extends StatefulWidget {
  const FruitsPage({super.key});

  @override
  State<FruitsPage> createState() => _FruitsPageState();
}

class _FruitsPageState extends State<FruitsPage> {
  @override
  void initState() {
    super.initState();
    DbHelper.loadItemsFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fruits"),
      ),
      body: FutureBuilder(
          future: DbHelper.loadItemsFromSharedPreferences(),
          builder: (ctx, snap) {
            if (snap.hasData) {
              final fruitsData = snap.requireData;
              return fruitsData.isNotEmpty
                  ? Consumer<FruitsProvider>(
                      builder: (ctx, fruitsProvider, child) {
                        return ListView.builder(
                            itemCount: fruitsData.length,
                            itemBuilder: (ctx, index) {
                              var fruit = fruitsData[index];
                              return Hero(
                                tag: 'heroTag$index',
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => UpdateFruit(
                                                  fruits: fruit,
                                                  index: index,
                                                )));
                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Text(fruit.fruit),
                                      subtitle: Text(fruit.description),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          TodoHelper.deleteTodo(
                                            fruitsData,
                                            index,
                                          );
                                          setState(() {});
                                        },
                                      ),
                                      // leading: Checkbox(
                                      //     value: fruit.isSelected,
                                      //     onChanged: (bool? value) {
                                      //       fruitsProvider
                                      //           .toggleItemSelection(index);
                                      //     }),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    )
                  : const Text("No Data Found");
            } else {
              return const Text("No data");
            }
          }),
      floatingActionButton:
          Consumer<FruitsProvider>(builder: (ctx, fruitsProvider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'H002',
              onPressed: () {
                fruitsProvider.deleteSelectedItems();
                setState(() {});
              },
              child: const Icon(Icons.delete),
            ),
            const Padding(padding: EdgeInsets.all(16)),
            FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      String newFruit = '';
                      String description = '';
                      return AlertDialog(
                        title: const Text("Add Fruit"),
                        content: SizedBox(
                          height: 200,
                          width: 200,
                          child: Column(
                            children: [
                              TextField(
                                decoration: const InputDecoration(
                                  labelText: "Fruit",
                                ),
                                onChanged: (value) {
                                  newFruit = value;
                                },
                              ),
                              TextField(
                                decoration: const InputDecoration(
                                  labelText: "Description",
                                ),
                                onChanged: (value) {
                                  description = value;
                                },
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              TodoHelper.addTodo(Fruits(
                                  fruit: newFruit, description: description));
                              setState(() {});
                              if (!mounted) return;
                              Navigator.of(context).pop();
                            },
                            child: const Text('Add'),
                          )
                        ],
                      );
                    });
              },
              child: const Icon(
                Icons.add,
              ),
            )
          ],
        );
      }),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart'; // Import your FruitsProvider class
// import 'package:todo_app_using_sharedpref/todo_app/helper/db_helper.dart';
// import 'package:todo_app_using_sharedpref/todo_app/helper/todo_helper.dart';
// import 'package:todo_app_using_sharedpref/todo_app/model/todo_model.dart';
// import 'package:todo_app_using_sharedpref/todo_app/screen/fruit_list_page.dart';
// import 'package:todo_app_using_sharedpref/todo_app/screen/update_page.dart';

// class FruitsPage extends StatefulWidget {
//   const FruitsPage({Key? key}) : super(key: key);

//   @override
//   State<FruitsPage> createState() => _FruitsPageState();
// }

// class _FruitsPageState extends State<FruitsPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Load data or initialize anything if needed.
//     DbHelper.loadItemsFromSharedPreferences();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Fruits"),
//       ),
//       body: FutureBuilder(
//         future: DbHelper.loadItemsFromSharedPreferences(),
//         builder: (ctx, snap) {
//           if (snap.hasData) {
//             final fruitData = snap.requireData;
//             return fruitData.isNotEmpty
//                 ? Consumer<FruitsProvider>(
//                     builder: (ctx, fruitsProvider, child) {
//                       return ListView.builder(
//                         itemCount: fruitsProvider.ffruits.length,
//                         itemBuilder: (ctx, index) {
//                           var fruit = fruitsProvider.ffruits[index];
//                           return Hero(
//                             tag: 'heroTag$index',
//                             child: InkWell(
//                               onTap: () {
//                                 // Handle item tap.
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (ctx) => UpdateFruit(
//                                               fruits: fruit,
//                                               index: index,
//                                             )));
//                               },
//                               child: Card(
//                                 child: ListTile(
//                                   title: Text(fruit.fruit),
//                                   subtitle: Text(fruit.description),
//                                   trailing: IconButton(
//                                     icon: const Icon(Icons.delete),
//                                     onPressed: () {
//                                       // Delete the selected item using the provider.
//                                       fruitsProvider.deleteSelectedItems();
//                                     },
//                                   ),
//                                   leading: Checkbox(
//                                     value: fruit.isSelected,
//                                     onChanged: (bool? value) {
//                                       // Toggle the selection using the provider.
//                                       fruitsProvider.toggleItemSelection(index);
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   )
//                 : const Text("No Data Found");
//           } else {
//             return const Text("No data");
//           }
//         },
//       ),
//       floatingActionButton: Consumer<FruitsProvider>(
//         builder: (ctx, fruitsProvider, child) {
//           return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//             FloatingActionButton(
//               onPressed: () {
//                 // Delete all selected items using the provider.
//                 fruitsProvider.deleteSelectedItems();
//               },
//               child: const Icon(Icons.delete),
//             ),
//             const Padding(padding: EdgeInsets.all(16)),
//             FloatingActionButton(
//               onPressed: () {
//                 showDialog(
//                     context: context,
//                     builder: (ctx) {
//                       String newFruit = '';
//                       String description = '';
//                       return AlertDialog(
//                         title: const Text("Add Fruit"),
//                         content: SizedBox(
//                           height: 200,
//                           width: 200,
//                           child: Column(
//                             children: [
//                               TextField(
//                                 decoration: const InputDecoration(
//                                   labelText: "Fruit",
//                                 ),
//                                 onChanged: (value) {
//                                   newFruit = value;
//                                 },
//                               ),
//                               TextField(
//                                 decoration: const InputDecoration(
//                                   labelText: "Description",
//                                 ),
//                                 onChanged: (value) {
//                                   description = value;
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () async {
//                               await TodoHelper.addTodo(Fruits(
//                                   fruit: newFruit, description: description));
//                               setState(() {});
//                               if (!mounted) return;
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text('Add'),
//                           )
//                         ],
//                       );
//                     });
//               },
//               child: const Icon(
//                 Icons.add,
//               ),
//             )
//           ]);
//         },
//       ),
//     );
//   }
// }
