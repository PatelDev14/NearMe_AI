/* Purpose: the HomeScreen StatefulWidget that contains search UI,
   triggers ApiService.search, and renders results via ResultCard widgets. */

import 'package:flutter/material.dart' hide SearchBar;
import '../services/api_service.dart'; // ApiService for handling API requests.
import '../widgets/result_card.dart'; // UI component to display individual search results.
import '../widgets/animated_background.dart'; // Animated background widget for visual appeal.
import '../widgets/search_bar.dart'; // Separate SearchBar widget extracted to another file.

// Home screen with search functionality and displays results.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key}); // Constructor with optional key parameter, key passed to superclass.
  

  @override
  State<HomeScreen> createState() => _HomeScreenState(); // Creates mutable state for this widget.
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController(); // Controller for managing the text input field (user's search queries).
  bool _loading = false; // Checks if a search operation is in progress.
  List<dynamic> _results = []; // Holds the search results fetched from the API.

  // Handles the search operation.
  Future<void> _performSearch() async {
    final query = _controller.text.trim(); // Get the trimmed text from the input field.
    if (query.isEmpty) return; // If the query is empty, do nothing.

    setState(() {
      _loading = true; // Loading indicator set to true.
      _results = []; // Clear previous results.
    });

    try {
      final results = await ApiService.search(query); // Performing the search using the ApiService.
      setState(() {
        _results = results; // Updating the results with the fetched data.
      });
    } catch (e) {
      debugPrint('Error: $e'); // Logging any errors that occur during the search.
    } finally {
      setState(() {
        _loading = false; // Clearing the loading indicator once the search is complete.
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to release resources.
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      centerTitle: true,
      title: const Text('Discover Nearby with AI'),
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: const ThemedAnimatedBackground(),
    ),
    body: Stack(
      children: [
        const ThemedAnimatedBackground(), // full-screen animated background
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _results.length,
                        itemBuilder: (context, index) {
                          final item = _results[index];
                          return ResultCard(item: item);
                        },
                      ),
              ),
              const SizedBox(height: 12),
              SearchBar(controller: _controller, onSearch: _performSearch),
            ],
          ),
        ),
      ],
    ),
  );
}

}
