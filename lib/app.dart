import 'package:flutter/material.dart';
import 'app_router.dart';
import 'config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Marketap Sample',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
    initialRoute: routeHome,
    onGenerateRoute: AppRouter.routeFactory,
  );
}
