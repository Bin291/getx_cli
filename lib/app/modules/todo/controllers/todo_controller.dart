
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TodoController extends GetxController {
  //TODO: Implement TodoController

  late final todoData=[].obs;
final isLoading = false.obs;


  final count = 0.obs;
  @override
  void onInit() async{
    super.onInit();
    await getTodo();
  }

  Future<void> getTodo() async {
    isLoading.value = true;
    try{
      todoData.value = await Supabase.instance.client.from('todos').select().order("id", ascending: true);
    }catch(e){
      if(kDebugMode){
        print('Error fetching data');
      }
    }finally{
      isLoading.value = false;
    }
  }



  Future<void> doneTask(int id, bool value) async {
    try{

      await Supabase.instance.client.from('todos').update({'is_done': value}).eq('id', id);
      todoData.value = await Supabase.instance.client.from('todos').select().order("id", ascending: true);

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
      todoData.value = await Supabase.instance.client.from('todos').select().order("id", ascending: true);




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
      todoData.value = await Supabase.instance.client.from('todos').select().order("id", ascending: true);
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
        title: 'Thêm công việc mới',
        content: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Tên'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Mô tả'),
            ),
          ],
        ),
        textConfirm: 'Tạo',
        textCancel: 'Hủy',
        onConfirm: () {
          final name = nameController.text.trim();
          final desc = descController.text.trim();
          if (name.isNotEmpty) {
            addTask(name, desc);
            Get.back();
          }
        }
    );

  }


  Future<void> updateTask(int id, String name, String description) async {
    try{
      await Supabase.instance.client.from('todos').update({
        'name': name,
        'description': description,
      }).eq('id', id);
      todoData.value = await Supabase.instance.client.from('todos').select().order("id", ascending: true);
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
      title: 'Cập nhật công việc',
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Tên'),
          ),
          TextField(
            controller: descController,
            decoration: const InputDecoration(labelText: 'Mô tả'),
          ),
        ],
      ),
      textConfirm: 'Lưu',
      textCancel: 'Hủy',
      onConfirm: () {
        final name = nameController.text.trim();
        final desc = descController.text.trim();
        if (name.isNotEmpty) {
          updateTask(todo['id'], name, desc);
          Get.back();
        }
      },
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
