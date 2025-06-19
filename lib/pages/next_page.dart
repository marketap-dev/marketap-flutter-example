import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  final String slug; // next1 | next2
  const NextPage({super.key, required this.slug});

  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: Text('Page $slug')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(
              ctx,
              '/$slug/detail1',
              arguments: {'source': 'manual', 'idx': '1'},
            ),
            child: const Text('Go to DETAIL1'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(
              ctx,
              '/$slug/detail2',
              arguments: {'source': 'manual', 'idx': '2'},
            ),
            child: const Text('Go to DETAIL2'),
          ),
        ],
      ),
    ),
  );
}
