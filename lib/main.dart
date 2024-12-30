import 'package:apiflutter/home_page.dart';
import 'package:apiflutter/post_api.dart';
import 'package:apiflutter/quotes_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Working with APIs in Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PostApi(),
      //home: const QuotesPage(),
     // home: const HomePage(),
    );
  }
}
