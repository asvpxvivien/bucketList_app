import 'package:flutter/material.dart';

class ViewItemScreen extends StatefulWidget {
  String title;
  String image;
  ViewItemScreen({super.key, required this.title, required this.image});

  @override
  State<ViewItemScreen> createState() => _ViewItemScreenState();
}

class _ViewItemScreenState extends State<ViewItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: 1, child: Text("Delete")),
                PopupMenuItem(value: 2, child: Text("Mark as complete")),
              ];
            },
          ),
        ],
        title: Text("${widget.title}"),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
