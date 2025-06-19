import 'package:flutter/material.dart';
import 'package:marketap_flutter_example/pages/login_page.dart';
import 'package:marketap_flutter_example/pages/products_page.dart';
import 'package:marketap_sdk/marketap_sdk.dart';
import 'pages/home_page.dart';
import 'pages/next_page.dart';
import 'pages/detail_page.dart';

class AppRouter {
  static Route<dynamic> routeFactory(RouteSettings s) {
    final name = s.name ?? '';
    debugPrint('$s');
    if (name == '/') {
      return MaterialPageRoute(builder: (_) => const HomePage(), settings: s);
    }

    final uri = Uri.parse(name);
    final segs = uri.pathSegments;
    final args =
        (uri.queryParameters.isEmpty ? s.arguments : uri.queryParameters)
            as Map<String, String>?;

    debugPrint('Page Viewed ${uri.path}, ${uri.query}');
    Marketap.trackPageView(
      eventProperties: {
        'mkt_page_path': uri.path, // 예: /checkout
        'mkt_page_params': uri.query, // 예: user=42&coupon=SUMMER
      },
    );

    if (segs.isEmpty) return _unknown();

    final first = segs.first; // next1 | next2
    if (segs.length == 1) {
      if (name == '/login') {
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: s,
        );
      }

      if (name == '/products') {
        return MaterialPageRoute(
          builder: (_) => const ProductsPage(),
          settings: s,
        );
      }

      return MaterialPageRoute(
        builder: (_) => NextPage(slug: first),
        settings: s,
      );
    }

    final second = segs[1]; // detail1 | detail2
    return MaterialPageRoute(
      builder: (_) => DetailPage(slug: '$first/$second', params: args),
      settings: s,
    );
  }

  static Route<dynamic> _unknown() => MaterialPageRoute(
    builder: (_) => const Scaffold(body: Center(child: Text('Unknown'))),
  );
}
