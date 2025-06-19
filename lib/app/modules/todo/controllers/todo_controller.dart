
import 'package:demo_getx_supabase/app/Models/todo_model.dart';
import 'package:demo_getx_supabase/app/service/todo_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TodoController extends GetxController with StateMixin<List<TodoModel?>>{
  //TODO: Implement TodoController

  late final todoData= RxList<TodoModel>([]);
final isLoading = false.obs;
final todoService = TodoService();

  final count = 0.obs;
  @override
  void onInit() async{
    super.onInit();
    await getTodo();
  }

  Future<void> getTodo() async {
    change(null, status: RxStatus.loading());
    try{
      todoData.value = await todoService.getTodo();
      change(todoData.value, status: RxStatus.success());
    }catch(e){
      change(null, status: RxStatus.error(e.toString()));
    }
  }



  Future<void> doneTask(int id, bool value) async {
    try{

      todoData.value = await todoService.doneTask();
      change(todoData.value, status: RxStatus.success());


      Get.showSnackbar(
        const GetSnackBar(
          borderRadius: 10,
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
          title: 'Success',
          message: 'Task updated successfully',
          duration: Duration(seconds: 2),
        ),
      );

    }catch(e) {
      Get.showSnackbar(
        const GetSnackBar(
          borderRadius: 10,
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          title: 'Error',
          message: 'Task update failed',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }



  Future<void>deleteTask(int id) async {
    try {


      await Supabase.instance.client.from('todos').delete().eq('id', id);




      Get.showSnackbar(
        const GetSnackBar(
          borderRadius: 10,
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
          title: 'Success',
          message: 'Task deleted successfully',
          duration: Duration(seconds: 2),
        ),
      );
    }catch(e){
      Get.showSnackbar(
        const GetSnackBar(
          borderRadius: 10,
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          title: 'Error',
          message: 'Task deletion failed',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> addTask(String name, String description) async {
    try{
      await Supabase.instance.client.from('todos').insert({
        'name': name,
        'description': description,
        'is_done': false,
      });
      Get.showSnackbar(
        const GetSnackBar(
          borderRadius: 10,
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
          title: 'Success',
          message: 'Task added successfully',
          duration: Duration(seconds: 2),
        ),
      );
    }catch(e){
      Get.showSnackbar(
        const GetSnackBar(
          borderRadius: 10,
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          title: 'Error',
          message: 'Task addition failed',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void showCreateDialog(BuildContext context) {
    final nameController = TextEditingController();
    final descController = TextEditingController();

    Get.defaultDialog(
      title: '', // Custom title widget instead
      backgroundColor: const Color(0xFF2A2A2A), // Dark background matching the app theme
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      radius: 16, // Rounded corners for a modern look
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Custom Title
          const Text(
            'Add Task',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          // Name TextField
          TextField(
            controller: nameController,
            style: const TextStyle(color: Colors.white), // White text
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: const Color(0xFF3A3A3A), // Slightly lighter dark background
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Description TextField
          TextField(
            controller: descController,
            style: const TextStyle(color: Colors.white), // White text
            maxLines: 3, // Multi-line support for description
            decoration: InputDecoration(
              labelText: 'Description',
              labelStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: const Color(0xFF3A3A3A),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Cancel Button
              TextButton(
                onPressed: () {
                  Get.back();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.grey[700], // Dark grey for Cancel
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Add Button
              TextButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  final desc = descController.text.trim();
                  if (name.isNotEmpty) {
                    addTask(name, desc);
                    Get.back();
                  }
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.blue, // Blue for Add button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> updateTask(int id, String name, String description) async {
    try{
      await Supabase.instance.client.from('todos').update({
        'name': name,
        'description': description,
      }).eq('id', id);
      Get.showSnackbar(
        const GetSnackBar(
          borderRadius: 10,
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
          title: 'Success',
          message: 'Task updated successfully',
          duration: Duration(seconds: 2),
        ),
      );
    }catch(e){
      Get.showSnackbar(
        const GetSnackBar(
          borderRadius: 10,
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          title: 'Error',
          message: 'Task update failed',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void showEditDialog(BuildContext context, Map<String, dynamic> todo) {
    final nameController = TextEditingController(text: todo['name']);
    final descController = TextEditingController(text: todo['description']);

    Get.defaultDialog(
      title: '', // We'll use a custom title widget
      backgroundColor: const Color(0xFF2A2A2A), // Dark background like in the images
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      radius: 16, // Rounded corners for the dialog
      content: Column(
        children: [
          // Custom Title
          const Text(
            'Update Task',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          // Name TextField
          TextField(
            controller: nameController,
            style: const TextStyle(color: Colors.white), // White text
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: const Color(0xFF3A3A3A), // Slightly lighter dark background
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Description TextField
          TextField(
            controller: descController,
            style: const TextStyle(color: Colors.white), // White text
            maxLines: 3, // Allow multi-line input for description
            decoration: InputDecoration(
              labelText: 'Description',
              labelStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: const Color(0xFF3A3A3A),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Cancel Button
              TextButton(
                onPressed: () {
                  Get.back();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.grey[700], // Dark grey button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Save Button
              TextButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  final desc = descController.text.trim();
                  if (name.isNotEmpty) {
                    updateTask(todo['id'], name, desc);
                    Get.back();
                  }
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.blue, // Blue button like in the images
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  @override
  void onReady() async{
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
