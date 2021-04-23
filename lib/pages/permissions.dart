import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixtrip/main.dart';
import 'package:pixtrip/common/utils.dart';

class Permissions extends StatefulWidget {
  @override
  _PermissionsState createState() => _PermissionsState();
}

class _PermissionsState extends State<Permissions> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print(state);
    if (state == AppLifecycleState.resumed) {
      Future.delayed(Duration.zero, () {
        print('checking permissions');
        checkPermissions(
          success: () => Get.offAll(() => App()),
          callBack: () => null,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('permissions__error'.tr),
              SizedBox(height: 35.0),
              ElevatedButton(
                child: Text('permissions__change_permissions'.tr),
                onPressed: () => openAppSettings(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
