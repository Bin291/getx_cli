import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://gvhkcptuquymmdcuiryw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd2aGtjcHR1cXV5bW1kY3Vpcnl3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDczOTM2MTUsImV4cCI6MjA2Mjk2OTYxNX0.JXk_SvBNwGp8bL9x7mLcx6qJQFjoChycI_N2LKIFS1g',
  );
  runApp(Myapp());
}

class Myapp extends StatelessWidget{
  const Myapp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX App',
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
    );
  }
}