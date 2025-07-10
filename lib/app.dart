import 'package:flutter/material.dart';
import 'package:marketap_sdk/marketap_sdk.dart';
import 'app_router.dart';
import 'config.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Marketap.setClickHandler((e) {
      final url = e.url;
      if (url == null) return;

      final uri = Uri.tryParse(url);
      if (uri == null) return;

      debugPrint('Custom Click Handling: $url');

      final targetPath = '/${uri.pathSegments.join('/')}';
      final args = uri.queryParameters.isEmpty ? null : uri.queryParameters;
      final ctx = navigatorKey.currentContext;
      if (ctx == null) {
        debugPrint('[ClickHandler] Context is null (app may be backgrounded)');
        // TODO: 백그라운드 큐로 저장 또는 무시
        return;
      }
      final navigator = Navigator.of(ctx, rootNavigator: true);
      navigator.pushNamed(targetPath, arguments: args);
    });
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Marketap Sample',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: routeHome,
      onGenerateRoute: AppRouter.routeFactory,
    );
  }
}
