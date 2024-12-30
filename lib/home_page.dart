import 'dart:convert';
import 'package:apiflutter/post_api.dart';
import 'package:apiflutter/quotes_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GET API'),
        centerTitle: true,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        actions: [
          //Post API
             InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PostApi(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                'Post',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          //Quote API
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const QuotesPage(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                'Quote',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: users.isEmpty
          ? const Center(child: Text('No users fetched. Tap the button below!'))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(users[index]['name']['first']),
                  subtitle: Text(users[index]['email']),
                  trailing: Text(users[index]['dob']['age'].toString()),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        child: const Text('Fetch'),
      ),
    );
  }
  
 //get REST API
  Future<void> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=20'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);

      setState(() {
        users = json['results'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
}


/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Working With API In Flutter'),
        centerTitle: true,
      ),

      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(users[index]['gender']),
              subtitle: Text(users[index]['email']),
              trailing: Text(users[index]['dob']['age'].toString()),
            );
          }),
      //button
      floatingActionButton:  FloatingActionButton(
        onPressed: fetchUsers,
        child: const Text('Fetch'),
      ),
    );
  }

  void fetchUsers() async {
  print('Users Fetched');
  
    const url = 'https://randomuser.me/api/?results=200';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
       users = json['results'];
    });

    print('Users Fetch Completed');
  }
}
*/