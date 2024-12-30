import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  List<dynamic> quotes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes API'),
        centerTitle: true,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
      ),
      body: quotes.isEmpty
          ? const Center(child: Text('No Quotes'))
          : ListView.builder(
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Quote: ${quotes[index]['text']}'),
                  subtitle: Text('Author: ${quotes[index]['from']}'),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: getQuotes,
        child: const Text('Get Quotes'),
      ),
    );
  }

 //get REST API
  Future<void> getQuotes() async {
    final response = await http.get(
      Uri.parse('https://jsonguide.technologychannel.org/quotes.json'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);

      setState(() {
        quotes = json;
      });
    } else {
      throw Exception('Failed');
    }
  }
}
