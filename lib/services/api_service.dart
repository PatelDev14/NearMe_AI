/*Purpose: Encapsulates network calls to your backend. Exposes a single static method search(query) that POSTs JSON to /search, parses the response, and returns a List<dynamic> of results.*/

import 'dart:convert';//JSON encoding/decoding.
import 'package:http/http.dart' as http;//HTTP client for making requests.
import 'package:nearme_ai/src/config.dart';//Importing configuration file for environment variables.

class ApiService {

  static Future<List<dynamic>> search(String query) async {
    final uri = Uri.parse('${Config.backendUrl}/search'); // use Config.backendUrl here
  // Perform a search by sending a POST request to the backend.
  // Returns a raw List<dynamic> parsed from JSON. Prefer returning List<ResultItem>.
  
    final response = await http.post(
      uri,//Post request to /search endpoint.
      headers: {'Content-Type': 'application/json'},//JSON content type header.
      body: jsonEncode({'query': query}),//Encoding the query into JSON format.
    );

    if (response.statusCode == 200) {//Check for successful response and parse JSON and return results.
      final data = jsonDecode(response.body);
      return data['results'] as List<dynamic>;//Return the list of results.
    }
    throw Exception('Failed to fetch search results: ${response.statusCode}');//On non 200 response, throw an exception with the status code.
  }
}

