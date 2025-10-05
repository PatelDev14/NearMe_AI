/*Purpose: the HomeScreen StatefulWidget that contains search UI, triggers ApiService.search, and renders results via ResultCard widgets.*/
import 'package:flutter/material.dart';
import '../services/api_service.dart';//ApiService for handling API requests.
import '../widgets/result_card.dart';//UI component to display individual search results.
import '../widgets/animated_background.dart';//Animated background widget for visual appeal.

//Home screen with search functionality and displays results.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});//Constructor with optional key parameter, key passed to superclass.

  @override
  State<HomeScreen> createState() => _HomeScreenState();//Creates mutable state for this widget.
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();//Controller for managing the text input field(users search queries).
  bool _loading = false;//Checks if a search operation is in progress.
  List<dynamic> _results = [];//Holds the search results fetched from the API.

  Future<void> _performSearch() async {//Handles the search operation.
    final query = _controller.text.trim();//Get the trimmed text from the input field.
    if (query.isEmpty) return;//If the query is empty, do nothing.

    setState(() {
      _loading = true;//Loading indicator set to true.
      _results = [];//Clear previous results.
    });

    try {
      final results = await ApiService.search(query);//Performing the search using the ApiService.
      setState(() {
        _results = results;//Updating the results with the fetched data.
      });
    } catch (e) {
      debugPrint('Error: $e');//Logging any errors that occur during the search.
    } finally {
      setState(() {
        _loading = false;//Clearing the loading indicator once the search is complete.
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Nearby with AI'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const ThemedAnimatedBackground(), // full-screen animated background
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Results area stays at the top and expands
                Expanded(
                  child: _loading
                      ? const Center(child: CircularProgressIndicator())
                      : _results.isEmpty
                          ? const Center(child: Text('No results yet — try a search!'))
                          : ListView.builder(
                              itemCount: _results.length,
                              itemBuilder: (context, index) {
                                final item = _results[index];
                                return ResultCard(item: item);
                              },
                            ),
                ),

            const SizedBox(height: 12),

            // Stylish bottom search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.search,
                      decoration: const InputDecoration(
                        hintText: 'Search places, activities and more...',
                        hintStyle: const TextStyle(fontSize: 11), // smaller hint text
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                      onSubmitted: (_) => _performSearch(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Unique search button (pill with icon + label)
                  Material(
                    color: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: InkWell(
                      onTap: _performSearch,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            colors: [const Color.fromARGB(255, 56, 98, 171), const Color.fromARGB(255, 167, 56, 187)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.search, color: Colors.white, size: 16),
                            SizedBox(width: 5),
                            Text('Let\'s Go!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:10)),
                          ],
                        ),
                      ),
                    )

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ]),
  );

  }

}


