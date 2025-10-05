/*This widget renders a single search result as a Material Card + ListTile. It expects a map-like item with keys like name, summary, rating, url/contact and uses url_launcher to open links. Prefer converting item to a typed model and moving URL logic to a helper for clarity and testability.*/
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';//For handling URL launches.

class ResultCard extends StatelessWidget {//Stateless widget that displays individual search results.
  final dynamic item;

  const ResultCard({super.key, required this.item});//Constructor with required item parameter.

  void _openUrl(String url) async {//Helper method to open URLs using url_launcher package.
    if (await canLaunchUrl(Uri.parse(url))) {//Check if the device can launch the URL.
      await launchUrl(Uri.parse(url));//Launch the URL.
    } else {
      debugPrint('Could not launch $url');//Log an error if the URL cannot be launched.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,//Shadow effect for the card.
      margin: const EdgeInsets.symmetric(vertical: 8),//Vertical margin around the card.
      child: ListTile(
        title: Text(item['name'] ?? 'Unnamed'),//Display the name of the item or 'Unnamed' if not available.
        subtitle: Text(
          '${item['summary'] ?? ''}\n⭐️ ${item['rating'] ?? 'N/A'}',//Display summary and rating.
        ),
        isThreeLine: true,//Allows subtitle to span three lines.
        trailing: IconButton(
          icon: const Icon(Icons.open_in_new),
          onPressed: () {
            // Add link handling if URL is available
            final url = item['url'] ?? item['contact'] ?? '';
            if (url.isNotEmpty) {
              _openUrl(url);
            }
          },
        ),
      ),
    );
  }
}
