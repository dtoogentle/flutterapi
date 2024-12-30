import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostApi extends StatefulWidget {
  const PostApi({super.key});

  @override
  State<PostApi> createState() => _PostApiState();
}

class _PostApiState extends State<PostApi> {
  List<dynamic> posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POST API'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: posts.isEmpty
          ? const Center(child: Text('No posts available'))
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post['title']),
                  subtitle: Text(post['body']),
                  trailing: Text(post['userId'].toString()),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: createPost,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> createPost() async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: jsonEncode({
          'title': 'Quote',
          'body': 'Take your life serious',
          'userId': 1,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {

        final Map<String, dynamic> json = jsonDecode(response.body);

        setState(() {
          posts.add(json);
        });

      } else {
        throw ('Failed to create post.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }
}



/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostApi extends StatefulWidget {
  const PostApi({super.key});

  @override
  State<PostApi> createState() => _PostApiState();
}

class _PostApiState extends State<PostApi> {
  List<dynamic> post = [];

  final textController = TextEditingController();
  final fromController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    fromController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POST API'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Text Field for "text"
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Enter Text',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Text Field for "from"
            TextField(
              controller: fromController,
              decoration: const InputDecoration(
                labelText: 'Enter From',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Button to trigger API call
            ElevatedButton(
              onPressed: createPost,
              child: const Text('Post API'),
            ),

            const SizedBox(height: 20),

            // Display the result
            Expanded(
              child: ListView.builder(
                itemCount: post.length,
                itemBuilder: (context, index) {
                  final item = post[index];
                  return ListTile(
                    title: Text(item['text'] ?? 'No text'),
                    subtitle: Text(item['from'] ?? 'No author'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createPost() async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonguide.technologychannel.org/quotes.json'),
        body: jsonEncode({
          'text': textController.text,
          'from': fromController.text,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.body);
        setState(() {
          post = json;
        });
      } else {
        throw Exception('Failed to post: ${response.statusCode}');
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
*/