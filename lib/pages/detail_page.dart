import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String slug; // next1/detail1 등
  final Map<String, String>? params;
  const DetailPage({super.key, required this.slug, this.params});

  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: Text('Detail $slug')),
    body: params == null || params!.isEmpty
        ? const Center(child: Text('No query parameters'))
        : ListView(
            padding: const EdgeInsets.all(16),
            children: params!.entries
                .map(
                  (e) => ListTile(title: Text(e.key), subtitle: Text(e.value)),
                )
                .toList(),
          ),
  );
}
