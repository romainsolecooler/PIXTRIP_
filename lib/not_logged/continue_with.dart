import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pixtrip/common/social_buttons.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/main.dart';

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

class OAuthRow extends StatefulWidget {
  @override
  _OAuthRowState createState() => _OAuthRowState();
}

class _OAuthRowState extends State<OAuthRow> {
  bool _loading = false;

  void oAuthConnect({String email, String pseudo, dynamic id, dynamic image}) {
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
          if (c.stayConnected.value) {
            final box = GetStorage();
            box.write('user', data['u_id']);
          }
          Get.offAll(() => App());
        });
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
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? CircularProgressIndicator.adaptive()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SocialButton(
                name: 'google',
                function: signInWithGoogle,
              ),
              SocialButton(
                name: 'facebook',
                function: signInWithFacebook,
              ),
            ],
          );
  }
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future login() => _googleSignIn.signIn();

  static Future logout() => _googleSignIn.disconnect();
}
