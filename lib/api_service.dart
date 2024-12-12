import 'dart:convert';  // Um JSON-Daten zu dekodieren
import 'package:http/http.dart' as http; // Für HTTP-Anfragen

class ApiService {
  final String baseUrl = "https://0dd22c3e-b3a4-413c-bef2-9f074b39ee85.mock.pstmn.io"; // URL deines Mockservers

  // Diese Methode holt Daten vom Server
  Future<List<dynamic>> fetchData(String endpoint) async {
    final url = Uri.parse('https://0dd22c3e-b3a4-413c-bef2-9f074b39ee85.mock.pstmn.io/Fahrzeugdaten'); // Vollständige URL für den Endpunkt
    try {
      final response = await http.get(url); // Sendet eine GET-Anfrage an den Server

      if (response.statusCode == 200) {
        // Wenn die Antwort ok ist, dekodiere die JSON-Daten
        return json.decode(response.body);
      } else {
        throw Exception('Fehler beim Abrufen der Daten');
      }
    } catch (e) {
      print('API-Fehler: $e');
      throw e;
    }
  }
}
