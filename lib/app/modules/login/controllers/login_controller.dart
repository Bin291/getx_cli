import 'package:demo_getx_supabase/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  Future<void>loginWithGoogle() async{
    try{
      final GoogleSignIn googleSignIn = GoogleSignIn(
       clientId: "591708297487-jdem8ecq7d8ouevnsh6k7e2ujjv0vjnt.apps.googleusercontent.com",
        serverClientId: "591708297487-fn0hvmc4ph0ggghp24sdti4ec5e9hmpv.apps.googleusercontent.com",
      );
      final GoogleSignInAccount  = await googleSignIn.signIn();
      final googleAuth = await GoogleSignInAccount!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;
      if(accessToken ==null){
        throw Exception("Access token is null");

      }
      if(idToken ==null){
        throw Exception("Id token is null");
      }
      final supbase = Supabase.instance.client;
      await supbase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
      accessToken: accessToken,);

      Get.offAllNamed(Routes.LAYOUT);
    }catch(e){
      if (kDebugMode) {
        print("===================================================================");
        print("Error signing in with Google: $e");
      }
    }


  }
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
