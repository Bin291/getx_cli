import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../history/views/history_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../../todo/views/todo_view.dart';
import '../controllers/layout_controller.dart';

class LayoutView extends GetView<LayoutController> {
  const LayoutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:TabBarView
        (controller: controller.tabController,
          children: [
            TodoView(),
        HistoryView(),
        ProfileView(),


      ]
      ),
      bottomNavigationBar: Obx(
            () => Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A), // Darker background for the nav bar
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue, // Active item color
            unselectedItemColor: Colors.white70, // Inactive item color
            selectedLabelStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(color: Colors.white70),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Lists',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: controller.currentIndex.value,
            onTap: controller.onTabTapped,
          ),
        ),
      ),
    );
  }
}
