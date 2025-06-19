import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';

class TodoView extends GetView<TodoController> {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), // Dark background like in the image
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Tasks',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort, color: Colors.white),
            onPressed: () {
              // Add sorting functionality here
            },
          ),
        ],
      ),
      body: controller.obx(
          (state)=>
            RefreshIndicator(
              onRefresh: () async {
                // await controller.getTodo();
              },
              child: ListView.builder(
                itemCount: controller.todoData.length,
                itemBuilder: (context, index) {
                  final task = state![index];
                  return ListTile(
                    title: Text(
                      task!.name,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    subtitle: Text(
                      task.description ?? 'No description provided',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    trailing: Checkbox(
                      value: task.is_done,
                      onChanged: (value) {
                        controller.doneTask( task.id, task.is_done ? false : true );
                      },
                      activeColor: Colors.blue,
                    ),
                  );
                },
              ),
            ),
        onLoading: const Center(
          child: CircularProgressIndicator(
            color: Colors.white, // White loading indicator
          ),
        ),
        onError: (error) => Center(
          child: Text(
            error.toString(),
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
      ),
onEmpty: Center(child: Text("No data found")),

      )

    );
  }
}