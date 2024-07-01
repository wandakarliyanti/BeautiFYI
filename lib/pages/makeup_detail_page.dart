import 'package:flutter/material.dart';
import 'package:uas_mobile/models/makeup_model.dart';

class MakeupDetailPage extends StatelessWidget {
  final Makeup makeup;

  MakeupDetailPage({required this.makeup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD07A7F),
        title: Text(
          makeup.name,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              makeup.imageLink,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error);
              },
            ),
            SizedBox(height: 8),
            Text(
              makeup.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Brand: ${makeup.brand}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              makeup.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
