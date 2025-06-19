import 'package:flutter/material.dart';
import 'package:marketap_sdk/marketap_sdk.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  static const _items = ['노트북', '데스크톱 컴퓨터', '스마트폰', '태블릿', '모니터'];

  Future<void> _action(BuildContext ctx, String item, int index) async {
    final choice = await showDialog<String>(
      context: ctx,
      builder: (_) => AlertDialog(
        title: Text(item),
        content: const Text('원하는 동작을 선택하세요'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'cart'),
            child: const Text('장바구니담기'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'buy'),
            child: const Text('구매하기'),
          ),
        ],
      ),
    );
    if (choice == null) return;
    final msg = choice == 'cart'
        ? '$item 을(를) 장바구니에 담으셨습니다.'
        : '$item 을(를) 구매하셨습니다.';
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));
    if (choice == 'cart') {
      Marketap.track(
        'mkt_add_to_cart',
        eventProperties: {
          'mkt_page_title': '구매 페이지 Flutter',
          'mkt_items': [
            {'mkt_product_id': '$index', 'mkt_product_name': item},
          ],
        },
      );
    } else {
      Marketap.track(
        'mkt_purchase',
        eventProperties: {
          'mkt_page_title': '구매 페이지 Flutter',
          'mkt_items': [
            {'mkt_product_id': '$index', 'mkt_product_name': item},
          ],
        },
      );
    }
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: const Text('Products')),
    body: ListView.separated(
      itemCount: _items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) => ListTile(
        title: Text(_items[i]),
        onTap: () => _action(ctx, _items[i], i),
      ),
    ),
  );
}
