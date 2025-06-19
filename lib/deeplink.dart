import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class DeepLinkService {
  static const _channel = MethodChannel('marketap/deeplink');
  static final _controller = StreamController<Uri>.broadcast();

  /// 반드시 앱 시작 시 한 번 호출
  static Future<void> init() async {
    // 실행 중(onLink) 이벤트 수신
    _channel.setMethodCallHandler((call) async {
      debugPrint('Deep Link: ${call.arguments}');
      if (call.method == 'onLink' && call.arguments is String) {
        _controller.add(Uri.parse(call.arguments as String));
      }
    });
  }

  static Stream<Uri> get stream => _controller.stream;
}
