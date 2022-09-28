import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_base/locales/app_translations.dart';
import 'package:flutter_base/locales/localizes.dart';
import 'package:flutter_base/models/user/user_model.dart';
import 'package:flutter_base/router/router_config.dart';
import 'package:flutter_base/utils/storage_util.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_base/values/app_theme.dart';
import 'package:flutter_base/values/colors.dart';
import 'package:flutter_base/values/globals.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLogging();
  await checkStatusLogin();
  await checkTheme();
  await Utils.getLocaleLanguageApp();
  configLoading();
  runApp(MyApp());
}

/// Check status login
Future<void> checkStatusLogin() async {
  var userProfile = await StorageUtil.retrieveItem(StorageUtil.userProfile);
  if (!Utils.isNull(userProfile)) {
    Globals.user.value = UserModel.fromJson(userProfile);
  }
}

Future<void> checkTheme() async {
  var value = await StorageUtil.retrieveItem(StorageUtil.theme);
  var themeMode = value ?? 'light';
  if (themeMode == 'light') {
    Get.changeThemeMode(ThemeMode.light);
  } else {
    Get.changeThemeMode(ThemeMode.dark);
  }
}

/// Setup log
void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

/// Config loading
void configLoading() => EasyLoading.instance
  ..displayDuration = const Duration(milliseconds: 2000)
  ..indicatorType = EasyLoadingIndicatorType.ring
  ..loadingStyle = EasyLoadingStyle.custom
  ..indicatorSize = 40.0
  ..radius = 10.0
  ..progressColor = Colors.primary
  ..backgroundColor = Colors.transparent
  ..indicatorColor = Colors.primary
  ..textColor = Colors.primary
  ..maskColor = Colors.blue.withOpacity(0.5)
  ..userInteractions = true
  ..dismissOnTap = false;

class MyApp extends StatelessWidget {
  getInitialRoute() {
    if (Utils.isNull(Globals.token)) {
      return RouterConfig.routeLogin;
    } else {
      return RouterConfig.routeMain;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter base',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
      getPages: RouterConfig.route,
      initialRoute: getInitialRoute(),
      translations: AppTranslations(),
      // theme: CommonStyle.mainTheme,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      builder: EasyLoading.init(),
      routingCallback: (routing) {
        if (routing!.current == RouterConfig.routeMain) {}
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale(Localizes.enCode, ''),
        Locale(Localizes.viCode, '')
      ],
    );
  }
}
