import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../history/views/history_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/layout_controller.dart';

class LayoutView extends GetView<LayoutController> {
  const LayoutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:TabBarView
        (controller: controller.tabController,
          children: [
        HomeView(),
        HistoryView(),
        ProfileView(),
      ]
      ),
      bottomNavigationBar: Obx(()=>BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
      ),),
    );
  }
}
