import 'package:flutter/material.dart';
import 'api_service.dart'; // Importiere den API-Service, den wir vorher erstellt haben

void main() {
  runApp(MyApp()); // Starte die Flutter-App
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Mockserver App')), // AppBar mit Titel
        body: DataScreen(), // Das Haupt-Widget für die Anzeige von Daten
      ),
    );
  }
}

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState(); // Erstelle den State für dieses Widget
}

class _DataScreenState extends State<DataScreen> {
  final ApiService apiService = ApiService(); // Erstelle eine Instanz des ApiService, um Daten zu holen
  late Future<List<dynamic>> _data; // Variable, um die vom API zurückgegebenen Daten zu speichern

  @override
  void initState() {
    super.initState();
    // Wir rufen die Daten vom Mockserver ab, zum Beispiel den "users"-Endpunkt
    _data = apiService.fetchData("Fahrzeugdaten");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _data, // Hier wird die Future verwendet, die Daten zu laden
      builder: (context, snapshot) {
        // Wenn die Daten noch geladen werden
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Ladeanzeige, während die Daten abgerufen werden
        } else if (snapshot.hasError) {
          return Center(child: Text('Fehler: ${snapshot.error}')); // Fehleranzeige, falls etwas schiefgeht
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Keine Daten gefunden')); // Wenn keine Daten vom Server kommen
        } else {
          // Wenn die Daten erfolgreich geladen wurden
          final data = snapshot.data!; // Speichere die geladenen Daten
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index]['name'] ?? 'Kein Name'), // Name anzeigen
                subtitle: Text(
                  'Typ: ${data[index]['typ'] ?? 'Unbekannt'}\nBaujahr: ${data[index]['baujahr'] ?? 'Unbekannt'}',
                ), // Weitere Attribute als Untertitel anzeigen
              );

            },
          );

        }
      },
    );
  }
}