import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  BookDetailPage({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
    body: SingleChildScrollView(
        child: Container(
          color: Colors.cyanAccent, // クリーム色の背景
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Image.network(
                    imageUrl,
                    width: 300,
                    height: 300,
                  ),              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
