import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClientListScreen extends StatefulWidget {
  @override
  _ClientListScreenState createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  List clients = [];

  void fetchClients() async {
    final response = await http.get(Uri.parse('http://localhost/api/clients'));
    if (response.statusCode == 200) {
      setState(() {
        clients = json.decode(response.body);
      });
    } else {
      // Handle error
    }
  }

  @override
  void initState() {
    super.initState();
    fetchClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clients')),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(clients[index]['name']),
            subtitle: Text(clients[index]['code']),
          );
        },
      ),
    );
  }
}
