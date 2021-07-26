import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pixtrip/controllers/oauth_controller.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:pixtrip/common/social_buttons.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/main.dart';

import 'package:pixtrip/common/utils.dart';

Controller c = Get.find();

class ContinueWith extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Column(
        children: [
          Divider(height: 40.0),
          Text('login__or_continue_with'.tr),
          SizedBox(height: 40.0),
          OAuthRow(),
        ],
      ),
    );
  }
}

class OAuthRow extends StatelessWidget {
  /* void oAuthConnect({String email, String pseudo, dynamic id, dynamic image}) {
    c.checkHttpResponse(
        url: 'user/oauth.php',
        data: {
          'email': email,
          'pseudo': pseudo,
          'id': id,
          'image': image,
        },
        loading: () => setState(() => _loading = true),
        error: () => setState(() => _loading = false),
        callBack: (data) {
          c.setUserId(data['u_id']);
          c.setUserMail(data['email']);
          c.setUserPseudo(data['pseudo']);
          c.setUserImage(data['image']);
          c.setUserAge(data['age']);
          c.setTutorialStep(data['tutorial']);
          final box = GetStorage();
          box.write('user', data['u_id']);
          Get.offAll(() => App());
        });
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
    if (email == null) {
      Get.defaultDialog(
        title: 'error_title'.tr,
        content: Text(
          'apple_sign_in__no_mail'.tr,
          textAlign: TextAlign.center,
        ),
      );
      return;
    }
    oAuthConnect(
        email: email, pseudo: '$firstName $familyName', id: id, image: null);
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
    final LoginResult result = await FacebookAuth.instance.login();
    logger.d(result);
    if (result.status == LoginStatus.success) {
      // final AccessToken accessToken = result.accessToken;
      final userData = await FacebookAuth.instance.getUserData();
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
  } */

  @override
  Widget build(BuildContext context) {
    OAauthController controller = Get.put(OAauthController());
    String name;
    Function function;
    if (Platform.isIOS) {
      name = 'apple';
      function = controller.signInWithApple;
    } else {
      name = 'google';
      function = controller.signInWithGoogle;
    }
    return Obx(() => controller.loading()
        ? CircularProgressIndicator.adaptive()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SocialButton(
                name: name,
                function: function,
              ),
              SocialButton(
                name: 'facebook',
                function: controller.signInWithFacebook,
              ),
            ],
          ));
  }
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future login() => _googleSignIn.signIn();

  static Future logout() => _googleSignIn.disconnect();
}
