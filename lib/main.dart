import 'dart:convert';

import 'package:google_books_demo/view/book_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Google book api demo',
      home: MyHomePage(title: 'Google book'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List items = [];

  Future<void> getData() async {
    var response = await http.get(Uri.https(
        'www.googleapis.com',
        '/books/v1/volumes',
        {'q': '{Flutter}', 'maxResults': '40', 'langRestrict': 'ja'}));

    var jsonResponse = jsonDecode(response.body);

    setState(() {
      items = jsonResponse['items'];
    });
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Books api demo'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Cardがタップされたときの処理
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailPage(
                    title: items[index]['volumeInfo']['title'],
                    imageUrl: items[index]['volumeInfo']['imageLinks']['thumbnail'],
                  ), // 遷移先の画面
                ),
              );
            },
            child: Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      items[index]['volumeInfo']['imageLinks']['thumbnail'],
                    ),
                    title: Text(items[index]['volumeInfo']['title']),
                    subtitle: Text(items[index]['volumeInfo']['publishedDate']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}