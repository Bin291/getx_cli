import 'package:demo_getx_supabase/app/Models/todo_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TodoService {
  Future<List<TodoModel>>getTodo() async {
    try {
      final response = await Supabase.instance.client.from('todos').select("*").order('id', ascending: false);
          if(response is List) {
        return response.map((item) => TodoModel.fromJson(item)).toList();
          }

    } catch (e) {
      if (kDebugMode) {
        print("Error fetching todos: $e");
      }
    }
    return [];
  }


Future<List<TodoModel>> doneTask() async {
        try {
          final response = await Supabase.instance.client.from('todos').select("*").eq('is_done', true).order('id', ascending: false);
          if (response is List) {
            return response.map((item) => TodoModel.fromJson(item)).toList();
          }
        } catch (e) {
          if (kDebugMode) {
            print("Error fetching done tasks: $e");
          }
        }
        return [];
      }
}