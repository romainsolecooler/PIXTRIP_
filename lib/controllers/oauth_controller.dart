import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/main.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class OAauthController extends GetxController {
  final loading = false.obs;

  void oAuthConnect({
    String email,
    String pseudo,
    dynamic id,
    dynamic image,
    bool apple = false,
  }) async {
    loading(true);
    Controller c = Get.find();
    var response = await dio.post('user/oauth.php', data: {
      'email': email,
      'pseudo': pseudo,
      'id': id,
      'image': image,
      'apple': apple,
    });
    var data = response.data;
    logger.d(data);
    if (data['error'] != null) {
      loading(false);
      Get.defaultDialog(
        title: 'error_title'.tr,
        content: Text(
          'oauth__error'.tr,
          textAlign: TextAlign.center,
        ),
      );
      return;
    } else {
      c.setUserId(data['u_id']);
      c.setUserMail(data['email']);
      c.setUserPseudo(data['pseudo']);
      c.setUserImage(data['image']);
      c.setUserAge(data['age']);
      c.setTutorialStep(data['tutorial']);
      final box = GetStorage();
      box.write('user', data['u_id']);
      Get.offAll(() => App());
    }
    loading(false);
  }

  void signInWithApple() async {
    print('gonna sign in with apple');
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    String email = credential.email;
    String id = credential.userIdentifier;
    String familyName = credential.familyName;
    String firstName = credential.givenName;
    print(id);
    /* if (email == null) {
      Get.defaultDialog(
        title: 'error_title'.tr,
        content: Text(
          'apple_sign_in__no_mail'.tr,
          textAlign: TextAlign.center,
        ),
      );
      return;
    } */
    bool apple = email == null;
    print(apple);
    oAuthConnect(
      email: email,
      pseudo: '$firstName $familyName',
      id: id,
      image: null,
      apple: apple,
    );
  }

  void signInWithGoogle() async {
    GoogleSignIn oAuth = GoogleSignIn();
    final user = await oAuth.signIn();
    oAuth.disconnect();
    oAuthConnect(
      email: user.email,
      pseudo: user.displayName,
      id: user.id,
      image: user.photoUrl,
    );
  }

  void signInWithFacebook() async {
    print('gonna facebook');
    final LoginResult result = await FacebookAuth.instance.login();
    logger.d(result);
    if (result.status == LoginStatus.success) {
      // final AccessToken accessToken = result.accessToken;
      final userData = await FacebookAuth.instance.getUserData();
      logger.d(userData['email']);
      if (userData['email'] == null) {
        Get.defaultDialog(
          title: 'error_title'.tr,
          content: Text(
            'oauth_error__no_email'.tr,
            textAlign: TextAlign.center,
          ),
        );
        return;
      }
      var image = !userData['picture']['data']['is_silhouette']
          ? userData['picture']['data']['url']
          : null;
      oAuthConnect(
        email: userData['email'],
        pseudo: userData['name'],
        id: userData['id'],
        image: image,
      );
    }
  }
}
