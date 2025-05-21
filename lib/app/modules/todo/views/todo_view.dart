import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';

class TodoView extends GetView<TodoController> {
  const TodoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoView'),
        centerTitle: true,
      ),
      body: Obx(() {
        if(controller.isLoading.value){
          return const Center(child: CircularProgressIndicator());
        }return ListView.builder(
          itemCount: controller.todoData.length,
          itemBuilder: (context, index) {
            final todo = controller.todoData[index];
            return Dismissible(
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [

                    Icon(Icons.delete, color: Colors.white),
                    SizedBox(width: 10),
                    Text('Delete', style: TextStyle(color: Colors.white)),
                  ],
                ),

              ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  controller.deleteTask(todo['id']);
                },
                key: ValueKey(todo['id'])  ,
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                      title: Text(todo['name']),
                      subtitle: Text(todo['description']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                              value: todo['is_done'],
                              onChanged: (value){
                                controller.doneTask(todo['id'], !todo['is_done']);
                              }
                          ),
                           IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              controller.showEditDialog(context, todo);

                            },
                          )
                        ],
                      )


                  ),
                )
                );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
backgroundColor: Colors.green,
        onPressed: (){
          controller.showCreateDialog(context);
        },
        child: const Icon(Icons.add),
        tooltip: 'Create Task',
      ),
    );

  }
}
