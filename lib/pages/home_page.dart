import 'dart:async';
import 'package:flutter/material.dart';
import 'package:marketap_sdk/marketap_sdk.dart';
import '../config.dart';
import '../deeplink.dart';
import '../utils/storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _cnt = 0;
  StreamSubscription<Uri?>? _sub;
  (String?, String?) _user = (null, null);

  @override
  void initState() {
    super.initState();
    _loadUser();
    _listenDeepLinks();
    debugPrint('Home Viewed!');
    Marketap.track(
      'mkt_home_view',
      eventProperties: {'mkt_page_title': '마켓탭 데모 홈'},
    );
  }

  Future<void> _loadUser() async {
    _user = await Storage.loadUser();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  /* ── Deeplink ── */
  Future<void> _listenDeepLinks() async {
    // 최초 링크(있을 수도 있고 없을 수도 있음)
    Uri? initial;
    try {
      // 100 ms 안에 안 오면 TimeoutException → initial = null
      initial = await DeepLinkService.stream.first.timeout(
        const Duration(milliseconds: 100),
      );
    } on TimeoutException {
      /* no initial link */
    }
    _handleUri(initial);

    // 이후 실시간 스트림
    _sub = DeepLinkService.stream.listen(_handleUri);
  }

  void _handleUri(Uri? uri) {
    if (uri == null || uri.scheme != scheme || uri.host != host) return;
    final segs = uri.pathSegments;
    if (segs.isEmpty) return;

    final target = '/${segs.join('/')}';
    final args = uri.queryParameters.isEmpty ? null : uri.queryParameters;

    if (ModalRoute.of(context)?.settings.name != target) {
      Navigator.pushNamed(context, target, arguments: args);
    }
  }

  /* ── UI ── */
  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: const Text('Home')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_user.$1 != null) Text('${_user.$1} (${_user.$2})'),
          Text('Counter: $_cnt'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(ctx, '/next1'),
            child: const Text('Go to NEXT1'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(ctx, '/next2'),
            child: const Text('Go to NEXT2'),
          ),
          // ───────── 로그인 전 ─────────
          if (_user.$1 == null)
            ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(ctx, '/login');
                _loadUser(); // 로그인 결과 반영
              },
              child: const Text('로그인하기'),
            )
          // ───────── 로그인 후 ─────────
          else ...[
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(ctx, '/products'),
              child: const Text('상품 목록 보기'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              // ← NEW
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                await Storage.clear(); // 로컬스토리지 삭제
                Marketap.logout(); // Marketap Logout 호출
                await _loadUser(); // 상태 초기화
                if (mounted) {
                  ScaffoldMessenger.of(
                    ctx,
                  ).showSnackBar(const SnackBar(content: Text('로그아웃되었습니다.')));
                }
              },
              child: const Text('로그아웃'),
            ),
          ],
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => setState(() => _cnt++),
      child: const Icon(Icons.add),
    ),
  );
}
