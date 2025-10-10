import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ResultCard extends StatelessWidget {
  final dynamic item;

  const ResultCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final name = item['name'] ?? '';
    final category = item['category'] ?? '';
    final markdown = item['markdown'] ?? item['summary'] ?? 'No content';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (category.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  category,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            if (name.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            MarkdownBody(
              data: markdown,
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(fontSize: 15),
                tableHead: TextStyle(fontWeight: FontWeight.bold),
                tableBorder: TableBorder.all(color: Colors.deepPurple.shade100),
                tableColumnWidth: const IntrinsicColumnWidth(),
                blockSpacing: 14,
              ),
              selectable: true,
            ),
          ],
        ),
      ),
    );
  }
}

